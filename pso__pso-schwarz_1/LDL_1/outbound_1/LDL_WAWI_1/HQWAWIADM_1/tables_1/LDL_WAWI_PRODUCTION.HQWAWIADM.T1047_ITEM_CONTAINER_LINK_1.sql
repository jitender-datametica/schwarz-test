CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t1047_item_container_link_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c1047_id BIGNUMERIC(38,10) NOT NULL,
c1047_item_short STRING(7) NOT NULL,
c1047_warehouse BIGNUMERIC(38,10) NOT NULL,
c1047_container_id BIGNUMERIC(38,10) NOT NULL,
c1047_listtype BIGNUMERIC(38,10),
c1047_valid_from DATETIME NOT NULL,
c1047_valid_until DATETIME NOT NULL,
c1047_moduser STRING(15) NOT NULL,
c1047_moddate DATETIME NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c1047_id) NOT ENFORCED
);