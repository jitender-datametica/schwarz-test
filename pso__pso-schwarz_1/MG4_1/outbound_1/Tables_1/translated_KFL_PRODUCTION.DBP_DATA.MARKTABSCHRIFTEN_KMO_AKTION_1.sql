DROP TABLE IF EXISTS kfl_production_dbp_data.marktabschriften_kmo_aktion_1;
CREATE OR REPLACE TABLE kfl_production_dbp_data.marktabschriften_kmo_aktion_1 (
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
mandant_id INTEGER NOT NULL,
dat DATE NOT NULL,
art_id INTEGER NOT NULL,
menge_abschrift NUMERIC(18,3) DEFAULT 0 NOT NULL,
abschriftbetrag_netto NUMERIC(18,4) DEFAULT 0 NOT NULL,
abschriftbetrag_brutto NUMERIC(18,2) DEFAULT 0 NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci',
vk_aktion_netto NUMERIC(9,2) DEFAULT 0 NOT NULL,
vk_vor_aktion_netto NUMERIC(9,2) DEFAULT 0 NOT NULL,
aktion_relevant_fg INTEGER DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, dat;