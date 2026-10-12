CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_list_wup_zu_per_sort_1 (
art_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_bis DATE NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
list_quelle_id STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
struktur_art_id BIGNUMERIC(38,0) NOT NULL,
baustein_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
list_sap_id BIGNUMERIC(38,0) NOT NULL,
komponente_fg BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);