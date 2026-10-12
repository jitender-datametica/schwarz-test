CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_hierarchie_ebene_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ma_hierarchie_ebene_id STRING(4) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
ma_hierarchie_ebene_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);