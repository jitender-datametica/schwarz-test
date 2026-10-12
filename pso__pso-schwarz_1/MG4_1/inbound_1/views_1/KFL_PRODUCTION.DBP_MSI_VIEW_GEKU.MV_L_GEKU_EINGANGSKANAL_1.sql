create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_EINGANGSKANAL_1(
	GEKU_EINGANGSKANAL_ID
) as
   SELECT
   geku_eingangskanal_id
   FROM dbp_view.v_l_geku_eingangskanal_1;