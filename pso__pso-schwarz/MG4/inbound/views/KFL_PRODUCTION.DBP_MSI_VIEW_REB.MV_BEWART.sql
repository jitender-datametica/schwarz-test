create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_BEWART(
	BEWART_ID
) as
   SELECT
   bewart_id
   FROM dbp_view.v_bewart
;