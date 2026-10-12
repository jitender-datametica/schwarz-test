--==============================================================
-- Table: crm_l_emotion_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_emotion_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_emotion_2 (
crm_emotion_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Emotion ID (GUID) aus CRM'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_emotion_id) NOT ENFORCED
)
OPTIONS(description='KMR - Enthält die möglichen Bewertungen der Kundenzufriedentheit aus der CRM Entität kl_emotion - MS Dynamics CRM');