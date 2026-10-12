--==============================================================
-- Table: crm_l_prioritaet
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_prioritaet
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_prioritaet (
crm_prioritaet_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Priorität, niedrig, mittel, hoch'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_prioritaet_id) NOT ENFORCED
) OPTIONS(description='KMR - Lookup für die Vorgangsprioritäten - MS Dynamics CRM');