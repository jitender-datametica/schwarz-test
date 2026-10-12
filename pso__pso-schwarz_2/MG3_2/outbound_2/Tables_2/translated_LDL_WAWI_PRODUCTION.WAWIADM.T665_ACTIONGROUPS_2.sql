CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t665_actiongroups_2 (
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
c665_groupid INTEGER,
scn INTEGER DEFAULT 0,
PRIMARY KEY (c665_country, c665_maingrpnr, c665_groupnr, c665_datefrom) NOT ENFORCED
);