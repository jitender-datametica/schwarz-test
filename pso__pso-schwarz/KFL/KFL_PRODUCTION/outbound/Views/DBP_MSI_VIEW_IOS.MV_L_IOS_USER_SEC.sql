CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_ios_user_sec AS SELECT *
FROM kfl_production_dbp_security.l_msi_user
WHERE msi_produkt_bez LIKE 'IOS';