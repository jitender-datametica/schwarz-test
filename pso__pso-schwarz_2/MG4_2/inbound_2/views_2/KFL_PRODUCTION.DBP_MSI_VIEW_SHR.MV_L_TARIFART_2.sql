create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_TARIFART_2(
	MANDANT_ID,
	TARIFART_ID
) as
   SELECT
   v01.mandant_id, v01.tarifart_id

   FROM dbp_view.v_l_tarifart_2 v01;