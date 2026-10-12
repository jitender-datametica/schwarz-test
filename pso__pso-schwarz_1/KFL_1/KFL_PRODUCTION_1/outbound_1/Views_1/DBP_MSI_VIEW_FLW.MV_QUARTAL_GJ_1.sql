CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_quartal_gj_1 (akt_gj, akt_gj_komplett, akt_gjqu,
akt_gjqu_komplett, gj, gjqu) AS SELECT akt_gj,
 akt_gj_komplett,
 akt_gjqu,
 akt_gjqu_komplett,
 gj,
 gjqu
FROM kfl_production_dbp_view.v_tag_1
GROUP BY akt_gj,
 akt_gj_komplett,
 akt_gjqu,
 akt_gjqu_komplett,
 gj,
 gjqu;