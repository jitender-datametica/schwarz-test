CREATE OR REPLACE TABLE ldl_data_production_etl.dispoeinheit_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
disponr INTEGER NOT NULL,
dispoeinheit_2 STRING(35) NOT NULL,
datum DATETIME,
bediener STRING(8),
sql_beziehung STRING(18),
shortdesc STRING(10) NOT NULL,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (disponr) NOT ENFORCED
);