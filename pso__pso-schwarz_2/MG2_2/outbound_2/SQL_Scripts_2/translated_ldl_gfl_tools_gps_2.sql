DELETE FROM ldl_data_production_etl_process.t_lookup_instr_2
WHERE source_system = 'gps';


INSERT INTO ldl_data_production_etl_process.t_lookup_instr_2 (country_2, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_employee_time_tracking_2', 'gps', 'xx', 'int_org_sid', 'int_org_sid', 'xx', 'int_org_natural_key',
  'int_org_natural_key', 'no', 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid'),
  ('xx', 't_employee_time_tracking_2', 'gps', 'xx', 'country_org_sid', 'country_org_sid', 'xx', 'country_org_natural_key'
  , 'country_org_natural_key', 'no', 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid'),
  ('xx', 't_employee_time_tracking_2', 'gps', 'xx', 'emp_tm_period_type_sid', 'emp_tm_period_type_sid', 'xx',
  'emp_tm_period_type_natural_key', 'emp_tm_period_type_natural_key', 'no', 'meta', 'meta', 'employee_time_period_type'
  , 'emp_tm_period_type_key_type_cd', 'emp_tm_period_type_nat_key_nr', 'emp_tm_period_type_sid'),
  ('xx', 't_employee_time_period_type_2', 'gps', 'xx', 'int_company_sid', 'int_company_sid', 'xx',
  'int_company_natural_key', 'int_company_natural_key', 'no', 'meta', 'meta', 'party', 'party_key_type_cd',
  'party_nat_key_nr', 'party_sid'),
  ('xx', 't_employee_time_period_type_2', 'gps', 'xx', 'emp_tm_period_type_sid', 'emp_tm_period_type_sid', 'xx',
  'emp_tm_period_type_natural_key', 'emp_tm_period_type_natural_key', 'no', 'meta', 'meta', 'employee_time_period_type'
  , 'emp_tm_period_type_key_type_cd', 'emp_tm_period_type_nat_key_nr', 'emp_tm_period_type_sid');