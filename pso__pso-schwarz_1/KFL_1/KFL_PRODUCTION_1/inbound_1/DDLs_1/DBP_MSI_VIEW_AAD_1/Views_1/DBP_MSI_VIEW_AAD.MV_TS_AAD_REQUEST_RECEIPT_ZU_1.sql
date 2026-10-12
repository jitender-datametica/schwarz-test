CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_TS_AAD_REQUEST_RECEIPT_ZU_1
(
	BON_ID,
	BON_DAT,
	WUP_ID,
	MANDANT_ID,
	AAD_REQUEST_ID
)
AS

--26.08.2024 twie: SPEC0266321 Filialumgliederung (P1760) alle Filialen werden in den Views von wup_id auf aktuell_wup_id umgemappt
--							   somit im Frontend nur die neue ID, auch alte Bewegungsdaten werden ab Umgliederungsdatum unter der neuen ID angzeigt 

SELECT 
v01.BON_ID,
v01.BON_DAT,
v02.aktuell_wup_id AS wup_id,
v01.MANDANT_ID,
v01.AAD_REQUEST_ID
FROM DBP_MSI_DATA.ts_aad_request_receipt_zu_1 v01

INNER JOIN dbp_view.v_wup_1 v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;