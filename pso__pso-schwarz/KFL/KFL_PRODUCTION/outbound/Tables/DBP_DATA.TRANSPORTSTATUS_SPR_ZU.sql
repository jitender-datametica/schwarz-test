CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportstatus_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
transportstatus_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
transportstatus_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);