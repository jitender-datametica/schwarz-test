CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t665_actiongroups (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c665_country STRING(3) NOT NULL,
c665_datefrom DATETIME NOT NULL,
c665_dateuntil DATETIME NOT NULL,
c665_groupcountry STRING(50),
c665_groupdesc STRING(50) NOT NULL,
c665_groupnr INTEGER NOT NULL,
c665_maingrpcountry STRING(50),
c665_maingrpdesc STRING(50) NOT NULL,
c665_maingrpnr INTEGER NOT NULL,
c665_moddate DATETIME,
c665_moduser STRING(8),
c665_groupid BIGNUMERIC(38,0),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c665_country, c665_maingrpnr, c665_groupnr, c665_datefrom) NOT ENFORCED
);