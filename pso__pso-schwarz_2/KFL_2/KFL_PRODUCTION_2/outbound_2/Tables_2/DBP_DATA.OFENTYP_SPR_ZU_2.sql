CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ofentyp_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ofen_typ_id STRING(2) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
ofen_typ_bez STRING(100) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);