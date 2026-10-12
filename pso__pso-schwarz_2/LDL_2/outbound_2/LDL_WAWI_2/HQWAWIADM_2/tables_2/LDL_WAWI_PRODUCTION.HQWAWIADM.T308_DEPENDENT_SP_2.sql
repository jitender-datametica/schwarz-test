CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t308_dependent_sp_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c308_id INTEGER NOT NULL,
c308_head_id INTEGER NOT NULL,
c308_detail_id INTEGER NOT NULL,
c308_subtype_head INTEGER NOT NULL,
c308_subtype_detail INTEGER NOT NULL,
c308_moduser STRING(100),
c308_moddate DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c308_id) NOT ENFORCED
);