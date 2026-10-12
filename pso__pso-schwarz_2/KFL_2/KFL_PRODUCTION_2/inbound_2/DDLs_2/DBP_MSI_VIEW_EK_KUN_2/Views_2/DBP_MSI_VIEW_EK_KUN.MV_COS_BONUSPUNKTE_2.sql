CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_COS_BONUSPUNKTE_2
(
 crm_konto_id
,dat_verfall_bonuspunkte
,mandant_id
,anz_bonuspunkte
,einloesbare_bonuspunkte
,verfallene_bonuspunkte
,bonuspunkt_fg
,dat_update
)
AS
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
FROM dbp_view.v_cos_bonuspunkte_2
GROUP BY 
 crm_konto_id
,dat_verfall_bonuspunkte
,mandant_id
,anz_bonuspunkte
,dat_update;