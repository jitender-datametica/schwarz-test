CREATE OR REPLACE TABLE ldl_data_production_etl.t664_brokerage_item_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c664_group STRING(4) NOT NULL,
c664_desc STRING(20) NOT NULL,
c664_item STRING(14) NOT NULL,
c664_std_flag INTEGER NOT NULL,
c664_modset INTEGER NOT NULL,
c664_moddate DATETIME,
c664_moduser STRING(8),
scn INTEGER DEFAULT 0,
c664_id BIGNUMERIC(29,10),
extraction_tmsp DATETIME
);