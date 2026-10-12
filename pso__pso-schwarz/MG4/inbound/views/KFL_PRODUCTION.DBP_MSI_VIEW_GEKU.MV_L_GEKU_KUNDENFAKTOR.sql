create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_KUNDENFAKTOR(
	KUNDENFAKTOR_ID,
	MARKT_FG,
	FACH_FG
) as
   SELECT
   kundenfaktor_id
   , markt_fg
   , fach_fg
   FROM dbp_view.v_l_geku_kundenfaktor;