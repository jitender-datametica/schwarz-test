CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_t119_status_locked (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
extraction_tmsp DATETIME,
wh_nr BIGNUMERIC(38,0) NOT NULL,
itemno STRING(18) NOT NULL,
warehouseno INTEGER NOT NULL,
locked INTEGER NOT NULL,
moduser STRING(8) NOT NULL,
moddate DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
);