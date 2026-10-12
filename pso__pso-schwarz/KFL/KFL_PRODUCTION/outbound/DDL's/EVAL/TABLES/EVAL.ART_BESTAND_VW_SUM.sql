DROP TABLE IF EXISTS kfl_production_eval.art_bestand_vw_sum;
CREATE OR REPLACE TABLE kfl_production_eval.art_bestand_vw_sum (
mandant_id INTEGER NOT NULL,
vw_id INTEGER NOT NULL,
bezugsweg_id INTEGER NOT NULL,
lagerbestand_fg INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
dat DATE NOT NULL,
gp_id INTEGER NOT NULL,
relevant_fg INTEGER NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
menge_lgbest_erp_frei_bme NUMERIC(29,3) NOT NULL,
menge_lgbest_erp_qual_bme NUMERIC(29,3) NOT NULL,
menge_lgbest_erp_gesamt_bme NUMERIC(29,3) NOT NULL,
betrag_vk_netto_frei_bme NUMERIC(29,4),
betrag_vk_netto_qual_bme NUMERIC(29,4),
betrag_vk_netto_gesamt_bme NUMERIC(29,4),
menge_abgang_bme NUMERIC(29,3),
betrag_vk_netto_abgang NUMERIC(29,4) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, dat;