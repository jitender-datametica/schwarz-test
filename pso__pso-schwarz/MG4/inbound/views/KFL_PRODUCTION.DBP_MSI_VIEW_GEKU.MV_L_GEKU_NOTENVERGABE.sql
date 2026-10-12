create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_NOTENVERGABE(
	GEKU_NOTENVERGABE_DURCH_ID
) as
   SELECT
   geku_notenvergabe_durch_id
   FROM dbp_view.v_l_geku_notenvergabe;