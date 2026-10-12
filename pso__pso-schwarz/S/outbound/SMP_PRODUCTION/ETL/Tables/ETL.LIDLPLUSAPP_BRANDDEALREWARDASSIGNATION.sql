CREATE OR REPLACE TABLE smp_production_etl.lidlplusapp_branddealrewardassignation (
eventid STRING(255) NOT NULL,
eventtimestamp DATETIME,
apitimestamp DATETIME,
userpromotionid STRING(255),
clientid STRING(255),
promotionid STRING(255),
adtemplateid STRING(255),
PRIMARY KEY (eventid) NOT ENFORCED
);