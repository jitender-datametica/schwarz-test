--==============================================================
-- Table: geku_crm_emotion_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_emotion_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_crm_emotion_zu (
geku_crm_emotion_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mapping ID'),
geku_emotion_id BIGNUMERIC(38,0) OPTIONS(description='eindeutige ID der Emotion'),
crm_emotion_id BIGNUMERIC(38,0) OPTIONS(description='Emotion ID (GUID) aus CRM'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_crm_emotion_id) NOT ENFORCED
) OPTIONS(description='Mapping Tabelle Geku CRM für Emotionen');