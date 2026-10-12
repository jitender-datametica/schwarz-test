create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_WRG(
	WRG_ID,
	WRG_BEZ
) as
   SELECT

   v01.wrg_id, v01.wrg_bez

   FROM dbp_view.v_wrg v01;