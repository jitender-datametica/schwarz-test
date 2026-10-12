CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_ORG_EINHEIT_HIER_TOP3_PL
-- srom0404: lt. Mail A. Wolter vom 17.04.2015, nur die aktuellste Zuordnung
-- srom0404: INC1053013, HR die hr_objekt_ebene1_id auf 30000666 anpassen
-- srom0404: INC1131471, RO die hr_objekt_ebene1_id auf 35000075 anpassen
-- srom0404 - 300320: AP0058593, SPEC0072408, Umstellung neue Arbeitsplätze und Implementierung Sicherheitsfilter über Benutzergruppen
-- srom0404 - 300320: AP0052703, SPEC0068452, DWH-LIN - Anpassungen, kursverantwortung_fg wird nicht mehr benötigt
-- srom0404 - 150520: AP0052703, SPEC0068452, Einschränkung auf die letzten 4 Monate analog Berichtsfilter und herausführung kjmo nach telefonischer Absprache
-- srom0404 - 240620: AP0052703, SPEC0068452, Korrektur der Einschränkung auf akt_mo (nicht abgeschlossen), die letzten 4 Monate
-- srom0404 - 290620: AP0052703, SPEC0068452, QUALIFY Row_Number entfernt
-- srom0404 - 150520: AP0052703, SPEC0068452, Einschränkung auf den relevanten Orga Nummerkreis für Moldau bzw. Rumänien. In den Quelldaten sind MD Ebene dem Land Ro zugeordnet (u. umgekehrt)
-- Es geht dann doch leider nicht anders, als unten RO und MD fest zu verdrahten
(
 mandant_id
,hr_objekt_ebene1_id
,hr_objekt_ebene2_id
,hr_objekt_ebene3_id
,hr_objekt_ebene4_id
,hr_objekt_ebene5_id
,hr_objekt_ebene6_id
,hr_objekt_ebene7_id
,hr_objekt_ebene8_id
,hr_objekt_ebene9_id
,hr_objekt_ebene10_id
,hr_objekt_ebene11_id
,kostenstelle_id
,hr_objekt_ebene1_bez
,hr_objekt_ebene2_bez
,hr_objekt_ebene3_bez
,hr_objekt_ebene4_bez
,hr_objekt_ebene5_bez
,hr_objekt_ebene6_bez
,hr_objekt_ebene7_bez
,hr_objekt_ebene8_bez
,hr_objekt_ebene9_bez
,hr_objekt_ebene10_bez
,hr_objekt_ebene11_bez
,mandant_sort_id
,kjmo
) 
AS
SELECT
 v01.mandant_id
,v01.hr_objekt_ebene1_id
,v01.hr_objekt_ebene2_id
,v01.hr_objekt_ebene3_id
,v01.hr_objekt_ebene4_id
,v01.hr_objekt_ebene5_id
,v01.hr_objekt_ebene6_id
,v01.hr_objekt_ebene7_id
,v01.hr_objekt_ebene8_id
,v01.hr_objekt_ebene9_id
,v01.hr_objekt_ebene10_id
,v01.hr_objekt_ebene11_id
,v01.kostenstelle_id
,v01.hr_objekt_ebene1_bez
,v01.hr_objekt_ebene2_bez
,v01.hr_objekt_ebene3_bez
,v01.hr_objekt_ebene4_bez
,v01.hr_objekt_ebene5_bez
,v01.hr_objekt_ebene6_bez
,v01.hr_objekt_ebene7_bez
,v01.hr_objekt_ebene8_bez
,v01.hr_objekt_ebene9_bez
,v01.hr_objekt_ebene10_bez
,v01.hr_objekt_ebene11_bez
,v01.om_sort_id
,v01.kjmo
FROM dbp_view.v_org_einheit_hierarchie v01
INNER JOIN dbp_view.v_monat v02
   ON v01.kjmo = v02.kjmo
WHERE v01.spr_id = 90
  AND v02.akt_mo BETWEEN -3 AND 0
  AND (
	   (mandant_id = 4 AND hr_objekt_ebene1_id = 35084871) -- das sind die benötigten MD Orgakreise
    OR (mandant_id = 7 AND hr_objekt_ebene1_id = 35000075) -- das sind die benötigten RO Orgakreise
    OR mandant_id NOT IN (4, 7)  -- alle anderen Länder
   )
/**  
  AND
      hr_objekt_ebene1_id IN (15000149, -- CZ
                              50526439, -- DE
                              51539142, -- INT
                              30000666, -- HR bisher 6000002
                              20000000, -- PL
                              35000075, -- RO bisher 7000002
                              25000068, -- SK
                              50028917  -- BG                             
                              )
**/
-- Es soll nur die aktuellste Zuordnung angezeigt werden
-- hr_objekt_ebene1_id muss mit in die Partition, da Ebene1 nicht mehr verdrahtet ist und ohne Ebene1 das QUALIFY nicht eindeutig ist und Zwischenebenen identifiziert werden
-- QUALIFY Row_Number() Over (PARTITION BY v01.mandant_id, v01.hr_objekt_ebene1_id, v01.hr_objekt_ebene11_id ORDER BY v01.kjmo DESC) = 1
;