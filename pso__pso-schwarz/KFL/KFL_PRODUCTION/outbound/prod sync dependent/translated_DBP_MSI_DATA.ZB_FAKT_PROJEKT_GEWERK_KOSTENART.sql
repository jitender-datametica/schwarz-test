CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.zb_fakt_projekt_gewerk_kostenart (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
buchung_typ_cd STRING(20) NOT NULL
OPTIONS(description='Code gibt an ob es sich um eine Buchung zu einer Bestellung (B), eine Buchung zum Vertrag (V) oder um eine Buchung ohne Bestellung und Vertrag (O) handelt.'),
krk_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='globale ID des Kostenrechnungskreises'),
kostenart_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschluessel fuer die Kostenarten'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
wrg_typ_id INTEGER NOT NULL
OPTIONS(description='ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_buchung NUMERIC(29,5)
OPTIONS(description='Betrag der Buchungen der Rechnungen auf Ebene Projekt,Gewerk und Kostenart'),
betrag_rueckstellung NUMERIC(29,5)
OPTIONS(description='Betrag der als Rückstellungen identifizierte Buchungen auf Ebene Projekt Gewerk und Kostenart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, gewerk_id, buchung_typ_cd, gp_id, wrg_typ_id) NOT ENFORCED
)
OPTIONS(description='Faktentabelle auf Ebene Projekt, Gewerk, Warengruppe und Kostenart  für Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich nicht einer Bestellung oder einem Vertrag zuordnen lassen.');