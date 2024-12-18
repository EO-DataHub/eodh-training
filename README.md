# eodh-training

## Table of Contents
* [Introduction](#introduction)
* [Repository Layout](#repository-layout)
* [Training and Support Sites](#training-and-support-sites)
* [Discussion Group](#discussion-group)
* [Filing Issues](#filing-issues)
* [Contributing](#contributing)

### Introduction
Welcome to the eodh-training repository! This repository aims to provide a live set of documents to demonstrate how to use the EODH (Earth Observation Data Hub) Python API client and QGIS plugin. Other training materials may be added to this repository in future.

Whether you're a user looking to explore the project or a developer wanting to contribute, you'll find all the information you need here.

### Repository Layout
The repository is organized as follows:

- **/api-client**: Information about how to use the Python API client to interact with the EODH.
- **/platform**: Information and pointers about how to directly interact with the EODH web presence.
- **/plugin**: Tutorials and guidance on installing and using the QGIS EODH plugin.
- **/presentations**: A collection of presentations made by the EODH team.
- **/science**: Some notebooks that demonstrate other scientific tools and methods. 
- **/website**: resources to be used to define the functionality of the GitHub Pages version of this repository.

### Training and Support Sites
You can visit our GitHub Pages site for additional information and documentation: [Training Materials site](https://eo-datahub.github.io/eodh-training/).

If you require specific development information on the API client then please check out the [ReadTheDocs page](https://pyeodh.readthedocs.io/en/latest/index.html#) for the client.

### Discussion group
We have set up a [Discussion Group](https://github.com/EO-DataHub/eodh-training/discussions) as a location that users can interact with other users, as well as the Hub owners and developers. If you are interested then please check it out and use this resource to build a vibrant community around the EODH platform. If you need help then please reach out.

### Filing Issues
If you encounter any bugs, have feature requests, or other issues, please file an issue on GitHub:

1. Navigate to the [Issues](https://github.com/EO-DataHub/eodh-training/issues) section.
2. Click on the "New Issue" button.
3. Provide a detailed description of the issue or feature request.
4. Click "Submit new issue".

We will endeavour to deal with the issue in an appropriate manner as quickly as possible.

---

## Contributing
### General method 
We welcome contributions from the community! To contribute:

1. **Fork the Repository**: Click on the "Fork" button at the top right of this page.
2. **Clone Your Fork**: Clone your forked repository to your local machine.
    ```bash
    git clone https://github.com/yourusername/your-repo-name.git
    ```
3. **Create a Branch**: Create a new branch for your feature or bug fix.
    ```bash
    git checkout -b your-feature-branch-name
    ```
4. **Make Your Changes**: Implement your feature or bug fix. Remember to also add to _quarto.yml if you are looking to add a new notebook/page to the website. If you are making changes to an existing notebook/page then do not edit _quarto.yml as this is the file that defines the layout of the training materials website.  
5. **Commit Your Changes**: Commit your changes with a descriptive commit message.
    ```bash
    git commit -m "Description of your changes"
    ```
6. **Push to Your Fork**: Push your changes to your forked repository.
    ```bash
    git push origin your-feature-branch-name
    ```
7. **Create a Pull Request**: Navigate to the original repository and click on the "New Pull Request" button. Select your branch and provide a descriptive title and description for your pull request. One of the repository owners will review the pull request and will decide on whether to accept it.

Alternatively you can edit the Jupyter Notebooks that you want to submit in JupyterHub, then upload them to your forked repository and generate the Pull Request from there. 

Remember to synchronise your fork with the main repository before making the pull request.  

For detailed instructions on creating a pull request, visit the [GitHub documentation](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request).

### GitHub Pages
The GitHub pages site runs a GitHub action that applies [Quarto](https://quarto.org/) to the repository. When a commit is accepted into the main branch of the repository the Action updates the training website. If your commit does not have the expected output, please ensure that your code is as Quarto would expect it.

Details can be found on the [Quarto website](https://quarto.org/docs/guide/).



---

Thank you for your interest in the Earth Observation Data Hub! We appreciate your support and contributions.
