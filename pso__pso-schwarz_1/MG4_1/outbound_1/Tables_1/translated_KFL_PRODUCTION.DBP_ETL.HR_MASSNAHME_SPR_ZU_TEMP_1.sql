CREATE OR REPLACE TABLE kfl_production_dbp_etl.hr_massnahme_spr_zu_temp_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='PK - Mandant_1 im DWH'),
hr_massnahme_grund_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Massnahmegrund'),
hr_massnahme_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Massnahme, z.Bsp. A0'),
spr_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
hr_massnahme_grund_bez STRING(30) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Mitarbeiter-Massnahme-Grundes'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
);