CREATE OR REPLACE TABLE kfl_production_dbp_data.zb_projekt_kondition_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
kondition_nr STRING(50) NOT NULL OPTIONS(description='Nummer der Kondition'),
konditionstyp_id INTEGER NOT NULL OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart.'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
mv_intreno STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Interner Schlüssel des Mietvertrages'),
gp_id INTEGER OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
partner_id STRING(10) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Geschäftspartnernummer'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_kondition NUMERIC(29,5) NOT NULL OPTIONS(description='Betrag der Kondition'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kondition_nr) NOT ENFORCED
) OPTIONS(description='Enthält Konditionen zu Verträgen die für ein Projekt gültig sind.');