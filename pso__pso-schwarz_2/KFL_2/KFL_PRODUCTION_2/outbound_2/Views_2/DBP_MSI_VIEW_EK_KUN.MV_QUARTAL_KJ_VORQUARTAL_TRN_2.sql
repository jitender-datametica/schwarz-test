CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_quartal_kj_vorquartal_trn_2 (kjqu, kjqu_vqu, kjqu_vvqu,
kjqu_vvvqu, kjqu_vvvvqu) AS SELECT kjqu,
 MIN(kjqu) OVER (ORDER BY kjqu NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS kjqu_vqu,
 MIN(kjqu) OVER (ORDER BY kjqu NULLS LAST ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS kjqu_vvqu,
 MIN(kjqu) OVER (ORDER BY kjqu NULLS LAST ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS kjqu_vvvqu,
 MIN(kjqu) OVER (ORDER BY kjqu NULLS LAST ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS kjqu_vvvvqu
FROM kfl_production_dbp_data.quartal_kj_2
WHERE kjqu > 200104;