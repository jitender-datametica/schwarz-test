CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t1300_supplier_tolerance (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c1300_groupid INTEGER NOT NULL,
c1300_group STRING(8),
c1300_group_desc STRING(35),
c1300_currency_sign INTEGER,
c1300_tolerance_std BIGNUMERIC(30,10),
c1300_tolerance_min BIGNUMERIC(30,10),
c1300_tolerance_max BIGNUMERIC(30,10),
c1300_moduser STRING(20),
c1300_moddate DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c1300_groupid) NOT ENFORCED
);