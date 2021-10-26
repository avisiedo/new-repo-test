ARG PARENT_IMG=quay.io/freeipa/freeipa-server:fedora-34

# Ignore the rule because we are providing a customized parent image
# that is passed as a build argument
# hadolint ignore=DL3006
FROM ${PARENT_IMG}

ARG QUAY_EXPIRATION=2w
ENV QUAY_EXPIRATION=$QUAY_EXPIRATION
LABEL quay.expires-after=$QUAY_EXPIRATION

# Just copy the ocp4 include shell file and parse the include list to 
# add it at the end
COPY ./init/ocp4.inc.sh /usr/local/share/ipa-container/ocp4.inc.sh
RUN sed -i 's/^#.\+includes:end/source \"\$\{INIT_DIR\}\/ocp4\.inc\.sh\"\n&./g' /usr/local/share/ipa-container/includes.inc.sh

ENTRYPOINT ["/usr/local/sbin/init"]
