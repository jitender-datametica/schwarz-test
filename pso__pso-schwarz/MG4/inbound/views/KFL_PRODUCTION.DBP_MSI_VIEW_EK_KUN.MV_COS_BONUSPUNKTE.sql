create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_COS_BONUSPUNKTE(
	CRM_KONTO_ID,
	DAT_VERFALL_BONUSPUNKTE,
	MANDANT_ID,
	ANZ_BONUSPUNKTE,
	EINLOESBARE_BONUSPUNKTE,
	VERFALLENE_BONUSPUNKTE,
	BONUSPUNKT_FG,
	DAT_UPDATE
) as
SELECT
 crm_konto_id
,dat_verfall_bonuspunkte
,mandant_id
,anz_bonuspunkte
,CASE WHEN dat_verfall_bonuspunkte >= CURRENT_DATE THEN SUM (anz_bonuspunkte) ELSE 0 END AS einloesbare_bonuspunkte
,CASE WHEN dat_verfall_bonuspunkte < CURRENT_DATE THEN SUM (anz_bonuspunkte) ELSE 0 END AS verfallene_bonuspunkte
-- ermittlung Einlösbar (Flag 1) bzw Verfallen (Flag 0)
,CASE WHEN einloesbare_bonuspunkte > 0 THEN '1' ELSE 0 END AS bonuspunkt_fg
,TO_DATE (datzeit_update) AS dat_update
FROM dbp_view.v_cos_bonuspunkte
GROUP BY 
 crm_konto_id
,dat_verfall_bonuspunkte
,mandant_id
,anz_bonuspunkte
,dat_update;