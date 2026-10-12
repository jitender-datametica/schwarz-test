CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t216_int_supplier_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c216_int_suppnr STRING(10) NOT NULL,
c216_suppnr STRING(7) NOT NULL,
c216_int_suppdesc STRING(35),
c216_moddate DATETIME,
c216_moduser STRING(8),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c216_int_suppnr, c216_suppnr) NOT ENFORCED
);