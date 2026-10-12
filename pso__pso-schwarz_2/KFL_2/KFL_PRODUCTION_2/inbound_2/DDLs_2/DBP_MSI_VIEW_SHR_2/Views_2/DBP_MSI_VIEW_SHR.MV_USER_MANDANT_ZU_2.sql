CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_USER_MANDANT_ZU_2
(
	MANDANT_ID,
	USER_ID
) AS

-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT
    mandant_id
   ,LOWER(user_id) AS user_id
   FROM dbp_security.user_hr_objekt_id_zu_2
   GROUP BY
   mandant_id
   ,user_id
   ;