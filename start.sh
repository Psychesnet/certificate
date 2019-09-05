#!/bin/bash

cd subca
sh start.sh
cd -

cd rootca
sh start.sh
cd -

# verify rootca and subca
openssl verify -verbose -CAfile rootca/rootca.crt subca/subca.crt
