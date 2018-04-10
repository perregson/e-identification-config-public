#!/bin/bash
# check os, os x users install coreutils: brew install coreutils
unamestr=$(uname)
if [ $unamestr == "Linux" ]; then
  SCRIPTFILE=$(readlink -f "$0")
elif [ $unamestr == "Darwin" ]; then
  SCRIPTFILE=$(greadlink -f "$0")
fi
SCRIPTPATH=$(dirname "$SCRIPTFILE")

rm -rf $SCRIPTPATH/tempdir
mkdir $SCRIPTPATH/tempdir

cd $SCRIPTPATH/tempdir
tar zxf ../shibboleth-identity-provider-3.2.1.tar.gz

mkdir saml-jar
cd saml-jar

jar xf ../shibboleth-identity-provider-3.2.1/webapp/WEB-INF/lib/opensaml-saml-impl-3.2.0.jar
cp ../../saml2-post-binding.vm templates/saml2-post-binding.vm
jar cf ../shibboleth-identity-provider-3.2.1/webapp/WEB-INF/lib/opensaml-saml-impl-3.2.0.jar .
cd ..
tar zcf ../shibboleth-identity-provider-3.2.1-post-binding.tar.gz shibboleth-identity-provider-3.2.1/
rm -rf $SCRIPTPATH/tempdir
