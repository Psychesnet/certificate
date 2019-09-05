#!/bin/bash

# needed by sub-ca.conf
touch db/index
openssl rand -hex 16  > db/serial
echo 1001 > db/crlnumber

# create private key
openssl genrsa -aes256 -out subca_pri.key 2048

# create public key
openssl rsa -in subca_pri.key -pubout -out subca_pub.key

# create certificate sign request
openssl req -new -key subca_pri.key -config sub-ca.conf -out subca.csr
