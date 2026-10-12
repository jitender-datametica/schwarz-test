CREATE OR REPLACE TABLE kfl_production_dbp_data.l_gewerk_2 (
gewerk_id INTEGER NOT NULL
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
finanz_gruppe_nr STRING(20) NOT NULL
OPTIONS(description='Alphanumerische Nummer der Finanzgruppe. Jedes Gewerk besitzt genau eine_2 dazugehörige Finanzgruppe. Über diese Nummer kann bspw. das Budget zum Projekt gemapped werden.'),
PRIMARY KEY (gewerk_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='IMS - Lookup-Tabelle der Gewerke (entspricht der letzten Stelle eines PSP-Elements). Manuell im DWH versorgt');