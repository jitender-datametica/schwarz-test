CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_quartal_gj_vorquartal_trn_1 (gjqu, gjqu_vqu, gjqu_vvqu,
gjqu_vvvqu, gjqu_vvvvqu) AS SELECT gjqu,
 MIN(gjqu) OVER (ORDER BY gjqu IS NULL, gjqu ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS gjqu_vqu,
 MIN(gjqu) OVER (ORDER BY gjqu IS NULL, gjqu ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS gjqu_vvqu,
 MIN(gjqu) OVER (ORDER BY gjqu IS NULL, gjqu ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS gjqu_vvvqu,
 MIN(gjqu) OVER (ORDER BY gjqu IS NULL, gjqu ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS gjqu_vvvvqu
FROM kfl_production_dbp_view.v_quartal_gj_1
WHERE gjqu > 200104;