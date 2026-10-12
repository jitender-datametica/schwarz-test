--==============================================================
-- Table: crm_l_themenbaum_lv1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_themenbaum_lv1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_themenbaum_lv1 (
crm_themenbaum_lv1_id STRING(36) COLLATE 'und:ci' NOT NULL OPTIONS(description='Themenbaum Level 1 Id'),
name STRING(70) COLLATE 'und:ci' OPTIONS(description='Name des aktuellen Themnbaumlevels'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='KMR - Enthält Themenabumeiträge der Ebene 1 - MS Dynamics CRM');