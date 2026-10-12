CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_monat_2 AS SELECT V01.kjmo,
 V01.kjmo_vj,
 V01.kj,
 V01.mo_kj,
 V01.gj,
 V01.mo_gj,
 V01.gjmo,
 V01.gjmo_vj,
 V01.kjqu,
 V01.gjqu,
 V01.akt_mo,
 V01.akt_mo_komplett,
 V01.akt_gj,
 V01.akt_gj_komplett,
 V01.akt_kj,
 V01.akt_kj_komplett,
 V01.akt_kjqu,
 V01.akt_kjqu_komplett,
 V01.akt_gjqu,
 V01.akt_gjqu_komplett,
 V01.min_dat AS mo_dat_von,
 V01.max_dat AS mo_dat_bis,
  V01.akt_mo + V02.summand AS akt_mo_teku,
 ROUND(CAST(FORMAT_DATE('%Y%m', IF(PARSE_DATE('%Y%m', SAFE_CAST(V01.kjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(V01.kjmo as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(V01.kjmo as STRING)), INTERVAL - 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(V01.kjmo as STRING)),
      INTERVAL - 1 MONTH))) AS BIGNUMERIC), 0) AS kjmo_vm,
 ROUND(CAST(FORMAT_DATE('%Y%m', IF(PARSE_DATE('%Y%m', SAFE_CAST(V01.kjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(V01.kjmo as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(V01.kjmo as STRING)), INTERVAL - 2 MONTH)), DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(V01.kjmo as STRING)),
      INTERVAL - 2 MONTH))) AS BIGNUMERIC), 0) AS kjmo_vvm
FROM kfl_production_dbp_view.v_monat_2 AS V01
 INNER JOIN (SELECT dat,
    CASE
    WHEN EXTRACT(DAY FROM dat) <= 4
    THEN 1
    ELSE 0
    END AS summand
  FROM kfl_production_dbp_view.v_tag_2
  WHERE akt_tag = 0) AS V02 ON TRUE
WHERE V01.akt_gj BETWEEN - 11 AND 1;