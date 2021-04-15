# USERDATA
```
#!/bin/bash

apt -y update
apt -y upgrade
apt -y install git
git clone https://github.com/scraswell-2/gateway-build.git /opt/post-install
/opt/post-install/pxe-boot/post-install.sh do-docker-host 1
rm -rf /opt/post-install
rm -rf /opt/system-setup
```