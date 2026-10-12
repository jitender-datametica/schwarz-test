CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AKTION_WME_AME_LOOKUP_1
AS

/* LOOKUP : Aktion_1 WME AME 
-- 20220727 ssch0611 : Review. New Join + Filter 
*/

SELECT 
  ein_hol.mandant_id
, ein_hol.aktion_id
, CASE 
    WHEN ein_hol.aktion_typ_id = 'ZAME' THEN 'AME' 
    ELSE 'WME' 
  END AS aktion_typ
, wme_ame.aktionsart_id
, ein_hol.schlagwort
, wme_ame.zusatzinfo
, ein_hol.dat_von
, ein_hol.dat_bis
FROM dbp_data.aktion_wme_ame_1 wme_ame  

JOIN (
  SELECT DISTINCT
    mandant_id
  , aktion_id
  , schlagwort
  , aktion_typ_id
  , dat_von
  , dat_bis
  FROM dbp_data.aktion_werbemengen_einholung_1
) ein_hol
ON  wme_ame.aktion_id = ein_hol.aktion_id 
AND wme_ame.mandant_id = ein_hol.mandant_id

WHERE ein_hol.dat_bis >= CURRENT_DATE;
