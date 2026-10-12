--==============================================================
-- Table: l_lagerauftrag_status_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lagerauftrag_status_2
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:58:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lagerauftrag_status_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lagerauftrag_status_id STRING(1) NOT NULL OPTIONS(description='Lagerauftrag_2 Status_2 ID '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagerauftrag_2 Status_2 Lookup');