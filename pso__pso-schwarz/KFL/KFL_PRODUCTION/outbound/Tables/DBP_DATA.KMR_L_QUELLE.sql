CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_l_quelle (
kmr_quelle_id BIGNUMERIC(38,0) NOT NULL,
kmr_quelle_bez STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);