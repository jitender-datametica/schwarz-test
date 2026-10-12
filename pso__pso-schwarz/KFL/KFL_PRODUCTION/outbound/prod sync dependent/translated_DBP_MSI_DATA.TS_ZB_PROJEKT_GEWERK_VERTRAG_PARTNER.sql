CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_vertrag_partner (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
vertrag_nr STRING(20) NOT NULL OPTIONS(description='Nummer des Vertrages.'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
anmerkung_txt STRING(500)
OPTIONS(description='Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk, Warengruppe, Kostenart'),
nicht_relevant_fg INTEGER
OPTIONS(description='Flag gibt an, ob der Datensatz für die Berechnung der Gesamtsummen relevant (0) ist oder nicht (1).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, gewerk_id, vertrag_nr, gp_id) NOT ENFORCED
)
OPTIONS(description='TS-Tabelle auf Ebene Projekt, Gewerk, Vertrag und Partner / Lieferant für zusätzliche Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich einem Vertrag zuordnen lassen.');