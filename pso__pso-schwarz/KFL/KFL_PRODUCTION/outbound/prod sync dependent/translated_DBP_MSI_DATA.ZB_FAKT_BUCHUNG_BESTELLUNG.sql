CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.zb_fakt_buchung_bestellung (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
warengruppe_cd STRING(20) NOT NULL OPTIONS(description='Code der Warengruppe'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
wrg_typ_id INTEGER NOT NULL
OPTIONS(description='ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_bestellung_netto NUMERIC(29,5) OPTIONS(description='Betrag Netto der Bestellungen auf Ebene Projekt und Gewerk'),
betrag_bestellung_nachtrag_netto NUMERIC(29,5)
OPTIONS(description='Betrag Netto der Nachträge bei  Bestellungen auf Ebene Projekt und Gewerk'),
betrag_obligo NUMERIC(29,5) OPTIONS(description='Betrag des Obligos auf Ebene Projekt und Gewerk.'),
betrag_buchung NUMERIC(29,5) OPTIONS(description='Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk'),
betrag_kostenprognose NUMERIC(29,5) OPTIONS(description='Betrag der Kostenprognose in Landeswährung'),
betrag_zek NUMERIC(29,5)
OPTIONS(description='Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)'),
betrag_zea NUMERIC(29,5)
OPTIONS(description='Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, gewerk_id, warengruppe_cd, gp_id, wrg_typ_id) NOT ENFORCED
)
OPTIONS(description='Faktentabelle für Buchungen die einer Bestellung zugeordnet werden können auf Ebene Projekt, Gewerk, Warengruppe, Lieferant.');