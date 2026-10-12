CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.marktabschriften_stamm_1 (
wup_id INTEGER,
nb_id INTEGER,
aktion_id STRING(10) COLLATE 'und:ci',
mandant_id INTEGER,
bewart_id INTEGER,
dat DATE,
art_id INTEGER,
vk_aktion_brutto NUMERIC(18,2),
vk_vor_aktion_brutto NUMERIC(18,2),
mwst_id INTEGER,
wrg_id STRING(3) COLLATE 'und:ci',
dat_preisaktiviert DATE,
aktion_relevant_fg INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);