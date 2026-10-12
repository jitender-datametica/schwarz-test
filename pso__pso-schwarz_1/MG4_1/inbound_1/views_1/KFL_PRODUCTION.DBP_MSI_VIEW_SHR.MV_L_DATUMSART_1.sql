create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_DATUMSART_1(
	MANDANT_ID,
	DATUMSART_ID
) as
   SELECT
   v01.mandant_id, v01.datumsart_id

   FROM dbp_view.v_l_datumsart_1 v01;