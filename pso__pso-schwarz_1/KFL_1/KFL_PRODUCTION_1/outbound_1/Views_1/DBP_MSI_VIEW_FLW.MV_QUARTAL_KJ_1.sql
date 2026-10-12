CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_quartal_kj_1 (akt_kj, akt_kj_komplett, akt_kjqu,
akt_kjqu_komplett, kj, kjqu) AS SELECT akt_kj,
 akt_kj_komplett,
 akt_kjqu,
 akt_kjqu_komplett,
 kj,
 kjqu
FROM kfl_production_dbp_view.v_tag_1
GROUP BY akt_kj,
 akt_kj_komplett,
 akt_kjqu,
 akt_kjqu_komplett,
 kj,
 kjqu;