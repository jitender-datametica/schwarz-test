--==============================================================
-- Table: coi_ump_umsatzplan_hwg_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_umsatzplan_hwg_1
   generated from Powerdesigner on Mittwoch, 12. Februar 2025 11:34:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.coi_ump_umsatzplan_hwg_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
gj_plan BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Plangeschäftsjahr, Format JJJJ. GJ, das geplant werden soll (s. Dateiname), z.B. 2022.'),
version_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Die Version des Plans im Geschäftsjahr (1-9).'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der "WUP_1" beinhaltet Märkte und Lager. WUP_1 = WarenUmschlagsPlatz. Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum. Aus in SAP (Feld WERKS).'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
dat_plan DATE NOT NULL OPTIONS(description='Datum des Plantags für das GJ auf Land_1-Level (im Format JJJJ-MM_1-TT).'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1-Hierarchie-Typ-ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen handelt.'),
hwg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Hauptwarengruppe.'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
land_level STRING(3) COLLATE 'und:ci'
OPTIONS(description='Landeskategorisierung (1-3 Stellen), z.B HRK für Kroatien Küste und HRL für Kroatien Land.'),
vs_id BIGNUMERIC(38,0) OPTIONS(description='ID der Vertriebsschiene.'),
wup_id_referenz BIGNUMERIC(38,0)
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum. Gibt auch die Möglichkeit, eine_1 andere Filiale als Basis (für IST-Umsätze) zu verwenden. Bei Expansionen MUSS, alle anderen Filialen KANN.'),
dat_referenz DATE
OPTIONS(description='Datum des Referenztages des Vorjahres zum Plantag (im Format JJJJ-MM_1-TT) auf Ebene Land_1-Level.'),
faktor_kalender BIGNUMERIC(14,10) NOT NULL
OPTIONS(description='Korrekturfaktor für den Referenztag der Umsatzplanung (Auf- / Abschlag zum dat_referenz) falls der Referenztag höheren oder geringeren Umsatz hat. Faktor = Abweichung in %, z.B. +2,5% zum Referenztag oder +/- 0 = keine Anpassung. Spielt eine_1 Rolle bei Kalenderverschiebungen, wenn z.B.vom Fachbereich der 01.03.2020 geplant wird, dann steht 28.02.2019 als Basis fest.'),
faktor_basis BIGNUMERIC(14,10) NOT NULL
OPTIONS(description='Faktor für den Basiswert (Filiale/Referenzfilial-Wert). Entsprechend kalender_faktor, aber Eingabe in Landeswährung.'),
faktor_wup_referenz BIGNUMERIC(14,10) NOT NULL
OPTIONS(description='Faktor (aus Upload-Excel) für Referenzfiliale (falls Filiale aus wup_id für einen Zeitraum geschlossen ist). Prozentwert zwischen -100% und +1000% zur Ermittlung des richtigen Werts (absolute Höhe).'),
umsatz_netto_basis_1 BIGNUMERIC(38,4)
OPTIONS(description='Der IST-Umsatz-Wert (ohne Mwst) der 1.Stufe der Gesamtkalkulation. Umsätze des aktuellen GJ ggf. aufgefüllt mit Planwerten basierend auf dem VJ. Netto-Umsatzwert: Umsatz Basis 0 + Anpassung über das VJ.'),
umsatz_netto_basis_2 BIGNUMERIC(38,4)
OPTIONS(description='Der IST Umsatz-Wert (ohne Mwst) der 2.Stufe der Gesamtkalkulation. Gebildet aus umsatz_netto_basis_1 und dem Referenzwert (aus Spalte faktor_wup_referenz der Tabelle coi_ump_umsatzplan_hwg_calc). Formel: umsatz_netto_basis_1 * (1 + faktor_wup_referenz).'),
umsatz_netto_basis_3 BIGNUMERIC(38,4)
OPTIONS(description='Der IST Umsatz-Wert (ohne Mwst) der 3.Stufe der Gesamtkalkulation. Bildung umsatz_netto_basis_2 und dem Referenzwert (aus Spalte faktor_kalender der Tabelle coi_ump_umsatzplan_hwg_calc). Formel: umsatz_netto_basis_2 * (1 + faktor_kalender).'),
umsatz_netto_plan BIGNUMERIC(38,4)
OPTIONS(description='Der PLAN Umsatz-Wert (ohne Mwst) für das Folge-Geschäftsjahr der letzten Stufe der Gesamtkalkulation. Formel: umsatz_netto_basis_3 * (1 + faktor_massnahme_ges), faktor_massnahme_ges = Immo-Faktor + Filial-Faktor + EK-Faktor + Immo-Wert + Filial-Wert + EK-Wert.'),
wup_geoeffnet_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
OPTIONS(description='Ist die Filiale an diesem Plantag geöffnet (keine Betriebsunterbrechung lt. Immo-Massnahmen), dann wird das Flag auf 1 gesetzt, ansonsten 0.'),
umsatz_netto_plan_vj BIGNUMERIC(38,4)
OPTIONS(description='Vorjahreswert der Umsatzplanung, Wochentagsgenau. Ist bei fehlenden IST-Umsätzen die Basis für die Planung des Folgejahres.'),
umsatz_netto_plan_vj_kt BIGNUMERIC(38,4)
OPTIONS(description='Vorjahreswert der Umsatzplanung, Kalendertagsgenau. Ist bei fehlenden IST-Umsätzen die Basis für die Planung des Folgejahres.'),
umsatz_basis_vj BIGNUMERIC(38,4)
OPTIONS(description='Ist der IST-Umsatz oder der Planumsatz des VJ der Filiale (unabhängig ob es eine_1 Referenzfiliale gibt), Wochentagsgenau.'),
umsatz_basis_vj_kt BIGNUMERIC(38,4)
OPTIONS(description='Ist der IST-Umsatz oder der Planumsatz des VJ der Filiale (unabhängig ob es eine_1 Referenzfiliale gibt), Kalendertagsgenau.'),
umsatz_basis_vvj BIGNUMERIC(38,4)
OPTIONS(description='Bildet die Umsatzbasis zur Berechnung der Kalender- und Referenzeffekte des Vorvorjahres ab (Corona-bedingte Anforderung).'),
umsatz_basis_vvj_kt BIGNUMERIC(38,4)
OPTIONS(description='Bildet die Umsatzbasis zur Berechnung der Kalender und Referenzeffekte des Vorvorjahres-Kalendertags ab (Corona-bedingte Anforderung).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gj_plan, version_id, wup_id, nb_id, dat_plan, arthiertyp_id, hwg_id) NOT ENFORCED
) CLUSTER BY mandant_id, gj_plan, version_id
OPTIONS(description='WWC - COI Umsatzplanung - Planumsaetze (Kennzahlen berechnen sich aus coi_ump_umsatzplan_massnahmen_zu_1) auf Level Filiale / Hauptwarengruppe / Tag_1 - Planversion abhaengig (mehrere Maßnahmen pro Tag_1 koennen sich auf Umsatz auswirken).');