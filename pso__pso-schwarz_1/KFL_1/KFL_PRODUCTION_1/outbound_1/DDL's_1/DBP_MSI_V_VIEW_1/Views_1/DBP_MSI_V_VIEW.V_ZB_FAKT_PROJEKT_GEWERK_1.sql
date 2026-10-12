CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_zb_fakt_projekt_gewerk_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id OPTIONS(description='ID eines Gewerks , z.Bsp 3 = Baukosten'), wrg_typ_id
OPTIONS(description='ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_kostenprognose
OPTIONS(description='Betrag der der aktuellen Kostenprognose auf Ebene Projekt und Gewerk.'), betrag_zek
OPTIONS(description='Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)'),
betrag_zea
OPTIONS(description='Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)'),
betrag_aktuelles_budget OPTIONS(description='Betrag des aktuellen Budgets auf Ebene Projekt und Gewerk.'),
betrag_objektfreigabe_budget
OPTIONS(description='Betrag des Budgets zum Zeitpunkt der Projektfreigabe auf Ebene Projekt und Gewerk.'),
betrag_vertrag OPTIONS(description='Betrag der Vertragswerte auf Ebene Projekt und Gewerk'), betrag_bestellung_netto
OPTIONS(description='Betrag Netto der Bestellungen auf Ebene Projekt und Gewerk'), betrag_bestellung_nachtrag_netto
OPTIONS(description='Betrag Netto der Nachträge bei  Bestellungen auf Ebene Projekt und Gewerk'), betrag_obligo
OPTIONS(description='Betrag des Obligos auf Ebene Projekt und Gewerk.'), betrag_buchung
OPTIONS(description='Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk (Kosten Typ CD =\'K\' in dbp_data.zb_projekt_ist_kosten_1)'),
betrag_baukostenzuschuss
OPTIONS(description='Betrag der Baukostenzuschuesse auf Ebene Projekt und Gewerk (Kosten Typ CD =\'B\' in dbp_data.zb_projekt_ist_kosten_1)'),
betrag_foerderung
OPTIONS(description='Betrag der Foerderungen auf Ebene Projekt und Gewerk (Kosten Typ CD =\'F\' in dbp_data.zb_projekt_ist_kosten_1)'),
betrag_rueckstellung
OPTIONS(description='Betrag der Rückstellungen auf Ebene Projekt und Gewerk (Kosten Typ CD =\'R\' in dbp_data.zb_projekt_ist_kosten_1)'))
OPTIONS(DESCRIPTION = `Faktentabelle auf Ebene Projekt und Gewerk für Projektdaten aus den Zentralbereichen`) AS SELECT
 mandant_id,
 projekt_nr,
 gewerk_id,
 wrg_typ_id,
 wrg_id,
 betrag_kostenprognose,
 betrag_zek,
 betrag_zea,
 betrag_aktuelles_budget,
 betrag_objektfreigabe_budget,
 betrag_vertrag,
 betrag_bestellung_netto,
 betrag_bestellung_nachtrag_netto,
 betrag_obligo,
 betrag_buchung,
 betrag_baukostenzuschuss,
 betrag_foerderung,
 betrag_rueckstellung
FROM kfl_production_dbp_msi_data.zb_fakt_projekt_gewerk_1;