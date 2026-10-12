CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_tcache_oso_orgaunits_2_tcache_oso_internal_organization_hierarchy___2
(
int_org_natural_key STRING(90),
int_org_key_type_cd STRING(30),
int_org_hierarchy_type_cd STRING(20),
parent_int_org_natural_key STRING(90),
parent_int_org_key_type_cd STRING(30),
derived_valid_from_tmsp TIMESTAMP,
derived_valid_to_tmsp TIMESTAMP,
extraction_tmsp TIMESTAMP,
lvl STRING(5),
source_system STRING(20),
extraction_dt DATE,
dwh_mapping_tmsp TIMESTAMP,
tf_error_fg INTEGER,
deleted_fg INTEGER,
record_id STRING(300),
filename STRING(1000) NOT NULL,
dwh_node_cd STRING(20) NOT NULL,
dwh_load_id INTEGER NOT NULL,
error_descr STRING(1000)
);