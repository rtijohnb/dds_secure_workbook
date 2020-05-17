# This script deletes the local identity CA issued certificate database
# It does NOT delete the private key file and identity cert associated with the CA
#
# This effectively returns the CA to its original state prior to having signed
# any identity certificates for applications.

if [ -z ${DDS_SECURE_DEMO_HOME+x} ]; then 
    echo "DDS_SECURE_DEMO_HOME is not set"; 
    exit 1
fi

echo ""
echo "Purging certs issued by this Identity CA:"
echo "  Purging all previously issued certificates"
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/certs/*
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/CertificateDatabase
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/CertificateDatabaseIndex.*
rm -f ${DDS_SECURE_DEMO_HOME}/ca/identity/*.old
echo "  Initializing certificate database"
cp ${DDS_SECURE_DEMO_HOME}/ca/identity/resource/CertificateDatabase ${DDS_SECURE_DEMO_HOME}/ca/identity
cp ${DDS_SECURE_DEMO_HOME}/ca/identity/resource/CertificateDatabaseIndex.txt ${DDS_SECURE_DEMO_HOME}/ca/identity
echo ""