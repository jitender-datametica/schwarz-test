CREATE OR REPLACE TABLE kfl_production_dbp_data.projektrolle_spr_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
projektrolle_cd STRING(100) NOT NULL OPTIONS(description='Eindeutiger Code der Projektrolle.'),
projektrolle_bez STRING(200) NOT NULL OPTIONS(description='Sprachabhängige Bezeichnung der Projektrolle.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, projektrolle_cd) NOT ENFORCED
) OPTIONS(description='Tabelle für sprachabhängige Bezeichnungen der Projektrollen.');