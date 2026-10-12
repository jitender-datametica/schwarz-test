create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_FOTO_FG_1(
	FOTO_FG
) as
-- 22.07.2019 twie: SPEC0059158 Lookup CRM Foto Flag

   SELECT

   flag AS foto_fg

   FROM dbp_view.v_flag_spr_zu_1  --keine Lookup vorhanden

   GROUP BY flag;