CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_l_ios_user_sec (user_id, msi_produkt_bez, td_insert, td_update)
AS SELECT *
FROM kfl_production_dbp_security.l_msi_user
WHERE msi_produkt_bez LIKE 'IOS';