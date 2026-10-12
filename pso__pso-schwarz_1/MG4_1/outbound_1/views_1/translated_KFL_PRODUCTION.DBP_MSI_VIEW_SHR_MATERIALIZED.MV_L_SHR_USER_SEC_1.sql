-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

CREATE OR REPLACE VIEW dbp_msi_view_shr_materialized.mv_l_shr_user_sec_1 (user_id, msi_produkt_bez) AS SELECT LOWER(user_id
  ) AS user_id,
 msi_produkt_bez
FROM kfl_production_dbp_security.l_msi_user_1
WHERE msi_produkt_bez LIKE 'SHR';