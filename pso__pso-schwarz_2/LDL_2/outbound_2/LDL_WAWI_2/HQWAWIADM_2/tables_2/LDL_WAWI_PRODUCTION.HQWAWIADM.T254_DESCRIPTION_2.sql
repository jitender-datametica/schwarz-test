CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t254_description_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c254_orgdesc STRING(50) NOT NULL,
c254_translation STRING(50) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c254_orgdesc) NOT ENFORCED
);