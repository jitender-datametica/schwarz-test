CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_aktion_thema (
aktion_thema_id STRING(4) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
aktion_thema_gruppe_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);