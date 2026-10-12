CREATE OR REPLACE TABLE kfl_production_dbp_data.abschriftart_spr_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
abschriftart_id INTEGER NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
spr_id INTEGER NOT NULL OPTIONS(description='Sprache ID'),
abschriftart_bez STRING(80) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Abschriftenart'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, abschriftart_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Sprachabhängige Bezeichnungen der Abschriftenschlüssel');