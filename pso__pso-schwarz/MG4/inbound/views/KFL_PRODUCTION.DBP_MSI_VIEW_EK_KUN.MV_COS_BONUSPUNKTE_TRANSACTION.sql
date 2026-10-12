create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_COS_BONUSPUNKTE_TRANSACTION(
	CRM_KONTO_ID,
	DAT_BONUSPUNKTE_TRANSAKTION,
	MANDANT_ID,
	BONUSPUNKTE_TRANSAKTION_ID,
	ANZ_BONUSPUNKTE_TRANSAKTION,
	EINGELOESTE_BONUSPUNKTE_FG,
	BONUSPUNKTE_TRANSAKTION_RICHTUNG
) as
SELECT
 crm_konto_id
,TO_DATE(datzeit_bonuspunkte_transaktion) AS dat_bonuspunkte_transaktion
,mandant_id
,bonuspunkte_transaktion_id
,SUM(anz_bonuspunkte_transaktion) AS anz_bonuspunkte_transaktion
,CASE WHEN bonuspunkte_transaktion_richtung = 2 THEN '1' END AS eingeloeste_bonuspunkte_fg
,bonuspunkte_transaktion_richtung

FROM dbp_view.v_cos_bonuspunkte_transaktion

GROUP BY
 crm_konto_id
,datzeit_bonuspunkte_transaktion
,mandant_id
,bonuspunkte_transaktion_id
,bonuspunkte_transaktion_richtung
;