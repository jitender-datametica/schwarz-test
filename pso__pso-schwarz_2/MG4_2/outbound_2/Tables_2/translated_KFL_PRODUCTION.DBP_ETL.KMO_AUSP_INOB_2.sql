CREATE OR REPLACE TABLE kfl_production_dbp_etl.kmo_ausp_inob_2 (
soursystem STRING(2) COLLATE 'und:ci',
class_type STRING(3) COLLATE 'und:ci',
xlausp STRING(30) COLLATE 'und:ci',
xlcabn STRING(10) COLLATE 'und:ci',
xlatzhl STRING(3) COLLATE 'und:ci',
xlatwrt STRING(60) COLLATE 'und:ci',
xlatflv INTEGER,
xlatflb INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);