--==============================================================
-- Table: lagerauftrag_status_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerauftrag_status_spr_zu
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:58:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerauftrag_status_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der SpracheSprachschlüssel'),
lagerauftrag_status_id STRING(1) NOT NULL OPTIONS(description='Lagerauftrag Status ID '),
lagerauftrag_status_bez STRING(60) OPTIONS(description='Lagersortiment Name'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagerauftrag Status Bezeichnung');