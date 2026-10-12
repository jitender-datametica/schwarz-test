CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_anlieferung_spediteur_1 (
anlieferung_spediteur_id BIGNUMERIC(38,0) NOT NULL,
anlieferung_spediteur_name STRING(255) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);