CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_MARKTABSCHRIFTEN_KMO_AKTION
-- 12.07.2016 srom: AP0009976 Werbeabschriften
-- Diese Tabelle/View ist als Aggregat für KMO Werbabschriften ausgelegt. Im Prinzip könnten die Daten aus der
-- Tabelle aktion_art_wup_zu abgeleitetet/berechnet werden. Hier Zugriff auf Aggregat wegen Performance
(
wup_id
,nb_id
,aktion_id
,mandant_id
,dat
,art_id
,menge_abschrift
,abschriftbetrag_netto
,abschriftbetrag_brutto
,wrg_id
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
   v01.wup_id, v01.nb_id, v01.aktion_id, v01.mandant_id, v01.dat, v01.art_id, v01.menge_abschrift, v01.abschriftbetrag_netto, v01.abschriftbetrag_brutto, v01.wrg_id, v01.vk_aktion_netto, v01.vk_vor_aktion_netto

   FROM dbp_view.v_marktabschriften_kmo_aktion v01
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
      OR (v02.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V02.wg_id,'FM000')|| TO_VARCHAR(v02.wug_id,'FM000') NOT IN     ('969001','969002','969003','969004'))
   )    
   AND V02.arthiertyp_id = 2
   AND V02.dat_bis = '9999-12-31';