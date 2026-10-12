CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t664_brokerage_item_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c664_group STRING(4) NOT NULL,
c664_desc STRING(20) NOT NULL,
c664_item STRING(14) NOT NULL,
c664_std_flag INTEGER NOT NULL,
c664_modset INTEGER NOT NULL,
c664_moddate DATETIME,
c664_moduser STRING(8),
scn INTEGER DEFAULT 0,
c664_id BIGNUMERIC(29,10) NOT NULL,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c664_id) NOT ENFORCED
);