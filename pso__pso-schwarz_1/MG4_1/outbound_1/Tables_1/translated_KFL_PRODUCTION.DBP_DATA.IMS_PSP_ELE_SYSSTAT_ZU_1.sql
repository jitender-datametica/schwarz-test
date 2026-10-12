CREATE OR REPLACE TABLE kfl_production_dbp_data.ims_psp_ele_sysstat_zu_1 (
mandant_id INTEGER NOT NULL,
psp_id INTEGER NOT NULL,
systemstatus_id STRING(5) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);