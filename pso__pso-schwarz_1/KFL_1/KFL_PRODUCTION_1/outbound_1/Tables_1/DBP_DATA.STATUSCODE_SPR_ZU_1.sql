CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.statuscode_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
statuscode_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
statuscode_bez STRING(40) COLLATE 'und:ci',
statuscode_bez_kurz STRING(20) COLLATE 'und:ci',
statuscode_bez_lang STRING(100) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);