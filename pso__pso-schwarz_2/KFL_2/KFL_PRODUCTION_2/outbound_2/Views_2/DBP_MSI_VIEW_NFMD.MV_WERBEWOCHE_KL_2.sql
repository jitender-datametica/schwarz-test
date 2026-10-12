CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_werbewoche_kl_2 AS SELECT DISTINCT V01.mandant_id,
 V01.akt_kjwo_ww,
  CASE
  WHEN V01.akt_kjwo_ww BETWEEN - 1 - V02.promo_lifecycle_weeks_cnt AND (- 1)
  THEN 1
  ELSE 0
  END AS akt_kjwo_ww_relvant_flag,
 V01.akt_kjwo_ww_komplett,
 V01.kjwo_ww,
 MIN(V01.dat) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.kjwo_ww AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ww_dat_von,
 MAX(V01.dat) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.kjwo_ww AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ww_dat_bis
FROM kfl_production_dbp_view.v_werbewoche_kl_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_nfmd_parameter_2 AS V02 ON V01.mandant_id = V02.mandant_id;