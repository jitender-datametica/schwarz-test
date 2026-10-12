create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_VS_1(
	VS_ID,
	MANDANT_ID,
	VK_ID,
	VS_BEZ,
	VSVT_BEZ,
	VS_REF_WUP_ID,
	TD_UPDATE,
	TD_INSERT
) as
SELECT
vs_id,
mandant_id,
vk_id,
vs_bez,
vsvt_bez,
vs_ref_wup_id,
TD_UPDATE,
TD_INSERT
FROM dbp_data.vs_1;
