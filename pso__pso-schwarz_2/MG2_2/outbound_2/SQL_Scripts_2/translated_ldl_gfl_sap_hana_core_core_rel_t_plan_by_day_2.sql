MERGE INTO ldl_data_production_etl_process.t_lookup_instr_2 AS tgt
USING (SELECT 'xx' AS country_2,
  't_plan_by_day_2' AS target_table,
  'saphana' AS source_system,
  'xx' AS source_unique_name,
  'planned_val_type_sid' AS sid_alias,
  'planned_val_type_sid' AS sid_name,
  'xx' AS table_name,
  'planned_val_type_natural_key' AS natural_keys,
  'planned_val_type_natural_key' AS temp_alias_keys,
  'no' AS add_temporal_join,
  'meta' AS lkp_table_area,
  'meta' AS keyspace_schema,
  'planned_value_type' AS keyspace_subject_area,
  'planned_val_type_key_type_cd' AS keyspace_key_type_cd,
  'planned_val_type_nat_key_nr' AS keyspace_natural_key_name,
  'planned_val_type_sid' AS keyspace_sid_key_name) AS src
ON tgt.country_2 = src.country_2 AND tgt.target_table = src.target_table AND tgt.source_system = src.source_system AND tgt.source_unique_name
     = src.source_unique_name AND tgt.sid_alias = src.sid_alias AND tgt.sid_name = src.sid_name
WHEN MATCHED THEN UPDATE SET
 table_name = src.table_name,
 natural_keys = src.natural_keys,
 temp_alias_keys = src.temp_alias_keys,
 add_temporal_join = src.add_temporal_join,
 lkp_table_area = src.lkp_table_area,
 keyspace_schema = src.keyspace_schema,
 keyspace_subject_area = src.keyspace_subject_area,
 keyspace_key_type_cd = src.keyspace_key_type_cd,
 keyspace_natural_key_name = src.keyspace_natural_key_name,
 keyspace_sid_key_name = src.keyspace_sid_key_name
WHEN NOT MATCHED THEN INSERT VALUES(src.country_2, src.target_table, src.source_system, src.source_unique_name, src.sid_alias
 , src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema
 , src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name);


MERGE INTO ldl_data_production_etl_process.t_lookup_instr_2 AS tgt
USING (SELECT 'xx' AS country_2,
  't_plan_by_day_2' AS target_table,
  'saphana' AS source_system,
  'xx' AS source_unique_name,
  'real_estate_sid' AS sid_alias,
  'real_estate_sid' AS sid_name,
  'xx' AS table_name,
  'real_estate_natural_key' AS natural_keys,
  'real_estate_natural_key' AS temp_alias_keys,
  'no' AS add_temporal_join,
  'meta' AS lkp_table_area,
  'meta' AS keyspace_schema,
  'resource_item' AS keyspace_subject_area,
  'resource_item_key_type_cd' AS keyspace_key_type_cd,
  'resource_item_nat_key_nr' AS keyspace_natural_key_name,
  'resource_item_sid' AS keyspace_sid_key_name) AS src
ON tgt.country_2 = src.country_2 AND tgt.target_table = src.target_table AND tgt.source_system = src.source_system AND tgt.source_unique_name
     = src.source_unique_name AND tgt.sid_alias = src.sid_alias AND tgt.sid_name = src.sid_name
WHEN MATCHED THEN UPDATE SET
 table_name = src.table_name,
 natural_keys = src.natural_keys,
 temp_alias_keys = src.temp_alias_keys,
 add_temporal_join = src.add_temporal_join,
 lkp_table_area = src.lkp_table_area,
 keyspace_schema = src.keyspace_schema,
 keyspace_subject_area = src.keyspace_subject_area,
 keyspace_key_type_cd = src.keyspace_key_type_cd,
 keyspace_natural_key_name = src.keyspace_natural_key_name,
 keyspace_sid_key_name = src.keyspace_sid_key_name
WHEN NOT MATCHED THEN INSERT VALUES(src.country_2, src.target_table, src.source_system, src.source_unique_name, src.sid_alias
 , src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema
 , src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name);


MERGE INTO ldl_data_production_etl_process.t_lookup_instr_2 AS tgt
USING (SELECT 'xx' AS country_2,
  't_plan_by_day_2' AS target_table,
  'saphana' AS source_system,
  'xx' AS source_unique_name,
  'int_org_sid' AS sid_alias,
  'int_org_sid' AS sid_name,
  'xx' AS table_name,
  't_internal_organization_2' AS natural_keys,
  'int_org_natural_key' AS temp_alias_keys,
  'no' AS add_temporal_join,
  'meta' AS lkp_table_area,
  'meta' AS keyspace_schema,
  'party' AS keyspace_subject_area,
  'party_key_type_cd' AS keyspace_key_type_cd,
  'party_nat_key_nr' AS keyspace_natural_key_name,
  'party_sid' AS keyspace_sid_key_name) AS src
ON tgt.country_2 = src.country_2 AND tgt.target_table = src.target_table AND tgt.source_system = src.source_system AND tgt.source_unique_name
     = src.source_unique_name AND tgt.sid_alias = src.sid_alias AND tgt.sid_name = src.sid_name
WHEN MATCHED THEN UPDATE SET
 table_name = src.table_name,
 natural_keys = src.natural_keys,
 temp_alias_keys = src.temp_alias_keys,
 add_temporal_join = src.add_temporal_join,
 lkp_table_area = src.lkp_table_area,
 keyspace_schema = src.keyspace_schema,
 keyspace_subject_area = src.keyspace_subject_area,
 keyspace_key_type_cd = src.keyspace_key_type_cd,
 keyspace_natural_key_name = src.keyspace_natural_key_name,
 keyspace_sid_key_name = src.keyspace_sid_key_name
WHEN NOT MATCHED THEN INSERT VALUES(src.country_2, src.target_table, src.source_system, src.source_unique_name, src.sid_alias
 , src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema
 , src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name);