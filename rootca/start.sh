#!/bin/bash

# needed by root-ca.conf
touch db/index
openssl rand -hex 16  > db/serial
echo 1001 > db/crlnumber

# create private key
openssl genrsa -aes256 -out rootca_pri.key 2048

# create public key
openssl rsa -in rootca_pri.key -pubout -out rootca_pub.key

# create certificate sign request
openssl req -new -key rootca_pri.key -config root-ca.conf -out rootca.csr

# self sign and create certificate
openssl ca -selfsign -config root-ca.conf -in rootca.csr -out rootca.crt -extensions ca_ext

# create sub certificate from rootca
openssl ca -config root-ca.conf -in ../subca/subca.csr -out ../subca/subca.crt -extensions sub_ca_ext

# show certificate
openssl x509 -noout -text -in rootca.crt

# show private key
openssl rsa -noout -text -in rootca_pri.key
