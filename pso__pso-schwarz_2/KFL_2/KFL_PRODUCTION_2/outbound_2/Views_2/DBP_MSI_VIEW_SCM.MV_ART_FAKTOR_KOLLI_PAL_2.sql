CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_faktor_kolli_pal_2 (mandant_id, art_id, einh_kolli,
faktor_kolli, einh_best, faktor_best, einh_pal, faktor_pal, einh_lag, faktor_lag, laenge_kolli, breite_kolli,
hoehe_kolli) AS SELECT *
FROM kfl_production_dbp_msi_view_scm.mv_dt_art_faktor_kolli_pal_2;