--==============================================================
-- Table: tp_objekt_status_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tp_objekt_status_spr_zu_2
   generated from Powerdesigner on Donnerstag, 18. August 2022 08:45:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tp_objekt_status_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
tp_objekt_status_id STRING(5) NOT NULL OPTIONS(description='Systemstatus'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachenschlüssel'),
tp_objekt_status_kbez STRING(4) OPTIONS(description='Einzelstatus eines Objekts (Kurzform)'),
tp_objekt_status_bez STRING(30) OPTIONS(description='Einzelstatus eines Objekts'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, tp_objekt_status_id, spr_id) NOT ENFORCED
) OPTIONS(description='Bezeichnung der Objektstatus aus SAP Industry (Tabelle TJ02T)');