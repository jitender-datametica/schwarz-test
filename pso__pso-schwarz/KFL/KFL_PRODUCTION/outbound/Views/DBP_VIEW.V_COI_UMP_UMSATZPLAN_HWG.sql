CREATE OR REPLACE VIEW kfl_production_dbp_view.v_coi_ump_umsatzplan_hwg (mandant_id
OPTIONS(description='Mandant im DWH.'), gj_plan
OPTIONS(description='Plangeschäftsjahr, Format JJJJ. GJ, das geplant werden soll (s. Dateiname), z.B. 2022.'),
version_id OPTIONS(description='Die Version des Plans im Geschäftsjahr (1-9).'), wup_id
OPTIONS(description='Der "WUP" beinhaltet Märkte und Lager. WUP = WarenUmschlagsPlatz. Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum. Aus in SAP (Feld WERKS).'),
nb_id OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), dat_plan
OPTIONS(description='Datum des Plantags für das GJ auf Land-Level (im Format JJJJ-MM-TT).'), arthiertyp_id
OPTIONS(description='Artikel-Hierarchie-Typ-ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen handelt.'),
hwg_id OPTIONS(description='ID der Hauptwarengruppe.'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'), land_level
OPTIONS(description='Landeskategorisierung (1-3 Stellen), z.B HRK für Kroatien Küste und HRL für Kroatien Land.'), vs_id
OPTIONS(description='ID der Vertriebsschiene.'), wup_id_referenz
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum. Gibt auch die Möglichkeit, eine andere Filiale als Basis (für IST-Umsätze) zu verwenden. Bei Expansionen MUSS, alle anderen Filialen KANN.'),
dat_referenz
OPTIONS(description='Datum des Referenztages des Vorjahres zum Plantag (im Format JJJJ-MM-TT) auf Ebene Land-Level.'),
faktor_kalender
OPTIONS(description='Korrekturfaktor für den Referenztag der Umsatzplanung (Auf- / Abschlag zum dat_referenz) falls der Referenztag höheren oder geringeren Umsatz hat. Faktor = Abweichung in %, z.B. +2,5% zum Referenztag oder +/- 0 = keine Anpassung. Spielt eine Rolle bei Kalenderverschiebungen, wenn z.B.vom Fachbereich der 01.03.2020 geplant wird, dann steht 28.02.2019 als Basis fest.'),
faktor_basis
OPTIONS(description='Faktor für den Basiswert (Filiale/Referenzfilial-Wert). Entsprechend kalender_faktor, aber Eingabe in Landeswährung.'),
faktor_wup_referenz
OPTIONS(description='Faktor (aus Upload-Excel) für Referenzfiliale (falls Filiale aus wup_id für einen Zeitraum geschlossen ist). Prozentwert zwischen -100% und +1000% zur Ermittlung des richtigen Werts (absolute Höhe).'),
umsatz_netto_basis_1
OPTIONS(description='Der IST-Umsatz-Wert (ohne Mwst) der 1.Stufe der Gesamtkalkulation. Umsätze des aktuellen GJ ggf. aufgefüllt mit Planwerten basierend auf dem VJ. Netto-Umsatzwert: Umsatz Basis 0 + Anpassung über das VJ.'),
umsatz_netto_basis_2
OPTIONS(description='Der IST Umsatz-Wert (ohne Mwst) der 2.Stufe der Gesamtkalkulation. Gebildet aus umsatz_netto_basis_1 und dem Referenzwert (aus Spalte faktor_wup_referenz der Tabelle coi_ump_umsatzplan_hwg_calc). Formel: umsatz_netto_basis_1 * (1 + faktor_wup_referenz).'),
umsatz_netto_basis_3
OPTIONS(description='Der IST Umsatz-Wert (ohne Mwst) der 3.Stufe der Gesamtkalkulation. Bildung umsatz_netto_basis_2 und dem Referenzwert (aus Spalte faktor_kalender der Tabelle coi_ump_umsatzplan_hwg_calc). Formel: umsatz_netto_basis_2 * (1 + faktor_kalender).'),
umsatz_netto_plan
OPTIONS(description='Der PLAN Umsatz-Wert (ohne Mwst) für das Folge-Geschäftsjahr der letzten Stufe der Gesamtkalkulation. Formel: umsatz_netto_basis_3 * (1 + faktor_massnahme_ges), faktor_massnahme_ges = Immo-Faktor + Filial-Faktor + EK-Faktor + Immo-Wert + Filial-Wert + EK-Wert.'),
wup_geoeffnet_fg
OPTIONS(description='Ist die Filiale an diesem Plantag geöffnet (keine Betriebsunterbrechung lt. Immo-Massnahmen), dann wird das Flag auf 1 gesetzt, ansonsten 0.'),
umsatz_netto_plan_vj
OPTIONS(description='Vorjahreswert der Umsatzplanung, Wochentagsgenau. Ist bei fehlenden IST-Umsätzen die Basis für die Planung des Folgejahres.'),
umsatz_netto_plan_vj_kt
OPTIONS(description='Vorjahreswert der Umsatzplanung, Kalendertagsgenau. Ist bei fehlenden IST-Umsätzen die Basis für die Planung des Folgejahres.'),
umsatz_basis_vj
OPTIONS(description='Ist der IST-Umsatz oder der Planumsatz des VJ der Filiale (unabhängig ob es eine Referenzfiliale gibt), Wochentagsgenau.'),
umsatz_basis_vj_kt
OPTIONS(description='Ist der IST-Umsatz oder der Planumsatz des VJ der Filiale (unabhängig ob es eine Referenzfiliale gibt), Kalendertagsgenau.'),
umsatz_basis_vvj
OPTIONS(description='Bildet die Umsatzbasis zur Berechnung der Kalender- und Referenzeffekte des Vorvorjahres ab (Corona-bedingte Anforderung).'),
umsatz_basis_vvj_kt
OPTIONS(description='Bildet die Umsatzbasis zur Berechnung der Kalender und Referenzeffekte des Vorvorjahres-Kalendertags ab (Corona-bedingte Anforderung).'))
OPTIONS(DESCRIPTION = `WWC - COI UMSATZPLANUNG - PLANUMSAETZE (KENNZAHLEN BERECHNEN SICH AUS COI_UMP_UMSATZPLAN_MASSNAHMEN_ZU) AUF LEVEL FILIALE / HAUPTWARENGRUPPE / TAG - PLANVERSION ABHAENGIG (MEHRERE MASSNAHMEN PRO TAG KOENNEN SICH AUF UMSATZ AUSWIRKEN).`)
AS SELECT mandant_id,
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
FROM kfl_production_dbp_data.coi_ump_umsatzplan_hwg;