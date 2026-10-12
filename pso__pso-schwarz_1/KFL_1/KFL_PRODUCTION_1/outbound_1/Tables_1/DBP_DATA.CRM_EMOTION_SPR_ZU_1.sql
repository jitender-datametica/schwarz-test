--==============================================================
-- Table: crm_emotion_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_emotion_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_emotion_spr_zu_1 (
crm_emotion_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Emotion ID (GUID) aus CRM'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
emotion_bez STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='Emotion text'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_emotion_id, spr_id) NOT ENFORCED
)
OPTIONS(description='KMR - Enthält die möglichen Bewertungen der Kundenzufriedentheit aus der CRM Entität kl_emotion - MS Dynamics CRM');