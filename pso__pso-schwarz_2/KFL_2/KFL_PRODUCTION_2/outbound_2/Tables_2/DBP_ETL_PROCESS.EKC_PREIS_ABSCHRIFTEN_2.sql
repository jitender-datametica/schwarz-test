CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ekc_preis_abschriften_2 (
mandant_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
bewart_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
dat DATE,
wrg_id STRING(3) COLLATE 'und:ci',
zek_id BIGNUMERIC(38,0),
eigenmarke_fg BIGNUMERIC(38,0),
wup_bereinigt_fg BIGNUMERIC(38,0),
preis_abschrift_netto NUMERIC(18,4) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);