CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_spediteur_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spediteur_id BIGNUMERIC(38,0) NOT NULL,
spediteur_name STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);