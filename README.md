# proxmox-k8s-terraform

## Step 1: Create proxmox Template for cloud-init compatible image

### References: 
* [how to create a proxmox ubuntu cloud init image](https://austinsnerdythings.com/2021/08/30/how-to-create-a-proxmox-ubuntu-cloud-init-image/)
* [Create Proxmox cloud-init template](https://www.yanboyang.com/clouldinit/)

### Lets's Go !
* Customize your settings inside *scripts/script_to_create_template.sh* file
* run as root 
```bash
./script_to_create_template.sh
```
* At the end of the process, you should have a new template created on your proxmox server
* you can use this template to create a new VM based on it. ie: (replace with your own values) 
```bash
qm clone <TEMPLATE_ID> <VM_ID> --name "myNewVM"
```

## Step 2: 





