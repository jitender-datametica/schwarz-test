CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sonderabwicklung_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
sonderabwicklung_id STRING(20) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
sonderabwicklung_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);