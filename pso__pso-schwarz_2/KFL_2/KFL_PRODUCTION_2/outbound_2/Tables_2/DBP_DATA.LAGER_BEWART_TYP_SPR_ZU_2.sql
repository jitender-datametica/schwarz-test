CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lager_bewart_typ_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lager_bewart_typ_id BIGNUMERIC(38,0) NOT NULL,
hist_fg BIGNUMERIC(38,0) NOT NULL,
lager_bewart_typ_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);