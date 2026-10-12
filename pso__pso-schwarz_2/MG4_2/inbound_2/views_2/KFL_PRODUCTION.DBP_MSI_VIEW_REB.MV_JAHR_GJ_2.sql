create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_JAHR_GJ_2(
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	AKT_GJ_HELP
) as
   SELECT
   gj, akt_gj, akt_gj_komplett, CASE WHEN EXTRACT (MONTH FROM(CURRENT_DATE)) = 3 THEN akt_gj +1 ELSE akt_gj END AS akt_gj_help

   FROM dbp_view.v_jahr_gj_2
   WHERE gj > 2001
;