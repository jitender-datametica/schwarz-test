--==============================================================
-- Table: coi_ump_umsatzplan_hwg
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_umsatzplan_hwg
   generated from Powerdesigner on Mittwoch, 12. Februar 2025 11:34:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COI_UMP_UMSATZPLAN_HWG CLUSTER BY (
     MANDANT_ID,
     GJ_PLAN,
     VERSION_ID 
) (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   gj_plan                             NUMBER(38,0)     NOT NULL COMMENT 'Plangeschäftsjahr, Format JJJJ. GJ, das geplant werden soll (s. Dateiname), z.B. 2022.',
   version_id                          NUMBER(38,0)     NOT NULL COMMENT 'Die Version des Plans im Geschäftsjahr (1-9).',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Der "WUP" beinhaltet Märkte und Lager. WUP = WarenUmschlagsPlatz. Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum. Aus in SAP (Feld WERKS).',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   dat_plan                            DATE             NOT NULL COMMENT 'Datum des Plantags für das GJ auf Land-Level (im Format JJJJ-MM-TT).',
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel-Hierarchie-Typ-ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen handelt.',
   hwg_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Hauptwarengruppe.',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   land_level                          VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Landeskategorisierung (1-3 Stellen), z.B HRK für Kroatien Küste und HRL für Kroatien Land.',
   vs_id                               NUMBER(38,0)     COMMENT 'ID der Vertriebsschiene.',
   wup_id_referenz                     NUMBER(38,0)     COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum. Gibt auch die Möglichkeit, eine andere Filiale als Basis (für IST-Umsätze) zu verwenden. Bei Expansionen MUSS, alle anderen Filialen KANN.',
   dat_referenz                        DATE             COMMENT 'Datum des Referenztages des Vorjahres zum Plantag (im Format JJJJ-MM-TT) auf Ebene Land-Level.',
   faktor_kalender                     NUMBER(14,10)    NOT NULL COMMENT 'Korrekturfaktor für den Referenztag der Umsatzplanung (Auf- / Abschlag zum dat_referenz) falls der Referenztag höheren oder geringeren Umsatz hat. Faktor = Abweichung in %, z.B. +2,5% zum Referenztag oder +/- 0 = keine Anpassung. Spielt eine Rolle bei Kalenderverschiebungen, wenn z.B.vom Fachbereich der 01.03.2020 geplant wird, dann steht 28.02.2019 als Basis fest.',
   faktor_basis                        NUMBER(14,10)    NOT NULL COMMENT 'Faktor für den Basiswert (Filiale/Referenzfilial-Wert). Entsprechend kalender_faktor, aber Eingabe in Landeswährung.',
   faktor_wup_referenz                 NUMBER(14,10)    NOT NULL COMMENT 'Faktor (aus Upload-Excel) für Referenzfiliale (falls Filiale aus wup_id für einen Zeitraum geschlossen ist). Prozentwert zwischen -100% und +1000% zur Ermittlung des richtigen Werts (absolute Höhe).',
   umsatz_netto_basis_1                NUMBER(38,4)     COMMENT 'Der IST-Umsatz-Wert (ohne Mwst) der 1.Stufe der Gesamtkalkulation. Umsätze des aktuellen GJ ggf. aufgefüllt mit Planwerten basierend auf dem VJ. Netto-Umsatzwert: Umsatz Basis 0 + Anpassung über das VJ.',
   umsatz_netto_basis_2                NUMBER(38,4)     COMMENT 'Der IST Umsatz-Wert (ohne Mwst) der 2.Stufe der Gesamtkalkulation. Gebildet aus umsatz_netto_basis_1 und dem Referenzwert (aus Spalte faktor_wup_referenz der Tabelle coi_ump_umsatzplan_hwg_calc). Formel: umsatz_netto_basis_1 * (1 + faktor_wup_referenz).',
   umsatz_netto_basis_3                NUMBER(38,4)     COMMENT 'Der IST Umsatz-Wert (ohne Mwst) der 3.Stufe der Gesamtkalkulation. Bildung umsatz_netto_basis_2 und dem Referenzwert (aus Spalte faktor_kalender der Tabelle coi_ump_umsatzplan_hwg_calc). Formel: umsatz_netto_basis_2 * (1 + faktor_kalender).',
   umsatz_netto_plan                   NUMBER(38,4)     COMMENT 'Der PLAN Umsatz-Wert (ohne Mwst) für das Folge-Geschäftsjahr der letzten Stufe der Gesamtkalkulation. Formel: umsatz_netto_basis_3 * (1 + faktor_massnahme_ges), faktor_massnahme_ges = Immo-Faktor + Filial-Faktor + EK-Faktor + Immo-Wert + Filial-Wert + EK-Wert.',
   wup_geoeffnet_fg                    NUMBER(38,0)     NOT NULL DEFAULT 1 COMMENT 'Ist die Filiale an diesem Plantag geöffnet (keine Betriebsunterbrechung lt. Immo-Massnahmen), dann wird das Flag auf 1 gesetzt, ansonsten 0.',
   umsatz_netto_plan_vj                NUMBER(38,4)     COMMENT 'Vorjahreswert der Umsatzplanung, Wochentagsgenau. Ist bei fehlenden IST-Umsätzen die Basis für die Planung des Folgejahres.',
   umsatz_netto_plan_vj_kt             NUMBER(38,4)     COMMENT 'Vorjahreswert der Umsatzplanung, Kalendertagsgenau. Ist bei fehlenden IST-Umsätzen die Basis für die Planung des Folgejahres.',
   umsatz_basis_vj                     NUMBER(38,4)     COMMENT 'Ist der IST-Umsatz oder der Planumsatz des VJ der Filiale (unabhängig ob es eine Referenzfiliale gibt), Wochentagsgenau.',
   umsatz_basis_vj_kt                  NUMBER(38,4)     COMMENT 'Ist der IST-Umsatz oder der Planumsatz des VJ der Filiale (unabhängig ob es eine Referenzfiliale gibt), Kalendertagsgenau.',
   umsatz_basis_vvj                    NUMBER(38,4)     COMMENT 'Bildet die Umsatzbasis zur Berechnung der Kalender- und Referenzeffekte des Vorvorjahres ab (Corona-bedingte Anforderung).',
   umsatz_basis_vvj_kt                 NUMBER(38,4)     COMMENT 'Bildet die Umsatzbasis zur Berechnung der Kalender und Referenzeffekte des Vorvorjahres-Kalendertags ab (Corona-bedingte Anforderung).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COI_UMP_UMSATZPLAN_HWG PRIMARY KEY (mandant_id, gj_plan, version_id, wup_id, nb_id, dat_plan, arthiertyp_id, hwg_id) NOT ENFORCED
)  COMMENT = 'WWC - COI Umsatzplanung - Planumsaetze (Kennzahlen berechnen sich aus coi_ump_umsatzplan_massnahmen_zu) auf Level Filiale / Hauptwarengruppe / Tag - Planversion abhaengig (mehrere Maßnahmen pro Tag koennen sich auf Umsatz auswirken).';
