# Developing Java applications on OpenShift - Starter Guides 

Workshop content designed to be used by the [Workshopper tool](https://github.com/osevg/workshopper).

## Install the APB into your Service Catalog

An [APB](https://hub.docker.com/r/openshiftapb/starter-workshop-apb/) is provided for 
deploying the Cloud-Native Workshop infra (lab instructions, Nexus, Gogs, etc) in a project 
on an OpenShift cluster via the service catalog. In order to add this APB to the OpenShift service catalog, log in 
as cluster admin and perform the following in the `openshift-ansible-service-broker` project :

1. Edit the `broker-config` configmap and add this snippet right after `registry:`:

  ```
    - name: dh
      type: dockerhub
      org: openshiftapb
      tag: ocp-3.11
      white_list: [.*-apb$]
  ```

2. Redeploy the `asb` deployment

You can [read more in the docs](https://docs.openshift.com/container-platform/3.11/install_config/oab_broker_configuration.html#oab-config-registry-dockerhub) 
on how to configure the service catalog.

Note that if you are using the _OpenShift Workshop_ in RHPDS, this APB is already available in your service catalog.


## Using this content

Either use the content directly by pointing at this repository

```
https://raw.githubusercontent.com/openshift-labs/starter-guides/ocp-3.11/
```

## Create a full workshop

You can follow this instructions to create a full workshop site:

```
$ oc new-project guides
$ oc apply -f https://raw.githubusercontent.com/openshift-labs/starter-guides/ocp-3.11/guides-template.yaml
$ oc new-app starter-guides \
             -p CONSOLE_ADDRESS="https://master.osevg.openshiftworkshop.com" \
             -p ROUTER_ADDRESS="apps.osevg.openshiftworkshop.com"
```

NOTE: You will need the following ENV values:

* *CONSOLE_ADDRESS*: Address to the master server's console
* *ROUTER_ADDRESS*: Wildcard DNS used for deployed apps

# Run Guides Locally
```
$ git clone https://github.com/openshift-labs/starter-guides.git
$ cd starter-labs

$ docker run -it --rm -p 8080:8080 -v $(pwd):/app-data \
              -e CONTENT_URL_PREFIX="file:///app-data" \
              -e LOG_TO_STDOUT=true \
              -e WORKSHOPS_URLS="file:///app-data/_workshops/java-starter-guides.yml" \
              quay.io/osevg/workshopper:0.4
```
