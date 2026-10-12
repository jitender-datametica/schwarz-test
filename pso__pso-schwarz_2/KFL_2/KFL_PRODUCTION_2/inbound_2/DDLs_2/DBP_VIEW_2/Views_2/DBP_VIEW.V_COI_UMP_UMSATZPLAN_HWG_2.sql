CREATE OR REPLACE VIEW DBP_VIEW.V_COI_UMP_UMSATZPLAN_HWG_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,gj_plan                                  COMMENT 'Plangeschäftsjahr, Format JJJJ. GJ, das geplant werden soll (s. Dateiname), z.B. 2022.'
  ,version_id                               COMMENT 'Die Version des Plans im Geschäftsjahr (1-9).'
  ,wup_id                                   COMMENT 'Der "WUP_2" beinhaltet Märkte und Lager. WUP_2 = WarenUmschlagsPlatz. Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum. Aus in SAP (Feld WERKS).'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'
  ,dat_plan                                 COMMENT 'Datum des Plantags für das GJ auf Land_2-Level (im Format JJJJ-MM_2-TT).'
  ,arthiertyp_id                            COMMENT 'Artikel_2-Hierarchie-Typ-ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen handelt.'
  ,hwg_id                                   COMMENT 'ID der Hauptwarengruppe.'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'
  ,land_level                               COMMENT 'Landeskategorisierung (1-3 Stellen), z.B HRK für Kroatien Küste und HRL für Kroatien Land.'
  ,vs_id                                    COMMENT 'ID der Vertriebsschiene.'
  ,wup_id_referenz                          COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum. Gibt auch die Möglichkeit, eine_2 andere Filiale als Basis (für IST-Umsätze) zu verwenden. Bei Expansionen MUSS, alle anderen Filialen KANN.'
  ,dat_referenz                             COMMENT 'Datum des Referenztages des Vorjahres zum Plantag (im Format JJJJ-MM_2-TT) auf Ebene Land_2-Level.'
  ,faktor_kalender                          COMMENT 'Korrekturfaktor für den Referenztag der Umsatzplanung (Auf- / Abschlag zum dat_referenz) falls der Referenztag höheren oder geringeren Umsatz hat. Faktor = Abweichung in %, z.B. +2,5% zum Referenztag oder +/- 0 = keine Anpassung. Spielt eine_2 Rolle bei Kalenderverschiebungen, wenn z.B.vom Fachbereich der 01.03.2020 geplant wird, dann steht 28.02.2019 als Basis fest.'
  ,faktor_basis                             COMMENT 'Faktor für den Basiswert (Filiale/Referenzfilial-Wert). Entsprechend kalender_faktor, aber Eingabe in Landeswährung.'
  ,faktor_wup_referenz                      COMMENT 'Faktor (aus Upload-Excel) für Referenzfiliale (falls Filiale aus wup_id für einen Zeitraum geschlossen ist). Prozentwert zwischen -100% und +1000% zur Ermittlung des richtigen Werts (absolute Höhe).'
  ,umsatz_netto_basis_1                     COMMENT 'Der IST-Umsatz-Wert (ohne Mwst) der 1.Stufe der Gesamtkalkulation. Umsätze des aktuellen GJ ggf. aufgefüllt mit Planwerten basierend auf dem VJ. Netto-Umsatzwert: Umsatz Basis 0 + Anpassung über das VJ.'
  ,umsatz_netto_basis_2                     COMMENT 'Der IST Umsatz-Wert (ohne Mwst) der 2.Stufe der Gesamtkalkulation. Gebildet aus umsatz_netto_basis_1 und dem Referenzwert (aus Spalte faktor_wup_referenz der Tabelle coi_ump_umsatzplan_hwg_calc). Formel: umsatz_netto_basis_1 * (1 + faktor_wup_referenz).'
  ,umsatz_netto_basis_3                     COMMENT 'Der IST Umsatz-Wert (ohne Mwst) der 3.Stufe der Gesamtkalkulation. Bildung umsatz_netto_basis_2 und dem Referenzwert (aus Spalte faktor_kalender der Tabelle coi_ump_umsatzplan_hwg_calc). Formel: umsatz_netto_basis_2 * (1 + faktor_kalender).'
  ,umsatz_netto_plan                        COMMENT 'Der PLAN Umsatz-Wert (ohne Mwst) für das Folge-Geschäftsjahr der letzten Stufe der Gesamtkalkulation. Formel: umsatz_netto_basis_3 * (1 + faktor_massnahme_ges), faktor_massnahme_ges = Immo-Faktor + Filial-Faktor + EK-Faktor + Immo-Wert + Filial-Wert + EK-Wert.'
  ,wup_geoeffnet_fg                         COMMENT 'Ist die Filiale an diesem Plantag geöffnet (keine Betriebsunterbrechung lt. Immo-Massnahmen), dann wird das Flag auf 1 gesetzt, ansonsten 0.'
  ,umsatz_netto_plan_vj                     COMMENT 'Vorjahreswert der Umsatzplanung, Wochentagsgenau. Ist bei fehlenden IST-Umsätzen die Basis für die Planung des Folgejahres.'
  ,umsatz_netto_plan_vj_kt                  COMMENT 'Vorjahreswert der Umsatzplanung, Kalendertagsgenau. Ist bei fehlenden IST-Umsätzen die Basis für die Planung des Folgejahres.'
  ,umsatz_basis_vj                          COMMENT 'Ist der IST-Umsatz oder der Planumsatz des VJ der Filiale (unabhängig ob es eine_2 Referenzfiliale gibt), Wochentagsgenau.'
  ,umsatz_basis_vj_kt                       COMMENT 'Ist der IST-Umsatz oder der Planumsatz des VJ der Filiale (unabhängig ob es eine_2 Referenzfiliale gibt), Kalendertagsgenau.'
  ,umsatz_basis_vvj                         COMMENT 'Bildet die Umsatzbasis zur Berechnung der Kalender- und Referenzeffekte des Vorvorjahres ab (Corona-bedingte Anforderung).'
  ,umsatz_basis_vvj_kt                      COMMENT 'Bildet die Umsatzbasis zur Berechnung der Kalender und Referenzeffekte des Vorvorjahres-Kalendertags ab (Corona-bedingte Anforderung).'
)
COMMENT = 'WWC - COI Umsatzplanung - Planumsaetze (Kennzahlen berechnen sich aus coi_ump_umsatzplan_massnahmen_zu_2) auf Level Filiale / Hauptwarengruppe / Tag_2 - Planversion abhaengig (mehrere Maßnahmen pro Tag_2 koennen sich auf Umsatz auswirken).'
 AS 
    SELECT 
        mandant_id,
        gj_plan,
        version_id,
        wup_id,
        nb_id,
        dat_plan,
        arthiertyp_id,
        hwg_id,
        wrg_id,
        land_level,
        vs_id,
        wup_id_referenz,
        dat_referenz,
        faktor_kalender,
        faktor_basis,
        faktor_wup_referenz,
        umsatz_netto_basis_1,
        umsatz_netto_basis_2,
        umsatz_netto_basis_3,
        umsatz_netto_plan,
        wup_geoeffnet_fg,
        umsatz_netto_plan_vj,
        umsatz_netto_plan_vj_kt,
        umsatz_basis_vj,
        umsatz_basis_vj_kt,
        umsatz_basis_vvj,
        umsatz_basis_vvj_kt

FROM DBP_DATA.COI_UMP_UMSATZPLAN_HWG_2 ;