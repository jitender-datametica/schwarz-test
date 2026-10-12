--==============================================================
-- Table: crm_fremdkoerper_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_fremdkoerper_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_fremdkoerper_spr_zu_2 (
crm_fremdkoerper_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Art_2 der Verunreinigung ID'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
crm_fremdkoerper_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Fremdkörper Bezeichnung DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_fremdkoerper_id, spr_id) NOT ENFORCED
) OPTIONS(description='KMR - Sprachzuordnungstabelle Fremdkörper - MS Dynamics CRM');