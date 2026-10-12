CREATE OR REPLACE TABLE kfl_production_dbp_etl.as_phasen_tmp_2 (
mandant_id INTEGER NOT NULL,
wg_id INTEGER NOT NULL,
posten_kz_sap STRING(2) COLLATE 'und:ci',
wtag_phasenbeginn INTEGER NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);