# OpenShift Starter Workshop Guides [![Build Status](https://travis-ci.org/openshift-labs/starter-guides.svg?branch=master)](https://travis-ci.org/openshift-labs/starter-guides)

Workshop content designed to be used by the [Workshopper tool](https://github.com/osevg/workshopper).

## Using this content

Either use the content directly by pointing at this repository

```
https://raw.githubusercontent.com/openshift-labs/starter-guides/master/
```

or host locally as static content, e.g. on OpenShift using the PHP S2I builder

```
$ oc new-app php~https://github.com/openshift-labs/starter-guides.git
```

and use that url to feed Workshopper with content.


## Create a full workshop

You can follow this instructions to create a full workshop site:

```
$ oc new-project labs
$ oc new-app osevg/workshopper -e WORKSHOPS_URLS="https://raw.githubusercontent.com/openshift-labs/starter-guides/master/_workshops/training.yml" -e CONSOLE_ADDRESS=console.example.com:8443 -e ROUTER_ADDRESS=apps.example.com -e DOCS_URL=docs.openshift.org --name workshop -n labs
$ oc expose service workshop --hostname workshop.apps.example.com -n labs
```

NOTE: You will need the following ENV values:

* *WORKSHOPS_URLS*: Raw URL for a training. There's some trainings [here](https://github.com/openshift-labs/starter-guides/tree/master/_workshops)

Depending on the workshop, you might need additional ENV. These are defined per workshop. In the sample use, we define:
* *CONSOLE_ADDRESS*: Address to the master server's console
* *ROUTER_ADDRESS*: Wildcard DNS used for deployed apps
* *DOCS_URL*: Link to the OpenShift documentation


# Run Guides Locally
```
$ git clone https://github.com/openshift-labs/starter-labs.git
$ cd starter-labs

$ docker run -it --rm -p 8080:8080 -v $(pwd):/app-data \
              -e CONTENT_URL_PREFIX="file:///app-data" \
              -e WORKSHOPS_URLS="file:///app-data/_workshops/roadshow.yml" \
              osevg/workshopper:latest 
```
