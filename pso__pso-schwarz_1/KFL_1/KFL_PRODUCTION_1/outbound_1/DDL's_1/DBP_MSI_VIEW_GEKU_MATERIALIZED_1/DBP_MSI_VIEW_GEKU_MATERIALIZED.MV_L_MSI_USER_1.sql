-- 25.01.2024 twie: NSR4272151 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

-- 15.01.2019 twie: SPEC0046912 Lookup User für Security

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_l_msi_user_1 (user_id) AS SELECT LOWER(user_id) AS
 user_id
FROM kfl_production_dbp_security.l_msi_user_1 AS V01
WHERE msi_produkt_bez = 'KMR';