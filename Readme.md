
## DRDB - Distributed replicated block device deployment using Vagrant and Ansible

```
git clone https://github.com/cokebottle/drbd-debian-ansible

```
## Requirements 
Linux box with 4GB RAM

* Vagrant: https://www.vagrantup.com/downloads.html
* VirtualBox: https://www.virtualbox.org/
* Ansible: http://docs.ansible.com/ansible/intro_installation.html

### Bootstrap the virtual machines
    vagrant up
    vagrant ssh node-01
    vagrant ssh node-02

#Rebuild the whole setup
    vagrant destroy -f
```


# Primary node only (node-01)
sudo /sbin/drbdadm primary --force r0

# create a filesystem and mount it (on node-01)
sudo /sbin/mkfs -t ext3 /dev/drbd0 
sudo mkdir -p /mnt/r0
sudo mount -t ext3 -o noatime,nodiratime /dev/drbd0 /mnt/r0/

# Sync check
watch cat /proc/drbd 

# failover (mannually)
# (on node-01)
sudo umount /mnt/r0
sudo /sbin/drbdadm secondary r0

# Secondary node node-02
sudo /sbin/drbdadm primary r0
sudo mkdir -p /mnt/r0
sudo mount /dev/drbd0 /mnt/r0/
# Sync check
watch cat /proc/drbd 

```