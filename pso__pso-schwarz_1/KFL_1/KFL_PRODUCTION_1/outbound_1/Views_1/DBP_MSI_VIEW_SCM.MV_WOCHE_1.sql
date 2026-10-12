CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_woche_1 AS SELECT V01.kjwo,
 ROUND(CAST(LEFT(SUBSTR(CAST(V01.kjwo AS STRING), 1, 39), 4) AS BIGNUMERIC), 0) AS kj,
 MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS wo_kj,
 V01.akt_wo,
 V01.akt_wo_komplett,
 V01.wo_dat_von,
 V01.wo_dat_bis,
 v02.kjwo_vj,
  v02.kjwo_vj / 100 AS kj_vj,
 MOD(CAST(v02.kjwo_vj AS BIGNUMERIC), 100) AS wo_vj,
      LTRIM(CAST(MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS STRING FORMAT '00')) || ' (' || FORMAT_DATE('%d.%m', V01.wo_dat_von
      ) || '-' || FORMAT_DATE('%d.%m', V01.wo_dat_bis) || ')' AS wo_von_bis,
    LTRIM(CAST(MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS STRING FORMAT '00')) || ' (' || FORMAT_DATE('%d.%m', V01.wo_dat_von
    ) || ')' AS wo_von,
  SUBSTR(SUBSTR(CAST(V01.wo_dat_von AS STRING), 1, 20), 1, 8) || '01' AS wo_dat_mo,
   CAST(MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS STRING FORMAT '00') || ' | ' || CAST(CAST(MOD(CAST(v02.kjwo_vj AS BIGNUMERIC)
     , 100) AS STRING FORMAT '00') AS STRING) AS kw_ist_vj
FROM kfl_production_dbp_view.v_woche_1 AS V01
 INNER JOIN (SELECT kjwo AS kjwo_vj,
   DATE_ADD(wo_dat_von, INTERVAL 364 DAY) AS wo_dat_von_vj
  FROM kfl_production_dbp_view.v_woche_1
  WHERE akt_wo BETWEEN - 623 AND 0) AS v02 ON V01.wo_dat_von = v02.wo_dat_von_vj
WHERE V01.akt_wo BETWEEN - 571 AND 55;