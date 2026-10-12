CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.anlieferungsart (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
anlieferungsartkzl STRING(3) NOT NULL,
anlieferungsart STRING(35) NOT NULL,
datum DATETIME,
bediener STRING(8),
sv_formula STRING(15),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (anlieferungsartkzl) NOT ENFORCED
);