cwlVersion: v1.1

class: CommandLineTool

requirements:
  DockerRequirement: 
    dockerPull: ghcr.io/osgeo/gdal:alpine-small-3.8.4

baseCommand: gdalwarp

arguments: [-cutline, -crop_to_cutline]
#gdalwarp -cutline path/to/polygonfile.shp -crop_to_cutline sat.tif output.tif

inputs:
  inputtif:
    type: File
    inputBinding:
      position: 4
  inputaoi:
    type: File
    inputBinding:
      position: 2
 

outputs:
  clipped_tif:
    type: stdout

stdout: clipped.tif

