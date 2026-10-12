CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.zb_fakt_projekt_gewerk_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL OPTIONS(description='ID eines Gewerks , z.Bsp 3 = Baukosten'),
wrg_typ_id INTEGER NOT NULL
OPTIONS(description='ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_kostenprognose NUMERIC(29,5)
OPTIONS(description='Betrag der der aktuellen Kostenprognose auf Ebene Projekt und Gewerk.'),
betrag_zek NUMERIC(29,5)
OPTIONS(description='Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)'),
betrag_zea NUMERIC(29,5)
OPTIONS(description='Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)'),
betrag_aktuelles_budget NUMERIC(29,5) OPTIONS(description='Betrag des aktuellen Budgets auf Ebene Projekt und Gewerk.'),
betrag_objektfreigabe_budget NUMERIC(29,5)
OPTIONS(description='Betrag des Budgets zum Zeitpunkt der Projektfreigabe auf Ebene Projekt und Gewerk.'),
betrag_vertrag NUMERIC(29,5) OPTIONS(description='Betrag der Vertragswerte auf Ebene Projekt und Gewerk'),
betrag_bestellung_netto NUMERIC(29,5) OPTIONS(description='Betrag Netto der Bestellungen auf Ebene Projekt und Gewerk'),
betrag_bestellung_nachtrag_netto NUMERIC(29,5)
OPTIONS(description='Betrag Netto der Nachträge bei  Bestellungen auf Ebene Projekt und Gewerk'),
betrag_obligo NUMERIC(29,5) OPTIONS(description='Betrag des Obligos auf Ebene Projekt und Gewerk.'),
betrag_buchung NUMERIC(29,5)
OPTIONS(description='Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk (Kosten Typ CD =\'K\' in dbp_data.zb_projekt_ist_kosten_1)'),
betrag_baukostenzuschuss NUMERIC(29,5)
OPTIONS(description='Betrag der Baukostenzuschuesse auf Ebene Projekt und Gewerk (Kosten Typ CD =\'B\' in dbp_data.zb_projekt_ist_kosten_1)'),
betrag_foerderung NUMERIC(29,5)
OPTIONS(description='Betrag der Foerderungen auf Ebene Projekt und Gewerk (Kosten Typ CD =\'F\' in dbp_data.zb_projekt_ist_kosten_1)'),
betrag_rueckstellung NUMERIC(29,5)
OPTIONS(description='Betrag der Rückstellungen auf Ebene Projekt und Gewerk (Kosten Typ CD =\'R\' in dbp_data.zb_projekt_ist_kosten_1)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, gewerk_id, wrg_typ_id) NOT ENFORCED
) OPTIONS(description='Faktentabelle auf Ebene Projekt und Gewerk für Projektdaten aus den Zentralbereichen');