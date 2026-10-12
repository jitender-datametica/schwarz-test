create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_L_SHR_USER_SEC_1(
	USER_ID,
	MSI_PRODUKT_BEZ
) as

-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT
    LOWER(user_id) AS user_id
   ,msi_produkt_bez
   FROM dbp_security.l_msi_user_1
   WHERE msi_produkt_bez LIKE 'SHR';