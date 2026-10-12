CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_bis_ldap (ma_ldap) AS SELECT SUBSTR(UPPER(ma_ldap), 1, 2) ||
  SUBSTR(LOWER(ma_ldap), 3, 8) AS ma_ldap
FROM kfl_production_dbp_security.l_bis_ldap;