CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_quartal_gj_2 (gjqu, akt_gjqu, akt_gjqu_komplett, gj, akt_gj,
akt_gj_komplett, gjqu_bez, gjqu_kbez, gjqu_bez2, dat_buchungs_schluss, max_dat) AS SELECT V01.gjqu,
 V01.akt_gjqu,
 V01.akt_gjqu_komplett,
 V01.gj,
 V01.akt_gj,
 V01.akt_gj_komplett,
   TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' - Q' || SUBSTR(CAST(MOD(CAST(V01.gjqu AS BIGNUMERIC), 100) AS STRING
    ), 1, 2) AS gjqu_bez,
  'Q' || SUBSTR(CAST(MOD(CAST(V01.gjqu AS BIGNUMERIC), 100) AS STRING), 1, 2) AS gjqu_kbez,
  SUBSTR(CAST(MOD(CAST(V01.gjqu AS BIGNUMERIC), 100) AS STRING), 1, 1) || '. Quartal' AS gjqu_bez2,
 v02.dat_buchungs_schluss,
 v02.max_dat
FROM kfl_production_dbp_view.v_quartal_gj_2 AS V01
 INNER JOIN (SELECT V11.gjqu,
   MAX(V12.dat_buchungs_schluss) AS dat_buchungs_schluss,
   MAX(V11.max_dat) AS max_dat
  FROM kfl_production_dbp_view.v_monat_2 AS V11
   LEFT JOIN kfl_production_dbp_view.v_l_buchungsstatus_ker_2 AS V12 ON V11.kjmo = V12.kj_ker_mo_id
  GROUP BY V11.gjqu) AS v02 ON V01.gjqu = v02.gjqu;