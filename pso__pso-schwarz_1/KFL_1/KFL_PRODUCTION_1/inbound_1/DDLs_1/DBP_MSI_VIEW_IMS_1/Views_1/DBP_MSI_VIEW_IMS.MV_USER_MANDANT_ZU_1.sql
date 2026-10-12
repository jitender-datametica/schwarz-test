CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_USER_MANDANT_ZU_1
(
	MANDANT_ID,
	USER_ID
) AS
-- 11.12.2018 twie: SPEC0044926 Zuordnung User - Mandant_1 für Attributbeziehung
-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT

   v01.mandant_id,
   LOWER(v01.user_id) AS user_id

   FROM dbp_security.user_mandant_msiprodukt_zu_1 v01

   WHERE v01.msi_produkt_bez = 'IMS';