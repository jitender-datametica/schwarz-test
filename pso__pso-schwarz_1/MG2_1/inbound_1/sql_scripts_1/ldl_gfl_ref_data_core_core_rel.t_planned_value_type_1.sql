MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_1,
         'xx' target_table, -- Only Required For Foreign Key Specifications
         'kpges' source_system,
         'xx' source_unique_name,
         'planned_val_type_sid' sid_alias,
         'planned_val_type_sid' sid_name,
         't_planned_value_type_1' table_name, 
         'planned_val_type_id,planned_val_role_cd' natural_keys,
         'planned_val_type_id,planned_val_role_cd' temp_alias_keys,
         'no' add_temporal_join,
         'meta' lkp_table_area,
         'meta' KEYSPACE_SCHEMA,
         'planned_value_type' KEYSPACE_SUBJECT_AREA,
         'planned_val_type_key_type_cd' KEYSPACE_KEY_TYPE_CD,
         'planned_val_type_nat_key_nr' KEYSPACE_NATURAL_KEY_NAME,
         'planned_val_type_sid' KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
  AND tgt.target_table       = src.target_table
  AND tgt.source_system      = src.source_system
  AND tgt.source_unique_name = src.source_unique_name
  AND tgt.sid_alias      = src.sid_alias
  AND tgt.sid_name         = src.sid_name
WHEN MATCHED THEN UPDATE 
SET 
  table_name          = src.table_name,
  natural_keys = src.natural_keys,
  temp_alias_keys    = src.temp_alias_keys,
  add_temporal_join  = src.add_temporal_join,
  lkp_table_area     = src.lkp_table_area,
  KEYSPACE_SCHEMA    = src.KEYSPACE_SCHEMA,
  KEYSPACE_SUBJECT_AREA = src.KEYSPACE_SUBJECT_AREA,
  KEYSPACE_KEY_TYPE_CD  = src.KEYSPACE_KEY_TYPE_CD,
  KEYSPACE_NATURAL_KEY_NAME = src.KEYSPACE_NATURAL_KEY_NAME,
  KEYSPACE_SID_KEY_NAME = src.KEYSPACE_SID_KEY_NAME
WHEN NOT MATCHED THEN
INSERT
VALUES 
  (src.country_1, src.target_table, src.source_system, src.source_unique_name, src.sid_alias, src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area,src.KEYSPACE_SCHEMA,src.KEYSPACE_SUBJECT_AREA,src.KEYSPACE_KEY_TYPE_CD,src.KEYSPACE_NATURAL_KEY_NAME,src.KEYSPACE_SID_KEY_NAME)
;
