#!/bin/bash

# Change "demo_app" to the name of your application
app_name=tools

echo "Creating identity for ${app_name}:"

echo "+ Private key deployed to './deploy/private/${app_name}.key'"
openssl ecparam -name secp256k1 -genkey -noout -out deploy/private/${app_name}key.pem

echo "+ Create Certificate Signing Request: './${app_name}.csr'"
openssl req -new -sha256 -key deploy/private/${app_name}key.pem -out ${app_name}.csr -config ${app_name}.cnf

echo "+ Requesting signing of certificate"
openssl ca -config ../../ca/identity/openssl.cnf -days 3650 -in ${app_name}.csr -out deploy/${app_name}.pem
echo "+ Signed certificate deployed to: './deploy/${app_name}.pem'"

echo "+ Removing the .csr file that is no longer needed"
rm ${app_name}.csr

# For convenience, rename the template permissions file to one for this app
echo "+ Edit permissions for this app in: '${app_name}_permissions.xml'"
echo "+ Then sign permissions using sign_permissions.sh"
mv appname_permissions.xml ${app_name}_permissions.xml
