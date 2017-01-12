-- This file is used to initialize local Vagrant test environment PostgreSQL
CREATE USER vagrant WITH PASSWORD 'vagrant';
DROP DATABASE  IF EXISTS metadata;
CREATE DATABASE metadata;
CREATE DATABASE sema;

--
GRANT ALL ON DATABASE metadata TO vagrant;
ALTER DATABASE metadata OWNER TO vagrant;

--
GRANT ALL ON DATABASE sema TO vagrant;
ALTER DATABASE sema OWNER TO vagrant;

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
  vtjVerificationRequired boolean DEFAULT true
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


INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://solo3.nordea.fi/cgi-bin/SOLO3011','Nordea','AUTHENTICATION_PROVIDER','nordea.fi','high','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.nordea.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://kultaraha.osuuspankki.fi/cgi-bin/krcgi','Osuuspankki','AUTHENTICATION_PROVIDER','op.fi','high','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.oko.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://tupas.saastopankki.fi','Saastopankki','AUTHENTICATION_PROVIDER','saastopankki.fi','high','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.saastopankki.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://tunnistepalvelu.samlink.fi/TupasTunnistus/TupasServlet','Aktia','AUTHENTICATION_PROVIDER','aktia.fi','high','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.aktia.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://online.alandsbanken.fi/service/identify','Alandsbanken','AUTHENTICATION_PROVIDER','alandsbanken.fi','high','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.alandsbanken.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://online.s-pankki.fi/service/identify','S-pankki','AUTHENTICATION_PROVIDER','s-pankki.fi','high','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.s-pankki.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://tupas.poppankki.fi','Pop-pankki','AUTHENTICATION_PROVIDER','poppankki.fi','high','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.pop.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://tupas.handelsbanken.fi','Handelsbanken','AUTHENTICATION_PROVIDER','handelsbanken.fi','high','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.handelsbanken.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://verkkopankki.danskebank.fi/SP/tupaha/TupahaApp','Danske','AUTHENTICATION_PROVIDER','danskebank.fi','high','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.sampo.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://tupas.omasp.fi','OmaSP','AUTHENTICATION_PROVIDER','omasp.fi','high','TUPAS','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/tupas.omasaastopankki.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://htesti.katso.tunnistus.fi/ubitp/saml2/names/ac/password.katso.1','Katso-pwd','AUTHENTICATION_PROVIDER','katso.fi','high','KATSOPWD','VETUMA_SAML2' , 'https://htesti.katso.tunnistus.fi/uas/saml2/names/ac/password.katso.1', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://htesti.katso.tunnistus.fi/ubitp/saml2/names/ac/otp.katso.1','Katso-otp','AUTHENTICATION_PROVIDER','katso.fi','high','KATSOOTP','VETUMA_SAML2' , 'https://htesti.katso.tunnistus.fi/uas/saml2/names/ac/otp.katso.1', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'urn:oid:1.2.246.517.99.10.23.1','VRK-varmenne','AUTHENTICATION_PROVIDER','vrk.fi','high','HST','VETUMA_SAML2' , 'https://www.tunnistus.fi/ubitp/saml2/names/ac/pki.hst.3', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'urn:oid:1.2.246.517.3002.110.999','Testi','AUTHENTICATION_PROVIDER','shib-idp.kapa.ware.fi','high','TESTI','VETUMA_SAML2' , 'urn:oid:1.2.246.517.3002.110.999', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'urn:oid:1.2.246.517.3002.110.3','Mobiilivarmenne','AUTHENTICATION_PROVIDER','mobiili2.fi','high','MOBIILI','VETUMA_SAML2' , 'urn:oasis:names:tc:SAML:2.0:ac:classes:MobileTwoFactorContract', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'urn:oid:1.2.246.517.3002.110.11','MPASS','AUTHENTICATION_PROVIDER','mpass.fi','high','MPASS1','VETUMA_SAML2' , 'urn:oid:1.2.246.517.3002.110.11', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');

-- some test values of service providing parties
-- SSO/SLO test SP's
INSERT INTO "public"."metadata"   VALUES (nextval('hibernate_sequence'),0,'https://testipalvelu.test/sp','TestiPalvelu','SERVICE_PROVIDER','testipalvelu.test','high','TUPAS;HST;MOBIILI;KATSOOTP;KATSOPWD;TESTI;MPASS1','VETUMA_SAML2' , ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', FALSE);


COMMIT;
