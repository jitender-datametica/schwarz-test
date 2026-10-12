CREATE OR REPLACE TABLE ldl_data_production_eval.t_wawi_item_variant_internal_organization_status (
wawi_item_variant_sid INTEGER,
int_org_sid INTEGER,
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
wawi_item_variant_status_type_id INTEGER,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER,
dwh_node_cd STRING(20)
);