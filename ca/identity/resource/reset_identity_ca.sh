# This script resets the identity CA by doing the following:
# - purging all previously issued identity cerficates from its database
# - purging the private key associated with the CA
# - purging the previously created CA certificate (public key)
# After running this script, you will have run the OpenSSL commands necessary
# to setup to self-sign certificates.

# DDS_SECURE_DEMO_HOME environment variable must be set before running
if [ -z ${DDS_SECURE_DEMO_HOME+x} ]; then 
    echo "DDS_SECURE_DEMO_HOME is not set"; 
    exit 1
fi

echo ""
echo "Reseting the Identity CA:"
echo "  Purging all previously issued certificates"
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/certs/*
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/CertificateDatabase
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/CertificateDatabaseIndex.*
echo "  Cleaning up temporary & leftover files"
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/*.csr
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/*.pem
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/*.cnf
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/*.old
echo "  Removing private key"
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/private/*
echo "  Initializing certificate database"
cp ${DDS_SECURE_DEMO_HOME}/ca/identity/resource/CertificateDatabase ${DDS_SECURE_DEMO_HOME}/ca/identity
cp ${DDS_SECURE_DEMO_HOME}/ca/identity/resource/CertificateDatabaseIndex.txt ${DDS_SECURE_DEMO_HOME}/ca/identity
echo "  Resetting OpenSSL configuration"
cp ${DDS_SECURE_DEMO_HOME}/ca/identity/resource/openssl.cnf ${DDS_SECURE_DEMO_HOME}/ca/identity
echo ""
