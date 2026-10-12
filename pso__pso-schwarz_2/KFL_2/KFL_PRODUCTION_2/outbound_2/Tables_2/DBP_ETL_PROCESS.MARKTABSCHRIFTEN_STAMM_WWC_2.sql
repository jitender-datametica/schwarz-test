CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.marktabschriften_stamm_wwc_2 (
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
aktion_id STRING(10) COLLATE 'und:ci',
mandant_id BIGNUMERIC(38,0),
bewart_id BIGNUMERIC(38,0),
dat DATE,
art_id BIGNUMERIC(38,0),
vk_aktion_brutto NUMERIC(18,2),
vk_vor_aktion_brutto NUMERIC(18,2),
mwst_id BIGNUMERIC(38,0),
wrg_id STRING(3) COLLATE 'und:ci',
dat_preisaktiviert DATE,
aktion_relevant_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);