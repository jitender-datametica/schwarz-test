CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kritische_zone_status_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kritische_zone_status_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kritische_zone_status_bez STRING(60) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);