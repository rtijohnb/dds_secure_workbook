# This script resets the permissions CA by doing the following:
# - reset OpenSSL issued cert database (the Permissions CA does not issue certs)
# - purging the private key associated with the Permissions CA
# - purging the previously created Permissions CA certificate (public key)
# After running this script, you will have run the OpenSSL commands necessary
# to setup to sign DDS Secure permissions files and domain governance files.

# DDS_SECURE_DEMO_HOME environment variable must be set before running
if [ -z ${DDS_SECURE_DEMO_HOME+x} ]; then 
    echo "DDS_SECURE_DEMO_HOME is not set"; 
    exit 1
fi

echo ""
echo "Reseting the Permissions CA:"
echo "  Purging all previously generated CA files"
rm -f ${DDS_SECURE_DEMO_HOME}/ca/permissions/certs/*
rm -f ${DDS_SECURE_DEMO_HOME}/ca/permissions/PermissionsDatabase
rm -f ${DDS_SECURE_DEMO_HOME}/ca/permissions/PermissionsDatabaseIndex.*
rm -f ${DDS_SECURE_DEMO_HOME}/ca/permissions/*.csr
rm -f ${DDS_SECURE_DEMO_HOME}/ca/permissions/*.pem
rm -f ${DDS_SECURE_DEMO_HOME}/ca/permissions/*.cnf
rm -f ${DDS_SECURE_DEMO_HOME}/ca/permissions/*.old
echo "  Removing private key"
rm -f ${DDS_SECURE_DEMO_HOME}/ca/permissions/private/*
echo "  Initializing certificate database"
cp ${DDS_SECURE_DEMO_HOME}/ca/permissions/resource/PermissionsDatabase ${DDS_SECURE_DEMO_HOME}/ca/permissions/
cp ${DDS_SECURE_DEMO_HOME}/ca/permissions/resource/PermissionsDatabaseIndex.txt ${DDS_SECURE_DEMO_HOME}/ca/permissions/
echo "  Resetting OpenSSL configuration"
cp ${DDS_SECURE_DEMO_HOME}/ca/permissions/resource/openssl.cnf ${DDS_SECURE_DEMO_HOME}/ca/permissions/
echo ""

