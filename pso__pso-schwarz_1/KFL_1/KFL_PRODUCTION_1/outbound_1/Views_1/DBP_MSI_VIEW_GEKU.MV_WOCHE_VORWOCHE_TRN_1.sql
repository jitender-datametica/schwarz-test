CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_woche_vorwoche_trn_1 (kjwo, gjwo, gjwo_vwo, gjwo_vvwo,
gjwo_vvvwo, gjwo_vvvvwo, kjwo_vwo, kjwo_vvwo, kjwo_vvvwo, kjwo_vvvvwo) AS SELECT kjwo,
 gjwo,
 MIN(gjwo) OVER (ORDER BY gjwo IS NULL, gjwo ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS gjwo_vwo,
 MIN(gjwo) OVER (ORDER BY gjwo IS NULL, gjwo ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS gjwo_vvwo,
 MIN(gjwo) OVER (ORDER BY gjwo IS NULL, gjwo ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS gjwo_vvvwo,
 MIN(gjwo) OVER (ORDER BY gjwo IS NULL, gjwo ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS gjwo_vvvvwo,
 MIN(kjwo) OVER (ORDER BY kjwo IS NULL, kjwo ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS kjwo_vwo,
 MIN(kjwo) OVER (ORDER BY kjwo IS NULL, kjwo ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS kjwo_vvwo,
 MIN(kjwo) OVER (ORDER BY kjwo IS NULL, kjwo ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS kjwo_vvvwo,
 MIN(kjwo) OVER (ORDER BY kjwo IS NULL, kjwo ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS kjwo_vvvvwo
FROM kfl_production_dbp_view.v_woche_1
WHERE kjwo > 200152;