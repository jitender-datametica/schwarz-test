CREATE TABLE IF NOT EXISTS ldl_data_etl.dispoeinheit_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
disponr INTEGER NOT NULL,
dispoeinheit_1 STRING(35) NOT NULL,
datum DATETIME,
bediener STRING(8),
sql_beziehung STRING(18),
shortdesc STRING(10) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (disponr) NOT ENFORCED
);