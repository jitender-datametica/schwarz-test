CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.massnahmenart_spr_zu_2 (
massnahmenart_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
massnahmenart_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);