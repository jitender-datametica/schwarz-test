CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS_DT.MV_L_MSI_USER
(
	USER_ID
)
AS
-- 06.12.2018 twie: SPEC0044926 Lookup User für Security
-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT

   LOWER(v01.user_id) AS user_id

   FROM dbp_security.l_msi_user v01

   WHERE msi_produkt_bez = 'IMS'
   ;