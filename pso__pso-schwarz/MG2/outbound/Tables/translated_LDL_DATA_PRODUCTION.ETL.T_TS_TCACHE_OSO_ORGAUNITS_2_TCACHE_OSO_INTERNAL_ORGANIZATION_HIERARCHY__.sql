CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_tcache_oso_orgaunits_2_tcache_oso_internal_organization_hierarchy__
(
int_org_sid INTEGER,
int_org_hierarchy_type_cd STRING(20),
parent_int_org_sid INTEGER,
extraction_tmsp TIMESTAMP,
dwh_load_id INTEGER,
dwh_node_cd STRING(20),
lvl STRING(5),
derived_valid_from_tmsp TIMESTAMP,
derived_valid_to_tmsp TIMESTAMP,
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg INTEGER
);