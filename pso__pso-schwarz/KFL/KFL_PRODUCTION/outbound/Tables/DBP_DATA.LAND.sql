CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.land (
land_id STRING(2) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
land_bez STRING(20) COLLATE 'und:ci' NOT NULL,
land_iso STRING(2) COLLATE 'und:ci' NOT NULL,
eu_land_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);