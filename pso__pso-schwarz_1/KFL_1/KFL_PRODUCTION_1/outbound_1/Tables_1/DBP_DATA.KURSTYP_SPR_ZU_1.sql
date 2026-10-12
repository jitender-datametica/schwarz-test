CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kurstyp_spr_zu_1 (
kurstyp_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kurstyp_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);