CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_sollstundenmodell_tag_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
zeit_stunde BIGNUMERIC(38,0) NOT NULL,
treiber_id BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci',
wert_tag NUMERIC(18,3),
wert_stunde NUMERIC(18,3),
td_insert TIMESTAMP,
td_update TIMESTAMP
);