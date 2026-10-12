create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_BEWART(
	BEWART_ID
) as
   SELECT
   bewart_id

   FROM dbp_view.v_bewart
   WHERE bewart_id IN (1001,1002);