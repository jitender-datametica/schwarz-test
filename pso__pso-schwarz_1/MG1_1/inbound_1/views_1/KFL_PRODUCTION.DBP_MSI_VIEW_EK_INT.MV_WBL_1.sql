create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_WBL_1(
	MANDANT_ID,
	WBL_ID,
	WBL_DAT_VON,
	WBL_NAME
) as
   SELECT
   mandant_id, wbl_id, wbl_dat_von, wbl_name
   FROM dbp_view.v_wbl_1;