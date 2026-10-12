CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kjmo_spr_zu_2 (
kjmo BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kjmo_bez STRING(20) COLLATE 'und:ci',
kjmo_bez_lang STRING(20) COLLATE 'und:ci',
gjmo BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);