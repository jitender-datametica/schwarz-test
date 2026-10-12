CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_monat_spr_zu_1 AS SELECT M.kjmo,
 M.kj,
 M.mo_kj,
 DATE(SUBSTR(CAST(M.kjmo AS STRING), 1, 6)) AS dat_mo_beginn,
 DATE_SUB(IF(DATE(SUBSTR(SAFE_CAST(M.kjmo as STRING), 1, 6)) = LAST_DAY(DATE(SUBSTR(SAFE_CAST(M.kjmo as STRING), 1, 6))
     ), LAST_DAY(DATE_ADD(DATE(SUBSTR(SAFE_CAST(M.kjmo as STRING), 1, 6)), INTERVAL 1 MONTH)), DATE_ADD(DATE(SUBSTR(SAFE_CAST(M
       .kjmo as STRING), 1, 6)), INTERVAL 1 MONTH)), INTERVAL 1 DAY) AS dat_mo_ende,
 M.gjmo,
 M.gj,
 M.mo_gj,
 M.akt_gj,
 M.akt_gj_komplett,
 M.akt_mo,
 M.akt_mo_komplett,
 K.akt_buchungs_schluss,
 TRIM(S.mo_bez) AS mo_bez,
   TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39)) AS mo_bez_land,
   SUBSTR(TRIM(S.mo_bez), 1, 3) || ' ' || SUBSTR(SUBSTR(CAST(M.kj AS STRING), 1, 4), 3, 4) AS mo_bez_kurz,
 S.spr_id
FROM kfl_production_dbp_view.v_monat_1 AS M
 INNER JOIN kfl_production_dbp_view.v_l_buchungsstatus_ker_1 AS K ON M.kjmo = K.kj_ker_mo_id
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS S ON M.mo_kj = S.mo_id AND S.spr_id = 22
WHERE M.akt_gj BETWEEN - 5 AND 1;