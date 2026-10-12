CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
wrg_typ_id INTEGER NOT NULL
OPTIONS(description='ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_zek NUMERIC(29,5)
OPTIONS(description='Betrag der zu erwartenden Mehr- bzw. Minderkosten des Projektes auf Ebene Gewerk'),
anmerkung_txt STRING(500) OPTIONS(description='Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, gewerk_id, wrg_typ_id) NOT ENFORCED
) OPTIONS(description='TS-Tabelle auf Ebene Projekt und Gewerk für zusätzliche Projektdaten aus den Zentralbereichen');