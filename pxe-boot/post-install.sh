#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PRESEED=${1}
DONT_EXECUTE=${2}
SETUPTMP=/opt/system-setup

if [ ! -d "${DIR}/${PRESEED}" ] || [ -z "${PRESEED}" ]
then
    echo "THE PRESEED FOLDER DID NOT EXIST!"
    exit 1
fi

# make setup temp dir...
mkdir -pv ${SETUPTMP}/{files,lib,preseeds}

echo "Copying files from BASE..."
cp -Rv ${DIR}/./base/lib/* ${SETUPTMP}/lib/.
cp -Rv ${DIR}/./preseeds/* ${SETUPTMP}/preseeds/.

echo "Copying files from preseed: ${PRESEED}..."
cp -Rfv ${DIR}/./${PRESEED}/lib/* ${SETUPTMP}/lib/.
cp -Rfv ${DIR}/./${PRESEED}/files/* ${SETUPTMP}/files/.

echo "Generating post-install script..."
####
cat > "${SETUPTMP}/post-install.sh" << "EOF"
#!/bin/bash

EOF
####

####
find ${SETUPTMP}/lib -type f -iname "*.sh" | sort -n | while read FILE
do
    echo "echo 'Running post script => ${FILE}...'" >> "${SETUPTMP}/post-install.sh"
    echo "${FILE}" >> "${SETUPTMP}/post-install.sh"
    echo "echo 'Finished script => ${FILE}.'" >> "${SETUPTMP}/post-install.sh"
done
#####

echo "Setting eXecute bits..."
find ${SETUPTMP} -type f -iname "*.sh" -exec chmod -v +x {} \;

if [ "${DONT_EXECUTE}" != "1" ]
then
    echo "Executing post-installation script..."
    ${SETUPTMP}/post-install.sh
fi