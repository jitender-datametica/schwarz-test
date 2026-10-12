CREATE OR REPLACE TABLE kfl_production_dbp_data.bewart_spr_zu (
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache\n            '),
bewart_id INTEGER NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
bewart_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Bewegungsart'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bewart_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='Bewegungsart-Sprachen-Zuordnung');