create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_JAHR_GJ(
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT
) as
   SELECT
   v01.gj, 
   v01.akt_gj, 
   v01.akt_gj_komplett
/* SPEC0249727 Umstellung auf VTA (vorher mv_jahr_gj_vvt) / sschuecke 23.05.2024 */
   FROM dbp_view.v_jahr_gj v01

   WHERE v01.akt_gj BETWEEN -10 AND 1;