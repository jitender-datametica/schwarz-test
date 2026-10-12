CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_item_nr STRING(100) NOT NULL,
nfpo_item_name STRING(100) NOT NULL,
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL,
nfpo_range_plan_nr STRING(100),
nfpo_item_sel_nr STRING(100),
kfl_step_item_nr STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_sid) NOT ENFORCED
)
OPTIONS(description='instances of NFPO items in the quarterly item planning and ordering process. For catalog items there might be several instances in this table, all sharing the same international article number             CBX: CNT_ITEM');