#!/usr/bin/python
import os
import urllib2

RED="\x1b[0;31m"
YELLOW="\x1b[0;33m"
RESET="\x1b[0;0;0m"
AUTHOR_KEY=".ssh/authorized_keys"

old_keys = {
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIixUgyh+/qyGfFgne82S3FVWzA/ckre/Mt8Di0SCnrj5IPzRE5j/PvIZcrggpTIz+FkIMuCAL4tXbcvQzm10MOkTCEMPkGYOH/tIw7oGa8hmTcVlk+FQ4ljtAaszCSoUvBOUGW+90uoTjMgE91TOEztDq36wKZKfwn9CpYUSY52YATKuFufeWWP5X3MYCCf+xUmVOEnMOCXf3i2sK7LCG2xQa5blyJFnQB6HBJ9o026FdgAbycsIBqLfGpHm8hsa+oD2pKAgIDX2BCCDxgkuIIux7bsKlNx2MAcpDH/ZIgHAgzfKt3Cj6Ug22rrx4AoKbyIjWXJZCTrmFQIFsl681ux9CdN+Ug2tKWFZpGn+jkabg5/2vb0NhMGtuzrZ03Gf2BOnXObn4QnlFTt77xFXtfo8F7rTz2Ph7gM4r2vYHHXkXqDz9NtvpvTo6H7k5B+Ehls7AXryNthMQKbA08ADQ74j5LqDWwCwgq/jxl0czHc1V0rqbe85NLsVSJ2XoS/8=": 'gpg subkey 2019',
}

def collect_gh_keys():
    ssh_keys = urllib2.urlopen("https://github.com/rkokkelk.keys").read()
    return [key.strip() for key in ssh_keys.split("\n") if key.strip()]

def collect_system_keys():
    with open(AUTHOR_KEY, 'r') as f:
        system_keys = f.readlines()

    return [key.strip() for key in system_keys if key.strip()]

def main():
    if not os.path.isfile(AUTHOR_KEY):
        exit(0)

    system_keys = collect_system_keys()
    for key in collect_gh_keys():
        if key not in system_keys:
            print YELLOW+"Github key not found in authorized_keys"+RESET

    for key, value in old_keys.items():
        if key in system_keys:
            print RED+"Old key ("+value+") still listed in authorized_keys"+RESET

if __name__ == "__main__":
    main()
