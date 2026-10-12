CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_hq_master_item_property_assignment_2_item_property_relation_hist_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40) COLLATE 'und:ci',
hq_master_item_property_assignment_item_nr BIGNUMERIC(38),
hq_master_item_property_assignment_case_size BIGNUMERIC(38),
hq_master_item_property_assignment_item_property_id BIGNUMERIC(38),
deleted_fg BIGNUMERIC(38),
active_fg BIGNUMERIC(38),
dummy_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000) COLLATE 'und:ci'
);