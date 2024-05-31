# STAC
* STAC vs ODC from odc-stac site: [readthedocs](https://odc-stac.readthedocs.io/en/latest/stac-vs-odc.html)
* Explanations on the similarities and differences between odc-stac and stackstac: [odc-stac](https://github.com/opendatacube/odc-stac/issues/54),  [Pangeo](https://discourse.pangeo.io/t/comparing-odc-stac-load-and-stackstac-for-raster-composite-workflow/4097/6) - stackstac is slightly simpler to use but needs some awareness around parameterising the data calls
* There's also: [xcube](https://xcube.readthedocs.io/en/latest/overview.html) - but I think this is maybe too complex for the user needs
* Another package called: [cubo](https://github.com/ESDS-Leipzig/cubo) - looks like it does a similar thing! 
* stackstac docs: [latest](https://stackstac.readthedocs.io/en/latest/index.html)
* An old discussion - 2021 - about STAC use at CEDA: [hosted on Pangeo forums](https://discourse.pangeo.io/t/stac-and-earth-systems-datasets/1472/17)
* Some new user STAC tutorials: [search for STAC](http://www.acgeospatial.co.uk/)
* pystac tutorial: [read a STAC catalog](https://stacspec.org/en/tutorials/1-read-stac-python/) - we will do this using pyeodh

# S3
* Telespazio initial EODH S2 demo: [using boto](https://github.com/UKEODHP/eodhp-guide/blob/main/examples/app-hub/s3demo.ipynb)

# CWL
## General
* CWL official tutorials: [Quick Start](https://www.commonwl.org/user_guide/introduction/quick-start.html)
* Dynamic workflow behavious: [use of JScript](https://doc.arvados.org/v2.7/user/cwl/rnaseq-cwl-training.html)
* The official documentation and specification: [specs](https://www.commonwl.org/user_guide/introduction/basic-concepts.html#the-cwl-specification) 
* Templating workflow files: [ToolJig](https://srp33.github.io/ToolJig/tool.html) - is there a way that users can utilise this to create spatial CWL files?
* Article about why CWL has been developed: [doc](https://elifesciences.org/articles/71069#abstract)
* Tool to create CWL workflows: [scriptcwl](https://github.com/NLeSC/scriptcwl) - old, but might be useful?
* Library of tools for working with CWL: [cwl-utils](https://github.com/common-workflow-language/cwl-utils) - less old, might be useful
* Old but comprehensive tutorial: [2017 how-to](https://andrewjesaitis.com/posts/2017-02-06-cwl-tutorial/)
* Official CWl snippets: [tests](https://github.com/common-workflow-language/cwl-v1.3/tree/main/tests)

## Spatial
* My first CWL workflow: [explainer](https://github.com/EO-DataHub/eodh-training/blob/main/temporary/first_workflow.md)
* EO Application Package example: [Waterbodies](https://github.com/Terradue/ogc-eo-application-package-hands-on/tree/master/water-bodies)
* OGC best practices: [EO app pkg](https://docs.ogc.org/bp/20-089r1.html#toc18)
* CWL for EO tutorials: [adding conditions](https://cwl-for-eo.github.io/guide/how-to/cwl-how-to/08-conditional-workflows/conditional-workflows/)
* Terradue training: [hands-on](https://github.com/Terradue/ogc-eo-application-package-hands-on) - not sure all the scripts work as they are supposed to...
* EO App Pkgs: [overview](https://github.com/eoap), [examples](https://github.com/EOEPCA/deployment-guide/tree/main/deploy/samples/requests/processing)


## Docker
* GDAL: [docker images](https://github.com/OSGeo/gdal/tree/master/docker)


# Workflow ideas
* Could Whitebox be of use in the data processing?: [discussion on Docker availability](https://github.com/jblindsay/whitebox-tools/issues/22), [official docs](https://www.whiteboxgeo.com/whitebox-workflows-for-python/), [repo](https://github.com/jblindsay/whitebox-tools)

# Platform
* EO Exploitation Platform Common Architecture examples and repos: [EOEPCA](https://github.com/EOEPCA)