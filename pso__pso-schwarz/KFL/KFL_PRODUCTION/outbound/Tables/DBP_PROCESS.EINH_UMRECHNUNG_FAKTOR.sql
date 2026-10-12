CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.einh_umrechnung_faktor (
von_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
nach_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
umrech_faktor NUMERIC(18,6) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);