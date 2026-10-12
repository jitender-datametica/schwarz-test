CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_teku_frage_1 (
teku_frage_id BIGNUMERIC(38,0) NOT NULL,
teku_frage_zyklus STRING(255) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);