CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t215_int_itemnr (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c215_int_itemnr STRING(20) NOT NULL,
c215_itemnr STRING(18) NOT NULL,
c215_int_itemdesc STRING(100),
c215_casesize NUMERIC(10,5),
c215_moddate DATETIME,
c215_moduser STRING(8),
c215_int_itemnrsho STRING(4),
c215_active INTEGER,
c215_is_main_link INTEGER,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
extraction_dt DATE,
dwh_created_tmsp DATETIME NOT NULL,
dwh_updated_tmsp DATETIME NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_node_cd STRING(20) NOT NULL
);