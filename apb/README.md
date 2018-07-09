# Starter Workshop Installer

The provided Ansible Playbook Bundle automates preparing an OpenShift cluster for the OpenShift Developer Starter Workshop 
by deploying required services (lab instructions, Gogs, Nexus, Che, etc) which are used during the labs.


## Use on OpenShift
Select the item from the catalog.

## Use as docker image
You can run the apb image locally with your docker daemon for testing purposes.

You need to add in the serviceaccount directory in this folder the ca.crt of your cluster so that the connection to the cluster will be secured.
The file is ommited from git, so you'll need to add yours.

There's `provision` and `deprovision` scripts to help you with the process. Set these environment variables on your host:

```
export APB_TEST_ENV_MASTER_URL=<CLUSTER_MASTER_URL>
export APB_TEST_ENV_ADMIN_USER=<CLUSTER_ADMIN_USER>
export APB_TEST_ENV_ADMIN_PASSWORD=<CLUSTER_ADMIN_PASSWORD>
```

### Provision
```
_user=<CLUSTER_ADMIN_USER>
_password=<CLUSTER_ADMIN_PASSWORD>
_cluster=<CLUSTER_MASTER_URL>
_namespace=starter-workshop-apb-test

# Connect to the cluster and create the project where the apb will run
oc login ${_cluster} -u ${_user} -p ${_password}
oc new-project ${_namespace}
oc project ${_namespace}

# Run the apb container
docker run -it --rm -v $(pwd)/serviceaccount:/var/run/secrets/kubernetes.io/serviceaccount starter-workshop-apb \
       provision -e namespace=${_namespace} \
                 -e master_url=${_cluster} \
                 -e openshift_user=${_user} \
                 -e openshift_password=${_password} \
                 -e workshop_type=java \
                 -e user_count=2 \
                 -e openshift_user_password=openshift \
                 -e openshift_master_url=${_cluster} \
                 -e infrasvcs_adm_user=adminuser \
                 -e infrasvcs_adm_password=adminpassword
```

### Deprovision
```
_user=<CLUSTER_ADMIN_USER>
_password=<CLUSTER_ADMIN_PASSWORD>
_cluster=<CLUSTER_MASTER_URL>
_namespace=starter-workshop-apb-test

# Connect to the cluster and create the project where the apb will run
oc login ${_cluster} -u ${_user} -p ${_password}

# Run the apb container
docker run -it --rm -v $(pwd)/serviceaccount:/var/run/secrets/kubernetes.io/serviceaccount starter-workshop-apb \
       deprovision -e namespace=${_namespace} \
                   -e master_url=${_cluster} \
                   -e openshift_user=${_user} \
                   -e openshift_password=${_password} \
                   -e user_count=2
```
