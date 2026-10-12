CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_flaeche_typ_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
flaeche_typ_id BIGNUMERIC(38,0) NOT NULL,
flaeche_typ_bez STRING(50) COLLATE 'und:ci',
spr_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);