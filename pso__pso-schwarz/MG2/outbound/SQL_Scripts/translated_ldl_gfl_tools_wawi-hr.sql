DELETE FROM ldl_data_production_etl_process.t_lookup_instr
WHERE source_system = 'wawi-hr';


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 'xx', 'wawi-hr', 'xx', 'prod_sid', 'prod_sid', 'xx', 'prod_key', 'prod_nat_key_nr', 'no', 'meta', 'meta',
  'product', 'prod_key_type_cd', 'prod_nat_key_nr', 'prod_sid'),
  ('xx', 'xx', 'wawi-hr', 'xx', 'int_org_sid', 'int_org_sid', 'xx', 'party_key', 'party_nat_key_nr', 'no', 'meta',
  'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid'),
  ('xx', 'xx', 'wawi-hr', 'xx', 'country_org_sid', 'int_org_sid', 'xx', 'party_key', 'party_nat_key_nr', 'no', 'meta',
  'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid'),
  ('xx', 'xx', 'wawi-hr', 'xx', 'prod_variant_sid', 'prod_variant_sid', 'xx', 'prod_variant_key',
  'prod_variant_nat_key_nr', 'no', 'meta', 'meta', 'product_variant', 'prod_variant_key_type_cd',
  'prod_variant_nat_key_nr', 'prod_variant_sid'),
  ('xx', 'xx', 'wawi-hr', 'xx', 'price_grp_sid', 'price_grp_sid', 'xx', 'price_grp_key', 'price_grp_nat_key_nr', 'no',
  'meta', 'meta', 'price_group', 'price_grp_key_type_cd', 'price_grp_nat_key_nr', 'price_grp_sid');