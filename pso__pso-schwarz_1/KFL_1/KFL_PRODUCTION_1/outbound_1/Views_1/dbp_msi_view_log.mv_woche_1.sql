CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_woche_1 (kjwo, kj, wo_kj, akt_wo, akt_wo_komplett, wo_dat_von,
wo_dat_bis, kjwo_vj, kj_vj, wo_vj, wo_von_bis, wo_von, wo_dat_mo, kw_ist_vj, kjwo_bez, kjwo_bez2) AS SELECT V01.kjwo,
 CAST(V01.kjwo / 100 AS BIGNUMERIC) AS kj,
 CAST(MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS BIGNUMERIC) AS wo_kj,
 V01.akt_wo,
 V01.akt_wo_komplett,
 V01.wo_dat_von,
 V01.wo_dat_bis,
 v02.kjwo_vj,
 CAST(v02.kjwo_vj / 100 AS BIGNUMERIC) AS kj_vj,
 CAST(MOD(CAST(v02.kjwo_vj AS BIGNUMERIC), 100) AS BIGNUMERIC) AS wo_vj,
      CAST(MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS STRING FORMAT '00') || ' (' || FORMAT_DATE('%d.%m', V01.wo_dat_von
      ) || '-' || FORMAT_DATE('%d.%m', V01.wo_dat_bis) || ')' AS wo_von_bis,
    CAST(MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS STRING FORMAT '00') || ' (' || FORMAT_DATE('%d.%m', V01.wo_dat_von)
  || ')' AS wo_von,
 PARSE_DATE('%F', SUBSTR(SUBSTR(CAST(V01.wo_dat_von AS STRING), 1, 20), 1, 8) || '01') AS wo_dat_mo,
   CAST(CAST(MOD(CAST(V01.kjwo AS BIGNUMERIC), 100) AS BIGNUMERIC) AS STRING FORMAT '00') || ' | ' || CAST(CAST(MOD(CAST(v02.kjwo_vj AS BIGNUMERIC)
     , 100) AS BIGNUMERIC) AS STRING FORMAT '00') AS kw_ist_vj,
     SUBSTR('KW', 1, 2) || ' ' || RIGHT(SUBSTR(CAST(V01.kjwo AS STRING), 1, 39), 2) || '/' || LEFT(SUBSTR(CAST(V01.kjwo AS STRING)
    , 1, 39), 4) AS kjwo_bez,
   TRIM(SUBSTR(CAST(CAST(V01.kjwo / 100 AS BIGNUMERIC) AS STRING), 1, 39)) || ' ' || (CAST(MOD(CAST(V01.kjwo AS BIGNUMERIC)
          , 100) AS STRING FORMAT '00') || ' (' || FORMAT_DATE('%d.%m', V01.wo_dat_von) || '-' || FORMAT_DATE('%d.%m',
      V01.wo_dat_bis) || ')') AS kjwo_bez2
FROM kfl_production_dbp_view.v_woche_1 AS V01
 INNER JOIN (SELECT kjwo AS kjwo_vj,
   DATE_ADD(wo_dat_von, INTERVAL 364 DAY) AS wo_dat_von_vj
  FROM kfl_production_dbp_view.v_woche_1
  WHERE akt_wo BETWEEN - 623 AND 0) AS v02 ON V01.wo_dat_von = v02.wo_dat_von_vj
WHERE V01.akt_wo BETWEEN - 571 AND 55;