CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_quartal_gj_1 (gjqu, akt_gjqu, akt_gjqu_komplett, gj, akt_gj,
akt_gj_komplett, system_id) AS SELECT gjqu,
 akt_gjqu,
 akt_gjqu_komplett,
 gj,
 akt_gj,
 akt_gj_komplett,
 7 AS system_id
FROM kfl_production_dbp_view.v_quartal_gj_1
WHERE gj >= 2005
 AND gj <= EXTRACT(YEAR FROM CURRENT_DATE);