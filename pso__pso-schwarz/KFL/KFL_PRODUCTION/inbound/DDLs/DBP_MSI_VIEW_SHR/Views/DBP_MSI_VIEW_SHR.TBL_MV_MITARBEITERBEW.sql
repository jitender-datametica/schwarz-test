CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.TBL_MV_MITARBEITERBEW
-- kkai0912 131002 Neuaufbau mitarbeiterbew # 573170 mit Flags und
-- Security  basierend auf User_id aus akt_user und Zuordnung IN $DBX_security.user_hr_objekt_id_zu
-- KKai0912 131114 Security  wieder herausgenommen, soll FE-seitig stattfinden
-- KKai0912 140122 Kalendertage als Vergleichswert hinzugefügt
-- KKai0912 140203 Austritts_kz nicht nur 1,2, sondern auch 3 bei untermonatlich_fg
-- KKai0912 140207 Austritts_kz  nur 2,3 untermonatlich_fg
-- KKai0912 140219 Aushilfe nur wenn sie auch gearbeitet hat fg
-- KKai0912 140507 ma_status_id = 0 und soll_kalendertage <> ist, untermonatlich_aushilfe_fg
-- KKai0912 140512 5 neue Kennzeichen für die Prüfberichte (damit mit Konsolidierung auswertbar)
-- KKai0912 140515 9 neue Kennzeichen , atz_passiv_fg wird zu atz_kz,  ma_ausgrenzung_netto_fg und ma_ausgrenzung_brutto_fg entfallen
-- KKai0912 140603 pruef_austritt_extern (2,3,4), pruef_austritt_intern (1,3), pruef_austritt_intern_extern (2,3),  pruef_eintritt_extern (2), pruef_eintritt_intern (1), pruef_eintritt_intern_extern (3)
-- Awol2209 140723: Anpassung von untermonatlich_fg
-- kkai0912 140904 die "Org Gruppierung" ermittelt und bereitgestellt, damit im FE die dyn. Gruppierung von einem Attribut abgelöst werden kann
-- kkai0912 150519  neuer BuchungskreIS  220 bei internationalen Firmen
-- kkai0912: 151013 Hinzunahme von 2 Feldern: abwesenheit_arbeitstage + soll_arbeitstage
-- #AP0003387 Berechnung Alter und Betriebszugehoerigkeit, Nationalitaet - sschuecke 14.01.2016
-- #AP0003387 Erweiterung um Feld für Berechnung Filter Vertragsende <6 Monate - sschuecke 20.01.2016
-- #AP0003387 Erweitert um Feld krank_tage_arbeitstage - sschuecke 05.02.2016
-- #AP0003387 Anpassung Logik vertragsende_fg - sschuecke 12.02.2016
-- #AP0003387 erneute Anpassung Logik vertragsende_fg - sschuecke 25.02.2016
-- #AP0003387 Berechnung untermonatlich_azubi_fg - sschuecke 25.02.2016
-- #AP0003387 erneute Anpassung Logik vertragsende_fg - sschuecke 17.03.2016
-- #AP0003387 betriebszugehörigkeit als range - kkaiser 20.05.2016
-- #AP0003387 20160622 kkai0912 Anbindung der 4 neuen Felder (anz_arbeits_unfall, vertragsende_fg, untermonatlich_fg,aushilfe_nicht_gearbeitet_fg) aus der Data
-- #AP0003387 20160919 kkai0912 Definitionsänderung bei Betriebszugehoerigkeit_sort (0 Jahre ist nun 0, 1 = 1, Rest bleibt unverändert)
-- #AP0003387 20161019 kkai0912 errechnetes Alter zum Monatsende
-- #AP0003387 20161026 kkai0912 errechnete Betriebszugehörigkeit zum Monatsende
-- #SPEC0020119 20170505 ttez1905 Neue Spalte "abgeltung_urlaub" aufgenommen
-- #SPEC0020119 20171009 kmor0912 Spalte "abgeltung_urlaub" wieder ausgebaut
--#SPEC0027571 20171013 Felder aufgenommen: , sonstige_abwesenheit_fg, pflege_fg, krankheit_unfall_fg, langzeit_abwesenheit_tage, langzeit_abwesenheit_tage_kum, langzeit_min_dat, langzeit_abwesenheit_grund, stichtag_fg
-- kmor0912 - zusätzliches Feld aufgenommenb dat_letzte_abwesenheit
-- #SPEC0027571 epla2707 Entfernen abwesenheit_stunden
-- #AP0025469 SPEC0033380 20180202 mmzy2302  Erweiterung um entsprechende IDs für Mitarbeiter-Gruppe, Mitarbeiter-Kreis, Kostenstelle etc.
-- nfis0811 - 180410: Anpassung Logik Befüllung Feld betriebszugehörigkeit_bereinigt
-- nfis0811 - 180416: Hinzufügen von  betriebszugehoerigkeit_bereinigt_in_tagen
-- nfis0811 - Einfügen des Betriebszugehörigkeitsclusters nach Monaten
-- #AP0025469 SPEC0033380 20180202 mmzy2302  Redesign Eintrittsdatum (Erweiterung um Eintrittsdatum03 - Teilabfrage im Bezug auf Neueinstellungen)
-- nfis0811 - 180420: Nachziehen der BZG-Logiken um die Anpassung des Eintrittdatums
-- nfis0811 - 180424: Einbau Durschnittsalter zum Stichtag/Austrittsdatum IN Jahren
-- nfis0811 - 180525: Änderung Defintion Austrittsdatum - NSR0188185
-- nfis0811 -180726: Einführung fg für untermonatlichen Wiedereintritt
-- nfis0811 - 181022: SPEC0045191 - Einführen der Funktionsaenderung_id
-- nfis0811 - 181105: SPEC0045192 - Übernahme neuer Logik für Funktion_id2 und anhängige Bezeichnung IN diese View wegen Gruppierung
-- nfis0811 - 181228: TEST1275372 Änderung Logik zur Ermittlung der funktionsaenderung_id
-- nfis0811 - 190204: SPEC0049938 Einführung Alterscluster CSR
-- nfis0811 - 190218: SPEC0049509 Erweiterung Moldau
-- nifs0811 - 190408: SPEC0053662 Anpassung Logik für Feld errechnetes_alter
-- nfis0811 - 190729: SPEC0058419 Einführung Arbeitsunfall-Flags
--	cbru1709 - 191107: SPEC0064121 shr_ma_fach_fuer_ebene Feld analog der Dynamischen Gruppe
--	cbru1709 - 191126:SPEC0064192 Änderung IN der Berechung der BZG 
-- cbru1709 - 200109:SPEC0064192 Nochmalige Änderung IN der Berechung der BZG; Behandlung wenn Austritt und Wiedereintritt im gleichen Monat 
-- cbru1709 - 200113_SPEC0064192 Geänderte Case Bedingung IN der With Clause, Änderung auf Funktion Extract Month from
-- cbru1709 - 200121 SPEC0066663 Änderung Viewlogik Arbeitsunfälle 
-- cbru1709 - 200312 SPEC0054818 Self-JoIN mit mitarbeiterbew wegen Änderung Fluktuation VM
-- richternic - 201215 SPEC0095481 vertragende unendlichkeitsdatum für CZ, SK und BG zulassen & vertragsende_fg herausnehmen 
-- richternic - 210427 NSR2125368 Anpassung Arbeitsunfall FG -> RO angepasst 
-- richternic -210609: SPEC0115547 Highdate fuer jeden Mandanten bei Vertragsende
-- richternic - 210713: SPEC0118609 Anpasssung arbeitsunfall_folgeabw_id
-- richternic - 210902: INC3465328 Anpassung Arbeitsunfall_FG -> Hier keine summierung mehr.
-- prescherad--211013 SPEC0130075 Ausbau Feld sb_prozent 
-- prescherad - 230317, SPEC0143976 erstetzen errechnetes Alter durch Mitarbeiter Alter direkt aus Quelle
-- prescherad - 230405, NSR3641945, Abwesenheiten im Krankenstandsfilter anpassen für Mandant 4 von 0240 auf (0240,9432)
AS

-- Berechnung Eintrittsdatum 03
-- Änderung der Berechnung erfolgte am 26.11.2019
WITH eintrittsdatum_03 AS (
SELECT v036.mandant_id
--,v036.datumsart_id
,v036.mitarbeiter_id
,v036.kjmo
,v036.dat_von
, MAX(v998.dat_von) AS dat_von_wenn_austritt
, MAX(v999.dat_von) AS dat_austritt_datumsart_id_05
-- Hier muss auf Monat und Jahr geprueft werden
, CASE WHEN CAST(EXTRACT(MONTH FROM v036.dat_von) AS INTEGER) = CAST(EXTRACT(MONTH FROM dat_austritt_datumsart_id_05) AS INTEGER)
  AND CAST(EXTRACT(YEAR FROM v036.dat_von) AS INTEGER) = CAST(EXTRACT(YEAR FROM dat_austritt_datumsart_id_05) AS INTEGER)
  THEN dat_von_wenn_austritt ELSE v036.dat_von END AS bzg_dat_von
  
FROM dbp_view.v_ma_datumsart_zu_per  v036
 LEFT JOIN dbp_view.v_ma_datumsart_zu_per  v999
  ON (v036.mandant_id = v999.mandant_id AND v036.mitarbeiter_id = v999.mitarbeiter_id AND v999.datumsart_id = '05' AND v999.dat_von < v036.dat_von 
     AND v999.kjmo >= REPLACE(SUBSTR(v999.dat_Von,1,7),'-','')) -- dies wird benoetigt, um Daten rauszufiltern bei denen KJMO kleiner ist als dAS Dat_Von 
 LEFT JOIN dbp_view.v_ma_datumsart_zu_per  v998
  ON (v036.mandant_id = v998.mandant_id AND v036.mitarbeiter_id = v998.mitarbeiter_id AND v998.datumsart_id = '02' AND v998.dat_von < v036.dat_von)
WHERE v036.datumsart_id IN ('02')
-- wird benoetigt damit datenmuell entfernt wird sowAS wie eIN Dat_von mit dem Jahr 2200
AND v036.dat_von <= CURRENT_DATE 
GROUP BY 1,2,3,4)

-- ab hier dAS MAIN Select
SELECT
v01.mandant_id
, v01.mitarbeiter_id
, v01.kjmo
--, ADD_MONTHS(CAST(v01.kjmo*100-19000000+1 AS DATE),-1)/100 + 190000  AS kjmo_vm
,TO_NUMBER(TO_VARCHAR(ADD_MONTHS(TO_DATE(TO_CHAR(v01.kjmo),'YYYYMM'),-1),'YYYYMM')) AS kjmo_vm

, v101.mitarbeiter_gruppe_id AS mitarbeiter_gruppe_id
, v102.mitarbeiter_kreis_id AS mitarbeiter_kreis_id
, v103.kostenstelle_id AS kostenstelle_id
, v01.abwesenheit_tage
, v01.soll_stunden_monat
, v01.abr_stunden_monat
, v01.langzeit_abwesend_fg
, v0111.langzeit_abwesend_fg AS langzeit_abwesend_fg_vm
, v01.neu_mitarbeiter_fg
, v01.krank_tage
, v01.teilzeit_fg
, v01.hr_objekt_id
, v01.ma_status_id
, v0111.ma_status_id AS ma_status_id_vm
, v01.geschlecht_id
, v01.tarifgebiet_id
, TRIM(v01.shr_ma_funktion_id) AS shr_ma_funktion_id

,v2.kostenstelle_ebene4_id

-- Snowflake Anpssung: blanks aus dem LIKE entfernt
-- shr_ma_funktion_id_2
,CASE WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%' THEN
--Ausahmen für alle Länder
CASE WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' THEN '13'
WHEN v01.shr_ma_funktion_id LIKE '14-017-1%' THEN '13'
WHEN v01.shr_ma_funktion_id LIKE '23-003-3%' THEN '22'
-- Ausnahme für CZ
WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 THEN '13'
--Ausnahme für HR
WHEN v01.shr_ma_funktion_id LIKE '14-001-2%' AND  v01.mandant_id = 6 THEN '13'
WHEN v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6 THEN '13'
-- Standardfall
ELSE CASE WHEN SUBSTRING (v01.shr_ma_funktion_id, 3, 1) = '-' THEN SUBSTRING (v01.shr_ma_funktion_id,1, 2) ELSE '99' END
END
ELSE CASE WHEN SUBSTRING (v01.shr_ma_funktion_id, 3, 1) = '-' THEN SUBSTRING (v01.shr_ma_funktion_id, 1 , 2) ELSE '99' END
END AS shr_ma_funktion_id_2

,CASE WHEN kostenstelle_ebene4_id LIKE '%-VT%' THEN
CASE WHEN shr_ma_funktion_id_2 IN (11) THEN 'MA'
WHEN shr_ma_funktion_id_2 IN (12) THEN 'MA'
WHEN shr_ma_funktion_id_2 IN (13) THEN 'MA'
WHEN shr_ma_funktion_id_2 IN (14) THEN 'Erstkraft'
WHEN shr_ma_funktion_id_2 IN (15) THEN 'PSB'
WHEN shr_ma_funktion_id_2 IN (21) THEN 'WBL'
WHEN shr_ma_funktion_id_2 IN (22) THEN 'HL'
WHEN shr_ma_funktion_id_2 IN (23) THEN 'HL'
ELSE 'nicht zugeordnet' END

--Dienstleistung
WHEN kostenstelle_ebene4_id LIKE '%-DLGES%' THEN
CASE WHEN shr_ma_funktion_id_2 IN (11) THEN 'MA1'
WHEN shr_ma_funktion_id_2 IN (12) THEN 'MA2'
WHEN shr_ma_funktion_id_2 IN (13) THEN 'MA3'
WHEN shr_ma_funktion_id_2 IN (14) THEN 'MA4'
WHEN shr_ma_funktion_id_2 IN (15) THEN 'MA5'
WHEN shr_ma_funktion_id_2 IN (16) THEN 'MA6'
WHEN shr_ma_funktion_id_2 IN (21) THEN 'FE6'
WHEN shr_ma_funktion_id_2 IN (22) THEN 'FE5'
WHEN shr_ma_funktion_id_2 IN (23) THEN 'FE4'
WHEN shr_ma_funktion_id_2 IN (31) THEN 'FE4 ppa.'
WHEN shr_ma_funktion_id_2 IN (32) THEN 'FE3 GF'
WHEN shr_ma_funktion_id_2 IN (33) THEN 'FE2 GL'
WHEN shr_ma_funktion_id_2 IN (34) THEN 'FE1 GLV'
ELSE 'nicht zugeordnet' END

--Logistik
WHEN kostenstelle_ebene4_id LIKE '%-LOG%' THEN
CASE WHEN shr_ma_funktion_id_2 IN (11) THEN 'MA1'
WHEN shr_ma_funktion_id_2 IN (12) THEN 'MA2'
WHEN shr_ma_funktion_id_2 IN (13) THEN 'MA3'
WHEN shr_ma_funktion_id_2 IN (14) THEN 'MA4'
WHEN shr_ma_funktion_id_2 IN (15) THEN 'MA5'
WHEN shr_ma_funktion_id_2 IN (16) THEN 'MA6'
WHEN shr_ma_funktion_id_2 IN (21) THEN 'FE6'
WHEN shr_ma_funktion_id_2 IN (22) THEN 'FE5'
WHEN shr_ma_funktion_id_2 IN (23) THEN 'FE4'
WHEN shr_ma_funktion_id_2 IN (31) THEN 'FE4 ppa.'
WHEN shr_ma_funktion_id_2 IN (32) THEN 'FE3 GF'
WHEN shr_ma_funktion_id_2 IN (33) THEN 'FE2 GL'
ELSE 'nicht zugeordnet' END

-- CZ-9800
WHEN kostenstelle_ebene4_id LIKE '%CZ-9800%' THEN
CASE WHEN shr_ma_funktion_id_2 IN (11) THEN 'MA1'
WHEN shr_ma_funktion_id_2 IN (12) THEN 'MA2'
WHEN shr_ma_funktion_id_2 IN (13) THEN 'MA3'
WHEN shr_ma_funktion_id_2 IN (14) THEN 'MA4'
WHEN shr_ma_funktion_id_2 IN (15) THEN 'MA5'
WHEN shr_ma_funktion_id_2 IN (16) THEN 'MA6'
WHEN shr_ma_funktion_id_2 IN (21) THEN 'FE6'
WHEN shr_ma_funktion_id_2 IN (22) THEN 'FE5'
WHEN shr_ma_funktion_id_2 IN (23) THEN 'FE4'
WHEN shr_ma_funktion_id_2 IN (31) THEN 'FE4 ppa.'
WHEN shr_ma_funktion_id_2 IN (32) THEN 'FE3 GF'
WHEN shr_ma_funktion_id_2 IN (33) THEN 'FE2 GL'
ELSE 'nicht zugeordnet' END
--alte Logik für alle übrigen Kostenstellenebene4_ids
ELSE
CASE WHEN shr_ma_funktion_id_2 IN (11) THEN 'MA'
WHEN shr_ma_funktion_id_2 IN (12) THEN 'MA'
WHEN shr_ma_funktion_id_2 IN (13) THEN 'MA'
WHEN shr_ma_funktion_id_2 IN (14) THEN 'Erstkraft'
WHEN shr_ma_funktion_id_2 IN (15) THEN 'PSB'
WHEN shr_ma_funktion_id_2 IN (16) THEN 'TL'
WHEN shr_ma_funktion_id_2 IN (21) THEN 'WBL'
WHEN shr_ma_funktion_id_2 IN (22) THEN 'HL'
ELSE 'nicht zugeordnet' END
END AS shr_ma_funktion_id_funktion
--ENDE shr_ma_funktion_id_funktion

-- Bedingungen aus dem ApplySimple aus der Metrik IN View übernommen
, CASE WHEN shr_ma_funktion_id_funktion LIKE ANY ( 'HL', 'WBL', 'PSB', 'Erstkraft') THEN 'Führungsebene'
WHEN shr_ma_funktion_id_funktion LIKE 'MA%' THEN 'Mitarbeiterebene'
WHEN shr_ma_funktion_id_funktion LIKE 'FE%' THEN 'Fach-/Führungsebene'
ELSE 'nicht zugeordnet'
END AS shr_ma_hierarchiestufe_funktion

-- Und jetzt dAS gleiche nochmal, nur anders. Warum weiss vermutlich keiner... SPEC0064121
-- Kann zu anderen Ergebnissen führen als dAS Case-Statement hier drüber.
,CASE WHEN TRIM(v01.shr_ma_funktion_id) LIKE '%-3' AND ( TRIM(v01.shr_ma_funktion_id) LIKE '2%' OR TRIM(v01.shr_ma_funktion_id) LIKE '3%' ) THEN 'Führungsebene'
WHEN TRIM(v01.shr_ma_funktion_id) NOT LIKE '%-3' AND ( TRIM(v01.shr_ma_funktion_id) LIKE '2%' OR TRIM(v01.shr_ma_funktion_id) LIKE '3%' ) THEN 'Fachebene'
WHEN TRIM(v01.shr_ma_funktion_id) LIKE '1%' THEN 'MA-Ebene'
ELSE 'nicht zugeordnet'
END AS shr_ma_fach_fuer_ebene

--die folgenden 2 Felder werden nur benötigt für die Generierung der funktionsänderungs_id
,CASE WHEN SUBSTRING (v01.shr_ma_funktion_id,3,1) = '-' THEN SUBSTRING (v01.shr_ma_funktion_id,1,2) ELSE '99' END AS shr_ma_funktionsaenderung1
,CASE WHEN SUBSTRING (mbew.shr_ma_funktion_id ,3 ,1) = '-' THEN SUBSTRING (mbew.shr_ma_funktion_id , 1 , 2) ELSE '99'  END AS shr_ma_funktionsaenderung2


, CASE WHEN shr_ma_funktionsaenderung1 > shr_ma_funktionsaenderung2 THEN 3
WHEN shr_ma_funktionsaenderung1 < shr_ma_funktionsaenderung2 THEN 1
ELSE 2 END AS shr_ma_funktionaenderung_id

, v01.tarifart_id
, v01.unternehmens_bereich_id
, v01.gehalts_region_id
, v01.haus_kategorie_id
, v01.haupt_mitarbeiter_id
, v01.soll_kalender_tage
, v01.resturlaub_vj
, v01.resturlaub_akt_kj
, v01.anspruch_urlaub_akt_kj
, v01.genommen_urlaub
, v01.langzeit_krank_fg
, v01.mutterschutz_fg
, v01.beschaeftigungs_verbot_fg
, v01.aushilfe_fg
, v01.elternzeit_fg
, v01.grundwehrdienst_fg
, v01.atz_kz
, v01.freigestellt_fg
, v01.impatriates_fg
, v01.externe_fg
, v01.azubi_fg
, CASE WHEN v03.kalendertage - v01.soll_kalender_tage <> 0
AND v01.ma_status_id IN (0)
AND v01.azubi_fg = 1
THEN 1 ELSE 0 END AS untermonatlich_azubi_fg
, v01.ma_eintritt_kz
, v01.ma_austritt_kz
, v01.fluktuation_kz
, v03.def_vollzeit_stunden
, v03.kalendertage
, v01.ki_fg
, v01.untermonatlich_fg
, v01.inventur_aushilfe_fg
, v01.tip_austraeger_fg
, v01.tip_kontrolleur_fg
, v01.tip_gebietsbetreuer_fg
, v01.diplomand_praktikant_fg
, v01.praktikant_o_entgeld_fg
, v01.expatriates_fg
, v01.hinterbliebene_fg
, v01.versorgungsbezieher_fg
, CASE WHEN v01.neu_mitarbeiter_fg = 1 AND v01.azubi_fg = 0
THEN 1 ELSE 0 END AS neumitarbeiter_ohne_azubi_fg

, CASE WHEN v01.mandant_id = 1   AND v02.buchungskreis_id NOT IN (1,220,234,80) THEN 'DE'
WHEN v01.mandant_id = 1   AND v02.buchungskreis_id IN (1,220,234,80)     THEN 'KI'
WHEN v01.mandant_id = 2   AND v02.mandant_id = 2                         THEN 'CZ'
WHEN v01.mandant_id = 3   AND v02.mandant_id = 3                         THEN 'PL'
WHEN v01.mandant_id = 4   AND v02.mandant_id = 4                         THEN 'MD'
WHEN v01.mandant_id = 5   AND v02.mandant_id = 5                         THEN 'SK'
WHEN v01.mandant_id = 6   AND v02.mandant_id = 6                         THEN 'HR'
WHEN v01.mandant_id = 7   AND v02.mandant_id = 7                         THEN 'RO'
WHEN v01.mandant_id = 8   AND v02.mandant_id = 8                         THEN 'BG'
ELSE  '0' END AS org_gruppierung_
, CAST(v01.abwesenheit_arbeitstage_bez + v01.abwesenheit_arbeitstage_unbez AS NUMBER(38,5)) AS abwesenheit_arbeitstage
, v01.soll_arbeitstage
, v01.arbeitszeit_anteil
--, v099.arbeitszeit_anteil_hr
,CASE WHEN v099.mandant_id IS  NOT NULL THEN v099.arbeitszeit_anteil_hr ELSE 0 END AS arbeitszeit_anteil_hr

, v01.abwesenheit_arbeitstage_bez
, v01.abwesenheit_arbeitstage_unbez
, v01.arb_stunden_tag
,CASE WHEN v094.mitarbeiter_id IS  NOT NULL
AND v035.mitarbeiter_id IS  NOT NULL
AND v094.dat_von_wiedereintritt - 1< v035.dat_von_wiedereintritt
AND CAST(EXTRACT(MONTH FROM v094.dat_von_wiedereintritt) AS INTEGER) = CAST(EXTRACT(MONTH FROM v035.dat_von_wiedereintritt) AS INTEGER)
THEN 1 ELSE 0 END AS  wiedereintritt_monatlich

-- Berechnung Alter des Mitarbeiters zum 31.12. des jeweiligen Jahres
, v07.dat_geburtstag AS geburtsdatum
, EXTRACT (YEAR FROM v07.dat_geburtstag) AS geburtsjahr

--17.03.2023, Alter wird nicht mehr errechnet, kommt direkt aus der Quelle, Umsezung mit SPEC SPEC0143976
--v094.dat_von_wiedereintritt im ersten Fall, da hier max gezogen wird, im Falle von mehreren Austritten
--, ROUND(CASE WHEN (v094.dat_von IS  NOT NULL AND wiedereintritt_monatlich = 0) THEN (v094.dat_von_wiedereintritt - v07.dat_geburtstag) / 365.25
--ELSE (v100.stichtag - v07.dat_geburtstag) / 365.25 END,2)AS errechnetes_alter
,v01.mitarbeiter_alter

, CASE WHEN v01.mitarbeiter_alter < 30 THEN 1 ELSE NULL END AS unter30
, CASE WHEN v01.mitarbeiter_alter >= 30 AND v01.mitarbeiter_alter < 50 THEN 1 ELSE NULL END AS zwischen30u50
, CASE WHEN v01.mitarbeiter_alter >= 50 THEN 1 ELSE NULL END AS ueber50

/*,CASE WHEN v094.dat_von IS  NULL THEN  (MONTHS_BETWEEN(v100.stichtag, v07.dat_geburtstag) + 1 ) /12
ELSE  MONTHS_BETWEEN(v094.dat_von, v07.dat_geburtstag) / 12 END  AS errechnetes_alter_monatsende*/
, v100.stichtag
, v09.betriebszugehoerigkeit -- kann wohl gelöscht werden
/*, v10.betriebszugehoerigkeit_monatsende -- kann wohl gelöscht werden*/
,CASE WHEN v09.betriebszugehoerigkeit IN (0)                    THEN 'beinhaltet < 1 Jahr'
WHEN v09.betriebszugehoerigkeit IN (1,2)        THEN 'beinhaltet 1 - 2 Jahre'
WHEN v09.betriebszugehoerigkeit IN (3,4)        THEN 'beinhaltet 3 - 4 Jahre'
WHEN v09.betriebszugehoerigkeit IN (5,6,7,8,9)  THEN 'beinhaltet 5 - 9 Jahre'
WHEN v09.betriebszugehoerigkeit IN (10)         THEN 'beinhaltet 10 Jahre'
ELSE 'beinhaltet > 10 Jahre'
END AS betriebszugehoerigkeit_anzeige

-- Wenn keIN Eintrittsdatum gepflegt ist, wird -1 gesetzt
-- Änderung der Berechnung der BZG START
--BZG IN Monaten
-- Achtung: Änderung für Snowflake
,COALESCE(CASE WHEN v094.dat_von IS  NULL THEN  CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF (to_timestamp_ltz(v100.stichtag) , to_timestamp_ltz(v036.bzg_dat_von + 1)) AS DECIMAL(4,1))
        WHEN v035.dat_von IS  NULL THEN CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(to_timestamp_ltz(v094.dat_von) , to_timestamp_ltz(v036.bzg_dat_von)) AS DECIMAL(4,1))
        ELSE CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(to_timestamp_ltz(v035.dat_von_wiedereintritt), to_timestamp_ltz(v036.bzg_dat_von)) AS DECIMAL(4,1)) END, -1)    AS  betriebszugehoerigkeit_bereinigt
--BZG IN Tagen
,COALESCE(CASE WHEN v094.dat_von IS  NULL THEN  v100.stichtag - v036.bzg_dat_von + 1
        WHEN v035.dat_von IS  NULL THEN v094.dat_von - v036.bzg_dat_von
        ELSE v035.dat_von_wiedereintritt - v036.bzg_dat_von END, -1)   AS  betriebszugehoerigkeit_bereinigt_in_tagen
-- Änderung der Berechnung der BZG END

/*,COALESCE(CASE WHEN v094.dat_von IS  NULL THEN  CAST(MONTHS_BETWEEN (v100.stichtag , COALESCE(v033.dat_von, v035.dat_von, v036.dat_von) + 1) AS DECIMAL(4,1))
ELSE  CAST(MONTHS_BETWEEN( v094.dat_von , COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS DECIMAL(4,1))
END, -1)    AS  betriebszugehoerigkeit_bereinigt
--BZG IN Tagen
,COALESCE(CASE WHEN v094.dat_von IS  NULL THEN  v100.stichtag - COALESCE(v033.dat_von, v035.dat_von, v036.dat_von) + 1
ELSE  v094.dat_von - COALESCE(v033.dat_von, v035.dat_von, v036.dat_von) END, -1)   AS  betriebszugehoerigkeit_bereinigt_in_tagen*/

-- BZG Cluster nach Monaten
, CASE WHEN betriebszugehoerigkeit_bereinigt < - 1 THEN 0
WHEN betriebszugehoerigkeit_bereinigt = - 1 THEN 1
WHEN betriebszugehoerigkeit_bereinigt <= 3 THEN 2
WHEN betriebszugehoerigkeit_bereinigt > 3 AND betriebszugehoerigkeit_bereinigt <= 6 THEN 3
WHEN betriebszugehoerigkeit_bereinigt > 6 AND betriebszugehoerigkeit_bereinigt <= 12 THEN 4
WHEN betriebszugehoerigkeit_bereinigt > 12 AND betriebszugehoerigkeit_bereinigt <= 36 THEN 5
ELSE 6 END AS betriebszugehoerigkeit_cluster_sort_id

--  DAYS_BETWEEN((DATE) , (  DATE -1))) AS INTEGER

,CASE WHEN v09.betriebszugehoerigkeit IN (0)  THEN 0
WHEN v09.betriebszugehoerigkeit IN (1,2)  THEN 1
WHEN v09.betriebszugehoerigkeit IN (3,4)   THEN 2
WHEN v09.betriebszugehoerigkeit IN (5,6,7,8,9)  THEN 3
WHEN v09.betriebszugehoerigkeit IN (10)  THEN 4
ELSE 5 END AS betriebszugehoerigkeit_sort -- kann wohl gelöscht werden

--- SPEC0117578 BGZ Schwarzlogik 
, CASE WHEN betriebszugehoerigkeit_bereinigt_in_tagen <= 365 THEN '<= 1 Jahr'
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 365 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 1825 THEN '> 1 - 5 Jahre'
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 1825 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 3650 THEN '> 5 - 10 Jahre'
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 3650 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 5475 THEN '> 10 - 15 Jahre'
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 5475 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 7300 THEN '> 15 - 20 Jahre'
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 7300 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 10950 THEN '> 20 - 30 Jahre'
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 10950 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 14600 THEN '> 30 - 40 Jahre'
ELSE '> 40 Jahre' END AS Betriebszugehoerigkeit_Cluster_Jahre
-- fuer die Sortierung 
, CASE WHEN betriebszugehoerigkeit_bereinigt_in_tagen <= 365 THEN 1
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 365 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 1825 THEN 2
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 1825 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 3650 THEN 3
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 3650 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 5475 THEN 4
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 5475 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 7300 THEN 5
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 7300 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 10950 THEN 6
WHEN betriebszugehoerigkeit_bereinigt_in_tagen > 10950 AND betriebszugehoerigkeit_bereinigt_in_tagen <= 14600 THEN 7
ELSE 8 END AS Betriebszugehoerigkeit_Cluster_Jahre_sort

, v07.land_id AS nationalitaet
, v09.err_dat

, v09.vertragsende
, v09.anz_mon_vertragsende
, v01.krank_tage_arbeitstage
, v01.anz_arbeits_unfall
, v01.sonstige_abwesenheit_fg
, v01.pflege_fg
, v01.krankheit_unfall_fg
, v01.langzeit_abwesenheit_tage
, v01.langzeit_abwesenheit_tage_kum
, v01.langzeit_min_dat
, v01.langzeit_abwesenheit_grund
, v01.stichtag_fg
, v01.dat_letzte_abwesenheit
,COALESCE( v094.dat_von -1, CAST( '9999-12-31' AS DATE))  AS austrittsdatum
,COALESCE( v033.dat_von, v035.dat_von, v036.dat_von, CAST( '1900-01-01' AS DATE))  AS eintrittsdatum

,CASE WHEN v094.mitarbeiter_id IS  NOT NULL THEN 1 ELSE 0 END AS  austritt_alles_fg
,CASE WHEN v095.mitarbeiter_id IS  NOT NULL THEN 1 ELSE 0 END AS austritt_919899_fg --löschbar nach Fertigstellung FE Moldau
-- comnent FDS, initions: dbp_view.v_ma_kostenstelle_lohnart_zu_per wird ausgelagert
--,CASE WHEN v096.mitarbeiter_id IS  NOT NULL THEN v096.anzahl_lohnart ELSE 0 END AS aushilfe_cz_sk_stunden
,CASE WHEN v097.mitarbeiter_id IS  NOT NULL THEN v097.anzahl_lohnart ELSE 0 END AS azubi_cz_sk_hr_stunden

-- Einführung Flag Arbeitsunfall + Berücksichtigung LZA noch einbauen + Austritt -> wiedereintritt??
,ma_abw.arbeitsunfall_fg
,ma_abw_au_folge.arbeitsunfall_folgeabw_fg
,ma_abw.arbeitsunfall_anzahl
FROM dbp_view.v_mitarbeiterbew v01
LEFT JOIN dbp_view.v_mitarbeiterbew mbew 
  ON mbew.mandant_id =  v01.mandant_id AND mbew.kjmo = TO_NUMBER(TO_VARCHAR(ADD_MONTHS(TO_DATE(TO_CHAR(v01.kjmo),'YYYYMM'),-1),'YYYYMM')) AND mbew.mitarbeiter_id = v01.mitarbeiter_id
JOIN dbp_view.v_monat v08
 ON v01.kjmo = v08.kjmo

LEFT JOIN dbp_view.v_mitarbeiterbew v0111
 ON  v0111.mitarbeiter_id = v01.mitarbeiter_id
  AND v0111.mandant_id = v01.mandant_id
  AND v0111.kjmo = TO_NUMBER(TO_VARCHAR(ADD_MONTHS(TO_DATE(TO_CHAR(v01.kjmo),'YYYYMM'),-1),'YYYYMM'))

LEFT JOIN
(SELECT v0.mandant_id
,v0.mitarbeiter_id
,v0.kjmo
,v0.mitarbeiter_gruppe_id
FROM dbp_msi_view_shr.mv_ma_gruppe_zu_per  v0
GROUP BY
v0.mandant_id
,v0.mitarbeiter_id
,v0.kjmo
,v0.mitarbeiter_gruppe_id)
v101
ON  v01.mitarbeiter_id = v101.mitarbeiter_id
AND v01.mandant_id = v101.mandant_id
AND v01.kjmo = v101.kjmo



-- Ermittlung MA Kreis
LEFT JOIN
(SELECT v0.mandant_id
,v0.mitarbeiter_id
,v0.kjmo
,v0.mitarbeiter_kreis_id
FROM dbp_msi_view_shr.mv_ma_kreis_zu_per  v0
GROUP BY
v0.mandant_id
,v0.mitarbeiter_id
,v0.kjmo
,v0.mitarbeiter_kreis_id)
v102
ON  v01.mitarbeiter_id = v102.mitarbeiter_id
AND v01.mandant_id = v102.mandant_id
AND v01.kjmo = v102.kjmo



-- Ermittlung MA Kostenstelle
LEFT JOIN
(SELECT v0.mandant_id
,v0.mitarbeiter_id
,v0.kjmo
,v0.kostenstelle_id
FROM dbp_msi_view_shr.mv_ma_kostenstelle_zu_per  v0
WHERE v0.haupt_kst_fg = 1
GROUP BY
v0.mandant_id
,v0.mitarbeiter_id
,v0.kjmo
,v0.kostenstelle_id)
v103
ON  v01.mitarbeiter_id = v103.mitarbeiter_id
AND v01.mandant_id = v103.mandant_id
AND v01.kjmo = v103.kjmo

--Hier enden die neu eingefügten Felder von mmzy2302


LEFT OUTER JOIN dbp_view.v_ma_personalbereich_zu_per v02
ON v01.mitarbeiter_id = v02.mitarbeiter_id
AND v01.mandant_id = v02.mandant_id
AND v01.kjmo = v02.kjmo

LEFT OUTER JOIN dbp_msi_view_shr.mv_l_ma_variable v03
ON v02.buchungskreis_id = v03.buchungskreis_id
AND v02.mandant_id = v03.mandant_id
AND v02.kjmo = v03.kjmo

LEFT OUTER JOIN dbp_view.v_ma_lohnart_zu_per v04
ON v01.mitarbeiter_id = v04.mitarbeiter_id
AND v01.mandant_id = v04.mandant_id
AND v01.kjmo = v04.kjmo
AND v04.lohnart_id = '7723'

LEFT JOIN dbp_msi_view_shr.mv_shr_datenfreigabe  v06
ON v01.mandant_id = v06.mandant_id
AND v01.kjmo = v06.kjmo

-- Berechnung Alter des Mitarbeiters des jeweiligen Jahres
JOIN dbp_view.v_hr_mitarbeiter v07
ON v01.mitarbeiter_id = v07.mitarbeiter_id
AND v01.mandant_id = v07.mandant_id

-- Berechnung Betriebszugehörigkeit des Mitarbeiters und Vertragsende / Kündigung
JOIN (SELECT v091.mandant_id
,v091.mitarbeiter_id
,v091.kjmo
,MAX(v091.betriebszugehoerigkeit) AS betriebszugehoerigkeit
--      ,MIN(v091.dat_von) AS dat_von
--,MAX(v091.betriebszugehoerigkeit_jahresende) AS betriebszugehoerigkeit_jahresende
,MAX(v091.err_dat) AS err_dat
,MAX(v091.vertragsende) AS vertragsende
,MAX(v091.anz_mon_vertragsende) AS  anz_mon_vertragsende
FROM (SELECT
v100.mandant_id
,v100.mitarbeiter_id
,v100.kjmo
--,MIN(v100.dat_von) AS dat_von
-- Berechnung Betriebszugehörigkeit des Mitarbeiters
,CAST(v100.kjmo/100 AS INTEGER) - EXTRACT (YEAR FROM v100.dat_von) AS betriebszugehoerigkeit
--,CASE WHEN (v100.kjmo MOD 100 ) = 12 THEN betriebszugehoerigkeit ELSE NULL END AS betriebszugehoerigkeit_jahresende
-- Berechnung des Datums aus kjmo
,TO_DATE(CAST(LEFT(v100.kjmo/100,4) AS CHAR(4))||'.'|| CAST(TO_NUMBER(MOD(v100.kjmo,100)) AS CHAR(2))||'.01','YYYY.MM.DD') err_dat
--,v08.min_dat AS err_dat
-- Berechnung der Mitarbeiter, wo eine Kündigung vorliegt
,CASE WHEN v100.datumsart_id = '-1' THEN dat_von ELSE NULL END AS vertragsende
-- Berechnung Anzahl Monate bIS  Vertragsende / Kündigung
--,CAST((vertragsende - err_dat MONTH(4)) AS INTEGER) AS anz_mon_vertragsende
,TIMEDIFF(MONTH,err_dat, vertragsende) AS anz_mon_vertragsende
-- Definition Flag, ob Datum Vertragsende <6 Monate
FROM dbp_view.v_ma_datumsart_zu_per v100
--JOIN dbp_view.v_monat v08
--ON v100.kjmo = v08.kjmo

WHERE 
   v100.datumsart_id IN ('02', '-1') 
   -- Einschraenkung auf Datum kann raus, da fuer jeden Mandanten dAS Highdate mitgenommen werden soll.
  /* AND 
     ( TO_DATE(v100.dat_von) < '2200-01-01'
       -- da bei CZ, SK & BG auch der Datumswert '9999-12-31' mitgenommen werden soll. 
     -- Nur bei Dat_von mit der Datumsart_id = -1 kommt dies vor. 
     OR v100.mandant_id IN (2,5,8) )*/
--   GROUP BY    v100.mandant_id
--   ,v100.mitarbeiter_id
--    ,v100.kjmo

) v091
GROUP BY mandant_id
,mitarbeiter_id
,kjmo
)v09

ON  v01.mitarbeiter_id = v09.mitarbeiter_id
AND v01.mandant_id = v09.mandant_id
AND v01.kjmo = v09.kjmo


-- Berechnung Austrittsdatum
LEFT JOIN (SELECT v093.mandant_id
,v093.mitarbeiter_id
,v093.kjmo
, v093.dat_von  AS dat_von
FROM dbp_view.v_ma_datumsart_zu_per v093
WHERE v093.datumsart_id IN ('05')
) v093
ON  v01.mitarbeiter_id = v093.mitarbeiter_id
AND v01.mandant_id = v093.mandant_id
AND v01.kjmo = v093.kjmo



-- Berechnung Eintrittsdatum 01
LEFT JOIN (SELECT v033.mandant_id
,v033.mitarbeiter_id
,v033.kjmo
,MIN(v033.dat_von) AS dat_von
FROM dbp_view.v_ma_hr_massnahme_zu_per v033
WHERE v033.hr_massnahme_id = '01'
GROUP BY 1,2,3

) v033
ON  v01.mitarbeiter_id = v033.mitarbeiter_id
AND v01.mandant_id = v033.mandant_id
AND v01.kjmo = v033.kjmo


-- Berechnung Eintrittsdatum 02
LEFT JOIN (SELECT v035.mandant_id
,v035.mitarbeiter_id
,v035.kjmo
,MIN(v035.dat_von)  AS dat_von
--Einführung MAX für Wiedereintrittslogik
,MAX(v035.dat_von) AS dat_von_wiedereintritt
FROM dbp_view.v_ma_hr_massnahme_zu_per v035
WHERE  v035.hr_massnahme_id = '02'
GROUP BY 1,2,3

) v035
ON  v01.mitarbeiter_id = v035.mitarbeiter_id
AND v01.mandant_id = v035.mandant_id
AND v01.kjmo = v035.kjmo

-- Berechnung Eintrittsdatum 03
-- Änderung der Berechnung der BZG START
LEFT JOIN eintrittsdatum_03 v036  -- with clause
ON  v01.mitarbeiter_id = v036.mitarbeiter_id
AND v01.mandant_id = v036.mandant_id
AND v01.kjmo = v036.kjmo


-- Ermittlung Austrittsdatum
LEFT JOIN
(SELECT v0.mandant_id
,v0.mitarbeiter_id
,v0.kjmo
,MIN(v0.dat_von) AS dat_von
--Einführung MAX für Wiedereintrittslogik
,MAX(v0.dat_von) AS dat_von_wiedereintritt
FROM dbp_view.v_ma_hr_massnahme_zu_per  v0

WHERE v0.hr_massnahme_id = '04'

GROUP BY
v0.mandant_id
,v0.mitarbeiter_id
,v0.kjmo)
v094
ON  v01.mitarbeiter_id = v094.mitarbeiter_id
AND v01.mandant_id = v094.mandant_id
AND v01.kjmo = v094.kjmo

-- Austritt wegen Tod, Rente, Wechsel: löschbar nach FE-Fertigstellung Moldau
LEFT JOIN
(SELECT v095.mandant_id
,v095.mitarbeiter_id
,v095.kjmo
FROM dbp_view.v_ma_hr_massnahme_zu_per v095

WHERE v095.hr_massnahme_id = '04' AND hr_massnahme_grund_id IN ('91','98','99')

GROUP BY
v095.mandant_id
,v095.mitarbeiter_id
,v095.kjmo)
v095
ON  v01.mitarbeiter_id = v095.mitarbeiter_id
AND v01.mandant_id = v095.mandant_id
AND v01.kjmo = v095.kjmo
-- Ende löschbar


-- comment FDS, initions: dbp_view.v_ma_kostenstelle_lohnart_zu_per wird ausgelagert
/*LEFT JOIN
(SELECT v096.mandant_id,
v096.mitarbeiter_id,
v096.kjmo,
SUM(v096.anzahl_lohnart) AS anzahl_lohnart
FROM dbp_view.v_ma_kostenstelle_lohnart_zu_per v096

WHERE (v096.mandant_id = 2 AND lohnart_id IN ('3001', '3004')) OR (v096.mandant_id = 5 AND lohnart_id IN ('3001'))
GROUP BY
v096.mandant_id,
v096.mitarbeiter_id,
v096.kjmo)
v096
ON  v01.mitarbeiter_id = v096.mitarbeiter_id
AND v01.mandant_id = v096.mandant_idv01.mandant_id
AND v01.kjmo = v096.kjmo
*/



LEFT JOIN
-- Die Stunden der AzubIS  CZ und HR 
(SELECT v097.mandant_id
,v097.mitarbeiter_id
,v097.kjmo
,SUM(v097.anzahl_lohnart) AS anzahl_lohnart
FROM dbp_view.v_ma_kostenstelle_lohnart_zu_per v097

WHERE ( v097.mandant_id = 2 AND lohnart_id IN ('1072') ) -- AzubIS  CZ
OR ( v097.mandant_id = 6 AND lohnart_id IN ('1071') ) -- AzubIS  HR
GROUP BY
v097.mandant_id
,v097.mitarbeiter_id
,v097.kjmo)
v097
ON  v01.mitarbeiter_id = v097.mitarbeiter_id
AND v01.mandant_id = v097.mandant_id
AND v01.kjmo = v097.kjmo

--Sonderregelung HR, weil über SAP falsche Werte kommen
LEFT JOIN
(SELECT v099.mandant_id
,v099.kjmo_von
,v099.kjmo_bis
,v099.anz_stunden_von
,v099.anz_stunden_bis
,SUM(v099.arbeitszeit_anteil) AS arbeitszeit_anteil_hr
FROM dbp_view.v_shr_arbeitszeit_anteil_mapping  v099

--WHERE v099.mandant_id = 6 AND lohnart_id IN ('MVST')
GROUP BY
v099.mandant_id
,v099.kjmo_von
,v099.kjmo_bis
,v099.anz_stunden_von
,v099.anz_stunden_bis)
v099
ON v01.mandant_id = v099.mandant_id
AND v01.kjmo BETWEEN v099.kjmo_von AND v099.kjmo_bis
AND v01.soll_stunden_monat BETWEEN v099.anz_stunden_von AND v099.anz_stunden_bis

LEFT JOIN
(SELECT v100.kjmo
,MAX(v100.dat) AS stichtag
FROM dbp_view.v_tag  v100

--WHERE v099.mandant_id = 6 AND lohnart_id IN ('MVST')
GROUP BY
v100.kjmo)
v100
ON  v01.kjmo = v100.kjmo

-- Einführung Flag Arbeitsunfall
-- Vormonatslogik: EIN Arbeitsunfall mit gleicher Abwesenheit im Folgemonat zählt nur als Arbeitsunfall, wenn der > 3Tage Ausfall
LEFT JOIN
(SELECT DISTINCT
mandant_id
, mitarbeiter_id
, kjmo_dat_von AS kjmo
, arbeitsunfall_fg AS arbeitsunfall_fg
, arbeitsunfall_fg AS arbeitsunfall_anzahl
--, MAX(arbeitsunfall_folgeabw_fg) AS arbeitsunfall_folgeabw_fg
-- Subselect, um Arbeitsunfälle zu identifizieren, die folgender Logik genügen: Differenz zwischen 2 Arbeitsunfällen, wenn <=3 -Tage> 1 Arbeitsunfall , > 3Tage mehrere AUs
FROM(
SELECT
mandant_id
, mitarbeiter_id
, kjmo

-- kjmo aus dat_von extrahieren zum joinen gg mitarbeiterbew -> damit ist SchiefstAND dat_von und kjmo aus ma_abwesenh_zu_per behoben
, EXTRACT(YEAR FROM dat_von) AS jahr
-- Anpassung für Snowflake
, TO_VARCHAR(MONTH(dat_von),'FM00') AS monat
, CAST(TRIM(jahr) || TRIM(monat) AS INTEGER)  AS kjmo_dat_von
, dat_von

-- Bestimmung des dat_bIS  aus der Vorperiode für die gleiche Mandant, Mitarbeiter, Abwesenheit Kombination
, (SELECT MAX(v2.dat_bis) FROM dbp_view.v_ma_abwesenh_zu_per v2
WHERE v2.mandant_id = ma_abw.mandant_id
AND v2.mitarbeiter_id = ma_abw.mitarbeiter_id
AND (ma_abw.dat_von > v2.dat_von OR ma_abw.kjmo > v2.kjmo)
AND ma_abw.abwesenheit_id = v2.abwesenheit_id) AS dat_bis_vorperiode

-- Bestimmung Differenz aktPeriode zu Vorperiode: 1000, wenn keine Vorperiode vorhanden
, COALESCE(dat_von - dat_bis_vorperiode, 1000) AS pruefdiff
, CASE  WHEN pruefdiff <=3 THEN 0
WHEN ma_abw.mandant_id = 2 AND ma_abw.abwesenheit_id = '0210' THEN 1
WHEN ma_abw.mandant_id = 3 AND ma_abw.abwesenheit_id IN ('0210', '9420') THEN 1
WHEN ma_abw.mandant_id = 4 AND ma_abw.abwesenheit_id IN ('0240','9432') THEN 1
WHEN ma_abw.mandant_id = 5 AND ma_abw.abwesenheit_id = '0410' THEN 1
WHEN ma_abw.mandant_id = 6 AND ma_abw.abwesenheit_id IN ('9015', '9413') THEN 1
WHEN ma_abw.mandant_id = 7 AND ma_abw.abwesenheit_id IN ('0240','9429','9432','9434') THEN 1
WHEN ma_abw.mandant_id = 8 AND ma_abw.abwesenheit_id = '0270' THEN 1
ELSE 0 END AS arbeitsunfall_fg


FROM dbp_view.v_ma_abwesenh_zu_per ma_abw
GROUP BY
mandant_id
, mitarbeiter_id
, kjmo
,jahr
,monat
,kjmo_dat_von
, dat_von
, dat_bis_vorperiode
, arbeitsunfall_fg

HAVING (arbeitsunfall_fg = 1 /*OR arbeitsunfall_folgeabw_fg = 1*/)
) ma_abw_au


) ma_abw
ON v01.kjmo = ma_abw.kjmo
AND v01.mitarbeiter_id = ma_abw.mitarbeiter_id
AND v01.mandant_id = ma_abw.mandant_id


-- Auslagerung Folgeabwesenheit, da hier über dAS 'normale'' kjmo gejoint werden soll
LEFT JOIN
(SELECT
mandant_id
, mitarbeiter_id
, kjmo

, MAX(CASE   WHEN ma_abw.mandant_id = 2 AND ma_abw.abwesenheit_id IN ('0210', '0211', '0215') THEN 1
WHEN ma_abw.mandant_id = 3 AND ma_abw.abwesenheit_id IN ('0210', '9420') THEN 1
WHEN ma_abw.mandant_id = 4 AND ma_abw.abwesenheit_id IN ('0240','9432') THEN 1
WHEN ma_abw.mandant_id = 5 AND ma_abw.abwesenheit_id IN ('0410', '0411', '0415') THEN 1
WHEN ma_abw.mandant_id = 6 AND ma_abw.abwesenheit_id IN ('9015','9016', '9413') THEN 1
WHEN ma_abw.mandant_id = 7 AND ma_abw.abwesenheit_id IN ('0240','9429','9432','9434')  THEN 1
WHEN ma_abw.mandant_id = 8 AND ma_abw.abwesenheit_id IN ('0270', '0271') THEN 1
ELSE 0 END) AS arbeitsunfall_folgeabw_fg

FROM dbp_view.v_ma_abwesenh_zu_per ma_abw
GROUP BY 1,2,3
HAVING arbeitsunfall_folgeabw_fg = 1
) ma_abw_au_folge

ON v01.kjmo = ma_abw_au_folge.kjmo
AND v01.mitarbeiter_id = ma_abw_au_folge.mitarbeiter_id
AND v01.mandant_id = ma_abw_au_folge.mandant_id



LEFT JOIN
(SELECT * FROM
dbp_view.v_kostenstelle_hierarchie
WHERE kjmo = (SELECT MAX(kjmo) FROM dbp_view.v_kostenstelle_hierarchie)
AND kostenstelle_ebene1_id IN ('KBG01','KDE01', 'KCZ01', 'KHR01', 'KPL01', 'KRO01','KSK01', 'KMD01')) v2
ON v2.mandant_id = v01.mandant_id
AND v2.kostenstelle_ebene15_id = v103.kostenstelle_id

-- NSR0292396 Ausblenden von Zeiträumen
WHERE v01.kjmo > 201510;
