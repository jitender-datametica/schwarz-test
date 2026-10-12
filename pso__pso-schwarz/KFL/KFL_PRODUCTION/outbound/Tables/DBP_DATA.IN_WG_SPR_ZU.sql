CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_wg_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
in_wg_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
in_wg_bez STRING(40) COLLATE 'und:ci' NOT NULL,
in_wg_bez_lang STRING(60) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);