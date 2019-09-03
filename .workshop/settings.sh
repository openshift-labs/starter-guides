WORKSHOP_NAME=lab-getting-started
WORKSHOP_IMAGE=quay.io/openshiftlabs/lab-getting-started:ocp-4.2
CONSOLE_IMAGE=quay.io/openshift/origin-console:4.2
SPAWNER_PASSWORD=openshift
RESOURCE_BUDGET=medium
MAX_SESSION_AGE=7200
IDLE_TIMEOUT=300
INFRA_PROJECT=`oc project --short 2>/dev/null`