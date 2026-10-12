CREATE OR REPLACE TABLE smp_production_core_rel.t_nrt_track_event_1 (
eventid STRING(255) NOT NULL,
eventtimestamp DATETIME,
apitimestamp DATETIME,
adtemplateid STRING(255),
clientid STRING(255),
promotionid STRING(255),
actionlocation STRING(255),
specificity STRING(255) NOT NULL,
PRIMARY KEY (eventid, specificity) NOT ENFORCED
);