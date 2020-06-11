# This script creates an identity CA for testing by doing the following:
# - Generating a private key for the CA
# - Use the key to generate a Certificate Signing Request (CSR)
# - Create an identity certificate for the CA and self-sign w/ private key
# - Deploy the public idenity CA certificate to the apps/deployall folder
#
# After running this script, you will be able to create and sign identity
# certificates for your DDS applications.  

# DDS_SECURE_DEMO_HOME environment variable must be set before running
if [ -z ${DDS_SECURE_DEMO_HOME+x} ]; then 
    echo "DDS_SECURE_DEMO_HOME is not set"; 
    exit 1
fi

cd ${DDS_SECURE_DEMO_HOME}/ca/identity

echo ""
echo "Working in directory:"
pwd

echo ""
echo "Creating a new Identity CA for self-signing certs:"
echo ""
echo "  Generating private key: ./private/cakey.pem"
openssl req -new -sha256 -key ./private/cakey.pem -out ca.csr -config openssl.cnf

echo "  Generating Certificate Signing Request: ca.csr"
openssl req -new -sha256 -key ./private/cakey.pem -out ca.csr -config openssl.cnf

echo "  Generating and self-signing the CA certificate"
openssl x509 -req -sha256 -days 3650 -in ca.csr -text -signkey ./private/cakey.pem -out cacert.pem

echo "  Deploying CA's public certificate to ${DDS_SECURE_DEMO_HOME}/app/deployall"
cp cacert.pem ${DDS_SECURE_DEMO_HOME}/apps/deployall
echo ""