CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_pm_vw_akt (art_id, mandant_id, vkpk1, vkpk10, vkpk4, vkpk2
, vkpk3) AS SELECT art_id,
 mandant_id,
 MAX(CASE
   WHEN pm_id = 1
   THEN vk_brutto
   ELSE NULL
   END) AS vkpk1,
 MAX(CASE
   WHEN pm_id = 10
   THEN vk_brutto
   ELSE NULL
   END) AS vkpk10,
 MAX(CASE
   WHEN pm_id = 4
   THEN vk_brutto
   ELSE NULL
   END) AS vkpk4,
 MAX(CASE
   WHEN pm_id = 2
   THEN vk_brutto
   ELSE NULL
   END) AS vkpk2,
 MAX(CASE
   WHEN pm_id = 3
   THEN vk_brutto
   ELSE NULL
   END) AS vkpk3
FROM kfl_production_dbp_view.v_art_pm_vw_zu_per AS V01
WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
 AND mandant_id = 1
 AND pm_id IN (1, 4, 10, 2, 3)
 AND preistyp_id = 0
GROUP BY art_id,
 mandant_id;