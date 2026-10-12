

CREATE OR REPLACE TABLE kfl_production_dbp_etl.kampagne_alle_quellen_2 (
quelle STRING(200) NOT NULL,
mandant_id INTEGER NOT NULL,
businessunitid STRING(200) NOT NULL,
customerjourneyid STRING(200) NOT NULL,
profileid STRING(200) NOT NULL,
messageid STRING(200) NOT NULL,
journeyrunid STRING(200) NOT NULL,
timestamp TIMESTAMP NOT NULL,
linktext STRING(2000) NOT NULL,
targeturl STRING(2000) NOT NULL,
linkname STRING(2000) NOT NULL,
messagevariationindexes STRING(200) NOT NULL,
emailaddressused STRING(200) NOT NULL,
category STRING(200) NOT NULL,
platform STRING(200) NOT NULL,
blockedreason STRING(200) NOT NULL,
bouncetype STRING(200) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP,
deliveredcount INTEGER NOT NULL,
PRIMARY KEY (quelle, mandant_id, businessunitid, customerjourneyid, profileid, messageid, journeyrunid, timestamp,
 linktext, targeturl, linkname, messagevariationindexes, emailaddressused, category, platform, blockedreason) NOT ENFORCED
);



