CREATE TABLE IF NOT EXISTS ldl_data_etl.anlieferungsart_hq_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
anlieferungsartkzl STRING(3) NOT NULL,
anlieferungsart_2 STRING(35) NOT NULL,
datum DATETIME,
bediener STRING(8),
sv_formula STRING(15),
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (anlieferungsartkzl) NOT ENFORCED
);