CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_AHK_AUFWAND_SPR_ZU_CZ_2 AS
-- 09.07.2013 twie: Erstellung Sprachview für Aufteilung AHK / Aufwand
-- 06.08.2013 twie: neues Element für AIB erstellt

   SELECT
   CASE WHEN dat = CURRENT_DATE -1 THEN 1
   WHEN dat = CURRENT_DATE -2 THEN 0
   WHEN dat = CURRENT_DATE -3 THEN 2
   ELSE -1 END ahk_aufwand_id,
   CASE WHEN dat = CURRENT_DATE -1 THEN 'AHK'
   WHEN dat = CURRENT_DATE -2 THEN 'Aufwand'
   WHEN dat= CURRENT_DATE -3 THEN 'AiB'
   ELSE 'Sonstige' END ahk_aufwand_bez

   FROM dbp_view.v_tag_2
   WHERE dat BETWEEN CURRENT_DATE -3 AND CURRENT_DATE;