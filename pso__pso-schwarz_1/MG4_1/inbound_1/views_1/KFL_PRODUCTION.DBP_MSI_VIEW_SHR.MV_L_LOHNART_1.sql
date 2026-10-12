create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_LOHNART_1(
	MANDANT_ID,
	LOHNART_ID
) as
   SELECT
   v01.mandant_id, v01.lohnart_id

   FROM dbp_view.v_l_lohnart_1 v01;