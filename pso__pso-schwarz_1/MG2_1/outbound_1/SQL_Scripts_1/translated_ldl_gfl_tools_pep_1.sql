DELETE FROM ldl_data_production_etl_process.t_lookup_instr_1
WHERE source_system = 'pep';


INSERT INTO ldl_data_production_etl_process.t_lookup_instr_1 (country_1, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_tcache_pep_gps_plantimeday_1', 'pep', 'xx', 'int_org_sid', 'int_org_sid', 'xx', 'int_org_natural_key',
  'int_org_natural_key', 'no', 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid'),
  ('xx', 't_plan_by_day_1', 'pep', 'xx', 'planned_val_type_sid', 'planned_val_type_sid', 'xx',
  'planned_val_type_natural_key', 'planned_val_type_natural_key', 'no', 'meta', 'meta', 'planned_value_type',
  'planned_val_type_key_type_cd', 'planned_val_type_nat_key_nr', 'planned_val_type_sid');