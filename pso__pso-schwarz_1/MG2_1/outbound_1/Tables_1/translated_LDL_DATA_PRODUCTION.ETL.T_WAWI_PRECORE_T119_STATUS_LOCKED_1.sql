CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t119_status_locked_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
extraction_tmsp DATETIME,
wh_nr INTEGER NOT NULL,
itemno STRING(18) NOT NULL,
warehouseno INTEGER NOT NULL,
locked INTEGER NOT NULL,
moduser STRING(8) NOT NULL,
moddate DATETIME,
scn INTEGER DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id INTEGER NOT NULL
);