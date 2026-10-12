CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t270_listtype_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c270_listnr INTEGER NOT NULL,
c270_listdescript STRING(50),
c270_eks_link STRING(6),
scn BIGNUMERIC(38,0) DEFAULT 0,
c270_main_type INTEGER,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c270_listnr) NOT ENFORCED
);