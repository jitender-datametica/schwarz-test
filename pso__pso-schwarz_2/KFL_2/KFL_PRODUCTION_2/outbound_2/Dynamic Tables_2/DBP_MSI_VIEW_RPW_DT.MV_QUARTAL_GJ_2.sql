CREATE OR REPLACE TABLE dbp_msi_view_rpw_dt.mv_quartal_gj_2 AS
SELECT gjqu,
 akt_gjqu,
 akt_gjqu_komplett,
 gj,
 akt_gj,
 akt_gj_komplett,
 7 AS system_id
FROM kfl_production_dbp_view.v_quartal_gj_2
WHERE gj >= 2005
 AND gj <= EXTRACT(YEAR FROM CURRENT_DATE);