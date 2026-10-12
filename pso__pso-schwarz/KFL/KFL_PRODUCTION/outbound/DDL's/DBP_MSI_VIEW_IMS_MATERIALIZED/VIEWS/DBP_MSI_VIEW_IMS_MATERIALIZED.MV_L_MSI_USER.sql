-- 06.12.2018 twie: SPEC0044926 Lookup User für Security

-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_materialized.mv_l_msi_user (user_id) AS SELECT LOWER(user_id) AS
 user_id
FROM kfl_production_dbp_security.l_msi_user AS V01
WHERE msi_produkt_bez = 'IMS';