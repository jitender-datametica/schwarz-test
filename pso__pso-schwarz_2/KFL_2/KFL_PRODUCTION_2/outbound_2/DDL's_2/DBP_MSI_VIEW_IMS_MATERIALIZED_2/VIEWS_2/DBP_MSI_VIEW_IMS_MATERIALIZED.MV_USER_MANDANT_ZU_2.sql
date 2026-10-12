-- 11.12.2018 twie: SPEC0044926 Zuordnung User - Mandant_2 für Attributbeziehung

-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_materialized.mv_user_mandant_zu_2 (mandant_id, user_id) AS SELECT
 mandant_id,
 LOWER(user_id) AS user_id
FROM kfl_production_dbp_security.user_mandant_msiprodukt_zu_2 AS V01
WHERE msi_produkt_bez = 'IMS';