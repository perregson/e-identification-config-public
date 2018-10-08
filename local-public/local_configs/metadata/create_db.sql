-- This file is used to initialize local Vagrant test environment PostgreSQL
CREATE USER vagrant WITH PASSWORD 'vagrant';
DROP DATABASE  IF EXISTS metadata;
CREATE DATABASE metadata;

--
GRANT ALL ON DATABASE metadata TO vagrant;
ALTER DATABASE metadata OWNER TO vagrant;

\c metadata

DROP TABLE  IF EXISTS metadata;
DROP SEQUENCE  IF EXISTS hibernate_sequence;



CREATE SEQUENCE hibernate_sequence
  START WITH 1
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE TABLE metadata(
  id bigint NOT NULL,
  version bigint NOT NULL,
  entityid CHARACTER VARYING(255) NOT NULL, -- SPs,IDPs & BAnks
  name CHARACTER VARYING(255) NOT NULL,
  providertype CHARACTER VARYING(255) NOT NULL, -- SP, IDP,BANK  etc -- see
  dnsname CHARACTER VARYING(255) NOT NULL,
  loa CHARACTER VARYING(255) NOT NULL,
  attr_loa CHARACTER VARYING(255) NOT NULL,
  profile CHARACTER VARYING(255) NOT NULL,
  acsAddress CHARACTER VARYING(255) NOT NULL,
  sloAddress CHARACTER VARYING(255) NOT NULL,
  pubKey CHARACTER VARYING(255) NOT NULL,
  userAttributes CHARACTER VARYING(255) NOT NULL,
  serviceName_fi CHARACTER VARYING(255) NOT NULL,
  serviceName_sv CHARACTER VARYING(255) NOT NULL,
  serviceName_en CHARACTER VARYING(255) NOT NULL,
  organizationName_fi CHARACTER VARYING(255) NOT NULL,
  organizationName_sv CHARACTER VARYING(255) NOT NULL,
  organizationName_en CHARACTER VARYING(255) NOT NULL,
  administrativeContact_name CHARACTER VARYING(255) NOT NULL,
  administrativeContact_email CHARACTER VARYING(255) NOT NULL,
  technicalContact_name CHARACTER VARYING(255) NOT NULL,
  technicalContact_email CHARACTER VARYING(255) NOT NULL,
  vtjVerificationRequired boolean DEFAULT true,
  eidasContactAddress CHARACTER VARYING(255) NOT NULL DEFAULT ' ',
  eidasSupport CHARACTER VARYING(255) NOT NULL DEFAULT 'full'
);

--CREATE TABLE loa(
--  id bigint NOT NULL,
--  nameId NOT NULL,
--  uriId CHARACTER VARYING(255) NOT NULL, -- SPs,IDPs & BAnks
--  name CHARACTER VARYING(255) NOT NULL
--
--);

ALTER TABLE hibernate_sequence OWNER TO vagrant;
ALTER TABLE metadata OWNER TO vagrant;

begin TRANSACTION;


INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://solo3.nordea.fi/cgi-bin/SOLO3011','Nordea','AUTHENTICATION_PROVIDER','nordea.fi','fLoA2','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.nordea.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://kultaraha.osuuspankki.fi/cgi-bin/krcgi','Osuuspankki','AUTHENTICATION_PROVIDER','op.fi','fLoA2','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.oko.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://tupas.saastopankki.fi','Saastopankki','AUTHENTICATION_PROVIDER','saastopankki.fi','fLoA2','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.saastopankki.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://tunnistepalvelu.samlink.fi/TupasTunnistus/TupasServlet','Aktia','AUTHENTICATION_PROVIDER','aktia.fi','fLoA2','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.aktia.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://online.alandsbanken.fi/service/identify','Alandsbanken','AUTHENTICATION_PROVIDER','alandsbanken.fi','fLoA2','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.alandsbanken.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://online.s-pankki.fi/service/identify','S-pankki','AUTHENTICATION_PROVIDER','s-pankki.fi','fLoA2','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.s-pankki.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://tupas.poppankki.fi','Pop-pankki','AUTHENTICATION_PROVIDER','poppankki.fi','fLoA2','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.pop.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://tupas.handelsbanken.fi','Handelsbanken','AUTHENTICATION_PROVIDER','handelsbanken.fi','fLoA2','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.handelsbanken.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://verkkopankki.danskebank.fi/SP/tupaha/TupahaApp','Danske','AUTHENTICATION_PROVIDER','danskebank.fi','fLoA2','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.sampo.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://tupas.omasp.fi','OmaSP','AUTHENTICATION_PROVIDER','omasp.fi','fLoA2','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.omasaastopankki.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://htesti.katso.tunnistus.fi/ubitp/saml2/names/ac/password.katso.1','Katso-pwd','AUTHENTICATION_PROVIDER','katso.fi','KATSOPWD','KATSOPWD','VETUMA_SAML2' , 'https://htesti.katso.tunnistus.fi/uas/saml2/names/ac/password.katso.1', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://htesti.katso.tunnistus.fi/ubitp/saml2/names/ac/otp.katso.1','Katso-otp','AUTHENTICATION_PROVIDER','katso.fi','KATSOOTP','KATSOOTP','VETUMA_SAML2' , 'https://htesti.katso.tunnistus.fi/uas/saml2/names/ac/otp.katso.1', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'urn:oid:1.2.246.517.99.10.23.1','VRK-varmenne','AUTHENTICATION_PROVIDER','vrk.fi','fLoA2','HST','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/pki.hst.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'urn:oid:1.2.246.517.3002.110.999','Testi','AUTHENTICATION_PROVIDER','shib-idp.kapa.ware.fi','TESTI','TESTI','VETUMA_SAML2' , 'urn:oid:1.2.246.517.3002.110.999', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'urn:oid:1.2.246.517.3002.110.3','Mobiilivarmenne','AUTHENTICATION_PROVIDER','mobiili2.fi','fLoA2','MOBIILI','VETUMA_SAML2' , 'urn:oasis:names:tc:SAML:2.0:ac:classes:MobileTwoFactorContract', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'urn:oid:1.2.246.517.3002.110.3','Mobiilivarmenne','AUTHENTICATION_PROVIDER','tunnistus-pp.telia.fi','fLoA2','MOBIILI','VETUMA_SAML2' , 'https://tunnistus-pp.telia.fi/uas/saml2/names/ac/mpki.telia.test.1' , ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'urn:oid:1.2.246.517.3002.110.11','MPASS','AUTHENTICATION_PROVIDER','mpass.fi','MPASS1','MPASS1','VETUMA_SAML2' , 'urn:oid:1.2.246.517.3002.110.11', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'http://eidas.europa.eu/LoA/high','Eidas','AUTHENTICATION_PROVIDER','suomi.fi','eLoA3','eLoA3','VETUMA_SAML2' , 'http://eidas.europa.eu/LoA/high', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');

-- some test values of service providing parties
-- SSO/SLO test SP's
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://testipalvelu.test/sp','TestiPalvelu','SERVICE_PROVIDER','testipalvelu.test','','KATSOOTP;KATSOPWD;TESTI;fLoA2;fLoA3;eLoA2;eLoA3','VETUMA_SAML2' , ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', FALSE);


COMMIT;


DROP TABLE  IF EXISTS country;

CREATE TABLE country(
  id bigint NOT NULL,
  countryCode CHARACTER VARYING(2) NOT NULL,
  imgSrc CHARACTER VARYING(255) NOT NULL,
  displayName_fi CHARACTER VARYING(255) NOT NULL,
  displayName_sv CHARACTER VARYING(255) NOT NULL,
  displayName_en CHARACTER VARYING(255) NOT NULL,
  levelOfAssurance CHARACTER VARYING(255) NOT NULL,
  eidasLoginContext CHARACTER VARYING(255) NOT NULL,
  sortOrder bigint NOT NULL,
  enabled boolean DEFAULT true
);

ALTER TABLE country OWNER TO {{ jdbc_username }};

begin TRANSACTION;

INSERT INTO "public"."country"   VALUES (nextval('hibernate_sequence'), 'EE', '/resources/images/flags/ee.svg', 'Viro', 'Estland', 'Estonia', 'eLoA3', '/Shibboleth.sso/LoginTest', 1, TRUE);
INSERT INTO "public"."country"   VALUES (nextval('hibernate_sequence'), 'DE', '/resources/images/flags/de.svg', 'Saksa', 'Tyskland', 'Germany', 'eLoA3', '/Shibboleth.sso/LoginTest', 2, TRUE);
INSERT INTO "public"."country"   VALUES (nextval('hibernate_sequence'), 'PL', '/resources/images/flags/pl.svg', 'Puola', 'Polen', 'Poland', 'eLoA3', '/Shibboleth.sso/LoginTest', 3, TRUE);
INSERT INTO "public"."country"   VALUES (nextval('hibernate_sequence'), 'FR', '/resources/images/flags/fr.svg', 'Ranska', 'Frankrike', 'France', 'eLoA3', '/Shibboleth.sso/LoginTest', 4, TRUE);
INSERT INTO "public"."country"   VALUES (nextval('hibernate_sequence'), 'UK', '/resources/images/flags/uk.svg', 'Yhdistynyt kuningaskunta', 'Förenade kungariket', 'United Kingdom', 'eLoA3', '/Shibboleth.sso/LoginTest', 5, TRUE);
INSERT INTO "public"."country"   VALUES (nextval('hibernate_sequence'), 'CX', '/resources/images/flags/cx.svg', 'Maa X', 'Land X', 'Country X', 'eLoA3', '/Shibboleth.sso/LoginTest', 6, TRUE);

COMMIT;
