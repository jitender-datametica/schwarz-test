CREATE OR REPLACE TABLE ldl_data_production_etl.anlieferungsart_wh_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
anlieferungsartkzl STRING(3) NOT NULL,
anlieferungsart_1 STRING(35) NOT NULL,
datum DATETIME,
bediener STRING(8),
sv_formula STRING(15),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (anlieferungsartkzl) NOT ENFORCED
);