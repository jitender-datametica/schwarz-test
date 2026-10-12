CREATE OR REPLACE TABLE ldl_data_production_etl.t271_packagetype_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c271_packnr INTEGER NOT NULL,
c271_packdescript STRING(15),
c271_eks_link INTEGER,
c271_int_short STRING(10),
c271_int_desc STRING(15),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c271_packnr) NOT ENFORCED
);