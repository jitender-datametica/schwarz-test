create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_FREMDKOERPER_FG_2(
	FREMDKOERPER_FG
) as
-- 22.07.2019 twie: SPEC0059158 Lookup CRM Fremdkoerper Flag

   SELECT

   flag AS fremdkoerper_fg

   FROM dbp_view.v_flag_spr_zu_2

   GROUP BY flag;