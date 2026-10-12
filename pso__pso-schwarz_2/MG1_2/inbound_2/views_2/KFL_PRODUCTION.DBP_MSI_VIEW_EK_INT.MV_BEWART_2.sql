create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_BEWART_2(
	BEWART_ID
) as
   SELECT
   bewart_id

   FROM dbp_view.v_bewart_2
   WHERE bewart_id IN (1001,1002);