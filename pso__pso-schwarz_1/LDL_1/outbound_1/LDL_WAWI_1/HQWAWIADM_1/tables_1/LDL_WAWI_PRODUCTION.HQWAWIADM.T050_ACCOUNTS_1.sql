CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t050_accounts_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c050_accountnr STRING(10) NOT NULL,
c050_accountdesc STRING(60) NOT NULL,
c050_germandesc STRING(60),
c050_matchitems INTEGER,
c050_costtype INTEGER,
c050_moddate DATETIME,
c050_moduser STRING(8),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c050_accountnr) NOT ENFORCED
);