create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_BERECHTIGT(
	BERECHTIGT_FG
) as
   SELECT
   berechtigt_fg
   FROM dbp_view.v_l_geku_berechtigt;