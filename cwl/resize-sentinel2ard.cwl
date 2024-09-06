cwlVersion: v1.0
$namespaces:
  s: https://schema.org/
s:softwareVersion: 1.0.0
schemas:
  - http://schema.org/version/9.0/schemaorg-current-http.rdf
$graph:
  - class: Workflow
    id: resize-sentinel2ard
    label: Resize sentinel2ard collection
    doc: Resize sentinel2ard collection
    requirements:
      - class: ScatterFeatureRequirement
    inputs: []
    outputs:
      - id: stac_output
        outputSource:
          - stac_step/stac_catalog
        type: Directory
    steps:
      get_urls_step:
        run: "#get_urls"
        in: []
        out:
          - urls
          - ids
      resize_step:
        run: "#resize"
        in:
          url: get_urls_step/urls
          id: get_urls_step/ids
        scatter:
          - url
          - id
        scatterMethod: dotproduct
        out:
          - resized
      stac_step:
        run: "#stac"
        in:
          items: resize_step/resized
        out:
          - stac_catalog
  - class: CommandLineTool
    id: get_urls
    requirements:
      InlineJavascriptRequirement: {}
      ResourceRequirement:
        coresMax: 1
        ramMax: 512
    hints:
      DockerRequirement:
        dockerPull: ghcr.io/eo-datahub/pyeodh:main
    baseCommand: python
    inputs:
      script:
        type: File
        inputBinding:
          position: 1
        default:
          class: File
          basename: "script.py"
          contents: |-
            import pyeodh
            col = (
                pyeodh.Client()
                .get_catalog_service()
                .get_catalog("supported-datasets/ceda-stac-fastapi")
                .get_collection("sentinel2_ard")
            )
            urls = []
            ids = []
            i = 0
            for item in col.get_items():
                cog = item.assets.get("cog")
                if cog is not None:
                    urls.append(cog.href)
                    ids.append(item.id)
                    i += 1
                if i == 2:
                    break
            with open("urls.txt", "w") as f:
                print(*urls, file=f, sep="\n", end="")
            with open("ids.txt", "w") as f:
                print(*ids, file=f, sep="\n", end="")
    outputs:
      urls:
        type: string[]
        outputBinding:
          loadContents: true
          glob: urls.txt
          outputEval: $(self[0].contents.split('\n'))
      ids:
        type: string[]
        outputBinding:
          loadContents: true
          glob: ids.txt
          outputEval: $(self[0].contents.split('\n'))
  - class: CommandLineTool
    id: resize
    requirements:
      InlineJavascriptRequirement: {}
      ResourceRequirement:
        coresMax: 1
        ramMax: 512
    hints:
      DockerRequirement:
        dockerPull: ghcr.io/osgeo/gdal:ubuntu-small-latest
    baseCommand: gdal_translate
    inputs:
      url:
        type: string
        inputBinding:
          position: 1
          prefix: /vsicurl/
          separate: false
      id:
        type: string
        inputBinding:
          position: 2
          valueFrom: $(self + "_resized.tif")
      outsize_x:
        type: string
        inputBinding:
          position: 3
          prefix: -outsize
        default: 5%
      outsize_y:
        type: string
        inputBinding:
          position: 4
        default: 5%
    outputs:
      resized:
        type: File
        outputBinding:
          glob: "*.tif"
  - class: CommandLineTool
    id: stac
    requirements:
      InlineJavascriptRequirement: {}
      ResourceRequirement:
        coresMax: 1
        ramMax: 512
    hints:
      DockerRequirement:
        dockerPull: ghcr.io/eo-datahub/pyeodh:main
    baseCommand: python
    inputs:
      script:
        type: File
        inputBinding:
          position: 1
        default:
          class: File
          basename: "script.py"
          contents: |-
            import pystac
            import datetime
            import argparse
            import shutil
            from pathlib import Path
            import os
            import pystac.utils
            parser = argparse.ArgumentParser()
            parser.add_argument(
                "--files",
                nargs="+",
                type=str,
                required=True,
            )
            args = parser.parse_args()
            cat = pystac.Catalog(id="catalog", description="sentinel2ard-resized")
            for f in args.files:
                name = Path(f).stem
                os.mkdir(name)
                f_copy = shutil.copy(f, f"./{name}/")
                item = pystac.Item(
                    id=name,
                    geometry={
                        "type": "Polygon",
                        "coordinates": [
                            [[-180, -90], [-180, 90], [180, 90], [180, -90], [-180, -90]]
                        ],
                    },
                    bbox=None,
                    datetime=datetime.datetime.now(),
                    properties={
                        "created": pystac.utils.datetime_to_str(datetime.datetime.now()),
                        "updated": pystac.utils.datetime_to_str(datetime.datetime.now()),
                    },
                    extra_fields={"bbox": [-180, -90, 180, 90]},
                )
                item.add_asset(
                    name,
                    pystac.Asset(
                        href=f_copy,
                        media_type=pystac.MediaType.GEOTIFF,
                        roles=["data"],
                        extra_fields={"file:size": os.path.getsize(f_copy)},
                    ),
                )
                cat.add_item(item)
            cat.normalize_and_save(root_href="./", catalog_type=pystac.CatalogType.SELF_CONTAINED)
      items:
        type: File[]
        inputBinding:
          position: 2
          prefix: "--files"
    outputs:
      stac_catalog:
        outputBinding:
          glob: .
        type: Directory
