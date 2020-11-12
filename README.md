Suomi.fi-tunnistaminen asennusohjeet
===================

Tämän ohjeen avulla saat käännettyä Suomi.fi-tunnistaminen lähdekoodit ja käynnistettyä lokaalin testiympäristön omalle koneelle.

### Ympäristö

Asennusohjeet on tehty juuri asennetun Ubuntu 20.04 LTS -käyttöjärjestelmän pohjalta. Aloitetaan asentamalla tarvittavat käännöstyökalut ja ajoympäristö.

```
sudo apt-get update # pakettilistausten päivitys
sudo apt-get -y dist-upgrade # pakettien päivitys

### Zulu8-jdk
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 # zulu jdk
# Download the installation package from the Azul Systems site 
wget https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-2_all.deb
sudo apt-get install ./zulu-repo_1.0.0-2_all.deb #Install Zulu repositories
sudo apt-get update
sudo apt-get install zulu8-jdk

### Docker
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
\# Verify fingerprint
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER # docker
sudo apt-get -y install maven git ansible

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

sudo apt-get -y install nodejs gem ruby-sass compass-blueprint-plugin # e-identification-static-ui
sudo ln -s /usr/bin/nodejs /usr/bin/node # e-identification-static-ui
```
Suositeltavaa on tehdä uudelleenkäynnistys (sudo reboot) tässä välissä, jotta päivitetyt paketit ja käyttöoikeudet tulevat varmasti voimaan.

Lisää /etc/hosts -tiedostoon seuraavat rivit:
```
192.168.0.1     tunnistaminen.test
192.168.0.2     kortti.tunnistaminen.test
192.168.0.3     testipalvelu.test
```
Luo hakemisto (mkdir ~/kapa) ja lisää uuteen tiedostoon ~/kapa/deploy-local.properties seuraavat rivit:
```
deploy_dir=~/build/deploy
log_dir=~/build/deploy/logs
```
Luo haluamasi hakemisto lähdekoodeille (tässä ohjeessa ~/build/src) sekä deploy-hakemistolle (tässä ohjeessa ~/build/deploy) ja kloonaa src-hakemistoon kaikki tarvittavat git-repositoryt:
```
mkdir -p ~/build/src
mkdir -p ~/build/deploy
cd ~/build/src
git clone https://github.com/vrk-kpa/e-identification-base-images-public.git
git clone https://github.com/vrk-kpa/e-identification-config-public.git
git clone https://github.com/vrk-kpa/e-identification-docker-images-public.git e-identification-docker-images
git clone https://github.com/vrk-kpa/e-identification-fake-vtj-public.git e-identification-fake-vtj
git clone https://github.com/vrk-kpa/e-identification-feedback-service-public.git e-identification-feedback-service
git clone https://github.com/vrk-kpa/e-identification-hst-idp-public.git e-identification-hst-idp
git clone https://github.com/vrk-kpa/e-identification-idp-service-public.git e-identification-idp-service
git clone https://github.com/vrk-kpa/e-identification-metadata-service-public.git e-identification-metadata-service
git clone https://github.com/vrk-kpa/e-identification-proxy-service-public.git e-identification-proxy-service
git clone https://github.com/vrk-kpa/e-identification-shared-api-public.git e-identification-shared-api
git clone https://github.com/vrk-kpa/e-identification-sp-service-public.git e-identification-sp-service
git clone https://github.com/vrk-kpa/e-identification-test-service-public.git e-identification-test-service
git clone https://github.com/vrk-kpa/e-identification-vtj-client-public.git e-identification-vtj-client
git clone https://github.com/vrk-kpa/e-identification-vartti-client-public.git e-identification-vartti-client
git clone https://github.com/vrk-kpa/e-identification-static-ui-public.git e-identification-static-ui
git clone https://github.com/vrk-kpa/e-identification-test-idp-public.git e-identification-test-idp
```

Osassa komponenteista build-skripteistä on poistettava käytöstä viittaukset sisäiseen docker-repoon:
```
sed --in-place "s/docker pull e-identification-docker-virtual/#docker pull e-identification-docker-virtual/g" \
 e-identification-idp-service/script/build.sh \
 e-identification-metadata-service/script/build.sh \
 e-identification-hst-idp/script/build.sh \
 e-identification-fake-vtj/script/build.sh \
 e-identification-sp-service/script/build.sh \
 e-identification-test-service/script/build.sh \
 e-identification-feedback-service/script/build.sh \
 e-identification-proxy-service/script/build.sh \
 e-identification-vartti-client/script/build.sh \
 e-identification-test-idp/script/build.sh \
 e-identification-vtj-client/script/build.sh \
 e-identification-base-images-public/tomcat/build_images.sh \
 e-identification-base-images-public/tomcat-idp-3.2.1/build_images.sh \
 e-identification-base-images-public/tomcat-idp-3.4.1/build_images.sh \
 e-identification-base-images-public/tomcat-idp-3.4.6/build_images.sh \
 e-identification-base-images-public/tomcat-apache2-shibd-sp/build_images.sh \
 e-identification-base-images-public/centos7-shibd/build.sh
```

Käännä kaikki komponentit:
```
# Docker base imaget:
cd ~/build/src/e-identification-base-images-public/centos7-java8
./build.sh

cd ~/build/src/e-identification-base-images-public/centos7-shibd
./build.sh

cd ~/build/src/e-identification-base-images-public/java8
./build.sh

cd ~/build/src/e-identification-base-images-public/node
./build.sh

cd ~/build/src/e-identification-base-images-public/tomcat
./build_images.sh
````
Fetched 19.0 MB in 9s (1938 kB/s)
Reading package lists...
E: The method driver /usr/lib/apt/methods/https could not be found.
E: Failed to fetch https://repos.azul.com/zulu/deb/dists/stable/InRelease  
E: Some index files failed to download. They have been ignored, or old ones used instead.
The command '/bin/sh -c set -x     && apt-get update     && apt-get -y upgrade && apt-get install -yq gcc make openssl libssl-dev libapr1 libapr1-dev less 	&& tar zxf /usr/share/tomcat/bin/tomcat-native.tar.gz -C /tmp 	&& cd /tmp/tomcat-native*-src/native/ 	&& ./configure --with-apr=/usr/bin/apr-1-config --with-java-home=/usr/lib/jvm/zulu-8-amd64 --with-ssl=yes --libdir=/usr/lib/ 	&& make && make install 	&& apt-get purge -y gcc make libssl-dev libapr1-dev 	&& apt-get -y autoremove 	&& rm -rf /tmp/tomcat-native* 	&& rm -rf /var/lib/apt/lists/*' returned a non-zero code: 100
````

cd ~/build/src/e-identification-base-images-public/tomcat-apache2-shibd-sp
./build_images.sh

cd ~/build/src/e-identification-base-images-public/tomcat-idp-3.2.1
./build_images.sh

cd ~/build/src/e-identification-base-images-public/tomcat-idp-3.4.1
./build_images.sh

cd ~/build/src/e-identification-base-images-public/tomcat-idp-3.4.6
./build_images.sh

# Shared api:
cd ~/build/src/e-identification-shared-api
mvn clean install

# Router-imaget:
cd ~/build/src/e-identification-docker-images
e-identification-external-router/script/build.sh local
e-identification-hst-router/script/build.sh local
e-identification-internal-router/script/build.sh local
e-identification-eidas-router/script/build.sh local

# Loput imaget:
cd ~/build/src/e-identification-fake-vtj
script/build.sh -d local

cd ~/build/src/e-identification-feedback-service
script/build.sh -d local

cd ~/build/src/e-identification-hst-idp
script/build.sh -d local

cd ~/build/src/e-identification-idp-service
script/build.sh -d local

cd ~/build/src/e-identification-metadata-service
script/build.sh -d local

cd ~/build/src/e-identification-proxy-service
script/build.sh -d local

cd ~/build/src/e-identification-sp-service
script/build.sh -d local

cd ~/build/src/e-identification-test-service
script/build.sh -d local

cd ~/build/src/e-identification-vtj-client
script/build.sh -d local

cd ~/build/src/e-identification-vartti-client
script/build.sh -d local

cd ~/build/src/e-identification-static-ui
script/build.sh -d local

cd ~/build/src/e-identification-test-idp
script/build.sh -d local
```

Aja deploy-prosessi lokaalille ympäristölle:
```
cd ~/build/src/e-identification-config-public/local-public
./deploy.sh all
```

Deployn jälkeen paketin mukana tuleva testiasiointipalvelu löytyy osoitteesta https://testipalvelu.test/

Huom! Selain varoittaa palvelinvarmenteista. Tämä on normaalia sillä julkaisussa on käytössä ns. self-signed varmenteet.  
Jotkin selaimet voivat vaatia yksityisen tilan käyttöä varoituksen ohittamiseksi.  
