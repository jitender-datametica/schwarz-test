CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.dispogruppen (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
dispogrupnr INTEGER NOT NULL,
dispogrupbez STRING(20),
datum DATETIME,
bediener STRING(8),
voraustage INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (dispogrupnr) NOT ENFORCED
);