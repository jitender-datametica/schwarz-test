CREATE OR REPLACE TABLE ldl_data_production_etl.t1041_itemcontainer_head_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c1041_container_id INTEGER NOT NULL,
c1041_desc_int STRING(35) NOT NULL,
c1041_status INTEGER NOT NULL,
c1041_information STRING(500),
c1041_moduser STRING(50) NOT NULL,
c1041_moddate DATETIME NOT NULL,
scn INTEGER DEFAULT 0,
c1041_country STRING(3),
c1041_desc_nat STRING(50),
c1041_cont_id_local INTEGER,
extraction_tmsp DATETIME,
PRIMARY KEY (c1041_container_id) NOT ENFORCED
);