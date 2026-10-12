CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_quartal_gj_1 (gjqu, akt_gjqu, akt_gjqu_komplett, gj, akt_gj,
akt_gj_komplett, gjhj) AS SELECT gjqu,
 akt_gjqu,
 akt_gjqu_komplett,
 gj,
 akt_gj,
 akt_gj_komplett,
 gjhj
FROM kfl_production_dbp_view.v_quartal_gj_1
WHERE gjqu > 200104;