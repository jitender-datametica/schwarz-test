CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_mamo_wup_massnahme_per (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_massnahme_von DATE NOT NULL,
dat_massnahme_bis DATE,
modernisierung_art STRING(20) COLLATE 'und:ci' NOT NULL,
gj BIGNUMERIC(38,0),
immo_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
hinweis_massnahme STRING(20) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);