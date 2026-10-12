CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_AKTION_ART_WUP_ZU
-- 18.03.2014 twie: Join auf tag entfernt, durch dat kam es zur Versiebenfachung der Werte
-- 29.07.2014 srom: dat_zeitraum, dat_von, dat_bis rausgenommen, damit mv_aktion als reine lookup funktioniert
-- 12.07.2016 srom: AP0009976 Werbeabschriften, Erweiterung um Netto
(
aktion_id
--,sap_aktion_id
--,dat_von
--,dat_bis
--,dat_zeitraum
,art_id
,wup_id
,nb_id
,mandant_id
,vk_aktion_brutto
,vk_vor_aktion_brutto
,vk_aktion_netto
,vk_vor_aktion_netto

)
AS
   --NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
   --04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
   --20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
   --22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
   --19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
   --14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE

   SELECT
   v01.aktion_id, v01.art_id, v01.wup_id, 0 AS nb_id, v01.mandant_id, v01.vk_aktion_brutto, v01.vk_vor_aktion_brutto, TRUNC(v01.vk_aktion_brutto     / (1.00 + (TRUNC(v03.mwst / 100.00)))) AS vk_aktion_netto, TRUNC(v01.vk_vor_aktion_brutto / (1.00 + (TRUNC(v03.mwst / 100.00)))) AS vk_vor_aktion_netto

   FROM dbp_view.v_aktion_art_wup_zu v01
   INNER JOIN dbp_view.v_art v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id

   JOIN dbp_view.v_mwst_per v03
   ON v02.mwst_id = v03.mwst_id
   AND v02.mandant_id = v03.mandant_id
   AND v03.dat_bis = '9999-12-31' -- akt MWSt. Satz

   --Suhsi RO ausfiltern   
   INNER JOIN DBP_VIEW.V_art_wg_zu_per V04
   ON v01.Art_ID=v04.art_id
   AND v01.mandant_id = v04.mandant_id
     -- Wenn nicht Mandant 1,7 dann alles   
   AND (v04.MANDANT_ID NOT IN (1,7)
      -- wenn  Mandant 1,7 dann  kein Sushi/Shop in Shop 
      OR (V04.MANDANT_ID IN (1,7) AND TO_VARCHAR(V04.wg_id,'FM000')|| TO_VARCHAR(V04.wug_id,'FM000') != '969006' )
   )
    -- Wenn nicht Mandant 7 dann alles   
   AND (v04.MANDANT_ID != 7
    -- Wenn  Mandant 7 dann kein Pfand 
      OR v04.MANDANT_ID = 7 AND TO_VARCHAR(v04.wg_id,'FM000') !='980')
   --Ausfiltern Shop in Shop
   AND V04.wg_id!=961
   --Ausfiltern E-Loading alle Mandaten ungleich 1
   AND (v04.MANDANT_ID NOT IN (2,3,4,5,6,7,8)
   -- wenn  Mandant ungleich 1 dann ohne E-loading 
      OR (v04.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V04.wg_id,'FM000')|| TO_VARCHAR(v04.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))
    )    
   AND V04.arthiertyp_id = 2
   AND V04.dat_bis = '9999-12-31'

   WHERE v01.mandant_id <> 1 AND v01.grund_sperrung IS NULL ;