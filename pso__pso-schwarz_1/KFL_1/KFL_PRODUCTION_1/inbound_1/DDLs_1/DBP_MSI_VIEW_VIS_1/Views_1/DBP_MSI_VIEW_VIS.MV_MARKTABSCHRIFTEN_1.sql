CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MARKTABSCHRIFTEN_1(
  MANDANT_ID
 ,NB_ID
 ,WUP_ID
 ,WRG_ID
 ,DAT
 ,ART_ID
 ,ABSCHRIFTART_ID
 ,GEWART_ID
 ,ABSCHRIFT_NETTO
 ,ABSCHRIFT_BRUTTO
 ,ABSCHRIFT_MENGE
 ,MENGE_ABSCHRIFT
 ,M_ABSCH_MENGE
 ,M_AUFSCH_MENGE
 ,ABSCHRIFTBETRAG_NETTO
 ,AUFSCHRIFTBETRAG_NETTO
 ,WUP_ABSCHRIFT_ID
 ,POSITIONSNUMMER_ID
 ,LASTUPD_DAT
 ,WOCHE_ID
 ,EREIGNISTYP_ID
 ,EREIGNIS_ID
) AS

-- FAKT Abschriften_1 pro Filiale/Artikel_1/Tag_1
-- 2013-06-06 Initial
-- 2015-02-28 Review BM2.0, Fehlerkorrektur Mandant_1
-- 2015-07-21 srom: Erweiterung Abschriften_1 Maßnahmen/Kommentare (Pflege innerhalb HL_1 Cockpit - FLOP20 Abschriften_1 Abteilung)
-- 2016-10-12 ssch0611 : Erweiterung Preisaenderungen (art_umbewertung_1) > Vorzeichenwechel in FAKT!
-- 2019-10-01 ssch0611 : Erweiterung/Filter Preisaenderung MD
-- 2021-05-04 ssch0611 : added preis_aend_grund_id = 20
-- 2022-10-04 ssch0611 : Calculation EUR with new logic [P16167] 
-- 2024-04-30 muellerpatri: Anpassung abschrift_menge auf neue CASE-WHEN-Logik (SPEC0250008)
-- 2024-06-10 muellerpatri: Anpassung abschrift_menge ohne Prüfung auf v01.abschriftbetrag_netto > 0 
-- 2024-06-20 muellerpatri : Filialumgliederung [P1760-DWH]
-- 2025-03-19 muellerpatri : Erweiterung um Grund 26

SELECT
  v01.mandant_id
 ,v01.nb_id
 ,wup.aktuell_wup_id 																				AS wup_id 
 ,krs.nach_wrg_id 																					AS wrg_id
 ,v01.dat
 ,v01.art_id
 ,v01.abschriftart_id
 ,v03.gewart_id
 ,v01.abschriftbetrag_netto * krs.umrechnungskurs   												AS abschrift_netto
 ,v01.abschriftbetrag_brutto * krs.umrechnungskurs													AS abschrift_brutto
 ,CASE WHEN v01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND v01.abschriftart_id <> '-1' 
 	THEN CAST (v01.menge_abschrift AS DECIMAL(13,4))/ 1000 
 WHEN v01.abschrift_menge_einh_id = 'G' AND v01.abschriftart_id <> '-1' 
	 THEN CAST (v01.menge_abschrift AS DECIMAL(13,4))/ 1000
 ELSE CAST (v01.menge_abschrift AS DECIMAL(13,4)) END												AS abschrift_menge
 ,menge_abschrift																					AS menge_abschrift -- Referenz/unveraendert
 /* AIS Logik (NOT USED)*/
 ,CASE WHEN v01.abschriftbetrag_netto > 0 THEN abschrift_menge END									AS M_Absch_Menge
 ,CASE WHEN v01.abschriftbetrag_netto < 0 THEN abschrift_menge END * -1								AS M_Aufsch_Menge
 ,CASE WHEN v01.abschriftbetrag_netto > 0 THEN v01.abschriftbetrag_netto END * krs.umrechnungskurs	AS abschriftbetrag_netto
 ,CASE WHEN v01.abschriftbetrag_netto < 0 THEN v01.abschriftbetrag_netto END * krs.umrechnungskurs	AS aufschriftbetrag_netto
 /* sonstiges (NOT USED)*/
 ,v01.wup_abschrift_id
 ,v01.positionsnummer_id
 ,v01.lastupd_dat
 ,v01.woche_id
 ,102																								AS ereignistyp_id
 ,-1																								AS ereignis_id
FROM dbp_view.v_marktabschriften_1 v01
 
INNER JOIN ( 
	SELECT mandant_id, art_id, gewart_id
	FROM dbp_view.v_art_1
) v03
ON v01.art_id = v03.art_id
AND v01.mandant_id  = v03.mandant_id
 
INNER JOIN ( 
	SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
	FROM dbp_data.kurs_1 krs1 
	WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
	AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
	UNION ALL 
	SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
	FROM dbp_data.kurs_1 krs2 
	WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
	AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = v01.wrg_id

INNER JOIN dbp_view.v_wup_1 wup_1
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

UNION ALL
SELECT
  v01.mandant_id
 ,v01.nb_id
 ,wup.aktuell_wup_id 									AS wup_id 
 ,krs.nach_wrg_id										AS wrg_id 
 ,v01.dat_umbew											AS dat
 ,v01.art_id
 ,v01.preis_aend_grund_id								AS abschriftart_id
 ,'0'													AS gewart_id -- nicht relevant
 ,v01.diff_wert_bestand_netto * krs.umrechnungskurs		AS abschrift_netto
 ,v01.diff_wert_bestand_brutto * krs.umrechnungskurs	AS abschrift_brutto
 /* vereinfachte Logik Vertrieb (Vorzeichenwechsel)*/
 ,CASE WHEN v01.preis_aend_grund_id IN (10, 20) THEN -1
	   WHEN wert_bestand_brutto_alt < 0 AND menge_bestand_bme < 0 AND menge_umbew = 0 THEN -1 ELSE 1
	   END * menge_erf 									AS abschrift_menge
 ,menge_erf AS menge_abschrift -- Referenz/unveraendert
 /* uebrige Spalten (NOT USED)*/
 ,0														AS M_Absch_Menge
 ,0														AS M_Aufsch_Menge
 ,0														AS abschriftbetrag_netto
 ,0														AS aufschriftbetrag_netto
 ,0														AS wup_abschrift_id
 ,0														AS positionsnummer_id
 ,dat_umbew												AS lastupd_dat
 ,0														AS woche_id
 ,102													AS ereignistyp_id
 ,-1													AS ereignis_id
 FROM dbp_view.v_art_umbewertung_1 v01
 
 INNER JOIN ( 
	SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
	FROM dbp_data.kurs_1 krs1 
	WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
	AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
	UNION ALL 
	SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
	FROM dbp_data.kurs_1 krs2 
	WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
	AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = v01.wrg_id

INNER JOIN dbp_view.v_wup_1 wup_1
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

WHERE (v01.mandant_id IN (2, 5) AND v01.preis_aend_grund_id IN (7, 10, 20, 26))
OR (v01.mandant_id IN (3) AND v01.preis_aend_grund_id IN (11, 20, 26))
OR (v01.mandant_id IN (6) AND v01.preis_aend_grund_id IN (2, 20, 26))
OR (v01.mandant_id IN (4, 7, 8) AND v01.preis_aend_grund_id IN (7, 20, 26));