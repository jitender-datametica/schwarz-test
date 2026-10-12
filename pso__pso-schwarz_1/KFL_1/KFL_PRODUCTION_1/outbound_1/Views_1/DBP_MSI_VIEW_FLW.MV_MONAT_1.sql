CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_monat_1 (kjmo, kjmo_vj, gjmo, gjmo_vj, kjqu, gjqu, kj, gj,
akt_mo, akt_mo_komplett, akt_gjqu, akt_gjqu_komplett, akt_kjqu, akt_kjqu_komplett, akt_gj, akt_gj_komplett, akt_kj,
akt_kj_komplett, mo_gj, mo_kj, min_dat, max_dat,kjmo_vm) AS SELECT kjmo,
 kjmo_vj,
 gjmo,
 gjmo_vj,
 kjqu,
 gjqu,
 kj,
 gj,
 akt_mo,
 akt_mo_komplett,
 akt_gjqu,
 akt_gjqu_komplett,
 akt_kjqu,
 akt_kjqu_komplett,
 akt_gj,
 akt_gj_komplett,
 akt_kj,
 akt_kj_komplett,
 mo_gj,
 mo_kj,
 min_dat,
 max_dat,
 CAST(FORMAT_DATE('%Y%m', IF(PARSE_DATE('%Y%m', SAFE_CAST(kjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(kjmo
       as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(kjmo as STRING)), INTERVAL - 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m'
     , SAFE_CAST(kjmo as STRING)), INTERVAL - 1 MONTH))) AS INT64)

FROM kfl_production_dbp_view.v_monat_1;