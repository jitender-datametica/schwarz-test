CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.werbung_kennzahlen_kopf (
kjwo BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
werbe_typ_id BIGNUMERIC(38,0) NOT NULL,
posten_id STRING(2) COLLATE 'und:ci' NOT NULL,
faktor_flaki NUMERIC(9,6) NOT NULL,
mutter_wb_id BIGNUMERIC(38,0) NOT NULL,
wtag_id_start BIGNUMERIC(38,0) NOT NULL,
wtag_id_ende BIGNUMERIC(38,0) NOT NULL,
avq_relevant_fg BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);