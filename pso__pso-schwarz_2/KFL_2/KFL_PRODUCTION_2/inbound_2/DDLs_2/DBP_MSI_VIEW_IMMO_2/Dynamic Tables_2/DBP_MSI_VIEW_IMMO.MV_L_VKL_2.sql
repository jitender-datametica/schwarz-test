CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_VKL_2(
	VKL_ID,
	MANDANT_ID,
	GF_ID,
	VKL_NAME
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT

   vkl_id, mandant_id, gf_id, vkl_name

   FROM dbp_view.v_vkl_2
;