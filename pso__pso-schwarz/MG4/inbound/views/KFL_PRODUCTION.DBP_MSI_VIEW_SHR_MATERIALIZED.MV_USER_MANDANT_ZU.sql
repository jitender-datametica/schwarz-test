create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR_MATERIALIZED.MV_USER_MANDANT_ZU(
	MANDANT_ID,
	USER_ID
) as

-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT
    mandant_id
   ,LOWER(user_id) AS user_id
   FROM dbp_security.user_hr_objekt_id_zu
   GROUP BY
   mandant_id
   ,user_id
   ;