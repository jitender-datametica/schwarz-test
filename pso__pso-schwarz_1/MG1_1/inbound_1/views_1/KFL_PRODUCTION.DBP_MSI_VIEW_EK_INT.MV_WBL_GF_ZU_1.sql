create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_WBL_GF_ZU_1(
	MANDANT_ID,
	WBL_ID,
	GF_ID
) as
   SELECT
   mandant_id, wbl_id, gf_id
   FROM dbp_security.wbl_gf_zu_1;