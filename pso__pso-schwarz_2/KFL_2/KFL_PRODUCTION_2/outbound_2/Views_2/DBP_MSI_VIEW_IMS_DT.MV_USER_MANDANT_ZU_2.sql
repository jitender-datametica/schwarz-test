CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_dt.mv_user_mandant_zu_2 (mandant_id, user_id) AS SELECT mandant_id
 ,
 LOWER(user_id) AS user_id
FROM kfl_production_dbp_security.user_mandant_msiprodukt_zu_2 AS V01
WHERE msi_produkt_bez = 'IMS';