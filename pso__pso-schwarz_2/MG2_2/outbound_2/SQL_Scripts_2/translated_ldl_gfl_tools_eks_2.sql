DELETE FROM ldl_data_production_etl_process.t_lookup_instr_2
WHERE source_system = 'eks';


INSERT INTO ldl_data_production_etl_process.t_lookup_instr_2 (country_2, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 'xx', 'eks', 'xx', 'int_org_sid', 'party_sid', 'xx', 'ctrcode', 'ctrcode', 'no', 'meta', 'meta', 'party',
  'party_key_type_cd', 'party_nat_key_nr', 'party_sid'),
  ('xx', 'xx', 'eks', 'xx', 'prod_sid', 'prod_sid', 'xx', 'prod_nr', 'prod_nr', 'no', 'meta', 'meta', 'product',
  'prod_key_type_cd', 'prod_nat_key_nr', 'prod_sid'),
  ('xx', 't_local_product_variant_2', 'eks', 'xx', 'int_org_sid', 'party_sid', 'xx', 'ctrcode', 'ctrcode', 'no', 'meta',
  'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid'),
  ('xx', 't_product_variant_2', 'eks', 'xx', 'prod_variant_sid', 'prod_variant_sid', 'xx', 'prod_variant_nr',
  'prod_variant_nr', 'no', 'meta', 'meta', 'product_variant', 'prod_variant_key_type_cd', 'prod_variant_nat_key_nr',
  'prod_variant_sid'),
  ('xx', 't_product_variant_2', 'eks', 'xx', 'prod_sid', 'prod_sid', 'xx', 'prod_nr', 'prod_nr', 'no', 'meta', 'meta',
  'product', 'prod_key_type_cd', 'prod_nat_key_nr', 'prod_sid'),
  ('xx', 't_local_product_2', 'eks', 'xx', 'prod_sid', 'prod_sid', 'xx', 'prod_nr', 'prod_nr', 'no', 'meta', 'meta',
  'product', 'prod_key_type_cd', 'prod_nat_key_nr', 'prod_sid'),
  ('xx', 't_local_product_2', 'eks', 'xx', 'int_org_sid', 'party_sid', 'xx', 'ctrcode', 'ctrcode', 'no', 'meta', 'meta',
  'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid');