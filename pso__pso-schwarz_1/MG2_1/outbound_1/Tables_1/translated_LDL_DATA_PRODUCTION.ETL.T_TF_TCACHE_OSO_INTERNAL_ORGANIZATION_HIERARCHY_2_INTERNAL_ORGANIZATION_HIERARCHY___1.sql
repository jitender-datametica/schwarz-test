CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_tcache_oso_internal_organization_hierarchy_2_internal_organization_hierarchy___1
(
int_org_sid INTEGER,
int_org_hierarchy_type_cd STRING(20),
parent_int_org_sid INTEGER,
source_system STRING(20),
extraction_dt DATE,
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
tf_error_fg INTEGER,
deleted_fg INTEGER,
record_id STRING(300),
filename STRING(1000) NOT NULL,
dwh_node_cd STRING(20) NOT NULL,
dwh_load_id INTEGER NOT NULL,
error_descr STRING(1000)
);