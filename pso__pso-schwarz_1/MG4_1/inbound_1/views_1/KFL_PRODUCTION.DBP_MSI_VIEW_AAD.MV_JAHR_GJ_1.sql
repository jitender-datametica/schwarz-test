create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_JAHR_GJ_1(
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT
) as
--15.06.2023 snik: SPEC0200542 Lookup GJ
SELECT
     v01.gj
   , v01.akt_gj
   , v01.akt_gj_komplett
FROM dbp_view.v_jahr_gj_1 v01
WHERE gj>=2023;