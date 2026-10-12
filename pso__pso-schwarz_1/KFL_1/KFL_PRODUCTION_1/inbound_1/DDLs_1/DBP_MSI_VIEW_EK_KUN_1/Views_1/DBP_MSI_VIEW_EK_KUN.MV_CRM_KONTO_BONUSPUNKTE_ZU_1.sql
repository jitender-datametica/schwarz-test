CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_KONTO_BONUSPUNKTE_ZU_1
--mcie1607, 03/12/2019, SPEC0066512- new view.
--staniszewskp 12.11.2020 SPEC0091715, -remove  anz_bald_verfallende_bonuspunkte + dat_verfall_bonuspunkte 
--staniszewskp 29.11.2020 SPEC0091715, -remove  dat_verfall_bonuspunkte from group by

AS
SELECT
v01.crm_konto_id
,SUM(v01.anz_einloesbare_bonuspunkte) AS anz_einloesbare_bonuspunkte
,SUM(v01.anz_eingeloeste_bonuspunkte) AS anz_eingeloeste_bonuspunkte
,SUM(v01.anz_verfallene_bonuspunkte) AS anz_verfallene_bonuspunkte

FROM dbp_view.v_crm_konto_bonuspunkte_zu_1 v01

GROUP BY
v01.crm_konto_id
;