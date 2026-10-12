CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.stueckliste_typ_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
stueckliste_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
stueckliste_typ_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);