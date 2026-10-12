CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_COS_BONUSPUNKTE_TRANSACTION_2
(
 crm_konto_id
,dat_bonuspunkte_transaktion
,mandant_id
,bonuspunkte_transaktion_id
,anz_bonuspunkte_transaktion
,eingeloeste_bonuspunkte_fg
,bonuspunkte_transaktion_richtung
)
AS
SELECT
 crm_konto_id
,TO_DATE(datzeit_bonuspunkte_transaktion) AS dat_bonuspunkte_transaktion
,mandant_id
,bonuspunkte_transaktion_id
,SUM(anz_bonuspunkte_transaktion) AS anz_bonuspunkte_transaktion
,CASE WHEN bonuspunkte_transaktion_richtung = 2 THEN '1' END AS eingeloeste_bonuspunkte_fg
,bonuspunkte_transaktion_richtung

FROM dbp_view.v_cos_bonuspunkte_transaktion_2

GROUP BY
 crm_konto_id
,datzeit_bonuspunkte_transaktion
,mandant_id
,bonuspunkte_transaktion_id
,bonuspunkte_transaktion_richtung
;