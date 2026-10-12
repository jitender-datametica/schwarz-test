CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_jahr_gj_2 (gj, akt_gj, akt_gj_komplett, gj_bez) AS SELECT gj,
 akt_gj,
 akt_gj_komplett,
 CAST(gj AS STRING) AS gj_bez
FROM kfl_production_dbp_view.v_jahr_gj_2
UNION DISTINCT
SELECT 1900 AS gj,
 - 9999 AS akt_gj,
 - 9999 AS akt_gj_komplett,
 '' AS gj_bez
FROM kfl_production_dbp_view.v_jahr_gj_2
WHERE akt_gj = 0;