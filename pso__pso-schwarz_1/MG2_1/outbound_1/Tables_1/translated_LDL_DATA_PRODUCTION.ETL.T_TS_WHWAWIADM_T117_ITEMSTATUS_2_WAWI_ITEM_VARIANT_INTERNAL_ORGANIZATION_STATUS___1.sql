CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_whwawiadm_t117_itemstatus_2_wawi_item_variant_internal_organization_status___1
(
wawi_item_variant_sid INTEGER,
int_org_sid INTEGER,
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
wawi_item_variant_status_type_id INTEGER,
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