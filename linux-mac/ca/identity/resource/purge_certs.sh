# TODO: Add check to make sure script is not running from resource directory
rm certs/*
rm CertificateDatabase
rm CertificateDatabaseIndex.*
rm *.old
cp ./resource/CertificateDatabase .
cp ./resource/CertificateDatabaseIndex.txt .

