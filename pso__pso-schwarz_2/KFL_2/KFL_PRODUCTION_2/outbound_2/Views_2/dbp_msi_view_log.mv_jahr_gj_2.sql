CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_jahr_gj_2 (gj, akt_gj, akt_gj_komplett) AS SELECT gj,
 akt_gj,
 akt_gj_komplett
FROM kfl_production_dbp_view.v_jahr_gj_2 AS V01
WHERE gj > 2003;