# Ubuntu Container Disks for KubeVirt

[![Docker Repository on Quay](https://quay.io/repository/quamotion/ubuntu-container-disk/status "Docker Repository on Quay")](https://quay.io/repository/quamotion/ubuntu-container-disk)

This repository contains container disks which you can use to run Ubuntu VMs inside
a Kubernetes cluster, using KubeVirt.

For example, you can use this YAML template to create a VM running Ubuntu 16.04,
to which you can connect with a user named `kubevirt` and a password of `kubevirt`.

```
apiVersion: kubevirt.io/v1alpha2
kind: VirtualMachineInstance
metadata:
  name: ubuntu-bionic
spec:
  domain:
    devices:
      disks:
        - name: containerdisk
          volumeName: containervolume
          disk:
            bus: virtio
        - name: cloudinitdisk
          volumeName: cloudinitvolume
          disk:
            bus: virtio
      interfaces:
      - name: default
        bridge: {}
    resources:
      requests:
        memory: 256M
  networks:
  - name: default
    pod: {}
  volumes:
    - name: containervolume
      containerDisk:
        image: quay.io/quamotion/ubuntu-container-disk:16.04
    - name: cloudinitvolume
      cloudInitNoCloud:
        userData: |-
          #cloud-config
          users:
            - name: kubevirt
              lock-passwd: false
              passwd: $1$SaltSalt$31kYxns5FwSKLI1ASNtey1
```
