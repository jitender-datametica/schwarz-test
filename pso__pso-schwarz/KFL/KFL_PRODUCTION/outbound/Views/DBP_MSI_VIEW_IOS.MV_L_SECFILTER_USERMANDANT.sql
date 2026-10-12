CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_secfilter_usermandant AS SELECT user_id,
 mandant_id
FROM kfl_production_dbp_security.user_mandant_msiprodukt_zu
WHERE msi_produkt_bez = 'IOS';