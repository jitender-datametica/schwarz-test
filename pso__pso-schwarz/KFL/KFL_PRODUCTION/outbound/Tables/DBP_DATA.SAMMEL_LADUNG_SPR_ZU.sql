CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sammel_ladung_spr_zu (
sammel_ladung_fg BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
sammel_ladung_bez STRING(20) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);