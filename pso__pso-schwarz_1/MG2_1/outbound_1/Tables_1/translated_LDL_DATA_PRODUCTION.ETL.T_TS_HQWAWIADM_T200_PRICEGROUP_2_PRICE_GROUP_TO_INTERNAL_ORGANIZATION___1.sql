CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_hqwawiadm_t200_pricegroup_2_price_group_to_internal_organization___1
(
int_org_sid INTEGER,
int_org_type_cd STRING(20),
price_grp_sid INTEGER,
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
price_grp_prio INTEGER,
dwh_load_id INTEGER,
dwh_node_cd STRING(20),
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg INTEGER
);