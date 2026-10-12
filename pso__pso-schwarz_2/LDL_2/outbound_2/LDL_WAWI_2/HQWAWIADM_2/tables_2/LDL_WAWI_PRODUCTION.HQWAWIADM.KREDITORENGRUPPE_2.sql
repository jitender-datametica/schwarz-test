CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.kreditorengruppe_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
kreditorgruppennr INTEGER NOT NULL,
kreditorgruppenbez STRING(35) NOT NULL,
datum DATETIME,
bediener STRING(8),
globalkreditor INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (kreditorgruppennr) NOT ENFORCED
);