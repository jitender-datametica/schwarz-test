CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_jahr_gj_2 (gj, akt_gj, akt_gj_komplett) AS SELECT gj,
 akt_gj,
 akt_gj_komplett
FROM kfl_production_dbp_view.v_jahr_gj_2
UNION ALL
SELECT DISTINCT 9999 AS gj,
 9999 AS akt_gj,
 9999 AS akt_gj_komplett
FROM kfl_production_dbp_view.v_jahr_gj_2;