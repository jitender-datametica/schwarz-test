CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_halbjahr_1 AS SELECT DISTINCT CASE
  WHEN MOD(CAST(kjmo AS BIGNUMERIC), 100) <= 6
  THEN 1
  ELSE 2
  END AS hj,
  CASE
  WHEN MOD(CAST(kjmo AS BIGNUMERIC), 100) <= 6
  THEN '1. Halbjahr'
  ELSE '2. Halbjahr'
  END AS hj_bez
FROM kfl_production_dbp_view.v_monat_1;