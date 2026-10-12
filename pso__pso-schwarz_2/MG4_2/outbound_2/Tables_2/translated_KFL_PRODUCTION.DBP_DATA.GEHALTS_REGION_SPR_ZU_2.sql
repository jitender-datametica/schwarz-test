CREATE OR REPLACE TABLE kfl_production_dbp_data.gehalts_region_spr_zu_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
gehalts_region_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Gehaltsregion aus region_2'),
spr_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
gehalts_region_bez STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Gehaltsregion aus region_txt'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='SHR - Sprachabhängige Bezeichnung der Gehaltsregionen aus zhrregion');