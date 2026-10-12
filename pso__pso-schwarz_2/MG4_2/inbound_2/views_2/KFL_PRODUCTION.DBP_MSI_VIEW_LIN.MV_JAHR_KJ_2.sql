create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_JAHR_KJ_2(
	KJ,
	AKT_KJ,
	AKT_KJ_KOMPLETT,
	KJ_KURZ
) as
   SELECT
   v01.kj, v01.akt_kj, v01.akt_kj_komplett, SUBSTR(CAST(v01.kj AS CHAR(4)),3,2) AS kj_kurz

   FROM dbp_view.v_jahr_kj_2 v01;