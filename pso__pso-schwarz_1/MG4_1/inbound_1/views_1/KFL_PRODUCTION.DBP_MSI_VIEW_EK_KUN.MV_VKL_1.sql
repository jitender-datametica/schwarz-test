create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_VKL_1(
	MANDANT_ID,
	VKL_ID,
	VKL_NAME,
	GF_ID
) as 
SELECT 
mandant_id
, vkl_id
, vkl_name
, gf_id
FROM dbp_view.v_vkl_1
;