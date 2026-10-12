CREATE OR REPLACE TABLE ldl_data_production_etl.t1043_container_groups (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c1043_id INTEGER NOT NULL,
c1043_prodgrpnr INTEGER NOT NULL,
c1043_itemgrpnr INTEGER NOT NULL,
c1043_family_id INTEGER NOT NULL,
c1043_listenknznr INTEGER NOT NULL,
c1043_valid_from DATETIME,
c1043_valid_until DATETIME,
c1043_moduser STRING(50) NOT NULL,
c1043_moddate DATETIME NOT NULL,
scn INTEGER DEFAULT 0,
c1043_main_type INTEGER,
extraction_tmsp DATETIME,
PRIMARY KEY (c1043_id) NOT ENFORCED
);