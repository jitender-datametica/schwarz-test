CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_region_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
region_id STRING(3) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
region_bez STRING(20) COLLATE 'und:ci' DEFAULT '                    ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);