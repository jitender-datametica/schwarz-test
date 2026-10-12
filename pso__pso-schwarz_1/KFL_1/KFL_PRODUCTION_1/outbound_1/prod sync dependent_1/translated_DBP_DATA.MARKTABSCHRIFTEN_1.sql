DROP TABLE IF EXISTS kfl_production_dbp_data.marktabschriften_1;
CREATE OR REPLACE TABLE kfl_production_dbp_data.marktabschriften_1 (
wup_id INTEGER NOT NULL,
wup_abschrift_id INTEGER NOT NULL,
positionsnummer_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
dat DATE NOT NULL,
mandant_id INTEGER NOT NULL,
lastupd_dat DATE NOT NULL,
woche_id INTEGER NOT NULL,
menge_abschrift NUMERIC(29,3) NOT NULL,
abschriftart_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
abschriftbetrag_netto NUMERIC(29,2) DEFAULT 0 NOT NULL,
abschriftbetrag_brutto NUMERIC(29,2) DEFAULT 0 NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
wv_kz STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
wv_grund_id INTEGER DEFAULT 0 NOT NULL,
vk_aktion_brutto NUMERIC(29,2) DEFAULT 0 NOT NULL,
vk_brutto NUMERIC(29,2) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP,
abschrift_menge_einh_id STRING(3) COLLATE 'und:ci'
) CLUSTER BY mandant_id, dat;