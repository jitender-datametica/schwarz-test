CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_nettostunden_quelle_1 (
quelle_id BIGNUMERIC(38,0) NOT NULL,
quelle_bez STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);