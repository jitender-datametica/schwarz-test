CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kreistyp_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kreistyp_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kreistyp_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);