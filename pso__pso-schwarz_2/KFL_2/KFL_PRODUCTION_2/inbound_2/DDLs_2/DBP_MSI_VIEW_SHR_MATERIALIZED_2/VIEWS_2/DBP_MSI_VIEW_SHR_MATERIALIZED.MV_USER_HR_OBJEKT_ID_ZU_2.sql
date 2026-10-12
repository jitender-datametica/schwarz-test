create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_USER_HR_OBJEKT_ID_ZU_2(
	MANDANT_ID,
	HR_OBJEKT_EBENE1_ID,
	USER_ID
) as
   SELECT
   mandant_id, hr_objekt_ebene1_id, user_id
   FROM dbp_security.user_hr_objekt_id_zu_2;