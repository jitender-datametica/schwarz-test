CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_geku_grund (
geku_grund_uid INTEGER NOT NULL,
geku_grund_id STRING(60) COLLATE 'und:ci' NOT NULL,
geku_bereich_uid INTEGER NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);