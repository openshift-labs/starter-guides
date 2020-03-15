Lab - Getting Started with OpenShift for Developers
=====================

This is a workshop for introducing developers to OpenShift.

Deploying the Full Workshop
----------------------

The full workshop contains several components:
* Etherpad - So users can claim a username
* A GOGS server and GOGS repositories for each user
* Nexus - Currently only used by the Java version of the workshop
* OCP Ops View - An instance of the [ops-view](https://github.com/hjacobs/kube-ops-view) cluster visualizer
* An instance of the homeroom workshop chooser application and the 4 starter lab guides (Java, PHP, Python, Node.js) from this repository.

[AgnosticD](https://github.com/redhat-cop/agnosticd) is used to deploy the workshop. 

First, log into the OpenShift cluster where you want to deploy the workshop. You need to log in with cluster admin permissions.

Next, clone the AgnosticD repository (or your fork of it, if you are making changes):

```
git clone https://github.com/redhat-cop/agnosticd
```

In your terminal, cd into the agnosticd repository and run:

```
docker run -it --rm -v $(pwd):/opt/app-root/src -v $HOME/.kube:/opt/app-root/src/.kube \
--entrypoint bash quay.io/osevg/agnosticd-runner
```

This will get you a bash shell into an AgnosticD enabled environment. In this environment, you'll be able to run or test AgnosticD workloads.

cd into the ansible directory:
```
cd ansible
```

Run the following script to deploy all the components of the starter workshop:

```
TARGET_HOST=localhost
GUID=sampleuser
ocp_username=opentlc-mgr
# WORKLOAD SPECIFICS
WORKSHOP_PROJECT=lab
workloads=("ocp-workload-etherpad" \
           "ocp-workload-ocp-ops-view" \
           "ocp-workload-gogs" \
           "ocp4-workload-nexus-operator" \
           "ocp-workload-gogs-load-repository" \
           "ocp4-workload-homeroomlab-starter-guides")

for WORKLOAD in ${workloads[@]}
do
  ansible-playbook -c local -i ${TARGET_HOST}, configs/ocp-workloads/ocp-workload.yml \
      -e ansible_python_interpreter=/opt/app-root/bin/python \
      -e ocp_workload=${WORKLOAD} \
      -e guid=${GUID} \
      -e project_name=${WORKSHOP_PROJECT} \
      -e etherpad_project=${WORKSHOP_PROJECT} \
      -e gogs_project=${WORKSHOP_PROJECT} \
      -e opsview_project=${WORKSHOP_PROJECT} \
      -e _nexus_operator_project=${WORKSHOP_PROJECT} \
      -e project_name=${WORKSHOP_PROJECT} \
      -e ocp_username=${ocp_username} \
      --extra-vars '{"num_users": 10, "user_count": 10, "ACTION": "create"}'
done
```

Once the deployment finishes, go to the `labs` project and view the Routes there. The `homeroom` route is the one that launches the workshop chooser.


Deploying/Testing the Lab Guides Only
----------------------

To deploy the lab guides only, first clone this Git repository to your own machine. Use the command:

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
