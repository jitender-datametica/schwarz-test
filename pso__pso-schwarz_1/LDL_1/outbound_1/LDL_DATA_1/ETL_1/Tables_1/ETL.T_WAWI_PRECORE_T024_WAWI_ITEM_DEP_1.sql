CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_t024_wawi_item_dep_1 (
ctrcode STRING(3) NOT NULL,
extraction_tmsp DATETIME NOT NULL,
seqid INTEGER NOT NULL,
itemno_head INTEGER NOT NULL,
level_head INTEGER NOT NULL,
itemno_detail INTEGER NOT NULL,
level_detail INTEGER NOT NULL,
posno INTEGER NOT NULL,
quantity INTEGER,
transferdate DATETIME,
transferflag INTEGER NOT NULL,
action_flag INTEGER,
location_1 STRING(6) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
);