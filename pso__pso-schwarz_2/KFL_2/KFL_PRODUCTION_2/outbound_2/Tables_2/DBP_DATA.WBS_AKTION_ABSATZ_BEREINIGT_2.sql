CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_aktion_absatz_bereinigt_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
bewart_id BIGNUMERIC(38,0) NOT NULL,
menge_bereinigt NUMERIC(18,3),
td_update TIMESTAMP,
td_insert TIMESTAMP
);