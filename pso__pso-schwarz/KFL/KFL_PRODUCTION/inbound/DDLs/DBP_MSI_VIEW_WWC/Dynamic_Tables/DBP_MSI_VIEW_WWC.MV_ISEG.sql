CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_ISEG
-- 20140526 kkaiser - initiale Erstellung für # 586188
-- 20180410 srom - Korrekture in SELECT dritte Zeile inv_beleg_id ... war auch auf MBLNR_ZEILE benannt. Ist aber IBLNR_ZEILE
-- 20210210 srom - intern, separate Lookup Tabelle für nullzaehl_fg (mv_fg_spr_zu)
(
inv_beleg_id
,gj
,inv_beleg_pos_id
,IBLNR_ZEILE
,mandant_id
,dat_letzt_zaehl
,lagerort_id
,dat_buch
,wup_id
,nb_id
,art_id
,lagerbew_beleg_id
,lagerbew_beleg_pos_id
,MBLNR_ZEILE
,kj
,erfsngs_menge_einh_id
,menge_erf
,menge_buch
,menge_zaehl
,wert_diff_inv
,wert_vk_brutto
,wert_vk_extern
,wert_vk_netto
,vk_inventur_diff_brutto
,vk_inventur_diff_netto
,wert_zaehl
,wert_menge_buch
,nullzaehl_fg
,beleg_erfasser_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
 --NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
 --04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
 --20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
 --22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
 --19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
 --14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
   SELECT
   v01.inv_beleg_id
  , v01.gj
  , v01.inv_beleg_pos_id
  , TO_VARCHAR(v01.inv_beleg_id, 'FM0000000000') ||' ' || TO_VARCHAR(v01.inv_beleg_pos_id, 'FM0000') AS IBLNR_ZEILE
  , v01.mandant_id, v01.dat_letzt_zaehl, v01.lagerort_id, v01.dat_buch, v01.wup_id, v01.nb_id, v01.art_id
  , COALESCE(v01.lagerbew_beleg_id,0) AS lagerbew_beleg_id
  , COALESCE(v01.lagerbew_beleg_pos_id,0) AS lagerbew_beleg_pos_id
  , TO_VARCHAR(v01.lagerbew_beleg_id, 'FM0000000000') ||' ' || TO_VARCHAR(v01.lagerbew_beleg_pos_id, 'FM0000') AS MBLNR_ZEILE
  , v01.kj, v01.erfsngs_menge_einh_id, v01.menge_erf, v01.menge_buch, v01.menge_zaehl
  , v01.wert_diff_inv, v01.wert_vk_brutto, v01.wert_vk_extern, v01.wert_vk_netto
  , v01.vk_inventur_diff_brutto, v01.vk_inventur_diff_netto, v01.wert_zaehl
  , v01.wert_menge_buch
  --, CASE WHEN v01.nullzaehl_fg > 0  THEN 'X' ELSE ' ' END  AS nullzaehl_fg
  , v01.nullzaehl_fg
  , v01.beleg_erfasser_id
  FROM dbp_view.v_inventur_det v01
  --Suhsi RO ausfiltern
  INNER JOIN DBP_VIEW.V_art_wg_zu_per V02
  ON v01.Art_ID=v02.art_id
  AND v01.mandant_id = v02.mandant_id
  -- Wenn nicht Mandant 1,7 dann alles   
  AND (v02.MANDANT_ID NOT IN (1,7)
     -- wenn  Mandant 1,7 dann  kein Sushi/Shop in Shop 
     OR (V02.MANDANT_ID IN (1,7) AND TO_VARCHAR(V02.wg_id,'FM000')|| TO_VARCHAR(V02.wug_id,'FM000') != '969006' )
  )
   -- Wenn nicht Mandant 7 dann alles   
  AND (v02.MANDANT_ID != 7
   -- Wenn  Mandant 7 dann kein Pfand 
      OR v02.MANDANT_ID = 7 AND TO_VARCHAR(v02.wg_id,'FM000') !='980')
  --Ausfiltern Shop in Shop
  AND V02.wg_id!=961
  --Ausfiltern E-Loading alle Mandaten ungleich 1
  AND (v02.MANDANT_ID NOT IN (2,3,4,5,6,7,8)
     -- wenn  Mandant ungleich 1 dann ohne E-loading 
      OR (v02.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V02.wg_id,'FM000')|| TO_VARCHAR(v02.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))
   )        
  AND V02.arthiertyp_id = 2
  AND V02.dat_bis = '9999-12-31';