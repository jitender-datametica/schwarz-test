--==============================================================
-- Table: crm_prozess_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_prozess_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_prozess_spr_zu (
crm_prozess_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Prozess ID (GUID) aus CRM - oberste Stuffe der Hierarchie'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
prozess_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Prozesses aus CRM'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_prozess_id, spr_id) NOT ENFORCED
) OPTIONS(description='KMR - Oberste Ebene der CRM Hierarchie - MS Dynamics CRM');