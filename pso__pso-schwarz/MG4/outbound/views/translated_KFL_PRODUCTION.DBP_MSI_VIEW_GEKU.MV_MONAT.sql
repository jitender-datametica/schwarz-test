CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_monat (gjmo, gjmo_vj, mo_gj, kjmo, kjmo_vj, mo_kj, akt_mo,
akt_mo_komplett, gjqu, akt_gjqu, akt_gjqu_komplett, kjqu, akt_kjqu, akt_kjqu_komplett, gj, akt_gj, akt_gj_komplett, kj,
akt_kj, akt_kj_komplett, kjmo_vm, akt_mo_kalendarisch) AS SELECT gjmo,
 gjmo_vj,
 mo_gj,
 kjmo,
 kjmo_vj,
 mo_kj,
 akt_mo,
 akt_mo_komplett,
 gjqu,
 akt_gjqu,
 akt_gjqu_komplett,
 kjqu,
 akt_kjqu,
 akt_kjqu_komplett,
 gj,
 akt_gj,
 akt_gj_komplett,
 kj,
 akt_kj,
 akt_kj_komplett -- , TRUNC(ADD_MONTHS(CAST(kjmo*100-19000000+1 AS DATE),-1)/100) + 190000
,
  CAST(EXTRACT(YEAR FROM IF(DATE(LEFT(SAFE_CAST(kjmo as STRING), 4) || '-' || RIGHT(SAFE_CAST(kjmo as STRING), 2) || '-20') = LAST_DAY(DATE(LEFT(SAFE_CAST(kjmo as STRING), 4) || '-' || RIGHT(SAFE_CAST(kjmo as STRING), 2) || '-20')), LAST_DAY(DATE_ADD(DATE(LEFT(SAFE_CAST(kjmo as STRING), 4) || '-' ||
          RIGHT(SAFE_CAST(kjmo as STRING), 2) || '-20'), INTERVAL - 1 MONTH)), DATE_ADD(DATE(LEFT(SAFE_CAST(kjmo as STRING), 4) || '-' || RIGHT(SAFE_CAST(kjmo as STRING), 2) || '-20'), INTERVAL - 1 MONTH))) AS STRING)
  || CAST(CAST(EXTRACT(MONTH FROM IF(DATE(LEFT(SAFE_CAST(kjmo as STRING), 4) || '-' || RIGHT(SAFE_CAST(kjmo as STRING), 2) || '-20') = LAST_DAY(DATE(LEFT(SAFE_CAST(kjmo as STRING), 4) || '-' || RIGHT(SAFE_CAST(kjmo as STRING), 2) || '-20')), LAST_DAY(DATE_ADD(DATE(LEFT(SAFE_CAST(kjmo as STRING), 4)
            || '-' || RIGHT(SAFE_CAST(kjmo as STRING), 2) || '-20'), INTERVAL - 1 MONTH)), DATE_ADD(DATE(LEFT(SAFE_CAST(kjmo as STRING), 4) || '-' || RIGHT(SAFE_CAST(kjmo as STRING), 2) || '-20'), INTERVAL - 1 MONTH))) AS BIGNUMERIC)
   AS STRING) AS kjmo_vm,
     (kj - EXTRACT(YEAR FROM CURRENT_DATE)) * 12 + MOD(kjmo, 100) - EXTRACT(MONTH FROM CURRENT_DATE) AS
 akt_mo_kalendarisch
FROM kfl_production_dbp_view.v_monat
WHERE kjmo >= 200201;