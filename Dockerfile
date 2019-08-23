FROM quay.io/openshifthomeroom/workshop-dashboard:4.0.0

USER root

COPY . /tmp/src

RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src

#COPY sudoers/ /etc/sudoers.d/
#
#RUN chown root:root /etc/sudoers.d/* && \
#    chmod 0440 /etc/sudoers.d/*

# ENV TERMINAL_TAB=split

USER 1001

RUN /usr/libexec/s2i/assemble
