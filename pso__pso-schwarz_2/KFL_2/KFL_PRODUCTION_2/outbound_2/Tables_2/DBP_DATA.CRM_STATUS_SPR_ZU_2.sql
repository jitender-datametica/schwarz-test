--==============================================================
-- Table: crm_status_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_status_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_status_spr_zu_2 (
crm_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ticket Status_2 ID z. B. Abgeschlossen'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
crm_status_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Status_2 Bezeichnung DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_status_id, spr_id) NOT ENFORCED
) OPTIONS(description='KMR - Sprachzuordnungstabelle Statuscode - MS Dynamics CRM');