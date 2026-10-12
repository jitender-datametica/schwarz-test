CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.einh_umrechnung_faktor_2 (
von_einh_id STRING(3) COLLATE 'und:ci',
nach_einh_id STRING(3) COLLATE 'und:ci',
umrech_faktor NUMERIC(18,6),
td_insert TIMESTAMP,
td_update TIMESTAMP
);