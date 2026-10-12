create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_USER_ROLLE_EK_INT_ZU_2(
	MANDANT_ID,
	USER_ID,
	ROLLE_ID,
	ROLLE_BEZ,
	ZEK_ID,
	WBL_ID,
	GF_ID
) as
   SELECT
    mandant_id
   --Anpassung user_id in Kleinschreibung im Zuge automat. Useranlage / sschuecke 30.10.2023
   ,LOWER (user_id)
   --,user_id
   ,rolle_id
   ,rolle_bez
   ,zek_id
   ,wbl_id
   ,gf_id
   FROM dbp_security.user_rolle_ek_int_zu_2
   UNION
   SELECT DISTINCT
    mandant_id
   ,'Superuser' AS user_id
   ,rolle_id
   ,rolle_bez
   ,zek_id
   ,wbl_id
   ,gf_id
   FROM dbp_security.user_rolle_ek_int_zu_2
   WHERE rolle_id = 4;