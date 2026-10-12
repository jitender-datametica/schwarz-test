CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_woche_trn (gjwo, gjwo_vj, kjwo, kjwo_vj, wo_dat_von,
wo_dat_bis, kjwo_vwo, kjwo_vwo2, kjwo_vwo3, kjwo_vwo4) AS SELECT gjwo,
 gjwo_vj,
 kjwo,
 kjwo_vj,
 wo_dat_von,
 wo_dat_bis,
 MIN(kjwo) OVER (ORDER BY kjwo IS NULL, kjwo ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS kjwo_vwo,
 MIN(kjwo) OVER (ORDER BY kjwo IS NULL, kjwo ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS kjwo_vwo2,
 MIN(kjwo) OVER (ORDER BY kjwo IS NULL, kjwo ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS kjwo_vwo3,
 MIN(kjwo) OVER (ORDER BY kjwo IS NULL, kjwo ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS kjwo_vwo4
FROM kfl_production_dbp_view.v_woche
WHERE kjwo > 200152;