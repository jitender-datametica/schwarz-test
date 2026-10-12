create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_JAHR_GJ(
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT
) as 
SELECT
 v01.gj
,v01.akt_gj
,v01.akt_gj_komplett 
FROM dbp_view.v_jahr_gj v01

WHERE v01.gj > 2001
;