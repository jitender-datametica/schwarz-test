--==============================================================
-- Table: oug_id_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: oug_id_spr_zu_2
   generated from Powerdesigner on Montag, 6. September 2021 14:09:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.oug_id_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
oug_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kennzeichen Obst und Gemüse'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
oug_id_bez STRING(40) NOT NULL OPTIONS(description='Bezeichnung für Kennzeichen Obst und Gemüse'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='AIS - Sprachabhängige Bezeichnungen für das Kennzeichen Obst und Gemüse - SAP RET ZZEK_KZTGART_LAN');