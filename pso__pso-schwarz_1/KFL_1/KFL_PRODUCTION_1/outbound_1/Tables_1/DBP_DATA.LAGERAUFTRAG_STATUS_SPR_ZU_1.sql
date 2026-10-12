--==============================================================
-- Table: lagerauftrag_status_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerauftrag_status_spr_zu_1
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:58:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerauftrag_status_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der SpracheSprachschlüssel'),
lagerauftrag_status_id STRING(1) NOT NULL OPTIONS(description='Lagerauftrag_1 Status_1 ID '),
lagerauftrag_status_bez STRING(60) OPTIONS(description='Lagersortiment Name'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagerauftrag_1 Status_1 Bezeichnung');