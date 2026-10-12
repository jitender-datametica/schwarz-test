CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kreistyp_gruppe_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kreistyp_gruppe_id STRING(4) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kreistyp_gruppe_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);