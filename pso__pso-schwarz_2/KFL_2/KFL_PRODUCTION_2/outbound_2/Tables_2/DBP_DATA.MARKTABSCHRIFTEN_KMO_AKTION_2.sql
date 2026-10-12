CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.marktabschriften_kmo_aktion_2 (
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
menge_abschrift NUMERIC(18,3) DEFAULT 0 NOT NULL,
abschriftbetrag_netto NUMERIC(18,4) DEFAULT 0 NOT NULL,
abschriftbetrag_brutto NUMERIC(18,2) DEFAULT 0 NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci',
vk_aktion_netto NUMERIC(9,2) DEFAULT 0 NOT NULL,
vk_vor_aktion_netto NUMERIC(9,2) DEFAULT 0 NOT NULL,
aktion_relevant_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, dat;