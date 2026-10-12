CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_oso_internal_organization_hierarchy_2 (
int_org_sid INTEGER,
int_org_hierarchy_type_cd STRING(20),
parent_int_org_sid INTEGER,
extraction_tmsp TIMESTAMP,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER,
dwh_node_cd STRING(20),
lvl STRING(5),
derived_valid_from_tmsp TIMESTAMP,
derived_valid_to_tmsp TIMESTAMP
);