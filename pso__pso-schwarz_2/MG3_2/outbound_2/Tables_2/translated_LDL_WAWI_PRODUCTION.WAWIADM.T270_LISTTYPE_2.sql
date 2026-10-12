CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t270_listtype_2 (
c270_listnr INTEGER NOT NULL,
c270_listdescript STRING(50),
c270_eks_link STRING(6),
scn INTEGER DEFAULT 0,
c270_main_type INTEGER,
PRIMARY KEY (c270_listnr) NOT ENFORCED
);