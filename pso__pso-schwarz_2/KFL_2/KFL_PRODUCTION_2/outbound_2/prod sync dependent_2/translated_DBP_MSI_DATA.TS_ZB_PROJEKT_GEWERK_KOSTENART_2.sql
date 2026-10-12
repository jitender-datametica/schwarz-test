CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_kostenart_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
buchung_typ_cd STRING(20) NOT NULL
OPTIONS(description='Code gibt an ob es sich um eine_2 Buchung zu einer Bestellung (B), eine_2 Buchung zum Vertrag (V) oder um eine_2 Buchung ohne Bestellung und Vertrag (O) handelt.'),
krk_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='globale ID des Kostenrechnungskreises'),
kostenart_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschluessel fuer die Kostenarten'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
anmerkung_txt STRING(500)
OPTIONS(description='Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk,, Kostenart_2'),
nicht_relevant_fg INTEGER
OPTIONS(description='Flag gibt an, ob der Datensatz für die Berechnung der Gesamtsummen relevant (0) ist oder nicht (1).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, gewerk_id, buchung_typ_cd, gp_id) NOT ENFORCED
)
OPTIONS(description='TS-Tabelle auf Ebene Projekt, Gewerk und Kostenart_2  für zusätzliche Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich nicht einer Bestellung oder einem Vertrag zuordnen lassen.');