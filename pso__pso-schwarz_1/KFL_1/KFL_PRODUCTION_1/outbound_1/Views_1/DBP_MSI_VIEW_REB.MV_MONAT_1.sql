CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_monat_1 
(gjmo, gjmo_vj, mo_gj, kjmo, kjmo_vj, mo_kj, akt_mo,
akt_mo_komplett, gjqu, akt_gjqu, akt_gjqu_komplett, kjqu, akt_kjqu, akt_kjqu_komplett, gj, akt_gj, akt_gj_komplett, kj,
akt_kj, akt_kj_komplett, kjmo_vm,akt_mo_kalendarisch) AS SELECT gjmo,
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
 akt_kj_komplett,
   CAST(FORMAT_DATE('%Y%m', IF(PARSE_DATE('%Y%m', SAFE_CAST(kjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(kjmo
       as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(kjmo as STRING)), INTERVAL - 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m'
     , SAFE_CAST(kjmo as STRING)), INTERVAL - 1 MONTH))) AS INT64) as kjmo_vm,
   (kj - EXTRACT(YEAR FROM CURRENT_DATE)) * 12 + MOD(CAST(kjmo AS BIGNUMERIC), 100) - EXTRACT(MONTH FROM CURRENT_DATE
   ) AS akt_mo_kalendarisch
FROM kfl_production_dbp_view.v_monat_1;