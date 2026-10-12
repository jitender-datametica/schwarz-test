CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rech_beleg_status_spr_zu_2 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
rech_beleg_status_id STRING(1) COLLATE 'und:ci' NOT NULL,
rech_beleg_status_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);