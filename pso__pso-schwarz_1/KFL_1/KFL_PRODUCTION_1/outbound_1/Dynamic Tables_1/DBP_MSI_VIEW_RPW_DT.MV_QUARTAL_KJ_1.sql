CREATE OR REPLACE TABLE dbp_msi_view_rpw_dt.mv_quartal_kj_1 AS
SELECT kjqu,
 kj,
 akt_kjqu,
 akt_kjqu_komplett,
 akt_kj,
 akt_kj_komplett,
 7 AS system_id
FROM kfl_production_dbp_view.v_quartal_kj_1
WHERE kj >= 2005
 AND kj <= EXTRACT(YEAR FROM CURRENT_DATE);