CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t664_brokerage_item (
c664_item STRING(14),
c664_moddate DATETIME,
c664_moduser STRING(8),
scn INTEGER,
ctrcode STRING(3) COLLATE 'und:ci',
extraction_tmsp DATETIME,
c664_group STRING(4),
c664_modset INTEGER,
c664_desc STRING(20),
c664_id BIGNUMERIC(29,10),
c664_std_flag INTEGER,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER
);