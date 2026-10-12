
MERGE INTO ldl_data_production_core_rel.t_product_order_area AS rel
USING ldl_data_production_etl.t_tf_wawi_precore_artikel_2_product_order_area___delete_keys AS keys
ON rel.int_org_sid = keys.int_org_sid AND rel.prod_sid = keys.prod_sid AND rel.dwh_valid_to_tmsp IS NULL
WHEN MATCHED THEN UPDATE SET
 dwh_valid_to_tmsp = CURRENT_TIMESTAMP();