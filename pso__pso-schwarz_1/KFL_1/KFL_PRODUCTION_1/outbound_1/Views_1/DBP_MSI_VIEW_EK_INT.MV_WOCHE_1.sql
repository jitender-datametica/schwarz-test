CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_woche_1 (kjwo, kj, wo_kj, akt_wo, akt_wo_komplett, wo_dat_von
, wo_dat_bis, kjwo_vj, kj_vj, wo_vj, wo_von_bis, wo_von, wo_dat_mo, kw_ist_vj) AS SELECT kjwo,
  kjwo / 100 AS kj,
 MOD(CAST(kjwo AS BIGNUMERIC), 100) AS wo_kj,
 akt_wo,
 akt_wo_komplett,
 wo_dat_von,
 wo_dat_bis,
 kjwo_vj,
  kjwo_vj / 100 AS kj_vj,
 MOD(CAST(kjwo_vj AS BIGNUMERIC), 100) AS wo_vj,
      LPAD(SUBSTR(CAST(MOD(CAST(kjwo AS BIGNUMERIC), 100) AS STRING), 1, 10), 2, '0') || ' (' || FORMAT_DATE('%d.%m',
      wo_dat_von) || '-' || FORMAT_DATE('%d.%m', wo_dat_bis) || ')' AS wo_von_bis,
    LPAD(SUBSTR(CAST(MOD(CAST(kjwo AS BIGNUMERIC), 100) AS STRING), 1, 10), 2, '0') || ' (' || FORMAT_DATE('%d.%m',
    wo_dat_von) || ')' AS wo_von,
  SUBSTR(SUBSTR(CAST(wo_dat_von AS STRING), 1, 20), 1, 8) || '01' AS wo_dat_mo,
   LPAD(SUBSTR(CAST(MOD(CAST(kjwo AS BIGNUMERIC), 100) AS STRING), 1, 39), 2, '0') || ' | ' || LPAD(SUBSTR(CAST(MOD(CAST(kjwo_vj AS BIGNUMERIC)
      , 100) AS STRING), 1, 39), 2, '0') AS kw_ist_vj
FROM kfl_production_dbp_view.v_woche_1
WHERE akt_wo BETWEEN - 571 AND 55;