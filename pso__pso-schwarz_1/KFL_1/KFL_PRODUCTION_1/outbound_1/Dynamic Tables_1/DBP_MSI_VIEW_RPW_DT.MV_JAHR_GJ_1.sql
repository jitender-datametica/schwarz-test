CREATE OR REPLACE TABLE dbp_msi_view_rpw_dt.mv_jahr_gj_1
 AS
SELECT gj,
 akt_gj,
 akt_gj_komplett,
 7 AS system_id
FROM kfl_production_dbp_view.v_jahr_gj_1
WHERE gj >= 2005
 AND gj <= EXTRACT(YEAR FROM CURRENT_DATE);