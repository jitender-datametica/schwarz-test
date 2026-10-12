--==============================================================
-- Table: l_oug_id_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_oug_id_1
   generated from Powerdesigner on Montag, 6. September 2021 14:06:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_oug_id_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
oug_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kennzeichen Obst und Gemüse'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='AIS - Lookup für das Kennzeichen Obst und Gemüse - SAP RET ZZEK_KZTGART_VAL');