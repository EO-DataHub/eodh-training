class: CommandLineTool

cwlVersion: v1.0
doc: This runs GDAL Merge to stack images together.

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement: 
    dockerPull: ghcr.io/osgeo/gdal:ubuntu-small-latest

baseCommand: gdal_merge.py

arguments: 
- -separate 
- valueFrom: ${ return inputs.tifs; }
- -o
- composite.tif
# gdal_merge.py -separate 1.tif 2.tif 3.tif -o rgb.tif

inputs:

  tifs:
    type: File[]

outputs:

  composite:
    outputBinding:
      glob: '*.tif'
    type: File

#stderr: stderr
#stdout: stdout


