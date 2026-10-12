-- 06.05.2021 twie: SPEC0081686 Zuordnung der User mit den IT Projekten für Steuerung Sicherheitsfilter

-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_materialized.mv_user_it_projekt_zu_1 (user_id, it_projekt_id) AS
SELECT LOWER(user_id) AS user_id,
 it_projekt_id
FROM kfl_production_dbp_security.l_ims_user_it_projekt_1 AS V01;