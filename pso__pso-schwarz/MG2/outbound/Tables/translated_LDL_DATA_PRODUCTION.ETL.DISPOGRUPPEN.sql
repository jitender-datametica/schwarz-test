CREATE OR REPLACE TABLE ldl_data_production_etl.dispogruppen (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
dispogrupnr INTEGER NOT NULL,
dispogrupbez STRING(20),
datum DATETIME,
bediener STRING(8),
voraustage INTEGER,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (dispogrupnr) NOT ENFORCED
);