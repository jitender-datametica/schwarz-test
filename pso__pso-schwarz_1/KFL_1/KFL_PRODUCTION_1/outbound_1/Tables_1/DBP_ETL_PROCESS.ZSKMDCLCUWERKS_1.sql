CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.zskmdclcuwerks_1 (
mandt STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Mandant_1 im SAP'),
mtart STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Materialart'),
werks STRING(4) COLLATE 'und:ci' OPTIONS(description='Werk'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);