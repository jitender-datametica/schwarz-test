CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_ARTBEW_MO_SUM_2
-- AP0016264, srom0404 19.01.2017 Sortimentspreiseffekt
-- Zugriff auf Aggregate, damit nicht mehr über Einzeldaten der View DBx_MSI_VIEW_WWC.mv_mseg_artbew_de_2 gegangen werden muss
-- in artbew_2 liegen die Betraege in Landeswährung vor. Über Mandant_2 die Default Waehrung anzeigen
-- AP0030398, SPEC0039495 srom0404 04.07.2018 - Payback ins WWC, Hier noch das Feld BWART aufgenommen
(
mandant_id
,WERKS
,nb_id
,bewart_id
,kjmo
,art_id
,MENGE
,VK_netto
,wrg_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS 
  --NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
  --04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
  --20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
  --22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
  --19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
  --14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
   SELECT v01.mandant_id, v01.wup_id AS WERKS, 
   v01.nb_id, 
   v01.bewart_id, 
   v01.kjmo, 
   v01.art_id, 
   v01.menge AS MENGE, 
   v01.umsatz_netto AS VK_netto,      
   v02.default_wrg AS wrg_id
   FROM dbp_view.v_artbew_mo_sum_2 v01
   JOIN dbp_view.v_mandant_2 v02
   ON v01.mandant_id = v02.mandant_id
     --Suhsi RO ausfiltern
   INNER JOIN DBP_VIEW.V_art_wg_zu_per_2 V03
   ON v01.Art_ID=v03.art_id
   AND v01.mandant_id = v03.mandant_id
   -- Wenn nicht Mandant_2 1,7 dann alles   
   AND (v03.MANDANT_ID NOT IN (1,7)
      -- wenn  Mandant_2 1,7 dann  kein Sushi/Shop in Shop 
      OR (V03.MANDANT_ID IN (1,7) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(V03.wug_id,'FM000') != '969006' )
   )
   -- Wenn nicht Mandant_2 7 dann alles   
   AND (v03.MANDANT_ID != 7
   -- Wenn  Mandant_2 7 dann kein Pfand 
      OR v03.MANDANT_ID = 7 AND TO_VARCHAR(v03.wg_id,'FM000') !='980')
   --Ausfiltern Shop in Shop
   AND V03.wg_id!=961
   --Ausfiltern E-Loading alle Mandaten ungleich 1
   AND (v03.MANDANT_ID NOT IN (2,3,4,5,6,7,8)
     -- wenn  Mandant_2 ungleich 1 dann ohne E-loading 
      OR (v03.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(v03.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))
  )   
   AND V03.arthiertyp_id = 2
   AND V03.dat_bis = '9999-12-31';