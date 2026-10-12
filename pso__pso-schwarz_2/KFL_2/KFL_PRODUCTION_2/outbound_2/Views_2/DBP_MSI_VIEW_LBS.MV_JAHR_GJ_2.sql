CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_jahr_gj_2 (gj, akt_gj, akt_gj_komplett) AS SELECT gj,
 akt_gj,
 akt_gj_komplett
FROM kfl_production_dbp_view.v_jahr_gj_2
WHERE gj > 2001;