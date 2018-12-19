FROM kubevirt/container-disk-v1alpha

# Add Ubuntu cloud disk image
ENV DIST=xenial
RUN curl -g -L http://cloud-images.ubuntu.com/${DIST}/current/${DIST}-server-cloudimg-amd64.img > /disk/${DIST}-server-cloudimg-amd64.img
