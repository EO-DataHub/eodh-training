

cwlVersion: v1.1

class: CommandLineTool

requirements:
  DockerRequirement: 
    dockerPull: ghcr.io/osgeo/gdal:alpine-small-3.8.4

baseCommand: gdal_calc.py

arguments: [-A, -A_band, -B, -B_band]
#gdal_calc.py -A output.tif --A_band=1 -B output.tif --B_band=2 --type=Float32 --outfile=ndvi.tif --calc="((B-A)/(B+A))"

inputs:
  clipimg:
    type: File
    inputBinding:
      position: 4
  aoi:
    type: File
    inputBinding:
      position: 2
 

outputs:
  outndvi:
    type: stdout

stdout: clipped.tif