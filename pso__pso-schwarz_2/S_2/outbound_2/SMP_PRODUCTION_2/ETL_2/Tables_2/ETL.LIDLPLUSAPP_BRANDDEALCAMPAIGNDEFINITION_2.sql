CREATE OR REPLACE TABLE smp_production_etl.lidlplusapp_branddealcampaigndefinition_2 (
eventid STRING(255) NOT NULL,
eventtimestamp DATETIME,
apitimestamp DATETIME,
id STRING(255),
type STRING(255),
isactive STRING(255),
title STRING(255),
startvaliditydatetime DATETIME,
endvaliditydatetime DATETIME,
couponid STRING(255),
PRIMARY KEY (eventid) NOT ENFORCED
);


CREATE OR REPLACE TABLE smp_production_eval.`20240827_zuordnung_gesellschaft_region` (
gesellschaft_id INTEGER,
column2 INTEGER,
gesellschaft_abk STRING(500),
region_2 STRING(500),
column5 STRING(500)
);