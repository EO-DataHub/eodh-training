#!/usr/bin/env cwl-runner
class: Workflow 

cwlVersion: v1.1

doc:
  Clip a large satellite image and calculate an index

inputs:
  aoi:
    type: File
    doc: polygon file of area of interest
  intif:
    type: File
    doc: tif file of input satellite image

outputs:
  output:
    type: File
    outputSource: calcs/outndvi
    doc: output NDVI layer

steps:
  clipper:
    run: clip.cwl
    in:
      inputtif:
        source: intif
      inputaoi:
        source: aoi
    out: [clipped_tif]

  calcs:
    run: calcs.cwl
    in:
      clipimg: clipper/clipped_tif
    out: [outndvi]
