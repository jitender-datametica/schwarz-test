CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MITARBEITERBEW_1
-- kkai0912 131002 Neuaufbau mitarbeiterbew_1 # 573170 mit Flags und
-- Security  basierend auf User_id aus akt_user und Zuordnung in $DBX_security.user_hr_objekt_id_zu_1
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
-- kkai0912 150519  neuer Buchungskreis 220 bei internationalen Firmen
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
-- #AP0025469 SPEC0033380 20180202 mmzy2302  Erweiterung um entsprechende IDs für Mitarbeiter-Gruppe_1, Mitarbeiter-Kreis, Kostenstelle etc.
-- nfis0811 - 180410: Anpassung Logik Befüllung Feld betriebszugehörigkeit_bereinigt
-- nfis0811 - 180416: Hinzufügen von  betriebszugehoerigkeit_bereinigt_in_tagen
-- nfis0811 - Einfügen des Betriebszugehörigkeitsclusters nach Monaten
-- #AP0025469 SPEC0033380 20180202 mmzy2302  Redesign Eintrittsdatum (Erweiterung um Eintrittsdatum03 - Teilabfrage im Bezug auf Neueinstellungen)
-- nfis0811 - 180420: Nachziehen der BZG-Logiken um die Anpassung des Eintrittdatums
-- nfis0811 - 180424: Einbau Durschnittsalter zum Stichtag/Austrittsdatum in Jahren
-- nfis0811 - 180525: Änderung Defintion Austrittsdatum - NSR0188185
-- nfis0811 -180726: Einführung fg für untermonatlichen Wiedereintritt
-- nfis0811 - 181022: SPEC0045191 - Einführen der Funktionsaenderung_id
-- nfis0811 - 181105: SPEC0045192 - Übernahme neuer Logik für Funktion_id2 und anhängige Bezeichnung in diese View wegen Gruppierung
-- nfis0811 - 181228: TEST1275372 Änderung Logik zur Ermittlung der funktionsaenderung_id
-- nfis0811 - 190204: SPEC0049938 Einführung Alterscluster CSR
-- nfis0811 - 190218: SPEC0049509 Erweiterung Moldau
-- nifs0811 - 190408: SPEC0053662 Anpassung Logik für Feld errechnetes_alter
-- nfis0811 - 190729: SPEC0058419 Einführung Arbeitsunfall-Flags
--	cbru1709 - 191107: SPEC0064121 shr_ma_fach_fuer_ebene Feld analog der Dynamischen Gruppe_1
--	cbru1709 - 191126:SPEC0064192 Änderung in der Berechung der BZG 
-- cbru1709 - 200109:SPEC0064192 Nochmalige Änderung in der Berechung der BZG; Behandlung wenn Austritt und Wiedereintritt im gleichen Monat_1 
-- cbru1709 - 200113_SPEC0064192 Geänderte Case Bedingung in der With Clause, Änderung auf Funktion Extract Month from
-- cbru1709 - 200121 SPEC0066663 Änderung Viewlogik Arbeitsunfälle 
-- cbru1709 - 200312 SPEC0054818 Self-Join mit mitarbeiterbew_1 wegen Änderung Fluktuation VM
-- richternic - 201215 SPEC0095481 vertragsende_fg herausnehmen wird nicht weiter benoetigt
-- richternic - 210628: SPEC0117578 BZG Cluster nach Jahren auf Basis der Tage
-- prescherad - 211013 SPEC0130075 Ausbau Feld sb_prozent 
-- prescherad - 230317, SPEC0143976 erstetzen errechnetes Alter durch Mitarbeiter Alter direkt aus Quelle
AS

SELECT
v01.MANDANT_ID
,v01.MITARBEITER_ID
,v01.KJMO
,v01.KJMO_VM
,v01.MITARBEITER_GRUPPE_ID
,v01.MITARBEITER_KREIS_ID
,v01.KOSTENSTELLE_ID
,v01.ABWESENHEIT_TAGE
,v01.SOLL_STUNDEN_MONAT
,v01.ABR_STUNDEN_MONAT
,v01.LANGZEIT_ABWESEND_FG
,v01.LANGZEIT_ABWESEND_FG_VM
,v01.NEU_MITARBEITER_FG
,v01.KRANK_TAGE
,v01.TEILZEIT_FG
,v01.HR_OBJEKT_ID
,v01.MA_STATUS_ID
,v01.MA_STATUS_ID_VM
,v01.GESCHLECHT_ID
,v01.TARIFGEBIET_ID
,v01.SHR_MA_FUNKTION_ID
,v01.KOSTENSTELLE_EBENE4_ID
,v01.SHR_MA_FUNKTION_ID_2
,v01.SHR_MA_FUNKTION_ID_FUNKTION
,v01.SHR_MA_HIERARCHIESTUFE_FUNKTION
,v01.SHR_MA_FACH_FUER_EBENE
,v01.SHR_MA_FUNKTIONSAENDERUNG1
,v01.SHR_MA_FUNKTIONSAENDERUNG2
,v01.SHR_MA_FUNKTIONAENDERUNG_ID
,v01.TARIFART_ID
,v01.UNTERNEHMENS_BEREICH_ID
,v01.GEHALTS_REGION_ID
,v01.HAUS_KATEGORIE_ID
,v01.HAUPT_MITARBEITER_ID
,v01.SOLL_KALENDER_TAGE
,v01.RESTURLAUB_VJ
,v01.RESTURLAUB_AKT_KJ
,v01.ANSPRUCH_URLAUB_AKT_KJ
,v01.GENOMMEN_URLAUB
,v01.LANGZEIT_KRANK_FG
,v01.MUTTERSCHUTZ_FG
,v01.BESCHAEFTIGUNGS_VERBOT_FG
,v01.AUSHILFE_FG
,v01.ELTERNZEIT_FG
,v01.GRUNDWEHRDIENST_FG
,v01.ATZ_KZ
,v01.FREIGESTELLT_FG
,v01.IMPATRIATES_FG
,v01.EXTERNE_FG
,v01.AZUBI_FG
,v01.UNTERMONATLICH_AZUBI_FG
,v01.MA_EINTRITT_KZ
,v01.MA_AUSTRITT_KZ
,v01.FLUKTUATION_KZ
,v01.DEF_VOLLZEIT_STUNDEN
,v01.KALENDERTAGE
,v01.KI_FG
,v01.UNTERMONATLICH_FG
,v01.INVENTUR_AUSHILFE_FG
,v01.TIP_AUSTRAEGER_FG
,v01.TIP_KONTROLLEUR_FG
,v01.TIP_GEBIETSBETREUER_FG
,v01.DIPLOMAND_PRAKTIKANT_FG
,v01.PRAKTIKANT_O_ENTGELD_FG
,v01.EXPATRIATES_FG
,v01.HINTERBLIEBENE_FG
,v01.VERSORGUNGSBEZIEHER_FG
,v01.NEUMITARBEITER_OHNE_AZUBI_FG
,v01.ORG_GRUPPIERUNG_
,v01.ABWESENHEIT_ARBEITSTAGE
,v01.SOLL_ARBEITSTAGE
,v01.ARBEITSZEIT_ANTEIL
,v01.ARBEITSZEIT_ANTEIL_HR
,v01.ABWESENHEIT_ARBEITSTAGE_BEZ
,v01.ABWESENHEIT_ARBEITSTAGE_UNBEZ
,v01.ARB_STUNDEN_TAG
,v01.WIEDEREINTRITT_MONATLICH
,v01.GEBURTSDATUM
,v01.GEBURTSJAHR
,v01.MITARBEITER_ALTER
,v01.UNTER30
,v01.ZWISCHEN30U50
,v01.UEBER50
,v01.STICHTAG
,v01.BETRIEBSZUGEHOERIGKEIT
,v01.BETRIEBSZUGEHOERIGKEIT_ANZEIGE
,v01.BETRIEBSZUGEHOERIGKEIT_BEREINIGT
,v01.BETRIEBSZUGEHOERIGKEIT_BEREINIGT_IN_TAGEN
,v01.BETRIEBSZUGEHOERIGKEIT_CLUSTER_SORT_ID
,v01.BETRIEBSZUGEHOERIGKEIT_SORT
,v01.Betriebszugehoerigkeit_Cluster_Jahre
,v01.Betriebszugehoerigkeit_Cluster_Jahre_sort
,v01.NATIONALITAET
,v01.ERR_DAT
,v01.VERTRAGSENDE
,v01.ANZ_MON_VERTRAGSENDE
,v01.KRANK_TAGE_ARBEITSTAGE
,v01.ANZ_ARBEITS_UNFALL
,v01.SONSTIGE_ABWESENHEIT_FG
,v01.PFLEGE_FG
,v01.KRANKHEIT_UNFALL_FG
,v01.LANGZEIT_ABWESENHEIT_TAGE
,v01.LANGZEIT_ABWESENHEIT_TAGE_KUM
,v01.LANGZEIT_MIN_DAT
,v01.LANGZEIT_ABWESENHEIT_GRUND
,v01.STICHTAG_FG
,v01.DAT_LETZTE_ABWESENHEIT
,v01.AUSTRITTSDATUM
,v01.EINTRITTSDATUM
,v01.AUSTRITT_ALLES_FG
,v01.AUSTRITT_919899_FG
,CASE WHEN v02.mitarbeiter_id IS NOT NULL THEN v02.anzahl_lohnart ELSE 0 END AS aushilfe_cz_sk_stunden
,v01.AZUBI_CZ_SK_HR_STUNDEN
,v01.ARBEITSUNFALL_FG
,v01.ARBEITSUNFALL_FOLGEABW_FG
,v01.ARBEITSUNFALL_ANZAHL



FROM DBP_MSI_VIEW_SHR.TBL_MV_MITARBEITERBEW_1 v01
LEFT JOIN
(SELECT v096.mandant_id
,v096.mitarbeiter_id
,v096.kjmo
,SUM(v096.anzahl_lohnart) AS anzahl_lohnart
FROM dbp_view.v_ma_kostenstelle_lohnart_zu_per_1 v096

--eklosiewicz NSR4698897
WHERE (v096.mandant_id = 2 AND lohnart_id IN ('3001' ,'3004')) OR (v096.mandant_id = 5 AND lohnart_id IN ('3001')) OR (v096.mandant_id = 6 AND lohnart_id IN ('1035'))
GROUP BY
v096.mandant_id
,v096.mitarbeiter_id
,v096.kjmo) v02
ON  v01.mitarbeiter_id = v02.mitarbeiter_id
AND v01.mandant_id = v02.mandant_id
AND v01.kjmo = v02.kjmo;
