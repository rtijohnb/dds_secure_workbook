# This script creates a Permissions CA for testing by doing the following:
# - Generating a private key for the CA
# - Use the key to generate a Certificate Signing Request (CSR)
# - Create an identity certificate for the CA and self-sign w/ private key
# - Deploy the public Permissions CA certificate to the apps/deployall folder
#
# After running this script, you will be able to create and sign permissions
# and domain governance files for your DDS Secure applications.  

# DDS_SECURE_DEMO_HOME environment variable must be set before running
if [ -z ${DDS_SECURE_DEMO_HOME+x} ]; then 
    echo "DDS_SECURE_DEMO_HOME is not set"; 
    exit 1
fi

cd ${DDS_SECURE_DEMO_HOME}/ca/permissions

echo ""
echo "Working in directory:"
pwd

echo ""
echo "Creating a new Permissions CA for signing Permissions and Governance files:"
echo ""
echo "  Generating private key: ./private/permissionscakey.pem"
openssl ecparam -name secp256k1 -genkey -noout -out private/permissionscakey.pem

echo "  Generating Certificate Signing Request: ca.csr"
openssl req -new -sha256 -key private/permissionscakey.pem -out ca.csr -config openssl.cnf

echo "  Generating and self-signing the Permissions CA certificate"
openssl x509 -req -sha256 -days 3650 -in ca.csr -text -signkey private/permissionscakey.pem -out permissionscacert.pem

echo "  Deploying Permissions CA's public certificate to ${DDS_SECURE_DEMO_HOME}/app/deployall"
cp permissionscacert.pem ${DDS_SECURE_DEMO_HOME}/apps/deployall
echo ""

echo "  Removing the ca.csr file that is no longer needed now that the permissions ca is signed"
rm ca.csr
