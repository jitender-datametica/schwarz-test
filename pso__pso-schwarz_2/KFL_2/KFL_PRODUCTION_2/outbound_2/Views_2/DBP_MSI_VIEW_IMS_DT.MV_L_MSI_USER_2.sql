CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_msi_user_2 (user_id) AS SELECT LOWER(user_id) AS user_id
FROM kfl_production_dbp_security.l_msi_user_2 AS V01
WHERE msi_produkt_bez = 'IMS';