
## Proxmox VE usage

Install [Proxmox VE](https://www.proxmox.com/en/proxmox-ve).

**NB** This assumes Proxmox VE was installed alike [rgl/proxmox-ve](https://github.com/rgl/proxmox-ve).

Set your Proxmox VE details:

```bash
ccat >secrets-proxmox.sh <<EOF
export PROXMOX_URL='https://192.168.10.21:8006/api2/json'
export PROXMOX_USERNAME='root@pam'
export PROXMOX_PASSWORD='P@ssw0rd'
export PROXMOX_NODE='pve'
EOF
source secrets-proxmox.sh
```

Create the template:

```bash
make build-windows-11-23h2-uefi-proxmox
```

**NB** There is no way to use the created template with vagrant (the [vagrant-proxmox plugin](https://github.com/telcat/vagrant-proxmox) is no longer compatible with recent vagrant versions). Instead, use packer (e.g. like in this repository) or terraform (e.g. see [rgl/terraform-proxmox-windows-example](https://github.com/rgl/terraform-proxmox-windows-example)).


