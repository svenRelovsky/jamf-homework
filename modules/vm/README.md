# Module for virtual machine creation

Requirements are existing "base" image, when creating a voloume image from the qcow image we cant specify size, see following links:

- [Terraform provider dmacvicar/libvirt documentation](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume#size)
- [GitHub issue describing the problem](https://github.com/dmacvicar/terraform-provider-libvirt/issues/821)

______________________________________________________________________

Inputs:

| Name                | Description  | type | default |
|---------------------|--------------|------|---------|
| `vm_name`           | Name of the virtual machine (domain). Must be unique in pool. | `string` |                     |
| `vm_memory`         | Memory allocation of the VM.                                  | `number` | `512`               |
| `vm_cpu`            | CPU allocation of the VM.                                     | `number` | `1`                 |
| `base_image_id`     | ID of the base image to be used.                              | `string` |                     |
| `pool_name`         | Libvirt pool for domain.                                      | `string` | `default`           |
| `disk_size`         | Size of root disk of domain.                                  | `number` | `10737418240`(10gb) |
| `network_name`      | Name of the network where interface for VM will be created.   | `string` |                     |
| `cloudinit_disk_id` | ID of volume for cloudinit to be mounted.                     | `string` |                     |

______________________________________________________________________

Outputs:
| Name | Description                                                                        | value                  |
|------|------------------------------------------------------------------------------------|------------------------|
| `ip` | First IP address assigned to VM (this module supports only a single net interface) | IPv4 address  (string) |
