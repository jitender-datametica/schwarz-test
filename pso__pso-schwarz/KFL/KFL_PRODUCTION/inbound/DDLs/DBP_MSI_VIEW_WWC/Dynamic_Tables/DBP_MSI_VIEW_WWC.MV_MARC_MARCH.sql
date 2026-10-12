CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_MARC_MARCH
-- #593469 Erweiterung um Dummy Lagerort, DLINL, Zeitstempel, PreissteuerungsKZ VPRSV (sschuecke 23.05.2014)
-- Erweiterung um Feld "VK brutto" und Join bzgl. MWwS-KZ / 04.06.2014
-- Ermittlung MwSt-Satz aus art, Berechnung bewertete Bestände brutto/netto / 04.06.2014
-- Feld DLINL (dat_aenderung_labst) herausgenommen / 25.08.2014
(
mandant_id
,art_id
,wup_id
,nb_id
,gjmo
,gjmo_bis
,marc_fg
,datzeit_daten_abzug
,LGORT
,VPRSV
,vk_brutto
,vk_netto
,UMLMC
,UMLMC_zvkbr
,UMLMC_zvknt
,TRAME
,TRAME_zvkbr
,TRAME_zvknt
,GLGMG
,GLGMG_zvkbr
,GLGMG_zvknt
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
 --NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
 --04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
 --20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
 --15.05.2024, SPEC0252092, prescherad: Mandant 1 mit aufnehmen
 --22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
 --19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
 --14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
   SELECT
  v01.mandant_id, v01.art_id, v01.wup_id, v01.nb_id, v01.gjmo, v01.gjmo_bis, v01.marc_fg, NULL AS datzeit_daten_abzug, CAST('-1' AS CHAR(4)), NULL AS VPRSV, v01.vk_brutto, CAST(v01.vk_brutto - (TRUNC((v01.vk_brutto * v03.mwst) / 100)) AS DECIMAL (18,4)) AS vk_netto, v01.menge_bestand_umlag_bme AS UMLMC, CAST(v01.menge_bestand_umlag_bme * v01.vk_brutto AS DECIMAL (18,3)) AS UMLMC_zvkbr, CAST(v01.menge_bestand_umlag_bme * vk_netto AS DECIMAL (18,3)) AS UMLMC_zvknt, v01.menge_bestand_transit_bme AS TRAME, CAST (v01.menge_bestand_transit_bme * v01.vk_brutto AS DECIMAL (18,3)) AS TRAME_zvkbr, CAST(v01.menge_bestand_transit_bme * vk_netto AS DECIMAL (18,3)) AS TRAME_zvknt, v01.menge_bestand_geb_leergut AS GLGMG, CAST (v01.menge_bestand_geb_leergut * v01.vk_brutto AS DECIMAL (18,3)) AS GLGMG_zvkbr, CAST (v01.menge_bestand_geb_leergut * vk_netto AS DECIMAL (18,3)) AS GLGMG_zvknt

   FROM dbp_view.v_art_wup_status_periode v01

   -- Ermittlung MwSt ID
   JOIN
   dbp_view.v_art v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND CURRENT_DATE BETWEEN v02.dat_von AND v02.dat_bis
   LEFT OUTER JOIN dbp_view.v_mwst_per v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.mwst_id = v03.mwst_id
   AND CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis
    --Suhsi RO ausfiltern
   INNER JOIN DBP_VIEW.V_art_wg_zu_per V04
   ON v01.Art_ID=v04.art_id
   AND v01.mandant_id = v04.mandant_id
   -- Wenn nicht Mandant 1,7 dann alles   
   AND (v04.MANDANT_ID NOT IN (1,7)
   -- Wenn  Mandant 1,7 dann  kein Sushi/Shop in Shop 
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

    -- WHERE  v01.mandant_id <> 1
    -- 20100330 Filterung der IWT Betriebe
   WHERE v01.nb_id <> 99 ;