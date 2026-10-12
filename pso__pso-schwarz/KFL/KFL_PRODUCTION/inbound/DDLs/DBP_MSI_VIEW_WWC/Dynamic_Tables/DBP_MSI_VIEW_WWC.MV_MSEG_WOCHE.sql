CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_MSEG_WOCHE
(
mandant_id
, BWART
, art_id
, WERKS
, nb_id
, LIFNR
, kjwo_kl
, WAERS
, DMBTR
, VKWRT
, MENGE
, VKWRA
, EXVKW
, betrag_verkauf_ist_netto
, EXVKW_nt
, VK_Wert_nt
, EXBWR
, exvkw_gleich_vkwrt_fg
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
  --NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
  --04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
  --20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
  --22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
  --19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
  --14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
  SELECT
  v01.mandant_id, 
  v01.lager_bewart_id AS BWART, 
  v01.art_id, 
  v01.wup_id AS WERKS, 
  v01.nb_id, v01.gp_id AS LIFNR, 
  v01.kjwo_kl, 
  v01.wrg_id AS WAERS, 
  v01.betrag_lagerbew AS DMBTR, 
  v01.betrag_verkauf AS VKWRT, 
  v01.menge_lagerbew_bme AS MENGE, 
  v01.betrag_vk_netto AS VKWRA, 
  v01.betrag_verkauf_ist AS EXVKW, 
  v01.betrag_verkauf_ist_netto, 
  CASE WHEN v01.exvkw_gleich_vkwrt_fg = 1 THEN v01.betrag_vk_netto ELSE v01.betrag_verkauf_ist_netto END AS EXVKW_nt,   
  CASE WHEN v01.lager_bewart_id IN ('251','252') AND v01.exvkw_gleich_vkwrt_fg = 1   THEN v01.betrag_vk_netto
  WHEN v01.lager_bewart_id IN ('251','252') AND v01.exvkw_gleich_vkwrt_fg = 0 THEN v01.betrag_verkauf_ist_netto
  WHEN v01.lager_bewart_id NOT IN ('251','252') THEN v01.betrag_vk_netto
  ELSE 0
  END AS VK_Wert_nt, 
  v01.betrag_exbwr AS EXBWR, 
  v01.exvkw_gleich_vkwrt_fg
  FROM dbp_view.v_lagerbew_det_wwc_woche v01
  --Suhsi RO ausfiltern
  INNER JOIN DBP_VIEW.V_art_wg_zu_per V03
  ON v01.Art_ID=v03.art_id
  AND v01.mandant_id = v03.mandant_id
  -- Wenn nicht Mandant 1,7 dann alles   
  AND (v03.MANDANT_ID NOT IN (1,7)
      -- Wenn  Mandant 1,7 dann  kein Sushi/Shop in Shop 
      OR (V03.MANDANT_ID IN (1,7) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(V03.wug_id,'FM000') != '969006' )
   )
   -- Wenn nicht Mandant 7 dann alles   
   AND (v03.MANDANT_ID != 7
   -- Wenn  Mandant 7 dann kein Pfand 
      OR v03.MANDANT_ID = 7 AND TO_VARCHAR(v03.wg_id,'FM000') !='980')
  --Ausfiltern Shop in Shop
  AND v03.wg_id!=961
  --Ausfiltern E-Loading alle Mandaten ungleich 1
  AND (v03.MANDANT_ID NOT IN (2,3,4,5,6,7,8)
     --- wenn  Mandant ungleich 1 dann ohne E-loading 
      OR (v03.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(v03.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))
  )         
  AND V03.arthiertyp_id = 2
  AND V03.dat_bis = '9999-12-31';