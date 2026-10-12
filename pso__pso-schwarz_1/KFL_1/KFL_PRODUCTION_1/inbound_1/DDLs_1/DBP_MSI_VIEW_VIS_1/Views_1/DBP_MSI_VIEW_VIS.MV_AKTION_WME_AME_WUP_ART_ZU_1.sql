CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AKTION_WME_AME_WUP_ART_ZU_1
AS

/* ZUORDNUNG : Artikel_1 / Filiale / Aktion_1 WME AME
-- 20220726 ssch0611 : Review. New Filter
*/

SELECT
  wme_ame.mandant_id
, wme_ame.aktion_id
, wme_ame.wup_id
, wme_ame.nb_id
, wme_ame.art_id 
FROM dbp_data.aktion_art_wup_zu_wme_ame_1 wme_ame

WHERE (wme_ame.aktion_id) IN (
  SELECT DISTINCT aktion_id
  FROM dbp_data.aktion_werbemengen_einholung_1
  WHERE dat_bis >= CURRENT_DATE
) ;