CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_SHR_USER_SEC_2
(
	USER_ID,
	MSI_PRODUKT_BEZ
) AS

-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT
    LOWER(user_id) AS user_id
   ,msi_produkt_bez
   FROM dbp_security.l_msi_user_2
   WHERE msi_produkt_bez LIKE 'SHR';