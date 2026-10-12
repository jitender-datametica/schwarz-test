CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_woche AS SELECT V01.kjwo,
  V01.kjwo / 100 AS kj,
 MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS wo_kj,
 V01.akt_wo,
 V01.akt_wo_komplett,
 V01.wo_dat_von,
 V01.wo_dat_bis,
 v02.kjwo_vj,
  v02.kjwo_vj / 100 AS kj_vj,
 MOD(CAST(v02.kjwo_vj AS BIGNUMERIC), 100) AS wo_vj,
      CAST(MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS STRING) || ' (' || CAST(V01.wo_dat_von AS STRING) || '-' || CAST(V01.wo_dat_bis AS STRING)
    || ')' AS wo_von_bis,
    CAST(MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS STRING) || ' (' || CAST(V01.wo_dat_von AS STRING) || ')' AS wo_von,
 PARSE_DATE('%F', SUBSTR(SUBSTR(CAST(V01.wo_dat_von AS STRING), 1, 20), 1, 8) || '01') AS wo_dat_mo,
   CAST(MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS STRING) || ' | ' || CAST(MOD(CAST(v02.kjwo_vj AS BIGNUMERIC), 100) AS
   STRING) AS kw_ist_vj
FROM kfl_production_dbp_view.v_woche AS V01
 INNER JOIN (SELECT kjwo AS kjwo_vj,
   DATE_ADD(wo_dat_von, INTERVAL 364 DAY) AS wo_dat_von_vj
  FROM kfl_production_dbp_view.v_woche
  WHERE akt_wo BETWEEN - 623 AND 0) AS v02 ON V01.wo_dat_von = v02.wo_dat_von_vj
WHERE V01.akt_wo BETWEEN - 571 AND 55;