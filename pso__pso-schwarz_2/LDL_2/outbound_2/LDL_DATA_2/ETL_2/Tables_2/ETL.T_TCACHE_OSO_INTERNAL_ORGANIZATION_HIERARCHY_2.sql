CREATE TABLE IF NOT EXISTS ldl_data_etl.t_tcache_oso_internal_organization_hierarchy_2 (
int_org_sid BIGNUMERIC(38,0),
int_org_hierarchy_type_cd STRING(20),
parent_int_org_sid BIGNUMERIC(38,0),
derived_valid_from_tmsp TIMESTAMP,
derived_valid_to_tmsp TIMESTAMP,
extraction_tmsp TIMESTAMP,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id BIGNUMERIC(38,0),
dwh_node_cd STRING(20),
lvl STRING(5)
);