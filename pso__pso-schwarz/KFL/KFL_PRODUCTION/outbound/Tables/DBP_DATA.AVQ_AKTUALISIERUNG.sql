--==============================================================
-- Table: avq_aktualisierung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: avq_aktualisierung
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.avq_aktualisierung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
dat_letzte_aktualisierung DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten AVQ Aktualisierung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kjwo) NOT ENFORCED
) OPTIONS(description='SCM - enthält den Zeitstempel der letzten AVQ Aktualisierung');