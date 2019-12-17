Lab - Getting Started
=====================

This is a workshop for introducing developers to OpenShift.

Deploying the Workshop
----------------------

To deploy the workshop, first clone this Git repository to your own machine. Use the command:

```
git clone --recurse-submodules https://github.com/openshift-labs/starter-guides.git
```

The ``--recurse-submodules`` option ensures that Git submodules are checked out. If you forget to use this option, after having clone the repository, run:

```
git submodule update --recursive --remote
```

Next create a project in OpenShift into which the workshop is to be deployed.

```
oc new-project workshops
```

From within the top level of the Git repository, now run:

```
.workshop/scripts/deploy-spawner.sh
```

The name of the deployment will be ``lab-getting-started``.

You can determine the hostname for the URL to access the workshop by running:

```
oc get route lab-getting-started
```

When the URL for the workshop is accessed you will be prompted for a user name and password. Use your email address or some other unique identifier for the user name. This is only used to ensure you get a unique session and can attach to the same session from a different browser or computer if need be. The password you must supply is ``openshift``.

Building the Workshop
---------------------

The deployment created above will use an image from ``quay.io`` for this workshop based on the ``ocp-4.2`` branch of the repository.

To make changes to the workshop content and test them, edit the files in the Git repository and then run:

```
.workshop/scripts/build-workshop.sh
```

This will replace the existing image used by the active deployment.

If you are running an existing instance of the workshop select "Restart Workshop" from the menu top right of the workshop environment dashboard.

When you are happy with your changes, push them back to the remote Git repository.

Deleting the Workshop
---------------------

To delete the spawner and any active sessions, including projects, run:

```
.workshop/scripts/delete-spawner.sh
```

To delete the build configuration for the workshop image, run:

```
.workshop/scripts/delete-workshop.sh
```

Developing Locally
------------------

To build the workshop image locally using `docker` you would run:

```bash
docker build -t lab-getting-started .
```

To run the image, you would then use:

```bash
docker run --rm -p 10080:10080 lab-getting-started
```

You can then access the workshop environment using http://localhost:10080.

If you want to be able to do iterative changes and check them without needing to rebuild the image each time, you can run:

```bash
docker run --rm -p 10080:10080 -v `pwd`:/opt/app-root/src lab-getting-started
```

This will mount your local Git repository directory into the container and the local files will be used. Each time you change the content of a page, refresh the web browser to view the latest version. You will only need to stop and restart the container if you make changes to the YAML configuration files.
