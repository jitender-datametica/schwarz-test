CREATE OR REPLACE TABLE kfl_production_dbp_etl.ind_iinob_1 (
soursystem STRING(2),
inob_1 INTEGER,
class_type STRING(3) COLLATE 'und:ci',
tabname STRING(30) COLLATE 'und:ci',
fvalue STRING(50) COLLATE 'und:ci',
mandant_id INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);