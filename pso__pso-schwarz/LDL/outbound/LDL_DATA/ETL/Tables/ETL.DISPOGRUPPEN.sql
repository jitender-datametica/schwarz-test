CREATE TABLE IF NOT EXISTS ldl_data_etl.dispogruppen (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
dispogrupnr INTEGER NOT NULL,
dispogrupbez STRING(20),
datum DATETIME,
bediener STRING(8),
voraustage INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (dispogrupnr) NOT ENFORCED
);