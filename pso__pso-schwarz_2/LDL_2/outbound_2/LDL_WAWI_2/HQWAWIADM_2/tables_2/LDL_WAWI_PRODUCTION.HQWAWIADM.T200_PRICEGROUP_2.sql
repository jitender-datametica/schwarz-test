CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t200_pricegroup_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c200_groupnr BIGNUMERIC(30,10) NOT NULL,
c200_groupdesc STRING(30),
c200_priority BIGNUMERIC(30,10) NOT NULL,
c200_warehouse BIGNUMERIC(30,10) NOT NULL,
c200_storenr BIGNUMERIC(30,10) NOT NULL,
c200_editedby STRING(8),
c200_lastedited DATETIME,
c200_datefrom DATETIME NOT NULL,
c200_dateto DATETIME NOT NULL,
c200_add_vatcode INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c200_groupnr, c200_storenr, c200_datefrom, c200_warehouse) NOT ENFORCED
);