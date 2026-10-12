CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_emotion_2 (
crm_emotion_id INTEGER NOT NULL OPTIONS(description='Emotion ID (GUID) aus CRM'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_emotion_id) NOT ENFORCED
)
OPTIONS(description='KMR - Enthält die möglichen Bewertungen der Kundenzufriedentheit aus der CRM Entität kl_emotion - MS Dynamics CRM');