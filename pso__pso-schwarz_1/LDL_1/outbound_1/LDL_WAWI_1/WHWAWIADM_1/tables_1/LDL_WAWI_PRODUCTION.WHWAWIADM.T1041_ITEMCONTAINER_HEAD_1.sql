CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t1041_itemcontainer_head_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c1041_container_id INTEGER NOT NULL,
c1041_desc_int STRING(50) NOT NULL,
c1041_status INTEGER NOT NULL,
c1041_information STRING(500),
c1041_moduser STRING(50) NOT NULL,
c1041_moddate DATETIME NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
c1041_country STRING(3),
c1041_desc_nat STRING(50),
c1041_cont_id_local BIGNUMERIC(38,0),
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c1041_container_id, wh_nr) NOT ENFORCED
);