CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t815_pcwo_reason_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c815_reason_id INTEGER NOT NULL,
c815_reason_id_int INTEGER NOT NULL,
c815_grp_id INTEGER,
c815_reason_desc_int STRING(50),
c815_reason_desc_nat STRING(50) NOT NULL,
c815_grp_desc STRING(50),
c815_active_flag INTEGER NOT NULL,
c815_bnl_grp INTEGER,
c815_new_grp INTEGER,
c815_moddate DATETIME,
c815_moduser STRING(8),
scn BIGNUMERIC(38,0) DEFAULT 0,
c815_displaytype INTEGER,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c815_reason_id) NOT ENFORCED
);