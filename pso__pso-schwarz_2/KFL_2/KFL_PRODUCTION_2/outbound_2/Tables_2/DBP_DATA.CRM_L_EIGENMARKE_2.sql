--==============================================================
-- Table: crm_l_eigenmarke_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_eigenmarke_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_eigenmarke_2 (
crm_eigenmarke_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eigenmarke ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_eigenmarke_id) NOT ENFORCED
) OPTIONS(description='KMR - Lookup für die Kaufland Eigenmarken - MS Dynamics CRM');