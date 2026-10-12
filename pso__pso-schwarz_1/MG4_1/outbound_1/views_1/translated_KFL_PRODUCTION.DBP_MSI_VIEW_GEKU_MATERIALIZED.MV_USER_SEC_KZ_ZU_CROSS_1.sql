-- 25.01.2024 twie: NSR4272151 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

-- 28.09.2022 twie: SPEC0167837 Kombination aller User mit allen Sec KZ für Transaktion Zuordnungsbericht

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_user_sec_kz_zu_cross_1 (sec_kz, user_id, sec_fg) AS SELECT v01.sec_kz
 ,
 LOWER(v02.user_id) AS user_id,
  CASE
  WHEN v03.user_id IS NULL
  THEN 0
  ELSE 1
  END AS sec_fg
FROM kfl_production_dbp_msi_v_view.v_l_kmr_security_1 AS v01
 INNER JOIN (SELECT user_id
  FROM kfl_production_dbp_security.l_msi_user_1
  WHERE msi_produkt_bez = 'KMR') AS v02 ON TRUE
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ts_kmr_user_sec_kz_zu_1 AS v03 ON v01.sec_kz = v03.sec_kz AND v02.user_id = v03
   .user_id;