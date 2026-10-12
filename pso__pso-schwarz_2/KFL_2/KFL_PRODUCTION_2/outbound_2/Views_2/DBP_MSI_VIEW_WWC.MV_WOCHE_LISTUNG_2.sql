CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_woche_listung_2 (kjwo, akt_wo) AS SELECT kjwo,
 akt_wo
FROM kfl_production_dbp_view.v_woche_2
WHERE kjwo > 200152
UNION ALL
SELECT DISTINCT 999952 AS kjwo,
 9999 AS akt_wo
FROM kfl_production_dbp_view.v_woche_2;