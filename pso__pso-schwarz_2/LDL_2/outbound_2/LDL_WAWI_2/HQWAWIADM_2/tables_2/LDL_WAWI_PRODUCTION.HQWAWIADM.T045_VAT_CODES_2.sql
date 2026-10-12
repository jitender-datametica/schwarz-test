CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t045_vat_codes_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c045_vatcode INTEGER NOT NULL,
c045_countrycode STRING(3) NOT NULL,
c045_vatdesc STRING(60),
c045_moddate DATETIME,
c045_moduser STRING(8),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c045_vatcode, c045_countrycode) NOT ENFORCED
);