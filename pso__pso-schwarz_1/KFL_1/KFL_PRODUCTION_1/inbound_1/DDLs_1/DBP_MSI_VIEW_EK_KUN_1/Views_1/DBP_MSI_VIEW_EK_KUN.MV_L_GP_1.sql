create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_L_GP_1(
	GP_ID,
	MANDANT_ID,
	GP_NAME,
	DAT_VON,
	DAT_BIS
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.gp_id
   ,v01.mandant_id
   ,CASE WHEN v01.gp_id >= 1 THEN v01.gp_name ELSE NULL END AS gp_name
   ,dat_von
   ,dat_bis
   FROM DBP_DATA.GP_1 v01;
