FROM quay.io/openshifthomeroom/workshop-dashboard:5.0.1

USER root

RUN  wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-4.8/openshift-client-linux.tar.gz -P /opt/app-root/src/ && \
       tar -xzvf /opt/app-root/src/openshift-client-linux.tar.gz -C /opt/workshop/bin/ && \
       rm -f /opt/app-root/src/openshift-client-linux.tar.gz && \
       chmod +x /opt/workshop/bin/{oc,kubectl}

COPY . /tmp/src

RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src

ENV TERMINAL_TAB=split

USER 1001

RUN /usr/libexec/s2i/assemble
