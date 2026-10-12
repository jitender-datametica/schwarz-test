CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_l_secfilter_usermandant_1 (user_id, mandant_id) AS SELECT user_id
 ,
 mandant_id
FROM kfl_production_dbp_security.user_mandant_msiprodukt_zu_1
WHERE msi_produkt_bez = 'IOS';