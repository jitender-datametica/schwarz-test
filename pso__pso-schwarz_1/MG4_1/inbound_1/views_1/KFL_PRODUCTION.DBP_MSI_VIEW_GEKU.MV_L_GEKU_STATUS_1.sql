create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_STATUS_1(
	GEKU_STATUS_ID
) as
   SELECT
   geku_status_id
   FROM dbp_view.v_l_geku_status_1;