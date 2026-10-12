CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t007_descriptions_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c007_id INTEGER NOT NULL,
c007_type STRING(25) NOT NULL,
c007_code STRING(25) NOT NULL,
c007_desc STRING(80),
c007_readonly INTEGER,
c007_moduser STRING(8),
c007_moddate DATETIME,
c007_eks_link INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c007_type, c007_code) NOT ENFORCED
);