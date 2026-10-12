create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_L_MSI_USER_1(
	USER_ID
) as
-- 15.01.2019 twie: SPEC0046912 Lookup User für Security
-- 25.01.2024 twie: NSR4272151 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT

   LOWER(v01.user_id) AS user_id

   FROM dbp_security.l_msi_user_1 v01

   WHERE msi_produkt_bez = 'KMR';