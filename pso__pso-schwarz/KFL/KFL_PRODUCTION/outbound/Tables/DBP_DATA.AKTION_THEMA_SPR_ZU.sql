--==============================================================
-- Table: aktion_thema_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_thema_spr_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktion_thema_spr_zu (
aktion_thema_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Aktionsthema aus der SAP Tabelle WAKP'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
aktion_thema_bez STRING(20) COLLATE 'und:ci' OPTIONS(description='Bezeichnung für das Aktionsthema'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Bezeichnung der Aktionsthemen');