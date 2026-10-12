CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rech_erfassung_spr_zu (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
erfassung_id STRING(3) COLLATE 'und:ci' NOT NULL,
erfassung_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);