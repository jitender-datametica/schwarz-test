--==============================================================
-- Table: crm_l_prozess_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_prozess_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_prozess_1 (
crm_prozess_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Prozess ID (GUID) aus CRM - oberste Stuffe der Hierarchie'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_prozess_id) NOT ENFORCED
) OPTIONS(description='KMR - Oberste Ebene der CRM Hierarchie - MS Dynamics CRM');