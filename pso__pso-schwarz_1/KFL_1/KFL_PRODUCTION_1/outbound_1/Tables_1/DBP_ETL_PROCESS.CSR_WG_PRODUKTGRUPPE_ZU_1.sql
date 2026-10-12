CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.csr_wg_produktgruppe_zu_1 (
wg_id BIGNUMERIC(38,0),
wug_id BIGNUMERIC(38,0),
csr_produktgruppe_bez STRING(100) COLLATE 'und:ci',
csr_produktgruppe_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);