CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_scm_materialized.mv_art_faktor_kolli_pal (
mandant_id INTEGER,
art_id INTEGER,
einh_kolli STRING(3) COLLATE 'und:ci',
faktor_kolli BIGNUMERIC(38,11),
einh_best STRING(3) COLLATE 'und:ci',
faktor_best NUMERIC(29,6),
einh_pal STRING(3) COLLATE 'und:ci',
faktor_pal NUMERIC(29,6),
einh_lag STRING(3) COLLATE 'und:ci',
faktor_lag NUMERIC(29,6),
laenge_kolli NUMERIC(29,3),
breite_kolli NUMERIC(29,3),
hoehe_kolli NUMERIC(29,3)
);