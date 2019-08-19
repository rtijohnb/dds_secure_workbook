#!/bin/bash

# Change "demo_app" to the name of your application
app_name=demo_app

echo "Creating identity certificate"

openssl genrsa -out ./deploy/private/${app_name}key.pem 2048
openssl req -config ${app_name}.cnf -new -key ./deploy/private/${app_name}key.pem -out ${app_name}.csr
openssl ca -config ../../ca/identity/openssl.cnf -days 365 -in ${app_name}.csr -out ./deploy/${app_name}.pem

# For convenience, copy the template permissions file to one for this app
mv appname_permissions.xml ${app_name}_permissions.xml
