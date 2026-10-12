CREATE OR REPLACE TABLE kfl_production_dbp_data.projektart_spr_zu_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
projektart_cd STRING(20) NOT NULL OPTIONS(description='Eindeutiger alphanumerischer Code der Projektart'),
projektart_bez STRING(200) NOT NULL OPTIONS(description='Sprachabhängige Bezeichnung der Projektart.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, projektart_cd) NOT ENFORCED
) OPTIONS(description='Tabelle für sprachabhängige Bezeichnungen der Projektarten.');