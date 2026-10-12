DELETE FROM ldl_data_production_etl_process.t_lookup_instr_1
WHERE source_system = 'txj';


INSERT INTO ldl_data_production_etl_process.t_lookup_instr_1 (country_1, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_tcache_pos_systems_txj_product_statistics_1', 'txj', 'xx', 'country_org_sid', 'country_org_sid', 'xx',
  'country_org_nk', 'country_org_nk', 'no', 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr',
  'party_sid'),
  ('xx', 't_tcache_pos_systems_txj_product_statistics_1', 'txj', 'xx', 'store_sid', 'store_sid', 'xx', 'store_nk',
  'store_nk', 'no', 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid'),
  ('xx', 't_tcache_pos_systems_txj_product_statistics_1', 'txj', 'xx', 'real_estate_sid', 'real_estate_sid', 'xx',
  'real_estate_nk', 'real_estate_nk', 'no', 'meta', 'meta', 'resource_item', 'resource_item_key_type_cd',
  'resource_item_nat_key_nr', 'resource_item_sid'),
  ('xx', 't_tcache_pos_systems_txj_product_statistics_1', 'txj', 'xx', 'sales_variant_sid', 'sales_variant_sid', 'xx',
  'sales_variant_nk', 'sales_variant_nk', 'no', 'meta', 'meta', 'product_variant', 'prod_variant_key_type_cd',
  'prod_variant_nat_key_nr', 'prod_variant_sid'),
  ('xx', 't_tcache_txj_510_load_2_tcache_daily_vat_statistics_intermediate_1', 'txj', 'xx', 'geo_area_sid', 'geo_area_sid'
  , 'xx', 'src_bic_zmlila', 'src_bic_zmlila', 'no', 'meta', 'meta', 'geographical_area', 'geo_area_key_type_cd',
  'geo_area_nat_key_nr', 'geo_area_sid'),
  ('xx', 't_tcache_txj_510_load_2_tcache_daily_vat_statistics_intermediate_1', 'txj', 'xx', 'real_estate_sid',
  'real_estate_sid', 'xx', 'src_bic_zmlila,src_orig_store_nr', 'src_bic_zmlila,src_orig_store_nr', 'no', 'meta', 'meta'
  , 'resource_item', 'resource_item_key_type_cd', 'resource_item_nat_key_nr', 'resource_item_sid'),
  ('xx', 't_tcache_txj_510_load_2_tcache_daily_vat_statistics_intermediate_1', 'txj', 'xx', 'country_org_sid',
  'country_org_sid', 'xx', 'src_bic_zmlila', 'src_bic_zmlila', 'no', 'meta', 'meta', 'party', 'party_key_type_cd',
  'party_nat_key_nr', 'party_sid'),
  ('xx', 't_tcache_txj_510_load_2_tcache_daily_vat_statistics_intermediate_1', 'txj', 'xx', 'store_sid', 'store_sid', 'xx'
  , 'src_bic_zmlila,src_orig_store_nr', 'src_bic_zmlila,src_orig_store_nr', 'no', 'meta', 'meta', 'party',
  'party_key_type_cd', 'party_nat_key_nr', 'party_sid');