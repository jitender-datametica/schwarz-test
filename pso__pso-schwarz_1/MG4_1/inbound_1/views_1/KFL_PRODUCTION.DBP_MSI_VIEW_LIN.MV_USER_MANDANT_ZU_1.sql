create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_USER_MANDANT_ZU_1(
	MANDANT_ID,
	USER_ID
) as
   SELECT
   mandant_id, user_id
   FROM dbp_security.user_hr_objekt_id_zu_1
   GROUP BY 1,2;