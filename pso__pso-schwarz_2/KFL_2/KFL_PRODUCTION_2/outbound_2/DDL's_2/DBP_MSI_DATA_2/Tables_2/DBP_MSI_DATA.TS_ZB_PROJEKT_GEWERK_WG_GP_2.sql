CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_wg_gp_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
warengruppe_cd STRING(20) NOT NULL OPTIONS(description='Code der Warengruppe'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
anmerkung_txt STRING(500)
OPTIONS(description='Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk, Warengruppe, GP_2'),
nicht_relevant_fg INTEGER
OPTIONS(description='Flag gibt an, ob der Datensatz für die Berechnung der Gesamtsummen relevant (0) ist oder nicht (1).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, gewerk_id, warengruppe_cd, gp_id) NOT ENFORCED
)
OPTIONS(description='TS-Tabelle auf Ebene Projekt, Gewerk, Warengruppe und GP_2 für zusätzliche Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich einer Bestellung zuordnen lassen.');