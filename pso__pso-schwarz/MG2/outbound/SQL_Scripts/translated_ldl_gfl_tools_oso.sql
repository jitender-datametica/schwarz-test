DELETE FROM ldl_data_production_etl_process.t_lookup_instr
WHERE source_system = 'oso';


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_store_opening_hours', 'oso', 'xx', 'store_sid', 'store_sid', 'xx', 'store_natural_key',
  'store_natural_key', 'no', 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid');


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_store_opening_hours', 'oso', 'xx', 'store_sid', 'store_sid', 'xx', 'store_natural_key',
  'store_natural_key', 'no', 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid');


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_tcache_oso_internal_organization_hierarchy', 'oso', 'xx', 'parent_int_org_sid', 'parent_int_org_sid',
  'xx', 'parent_int_org_natural_key', 'parent_int_org_natural_key', 'no', 'meta', 'meta', 'party', 'party_key_type_cd',
  'party_nat_key_nr', 'party_sid');


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_tcache_oso_internal_organization_hierarchy', 'oso', 'xx', 'int_org_sid', 'int_org_sid', 'xx',
  'int_org_natural_key', 'int_org_natural_key', 'no', 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr',
  'party_sid');


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_tcache_oso_internal_organization', 'oso', 'xx', 'int_org_sid', 'int_org_sid', 'xx',
  'int_org_natural_key', 'int_org_natural_key', 'no', 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr',
  'party_sid');


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_job_role', 'oso', 'xx', 'job_role_sid', 'job_role_sid', 'xx', 'job_role_nat_key_nr',
  'job_role_nat_key_nr', 'no', 'meta', 'meta', 'job_role', 'job_role_key_type_cd', 'job_role_nat_key_nr', 'job_role_sid'
  );


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_job_role', 'oso', 'xx', 'int_org_sid', 'int_org_sid', 'xx', 'int_org_nat_key', 'int_org_nat_key', 'no'
  , 'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid');


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_job_role', 'oso', 'xx', 'reports_to_job_role_sid', 'reports_to_job_role_sid', 'xx',
  'reports_to_job_role_nat_key_nr', 'reports_to_job_role_nat_key_nr', 'no', 'meta', 'meta', 'job_role',
  'job_role_key_type_cd', 'job_role_nat_key_nr', 'job_role_sid');


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_employee_job_role', 'oso', 'xx', 'job_role_sid', 'job_role_sid', 'xx', 'job_role_nat_key_nr',
  'job_role_nat_key_nr', 'no', 'meta', 'meta', 'job_role', 'job_role_key_type_cd', 'job_role_nat_key_nr', 'job_role_sid'
  );


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_employee_job_role', 'oso', 'xx', 'emp_sid', 'emp_sid', 'xx', 'emp_nat_key_nr', 'emp_nat_key_nr', 'no',
  'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid');


INSERT INTO ldl_data_production_etl_process.t_lookup_instr (country, target_table, source_system, source_unique_name,
 sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema,
 keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
VALUES ('xx', 't_person', 'oso', 'xx', 'person_sid', 'person_sid', 'xx', 'party_nat_key_nr', 'party_nat_key_nr', 'no',
  'meta', 'meta', 'party', 'party_key_type_cd', 'party_nat_key_nr', 'party_sid');