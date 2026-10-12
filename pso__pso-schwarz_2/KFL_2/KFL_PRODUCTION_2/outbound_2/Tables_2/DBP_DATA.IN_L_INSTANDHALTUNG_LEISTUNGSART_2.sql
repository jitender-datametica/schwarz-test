CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_instandhaltung_leistungsart_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
instandhaltung_leistungsart_id STRING(3) COLLATE 'und:ci' DEFAULT '   ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);