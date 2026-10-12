DELETE FROM ldl_data_production_etl_process.t_lookup_instr_1
WHERE source_system = 'common';


INSERT INTO ldl_data_production_etl_process.t_lookup_instr_1 (country_1, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_tax_class_1', 'common', 'xx', 'geo_area_sid', 'geo_area_sid', 'xx', 'country_org_cd', 'country_org_cd',
  'no', 'meta', 'meta', 'geographical_area', 'geo_area_key_type_cd', 'geo_area_nat_key_nr', 'geo_area_sid');