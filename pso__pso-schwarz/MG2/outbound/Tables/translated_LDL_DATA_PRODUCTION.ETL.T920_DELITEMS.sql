CREATE OR REPLACE TABLE ldl_data_production_etl.t920_delitems (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c920_batchnr INTEGER,
c920_batchdate DATETIME,
c920_batchitemnr INTEGER NOT NULL,
c920_itemnr_short STRING(18),
c920_state INTEGER,
c920_closed INTEGER,
c920_moddate DATETIME,
c920_moduser STRING(8),
c920_itemdesc STRING(100),
c920_errortable STRING(30),
c920_error_message STRING(1000),
c920_released_by STRING(8),
c920_created_by STRING(8),
c920_idvalue BIGNUMERIC(29,10),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME
);