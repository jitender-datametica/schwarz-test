CREATE OR REPLACE TABLE ldl_data_production_etl.t921_delitemsstate_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c921_batchnr INTEGER NOT NULL,
c921_batchitemnr INTEGER NOT NULL,
c921_itemnr STRING(18) NOT NULL,
c921_desc_long STRING(100),
c921_state INTEGER,
c921_moddate DATETIME,
c921_moduser STRING(8),
c921_whnr INTEGER NOT NULL,
c921_itemnr_short STRING(14) NOT NULL,
c921_errortable STRING(30),
c921_error_message STRING(1000),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c921_batchnr, c921_batchitemnr, c921_itemnr, c921_whnr) NOT ENFORCED
);