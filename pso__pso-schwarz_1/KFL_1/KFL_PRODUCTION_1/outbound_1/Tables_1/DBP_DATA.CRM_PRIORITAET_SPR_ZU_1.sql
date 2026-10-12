--==============================================================
-- Table: crm_prioritaet_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_prioritaet_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_prioritaet_spr_zu_1 (
crm_prioritaet_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Priorität, niedrig, mittel, hoch'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
crm_prioritaet_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Priorität Bezeichnung DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_prioritaet_id, spr_id) NOT ENFORCED
) OPTIONS(description='KMR - Sprachzuordnungstabelle Priorität - MS Dynamics CRM');