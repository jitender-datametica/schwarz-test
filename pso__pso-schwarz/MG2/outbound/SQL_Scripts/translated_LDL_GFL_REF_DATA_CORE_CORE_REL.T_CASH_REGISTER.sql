MERGE INTO ${CONFIGURATION_TABLE}  AS tgt
USING (SELECT 'xx' AS country,
  'xx' AS target_table,
  -- Only Required For Foreign Key Specifications
 'ejr' AS source_system,
  'xx' AS source_unique_name,
  'cash_register_sid' AS sid_alias,
  'cash_register_sid' AS sid_name,
  -- The SID field we are looking to populate
 't_cash_register' AS table_name,
  -- The table we are populating for primary SIDs or teh target we are relating to for foreign key SIDs

  'context_country,orig_store_nr,pos_terminal_id' AS natural_keys,
  'context_country,orig_store_nr,pos_terminal_id' AS temp_alias_keys,
  'no' AS add_temporal_join,
  'meta' AS lkp_table_area,
  'meta' AS keyspace_schema,
  -- Following and remaining details are from the key table definition
 'resource_item' AS keyspace_subject_area,
  'resource_item_key_type_cd' AS keyspace_key_type_cd,
  'resource_item_nat_key_nr' AS keyspace_natural_key_name,
  'resource_item_sid' AS keyspace_sid_key_name) AS src
ON tgt.country = src.country AND tgt.target_table = src.target_table AND tgt.source_system = src.source_system AND tgt.source_unique_name
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
WHEN NOT MATCHED THEN INSERT VALUES(src.country, src.target_table, src.source_system, src.source_unique_name, src.sid_alias
 , src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema
 , src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name);


MERGE INTO ${CONFIGURATION_TABLE}  AS tgt
USING (SELECT 'xx' AS country,
  'xx' AS target_table,
  -- Only Required For Foreign Key Specifications
 'ejr' AS source_system,
  'xx' AS source_unique_name,
  'real_estate_sid' AS sid_alias,
  'real_estate_sid' AS sid_name,
  -- The SID field we are looking to populate
 't_cash_register' AS table_name,
  -- The table we are populating for primary SIDs or teh target we are relating to for foreign key SIDs

  'context_country,orig_store_nr' AS natural_keys,
  'context_country,orig_store_nr' AS temp_alias_keys,
  'no' AS add_temporal_join,
  'meta' AS lkp_table_area,
  'meta' AS keyspace_schema,
  -- Following and remaining details are from the key table definition
 'resource_item' AS keyspace_subject_area,
  'resource_item_key_type_cd' AS keyspace_key_type_cd,
  'resource_item_nat_key_nr' AS keyspace_natural_key_name,
  'resource_item_sid' AS keyspace_sid_key_name) AS src
ON tgt.country = src.country AND tgt.target_table = src.target_table AND tgt.source_system = src.source_system AND tgt.source_unique_name
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
WHEN NOT MATCHED THEN INSERT VALUES(src.country, src.target_table, src.source_system, src.source_unique_name, src.sid_alias
 , src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema
 , src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name);