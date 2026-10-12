DROP TABLE IF EXISTS kfl_production_dbp_msi_data.vis_tag_abschriften_wg_1;
CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.vis_tag_abschriften_wg_1 (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
arthiertyp_id INTEGER NOT NULL,
wg_id INTEGER NOT NULL,
dat DATE NOT NULL,
abschriftart_id INTEGER NOT NULL,
abt_id INTEGER NOT NULL,
gj INTEGER NOT NULL,
kjmo INTEGER NOT NULL,
kjwo INTEGER NOT NULL,
wtag_id INTEGER NOT NULL,
abschrift_brutto NUMERIC(29,2) NOT NULL,
abschrift_brutto_kvj NUMERIC(29,2) NOT NULL,
abschrift_brutto_wvj NUMERIC(29,2) NOT NULL,
abschrift_netto NUMERIC(29,2) NOT NULL,
abschrift_netto_kvj NUMERIC(29,2) NOT NULL,
abschrift_netto_wvj NUMERIC(29,2) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, dat;