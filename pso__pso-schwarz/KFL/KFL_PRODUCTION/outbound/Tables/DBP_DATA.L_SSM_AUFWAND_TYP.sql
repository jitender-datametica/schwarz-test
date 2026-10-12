CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ssm_aufwand_typ (
ssm_aufwand_typ_id BIGNUMERIC(38,0) NOT NULL,
ssm_aufwand_typ_bez STRING(20) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);