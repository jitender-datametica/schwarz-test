create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_STANDARDLOESUNG_FG_2(
	STANDARDLOESUNG_FG
) as
-- 02.04.2020 lsvi: SPEC0064978 Lookup CRM Standardloesung Flag

   SELECT

   flag AS standardloesung_fg

   FROM dbp_view.v_flag_spr_zu_2  --keine Lookup vorhanden

   GROUP BY flag;