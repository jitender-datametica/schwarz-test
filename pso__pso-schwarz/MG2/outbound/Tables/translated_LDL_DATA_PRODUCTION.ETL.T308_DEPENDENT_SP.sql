CREATE OR REPLACE TABLE ldl_data_production_etl.t308_dependent_sp (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c308_id INTEGER NOT NULL,
c308_head_id INTEGER NOT NULL,
c308_detail_id INTEGER NOT NULL,
c308_subtype_head INTEGER NOT NULL,
c308_subtype_detail INTEGER NOT NULL,
c308_moduser STRING(100),
c308_moddate DATETIME,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c308_id) NOT ENFORCED
);