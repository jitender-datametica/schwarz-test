CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_besitzstatus_spr_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
besitzstatus_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Besitzstatus '),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
besitzstatus_bez STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung Besitzstatus'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='IMMO - Sprachabhängige Bezeichnungen des Besitzstatus der Wirtschaftseinheit - SAP REFX - ZRE_BESITZSTATT');