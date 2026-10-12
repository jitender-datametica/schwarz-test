create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_ODS_BON_STORNO_1(
	BON_ID,
	BON_DAT,
	MANDANT_ID,
	WUP_ID,
	BON_NR,
	KASSE_NR,
	DATEI_NAME
) as





	SELECT
	  v01.BON_ID
	, v01.BON_DAT
	, v01.MANDANT_ID
	, v02.aktuell_wup_id AS wup_id
	, v01.BON_NR
	, v01.KASSE_NR
	, v01.DATEI_NAME
	FROM KFL_PRODUCTION_CLONE_AAD.DBP_V_ODS.V_ODS_BON_STORNO_1 v01

INNER JOIN dbp_view.v_wup_1 v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;