--==============================================================
-- Table: banf_prognose_gp_filter
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: banf_prognose_gp_filter
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.banf_prognose_gp_filter (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gp_id) NOT ENFORCED
)
OPTIONS(description='FLW - Lookuptabelle - Filter der Lieferanten, die in den Bestellanforderungsprognosen berücksichtigt werden sollen - wird manuell versorgt');