CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_shr_user_sec (user_id, msi_produkt_bez) AS SELECT LOWER(user_id
  ) AS user_id,
 msi_produkt_bez
FROM kfl_production_dbp_security.l_msi_user
WHERE msi_produkt_bez LIKE 'SHR';