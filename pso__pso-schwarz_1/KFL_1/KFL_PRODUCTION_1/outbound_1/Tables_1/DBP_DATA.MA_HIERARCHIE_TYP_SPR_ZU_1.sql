CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_hierarchie_typ_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ma_hierarchie_typ_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
ma_hierarchie_typ_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);