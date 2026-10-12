-- #AP0003387 20160622 kkai0912 Anbindung der 4 neuen Felder (anz_arbeits_unfall, vertragsende_fg, untermonatlich_fg,aushilfe_nicht_gearbeitet_fg) aus der Data

-- KKai0912 140207 Austritts_kz  nur 2,3 untermonatlich_fg

-- nfis0811 - 181022: SPEC0045191 - Einführen der Funktionsaenderung_id

-- nfis0811 - 180420: Nachziehen der BZG-Logiken um die Anpassung des Eintrittdatums

-- cbru1709 - 200113_SPEC0064192 Geänderte Case Bedingung in der With Clause, Änderung auf Funktion Extract Month from

-- kmor0912 - zusätzliches Feld aufgenommenb dat_letzte_abwesenheit

-- #AP0003387 Erweiterung um Feld für Berechnung Filter Vertragsende <6 Monate - sschuecke 20.01.2016

-- #AP0003387 Berechnung Alter und Betriebszugehoerigkeit, Nationalitaet - sschuecke 14.01.2016

-- prescherad - 211013 SPEC0130075 Ausbau Feld sb_prozent

-- #AP0025469 SPEC0033380 20180202 mmzy2302  Redesign Eintrittsdatum (Erweiterung um Eintrittsdatum03 - Teilabfrage im Bezug auf Neueinstellungen)

-- nfis0811 - 190729: SPEC0058419 Einführung Arbeitsunfall-Flags

-- #SPEC0020119 20170505 ttez1905 Neue Spalte "abgeltung_urlaub" aufgenommen

-- #AP0003387 betriebszugehörigkeit als range - kkaiser 20.05.2016

-- nfis0811 - 190204: SPEC0049938 Einführung Alterscluster CSR

-- richternic - 201215 SPEC0095481 vertragsende_fg herausnehmen wird nicht weiter benoetigt

-- nfis0811 - Einfügen des Betriebszugehörigkeitsclusters nach Monaten

-- KKai0912 140512 5 neue Kennzeichen für die Prüfberichte (damit mit Konsolidierung auswertbar)

-- nfis0811 -180726: Einführung fg für untermonatlichen Wiedereintritt

-- nifs0811 - 190408: SPEC0053662 Anpassung Logik für Feld errechnetes_alter

-- kkai0912 131002 Neuaufbau mitarbeiterbew_1 # 573170 mit Flags und

-- nfis0811 - 180410: Anpassung Logik Befüllung Feld betriebszugehörigkeit_bereinigt

-- KKai0912 140203 Austritts_kz nicht nur 1,2, sondern auch 3 bei untermonatlich_fg

-- cbru1709 - 200121 SPEC0066663 Änderung Viewlogik Arbeitsunfälle

-- nfis0811 - 190218: SPEC0049509 Erweiterung Moldau

-- nfis0811 - 181105: SPEC0045192 - Übernahme neuer Logik für Funktion_id2 und anhängige Bezeichnung in diese View wegen Gruppierung

-- KKai0912 140515 9 neue Kennzeichen , atz_passiv_fg wird zu atz_kz,  ma_ausgrenzung_netto_fg und ma_ausgrenzung_brutto_fg entfallen

-- KKai0912 131114 Security  wieder herausgenommen, soll FE-seitig stattfinden

-- KKai0912 140219 Aushilfe nur wenn sie auch gearbeitet hat fg

-- kkai0912 140904 die "Org Gruppierung" ermittelt und bereitgestellt, damit im FE die dyn. Gruppierung von einem Attribut abgelöst werden kann

-- #SPEC0027571 epla2707 Entfernen abwesenheit_stunden

-- #AP0003387 Erweitert um Feld krank_tage_arbeitstage - sschuecke 05.02.2016

-- kkai0912: 151013 Hinzunahme von 2 Feldern: abwesenheit_arbeitstage + soll_arbeitstage

-- kkai0912 150519  neuer Buchungskreis 220 bei internationalen Firmen

-- #SPEC0020119 20171009 kmor0912 Spalte "abgeltung_urlaub" wieder ausgebaut

-- cbru1709 - 191107: SPEC0064121 shr_ma_fach_fuer_ebene Feld analog der Dynamischen Gruppe_1

-- cbru1709 - 191126:SPEC0064192 Änderung in der Berechung der BZG

-- #SPEC0027571 20171013 Felder aufgenommen: , sonstige_abwesenheit_fg, pflege_fg, krankheit_unfall_fg, langzeit_abwesenheit_tage, langzeit_abwesenheit_tage_kum, langzeit_min_dat, langzeit_abwesenheit_grund, stichtag_fg

-- #AP0003387 erneute Anpassung Logik vertragsende_fg - sschuecke 25.02.2016

-- KKai0912 140603 pruef_austritt_extern (2,3,4), pruef_austritt_intern (1,3), pruef_austritt_intern_extern (2,3),  pruef_eintritt_extern (2), pruef_eintritt_intern (1), pruef_eintritt_intern_extern (3)

-- richternic - 210628: SPEC0117578 BZG Cluster nach Jahren auf Basis der Tage

-- Security  basierend auf User_id aus akt_user und Zuordnung in $DBX_security.user_hr_objekt_id_zu_1

-- prescherad - 230317, SPEC0143976 erstetzen errechnetes Alter durch Mitarbeiter Alter direkt aus Quelle

-- nfis0811 - 181228: TEST1275372 Änderung Logik zur Ermittlung der funktionsaenderung_id

-- #AP0003387 20161019 kkai0912 errechnetes Alter zum Monatsende

-- nfis0811 - 180525: Änderung Defintion Austrittsdatum - NSR0188185

-- Awol2209 140723: Anpassung von untermonatlich_fg

-- nfis0811 - 180416: Hinzufügen von  betriebszugehoerigkeit_bereinigt_in_tagen

-- #AP0003387 erneute Anpassung Logik vertragsende_fg - sschuecke 17.03.2016

-- cbru1709 - 200312 SPEC0054818 Self-CROSS JOIN mit mitarbeiterbew_1 wegen Änderung Fluktuation VM

-- #AP0003387 Berechnung untermonatlich_azubi_fg - sschuecke 25.02.2016

-- cbru1709 - 200109:SPEC0064192 Nochmalige Änderung in der Berechung der BZG; Behandlung wenn Austritt und Wiedereintritt im gleichen Monat_1

-- KKai0912 140507 ma_status_id = 0 und soll_kalendertage <> ist, untermonatlich_aushilfe_fg

-- #AP0003387 Anpassung Logik vertragsende_fg - sschuecke 12.02.2016

-- #AP0003387 20161026 kkai0912 errechnete Betriebszugehörigkeit zum Monatsende

-- nfis0811 - 180424: Einbau Durschnittsalter zum Stichtag/Austrittsdatum in Jahren

-- #AP0025469 SPEC0033380 20180202 mmzy2302  Erweiterung um entsprechende IDs für Mitarbeiter-Gruppe_1, Mitarbeiter-Kreis, Kostenstelle etc.

-- #AP0003387 20160919 kkai0912 Definitionsänderung bei Betriebszugehoerigkeit_sort (0 Jahre ist nun 0, 1 = 1, Rest bleibt unverändert)

-- KKai0912 140122 Kalendertage als Vergleichswert hinzugefügt

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_mitarbeiterbew_1 AS -- eklosiewicz NSR4698897
 SELECT V01.mandant_id
 ,
 V01.mitarbeiter_id,
 V01.kjmo,
 V01.kjmo_vm,
 V01.mitarbeiter_gruppe_id,
 V01.mitarbeiter_kreis_id,
 V01.kostenstelle_id,
 V01.abwesenheit_tage,
 V01.soll_stunden_monat,
 V01.abr_stunden_monat,
 V01.langzeit_abwesend_fg,
 V01.langzeit_abwesend_fg_vm,
 V01.neu_mitarbeiter_fg,
 V01.krank_tage,
 V01.teilzeit_fg,
 V01.hr_objekt_id,
 V01.ma_status_id,
 V01.ma_status_id_vm,
 V01.geschlecht_id,
 V01.tarifgebiet_id,
 V01.shr_ma_funktion_id,
 V01.kostenstelle_ebene4_id,
 V01.shr_ma_funktion_id_2,
 V01.shr_ma_funktion_id_funktion,
 V01.shr_ma_hierarchiestufe_funktion,
 V01.shr_ma_fach_fuer_ebene,
 V01.shr_ma_funktionsaenderung1,
 V01.shr_ma_funktionsaenderung2,
 V01.shr_ma_funktionaenderung_id,
 V01.tarifart_id,
 V01.unternehmens_bereich_id,
 V01.gehalts_region_id,
 V01.haus_kategorie_id,
 V01.haupt_mitarbeiter_id,
 V01.soll_kalender_tage,
 V01.resturlaub_vj,
 V01.resturlaub_akt_kj,
 V01.anspruch_urlaub_akt_kj,
 V01.genommen_urlaub,
 V01.langzeit_krank_fg,
 V01.mutterschutz_fg,
 V01.beschaeftigungs_verbot_fg,
 V01.aushilfe_fg,
 V01.elternzeit_fg,
 V01.grundwehrdienst_fg,
 V01.atz_kz,
 V01.freigestellt_fg,
 V01.impatriates_fg,
 V01.externe_fg,
 V01.azubi_fg,
 V01.untermonatlich_azubi_fg,
 V01.ma_eintritt_kz,
 V01.ma_austritt_kz,
 V01.fluktuation_kz,
 V01.def_vollzeit_stunden,
 V01.kalendertage,
 V01.ki_fg,
 V01.untermonatlich_fg,
 V01.inventur_aushilfe_fg,
 V01.tip_austraeger_fg,
 V01.tip_kontrolleur_fg,
 V01.tip_gebietsbetreuer_fg,
 V01.diplomand_praktikant_fg,
 V01.praktikant_o_entgeld_fg,
 V01.expatriates_fg,
 V01.hinterbliebene_fg,
 V01.versorgungsbezieher_fg,
 V01.neumitarbeiter_ohne_azubi_fg,
 V01.org_gruppierung_,
 V01.abwesenheit_arbeitstage,
 V01.soll_arbeitstage,
 V01.arbeitszeit_anteil,
 V01.arbeitszeit_anteil_hr,
 V01.abwesenheit_arbeitstage_bez,
 V01.abwesenheit_arbeitstage_unbez,
 V01.arb_stunden_tag,
 V01.wiedereintritt_monatlich,
 V01.geburtsdatum,
 V01.geburtsjahr,
 V01.mitarbeiter_alter,
 V01.unter30,
 V01.zwischen30u50,
 V01.ueber50,
 V01.stichtag,
 V01.betriebszugehoerigkeit,
 V01.betriebszugehoerigkeit_anzeige,
 V01.betriebszugehoerigkeit_bereinigt,
 V01.betriebszugehoerigkeit_bereinigt_in_tagen,
 V01.betriebszugehoerigkeit_cluster_sort_id,
 V01.betriebszugehoerigkeit_sort,
 V01.betriebszugehoerigkeit_cluster_jahre,
 V01.betriebszugehoerigkeit_cluster_jahre_sort,
 V01.nationalitaet,
 V01.err_dat,
 V01.vertragsende,
 V01.anz_mon_vertragsende,
 V01.krank_tage_arbeitstage,
 V01.anz_arbeits_unfall,
 V01.sonstige_abwesenheit_fg,
 V01.pflege_fg,
 V01.krankheit_unfall_fg,
 V01.langzeit_abwesenheit_tage,
 V01.langzeit_abwesenheit_tage_kum,
 V01.langzeit_min_dat,
 V01.langzeit_abwesenheit_grund,
 V01.stichtag_fg,
 V01.dat_letzte_abwesenheit,
 V01.austrittsdatum,
 V01.eintrittsdatum,
 V01.austritt_alles_fg,
 V01.austritt_919899_fg,
  CASE
  WHEN v02.mitarbeiter_id IS NOT NULL
  THEN v02.anzahl_lohnart
  ELSE 0
  END AS aushilfe_cz_sk_stunden,
 V01.azubi_cz_sk_hr_stunden,
 V01.arbeitsunfall_fg,
 V01.arbeitsunfall_folgeabw_fg,
 V01.arbeitsunfall_anzahl
FROM kfl_production_dbp_msi_view_shr.tbl_mv_mitarbeiterbew_1 AS V01
 LEFT JOIN (SELECT mandant_id,
   mitarbeiter_id,
   kjmo,
   SUM(anzahl_lohnart) AS anzahl_lohnart
  FROM kfl_production_dbp_view.v_ma_kostenstelle_lohnart_zu_per_1 AS V096
  WHERE mandant_id = 2 AND lohnart_id IN ('3001', '3004')
   OR mandant_id = 5 AND lohnart_id IN ('3001')
   OR mandant_id = 6 AND lohnart_id IN ('1035')
  GROUP BY mandant_id,
   mitarbeiter_id,
   kjmo) AS v02 ON V01.mitarbeiter_id = v02.mitarbeiter_id AND V01.mandant_id = v02.mandant_id AND V01.kjmo = v02.kjmo;