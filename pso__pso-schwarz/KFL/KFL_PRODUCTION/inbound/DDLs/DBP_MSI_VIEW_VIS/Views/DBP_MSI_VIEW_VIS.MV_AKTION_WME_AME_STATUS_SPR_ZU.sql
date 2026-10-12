CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AKTION_WME_AME_STATUS_SPR_ZU
AS

/* SPRACHE : Aktion FG Bezeichnung
-- 20220727 ssch0611 : Review. New Status FG
*/

SELECT
  $1 AS aktion_wme_ame_status_fg 
, $2 AS aktion_wme_ame_status_bez 
FROM (
  SELECT 0, 'Mengeneinholung' FROM TABLE(GENERATOR(rowcount => 1))
  UNION ALL 
  SELECT 1, 'Bekanntmachung' FROM TABLE(GENERATOR(rowcount => 1))
) sub00;