CREATE OR REPLACE TABLE kfl_production_dbp_data.in_l_buchungskreis_1 (
buchungskreis_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
kontenplan_id STRING(4) COLLATE 'und:ci',
sako_fg INTEGER DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);