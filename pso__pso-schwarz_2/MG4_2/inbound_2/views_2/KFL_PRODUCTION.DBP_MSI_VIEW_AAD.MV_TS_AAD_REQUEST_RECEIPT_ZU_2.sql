create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_TS_AAD_REQUEST_RECEIPT_ZU_2(
	BON_ID,
	BON_DAT,
	WUP_ID,
	MANDANT_ID,
	AAD_REQUEST_ID
) as




SELECT 
v01.BON_ID,
v01.BON_DAT,
v02.aktuell_wup_id AS wup_id,
v01.MANDANT_ID,
v01.AAD_REQUEST_ID
FROM DBP_MSI_DATA.ts_aad_request_receipt_zu_2 v01

INNER JOIN dbp_view.v_wup_2 v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;