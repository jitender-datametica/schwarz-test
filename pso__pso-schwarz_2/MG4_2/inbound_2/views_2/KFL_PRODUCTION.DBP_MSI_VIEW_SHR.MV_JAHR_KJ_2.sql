create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_JAHR_KJ_2(
	KJ,
	AKT_KJ,
	AKT_KJ_KOMPLETT
) as
   SELECT
   v01.kj, v01.akt_kj, v01.akt_kj_komplett

   FROM dbp_view.v_jahr_kj_2 v01;