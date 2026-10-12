--==============================================================
-- Table: crm_l_gutschein_grund_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_gutschein_grund_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_gutschein_grund_2 (
crm_gutschein_grund_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Grund der Gutscheinausgabe ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_gutschein_grund_id) NOT ENFORCED
) OPTIONS(description='KMR - Lookup für Gutscheinausgabegrund - MS Dynamics CRM');