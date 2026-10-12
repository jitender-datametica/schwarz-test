CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_aktivitaet_typ_2 (
aktivitaet_typ_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
aktivitaet_typ_bez STRING(40) COLLATE 'und:ci',
spr_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);