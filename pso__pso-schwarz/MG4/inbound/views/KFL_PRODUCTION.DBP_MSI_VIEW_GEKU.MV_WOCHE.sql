create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_WOCHE(
	KJWO,
	GJWO,
	KJWO_VJ,
	GJWO_VJ,
	KJWO_VVJ,
	GJWO_VVJ,
	AKT_WO_KALENDARISCH,
	KJ,
	GJ,
	AKT_WO,
	AKT_WO_KOMPLETT,
	WW_BEZ
) as
-- 01.09.2016 twie: bez für Werbewoche (WW)

   SELECT
   kjwo,
   gjwo,
   kjwo_vj,
   gjwo_vj,
   kjwo - 200,
   gjwo - 200,
   akt_wo_kalendarisch, 
   TRUNC(kjwo/100::SMALLINT),
   TRUNC(gjwo/100::SMALLINT),
   akt_wo,
   akt_wo_komplett,
   'WW' || CAST(kjwo AS VARCHAR(6)) AS ww_bez
   FROM dbp_view.v_woche
   WHERE kjwo > 200152;