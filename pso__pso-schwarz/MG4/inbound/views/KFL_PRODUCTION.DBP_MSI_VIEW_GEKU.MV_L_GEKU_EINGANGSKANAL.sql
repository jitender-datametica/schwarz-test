create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_EINGANGSKANAL(
	GEKU_EINGANGSKANAL_ID
) as
   SELECT
   geku_eingangskanal_id
   FROM dbp_view.v_l_geku_eingangskanal;