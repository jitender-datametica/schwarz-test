create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_IDEE_2(
	IDEE_FG
) as
-- 23.03.2015 twie: Lookupview Idee aus universeller Flagtabelle ja/nein

   SELECT
   flag AS idee_fg
   FROM dbp_view.v_flag_spr_zu_2
   WHERE  flag_typ_id = 1 -- entspricht ja/nein Flag
   GROUP BY flag;