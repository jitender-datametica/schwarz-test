CREATE OR REPLACE TABLE kfl_production_dbp_data.aktionsart_liste_spr_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
aktionsart_liste_id STRING(500) NOT NULL
OPTIONS(description='Enthält als kommaseparierte Textliste die Art_1 der Aktion_1(en) als ID, die verwendet wurde(n).'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
aktionsart_liste_bez STRING(500)
OPTIONS(description='Enthält als kommaseparierte Textliste die Bezeichnung der Aktionsarte(n).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, aktionsart_liste_id, spr_id) NOT ENFORCED
) OPTIONS(description='AIS - Sprachabhängige Bezeichnungen der Aktionsarten.');