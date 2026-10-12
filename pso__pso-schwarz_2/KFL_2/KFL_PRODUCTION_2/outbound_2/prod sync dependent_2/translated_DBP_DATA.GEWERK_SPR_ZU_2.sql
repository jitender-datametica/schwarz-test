CREATE OR REPLACE TABLE kfl_production_dbp_data.gewerk_spr_zu_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
gewerk_id INTEGER NOT NULL OPTIONS(description='ID eines Gewerks , z.Bsp 3 = Baukosten'),
gewerk_bez STRING(200) NOT NULL OPTIONS(description='Sprachabhängige Bezeichnung der Gewerke'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, gewerk_id) NOT ENFORCED
) OPTIONS(description='Tabelle für sprachabhängige Bezeichnungen der Gewerke.');