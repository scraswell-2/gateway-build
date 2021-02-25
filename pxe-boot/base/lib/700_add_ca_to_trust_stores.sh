#!/bin/bash
##############################################
## dot sourcing
##############################################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. ${DIR}/config
. ${DIR}/functions
##############################################
## end dot sourcing
##############################################

CA_CERT_URL=https://scraswell-2.github.io/gateway-build/ca.cert.pem
IMPLICIT_TRUST_STORE=/usr/local/share/ca-certificates

curl -ss -L -o "${IMPLICIT_TRUST_STORE}/my-ca.crt" "${CA_CERT_URL}"

update-ca-certificates
