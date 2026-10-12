--==============================================================
-- Table: crm_l_fremdkoerper_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_fremdkoerper_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_fremdkoerper_2 (
crm_fremdkoerper_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Art_2 der Verunreinigung ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_fremdkoerper_id) NOT ENFORCED
) OPTIONS(description='KMR - Lookup für Fremdkörper - MS Dynamics CRM');