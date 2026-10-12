CREATE OR REPLACE TABLE kfl_production_dbp_data.datumsart_spr_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='PK - Mandant im DWH'),
datumsart_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Datumsart, z.Bsp. 13'),
spr_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
datumsart_bez STRING(50) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Datumsart, z.Bsp. Beginn Wehrdienst'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='SHR - Sprachabhängige Bezeichnung der Ereignisse');