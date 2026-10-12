CREATE OR REPLACE TABLE smp_production_etl.lidlplusapp_branddealimpression_1 (
eventid STRING(255) NOT NULL,
eventtimestamp DATETIME,
apitimestamp DATETIME,
adtemplateid STRING(255),
clientid STRING(255),
promotionid STRING(255),
actionlocation STRING(255),
PRIMARY KEY (eventid) NOT ENFORCED
);