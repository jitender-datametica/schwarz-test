CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.metadata_artbew_rb_de_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
bewart_id BIGNUMERIC(38,0) NOT NULL,
menge_alt NUMERIC(18,3) NOT NULL,
menge_neu NUMERIC(18,3) NOT NULL,
wg_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);