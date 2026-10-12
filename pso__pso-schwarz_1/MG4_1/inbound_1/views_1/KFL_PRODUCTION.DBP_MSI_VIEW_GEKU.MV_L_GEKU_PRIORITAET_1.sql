create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_PRIORITAET_1(
	GEKU_PRIORITAET_ID,
	GEKU_RISIKOKLASSE_ID
) as
-- 25.11.2015 twie: SPEC0003061 Risikoklasse als Elternattribut

   SELECT
   geku_prioritaet_id
   , geku_risikoklasse_id
   FROM dbp_view.v_l_geku_prioritaet_1;