CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_ios_user_sec_2 AS SELECT *
FROM kfl_production_dbp_security.l_msi_user_2
WHERE msi_produkt_bez LIKE 'IOS';