Suomi.fi-tunnistaminen asennusohjeet
===================

Tämän ohjeen avulla saat käännettyä Suomi.fi-tunnistaminen lähdekoodit ja käynnistettyä lokaalin testiympäristön omalle koneelle.

### Ympäristö

Asennusohjeet on tehty juuri asennetun Ubuntu 16.04 LTS -käyttöjärjestelmän pohjalta. Aloitetaan asentamalla tarvittavat käännöstyökalut ja ajoympäristö.

```
sudo apt-get update # pakettilistausten päivitys
sudo apt-get dist-upgrade # pakettien päivitys
sudo add-apt-repository ppa:webupd8team/java # Oracle JDK
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D # docker
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list # docker
sudo apt-get update
 
sudo apt-get install linux-image-extra-$(uname -r) apt-transport-https ca-certificates # docker
sudo apt-get install docker-engine # docker
sudo groupadd docker # docker
sudo usermod -aG docker $USER # docker
 
sudo apt-get install oracle-java8-installer # oracle jdk
sudo apt-get install maven git ansible
 
sudo apt-get install nodejs npm gem ruby-sass ruby-compass # sevi-identification-ui
sudo ln -s /usr/bin/nodejs /usr/bin/node # sevi-identification-ui 
```
Suositeltavaa on tehdä uudelleenkäynnistys (sudo reboot) tässä välissä, jotta päivitetyt paketit ja käyttöoikeudet tulevat varmasti voimaan.

Lisää /etc/hosts -tiedostoon seuraavat rivit:
```
192.168.0.1     tunnistaminen.test
192.168.0.2     kortti.tunnistaminen.test
192.168.0.3     testipalvelu.test
```
Luo tiedosto ~/kapa/deploy-local.properties ja lisää sinne seuraavat rivit:
```
deploy_dir=~/build/deploy
log_dir=~/build/deploy/logs
```
Luo haluamasi hakemisto lähdekoodeille (tässä ohjeessa ~/build/src) sekä deploy-hakemistolle (tässä ohjeessa ~/build/deploy) ja kloonaa src-hakemistoon kaikki tarvittavat git-repositoryt:
```
mkdir -p ~/build/src
mkdir -p ~/build/deploy
cd ~/build/src
git clone https://github.com/vrk-kpa/e-identification-config-public.git
git clone https://github.com/vrk-kpa/e-identification-adapter-service-public.git e-identification-adapter-service
git clone https://github.com/vrk-kpa/e-identification-docker-images-public.git e-identification-docker-images
git clone https://github.com/vrk-kpa/e-identification-fake-vtj-public.git e-identification-fake-vtj
git clone https://github.com/vrk-kpa/e-identification-feedback-service-public.git e-identification-feedback-service
git clone https://github.com/vrk-kpa/e-identification-hst-idp-public.git e-identification-hst-idp
git clone https://github.com/vrk-kpa/e-identification-idp-service-public.git e-identification-idp-service
git clone https://github.com/vrk-kpa/e-identification-integration-idp-public.git e-identification-integration-idp
git clone https://github.com/vrk-kpa/e-identification-localisation-service-public.git e-identification-localisation-service
git clone https://github.com/vrk-kpa/e-identification-metadata-service-public.git e-identification-metadata-service
git clone https://github.com/vrk-kpa/e-identification-mobile-idp-public.git e-identification-mobile-idp
git clone https://github.com/vrk-kpa/e-identification-mobile-idp-backend-public.git e-identification-mobile-idp-backend
git clone https://github.com/vrk-kpa/e-identification-mobile-idp-plugin-public.git e-identification-mobile-idp-plugin
git clone https://github.com/vrk-kpa/e-identification-proxy-service-public.git e-identification-proxy-service
git clone https://github.com/vrk-kpa/e-identification-shared-api-public.git e-identification-shared-api
git clone https://github.com/vrk-kpa/e-identification-sp-service-public.git e-identification-sp-service
git clone https://github.com/vrk-kpa/e-identification-test-service-public.git e-identification-test-service
git clone https://github.com/vrk-kpa/e-identification-vtj-client-public.git e-identification-vtj-client
git clone https://github.com/vrk-kpa/sevi-identification-ui-public.git sevi-identification-ui
```

Osassa komponenteista build-skripteistä on poistettava käytöstä viittaukset sisäiseen docker-repoon:
```
sed --in-place "s/docker pull dev-docker/#docker pull dev-docker/g" \
 e-identification-idp-service/script/build.sh \
 e-identification-metadata-service/script/build.sh \
 e-identification-hst-idp/script/build.sh \
 e-identification-fake-vtj/script/build.sh \
 e-identification-sp-service/script/build.sh \
 e-identification-test-service/script/build.sh \
 e-identification-feedback-service/script/build.sh \
 e-identification-mobile-idp/script/build.sh \
 e-identification-proxy-service/script/build.sh \
 e-identification-integration-idp/script/build.sh

sed --in-place "s/docker push dev-docker/#docker push dev-docker/g" \
 e-identification-config-public/build/docker/tomcat/build_images.sh \
 e-identification-config-public/build/docker/tomcat-idp-3.2.1/build_images.sh \
 e-identification-config-public/build/docker/tomcat-apache2-shibd-sp/build_images.sh
```

Käännä kaikki komponentit:
```
# Docker base imaget:
cd ~/build/src/e-identification-config-public/build/docker/java8
./build.sh

cd ~/build/src/e-identification-config-public/build/docker/node
./build.sh

cd ~/build/src/e-identification-config-public/build/docker/tomcat
./build_images.sh

cd ~/build/src/e-identification-config-public/build/docker/tomcat-apache2-shibd-sp
./build_images.sh

cd ~/build/src/e-identification-config-public/build/docker/tomcat-idp-3.2.1
./build_images.sh

# Shared api:
cd ~/build/src/e-identification-shared-api
mvn clean install

# Router-imaget:
cd ~/build/src/e-identification-docker-images
e-identification-external-router/script/build.sh local
e-identification-hst-router/script/build.sh local
e-identification-internal-router/script/build.sh local

# Loput imaget:
cd ~/build/src/e-identification-adapter-service
script/build.sh -d local

cd ~/build/src/e-identification-fake-vtj
script/build.sh -d local

cd ~/build/src/e-identification-feedback-service
script/build.sh -d local

cd ~/build/src/e-identification-hst-idp
script/build.sh -d local

cd ~/build/src/e-identification-idp-service
script/build.sh -d local

cd ~/build/src/e-identification-integration-idp
script/build.sh -d local

cd ~/build/src/e-identification-localisation-service
script/build.sh -d local

cd ~/build/src/e-identification-metadata-service
script/build.sh -d local

cd ~/build/src/e-identification-mobile-idp
script/build.sh -d local

cd ~/build/src/e-identification-mobile-idp-backend
script/build.sh -d local

cd ~/build/src/e-identification-mobile-idp-plugin
script/build.sh -d local

cd ~/build/src/e-identification-proxy-service
script/build.sh -d local

cd ~/build/src/e-identification-sp-service
script/build.sh -d local

cd ~/build/src/e-identification-test-service
script/build.sh -d local

cd ~/build/src/e-identification-vtj-client
script/build.sh -d local

cd ~/build/src/sevi-identification-ui
script/build.sh -d local
```

Aja deploy-prosessi lokaalille ympäristölle:
```
cd ~/build/src/e-identification-config-public/local-public
NET_IF=enp0s3 ./deploy.sh all
```

Deployn jälkeen paketin mukana tuleva testiasiointipalvelu löytyy osoitteesta https://testipalvelu.test/
