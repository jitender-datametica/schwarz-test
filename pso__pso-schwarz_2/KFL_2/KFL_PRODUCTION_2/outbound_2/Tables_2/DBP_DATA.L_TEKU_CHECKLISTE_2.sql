CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_teku_checkliste_2 (
teku_checkliste_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
frische_fg BIGNUMERIC(38,0) NOT NULL,
teku_checkliste_bez STRING(150) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);