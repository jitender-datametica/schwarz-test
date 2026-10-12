--==============================================================
-- Table: banf_prognose_gp_filter_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: banf_prognose_gp_filter_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.banf_prognose_gp_filter_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gp_id) NOT ENFORCED
)
OPTIONS(description='FLW - Lookuptabelle - Filter der Lieferanten, die in den Bestellanforderungsprognosen berücksichtigt werden sollen - wird manuell versorgt');