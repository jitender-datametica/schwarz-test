CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_l_besitzstatus (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
besitzstatus_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Besitzstatus '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='IMMO - Lookup-Tabelle Besitzstatus der Wirtschaftseinheit - SAP REFX - ZRE_BESITZSTATT');