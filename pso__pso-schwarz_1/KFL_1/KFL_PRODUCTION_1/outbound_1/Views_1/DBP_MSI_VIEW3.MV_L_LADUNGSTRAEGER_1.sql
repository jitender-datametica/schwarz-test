CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_ladungstraeger_1 (mandant_id, lagernummer_id, art_id, wup_id,
nb_id, anz_ladtraeger_max, stellplatz_faktor, zlv_ladhilf_fg) AS SELECT mandant_id,
 lagernummer_id,
 art_id,
 wup_id,
 nb_id,
 anz_ladtraeger_max,
 stellplatz_faktor,
 zlv_ladhilf_fg
FROM kfl_production_dbp_view.v_art_lagernummer_zu_per_1
WHERE zlv_ladhilf_fg = 1;