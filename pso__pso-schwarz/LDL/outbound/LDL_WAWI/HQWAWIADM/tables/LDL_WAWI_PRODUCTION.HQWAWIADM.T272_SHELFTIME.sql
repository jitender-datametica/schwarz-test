CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t272_shelftime (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c272_shelft_nr INTEGER NOT NULL,
c272_shelft_desc STRING(15),
c272_shelft_lt STRING(2),
c272_shelft_calc INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c272_shelft_nr) NOT ENFORCED
);