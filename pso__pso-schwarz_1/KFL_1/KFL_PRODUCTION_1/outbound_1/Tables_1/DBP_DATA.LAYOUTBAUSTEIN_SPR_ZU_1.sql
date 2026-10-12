CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.layoutbaustein_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
layoutbaustein_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
layoutbaustein_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);