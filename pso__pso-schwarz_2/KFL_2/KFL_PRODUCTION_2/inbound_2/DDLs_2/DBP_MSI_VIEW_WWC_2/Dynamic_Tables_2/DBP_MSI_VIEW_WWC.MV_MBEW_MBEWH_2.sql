CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_MBEW_MBEWH_2
-- #593469 Erweiterung um Dummy_2 Lagerort, DLINL, Zeitstempel (sschuecke 23.05.2014)
-- Feld DLINL (dat_aenderung_labst) herausgenommen / 25.08.2014
-- 27.03.2018, srom0404, INC0179752, Es gibt nicht numerische Bewertungskreise (keine Märkte)
-- diese werden hier herausgenommen und IN einer separaten VIEW bereitgestellt
-- 23.04.2019, srom0404, INC0915178, Eingrenzung auf gjmo <> 190001. Das sind initiale Datensätze, die auf Grund der BETWEEN Logik im MSI Bericht mit angezeigt werden.
-- gjmo aus dat_aenderung ableiten geht auch nicht, da es mehrere Änderungen in einem Monat_2 geben kann.
-- 13.08.2019, pjan1603, INC1250729, At Sascha's request, to make sure that BWKEY column contains only numbers the TRYCAST function is used from now on.
-- Previous solution (traditional CAST) did not work when there were some varchar values in the bewertungskreis_id column of the underlying tables (error: format or data contains a bad character).
-- 26.09.2019, cbru1709, Änderung von LEFT JOIN zur WUP_2 Tabelle auf INNER JOIN und Änderung der JOIN und der WHERE  Condition
(
gjmo
,art_id
,mandant_id
,BWKEY
,nb_id
,wrg_id
,dat_aenderung
,LBKUM
,SALK3
,VKSAL
--,VKSAL_STCK
,mbew_fg
,gjmo_bis
,datzeit_daten_abzug
,LGORT
,BKLAS
,VPRSV
,VERPR
,STPRS
,LAEPR
,VKSAL_NT
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
   --NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
   --04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
   --20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
   --22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
   --19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
   --14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
   SELECT
   v01.gjmo, v01.art_id, v01.mandant_id, TRY_CAST(v01.bewertungskreis_id AS INTEGER) AS BWKEY, v02.nb_id, v01.wrg_id, v01.dat_aenderung, v01.menge_bestand_bme AS LBKUM, v01.wert_bestand AS SALK3, v01.vk_wert AS VKSAL, v01.mbew_fg, v01.gjmo_bis, NULL AS datzeit_daten_abzug, CAST('-1' AS CHAR(4)) AS LGORT, v01.bewertung_klasse_id AS BKLAS, v01.preis_steuer_kz AS VPRSV, v01.gld AS VERPR, v01.standard_preis AS STPRS, v01.dat_letzte_preisaenderung AS LAEPR, v01.vk_wert_netto AS VKSAL_NT
   FROM dbp_view.v_art_bewertungskreis_periode_2 v01
  
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
   AND V03.dat_bis = '9999-12-31'
     
   JOIN
   dbp_view.v_wup_2 v02
   ON v01.mandant_id = v02.mandant_id
   -- Nur die numerischen zum Join durchlassen
   -- Alles was eine_2 nb_id aus der wup_2 Tabelle kommt, wird behalten
   -- Wurde geändert auf INNER JOIN und gleichzeitig die TRYCAST Funktion in der Join Bedingung eingebaut.
   -- Alte Where Bedingung auf NB_ID IS NULL entfernt da durch den INNER JOIN obsolet 
   AND
   TRY_CAST(v01.bewertungskreis_id AS INTEGER) = v02.wup_id
   WHERE v01.gjmo > 190001;