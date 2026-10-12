DELETE FROM ldl_data_production_etl_process.t_lookup_instr_2
WHERE source_system = 'wawi' AND target_table IN ('t_wawi_item_2', 't_wawi_item_variant_2',
   't_wawi_item_variant_sales_price_2');


INSERT INTO ldl_data_production_etl_process.t_lookup_instr_2 (country_2, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_wawi_item_variant_2', 'wawi', 'xx', 'country_org_sid', 'country_org_sid', 'xx', 'country_org_nat_key',
  'country_org_nat_key', 'no', 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid'),
  ('xx', 't_wawi_item_variant_2', 'wawi', 'xx', 'wawi_item_variant_sid', 'wawi_item_variant_sid', 'xx',
  'wawi_item_variant_nat_key_nr', 'wawi_item_variant_nat_key_nr', 'no', 'meta', 'meta', 'wawi_item_variant',
  'wawi_item_variant_key_type_cd', 'wawi_item_variant_nat_key_nr', 'wawi_item_variant_sid'),
  ('xx', 't_wawi_item_variant_2', 'wawi', 'xx', 'wawi_item_sid', 'wawi_item_sid', 'xx', 'wawi_item_nat_key_nr',
  'wawi_item_nat_key_nr', 'no', 'meta', 'meta', 'wawi_item_2', 'wawi_item_key_type_cd', 'wawi_item_nat_key_nr',
  'wawi_item_sid'),
  ('xx', 't_wawi_item_2', 'wawi', 'xx', 'wawi_item_sid', 'wawi_item_sid', 'xx', 'wawi_item_nat_key_nr',
  'wawi_item_nat_key_nr', 'no', 'meta', 'meta', 'wawi_item_2', 'wawi_item_key_type_cd', 'wawi_item_nat_key_nr',
  'wawi_item_sid'),
  ('xx', 't_wawi_item_2', 'wawi', 'xx', 'country_org_sid', 'country_org_sid', 'xx', 'country_org_nat_key',
  'country_org_nat_key', 'no', 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid'),
  ('xx', 't_wawi_item_variant_sales_price_2', 'wawi', 'xx', 'price_grp_sid', 'price_grp_sid', 'xx', 'price_grp_nat_key_nr'
  , 'price_grp_nat_key_nr', 'no', 'meta', 'meta', 'price_group', 'price_grp_key_type_cd', 'price_grp_nat_key_nr',
  'price_grp_sid'),
  ('xx', 't_wawi_item_variant_sales_price_2', 'wawi', 'xx', 'wawi_item_variant_sid', 'wawi_item_variant_sid', 'xx',
  'wawi_item_variant_nat_key_nr', 'wawi_item_variant_nat_key_nr', 'no', 'meta', 'meta', 'wawi_item_variant',
  'wawi_item_variant_key_type_cd', 'wawi_item_variant_nat_key_nr', 'wawi_item_variant_sid');