CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.zb_fakt_buchung_vertrag_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
vertrag_nr STRING(20) NOT NULL OPTIONS(description='Nummer des Vertrages.'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
wrg_typ_id INTEGER NOT NULL
OPTIONS(description='ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_vertrag NUMERIC(29,5) OPTIONS(description='Betrag der Vertragswerte auf Ebene Projekt und Gewerk'),
betrag_obligo NUMERIC(29,5) OPTIONS(description='Betrag des Obligos auf Ebene Projekt und Gewerk.'),
betrag_buchung NUMERIC(29,5) OPTIONS(description='Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, gewerk_id, vertrag_nr, gp_id, wrg_typ_id) NOT ENFORCED
)
OPTIONS(description='Faktentabelle für Buchungen die einem Vertrag zugeordnet werden können auf Ebene Projekt, Gewerk, Lieferant und Vertrag.');