CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.positionstyp_grp_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
positionstyp_grp_id STRING(4) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
positionstyp_grp_bez STRING(50) COLLATE 'und:ci' DEFAULT '' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);