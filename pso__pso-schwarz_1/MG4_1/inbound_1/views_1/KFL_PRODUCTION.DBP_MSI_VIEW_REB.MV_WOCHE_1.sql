create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_WOCHE_1(
	KJWO,
	GJWO,
	KJWO_VJ,
	GJWO_VJ,
	AKT_WO_KALENDARISCH,
	AKT_WO,
	KJ,
	GJ
) as
   SELECT
   kjwo, gjwo, kjwo_vj, gjwo_vj, akt_wo_kalendarisch, akt_wo, CAST (SUBSTR(TRIM(kjwo), 0, 4) AS SMALLINT), CAST (SUBSTR(TRIM(gjwo), 0, 4) AS SMALLINT)

   FROM dbp_view.v_woche_1
   WHERE kjwo > 200152
;