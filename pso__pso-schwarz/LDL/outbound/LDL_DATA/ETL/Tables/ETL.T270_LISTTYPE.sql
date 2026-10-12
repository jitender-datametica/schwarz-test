CREATE TABLE IF NOT EXISTS ldl_data_etl.t270_listtype (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c270_listnr INTEGER NOT NULL,
c270_listdescript STRING(50),
c270_eks_link STRING(6),
scn BIGNUMERIC(38,0) DEFAULT 0,
c270_main_type INTEGER,
extraction_tmsp DATETIME,
PRIMARY KEY (c270_listnr) NOT ENFORCED
);