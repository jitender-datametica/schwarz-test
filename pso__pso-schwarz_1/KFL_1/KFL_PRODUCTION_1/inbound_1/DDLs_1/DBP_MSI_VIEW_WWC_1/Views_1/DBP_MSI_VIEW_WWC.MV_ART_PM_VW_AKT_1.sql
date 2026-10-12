CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_PM_VW_AKT_1
-- AP0032822, SPEC0041631 - 13.11.2108, mkub1811 Erweiterung um VKPK 2 und VKPK3
(
art_id
,mandant_id
,VKPK1
,VKPK10
,VKPK4
,VKPK2
,VKPK3
)
AS
   SELECT art_id, mandant_id, MAX(CASE WHEN pm_id = 1 THEN vk_brutto END) AS VKPK1, MAX(CASE WHEN pm_id = 10 THEN vk_brutto END) AS VKPK10, MAX(CASE WHEN pm_id = 4 THEN vk_brutto END) AS VKPK4, MAX(CASE WHEN pm_id = 2 THEN vk_brutto END) AS VKPK2, MAX(CASE WHEN pm_id = 3 THEN vk_brutto END) AS VKPK3

   FROM dbp_view.v_art_pm_vw_zu_per_1  v01
   WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
   AND v01.mandant_id = 1
   -- Einschr?en, da Tabelle von FLW erweitert wurde
   AND
   pm_id IN  (1, 4, 10, 2, 3)
   AND preistyp_id = 0

   GROUP BY art_id
   ,mandant_id;