CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_aktion_thema_gruppe (
aktion_thema_gruppe_id BIGNUMERIC(38,0) NOT NULL,
aktion_thema_gruppe_bez STRING(30) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);