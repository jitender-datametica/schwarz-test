MERGE INTO etl_process.T_LOOKUP_INSTR_2 tgt USING 
  (SELECT 
         'xx' country_2,
         't_mdm_item_client_order_hist_2' target_table,
         'misc' source_system,
         'xx' source_unique_name,
         'mdm_item_sid' sid_alias,
         'mdm_item_sid' sid_name,
         't_mdm_item_2' table_name,
         'item_selection_nr' natural_keys,
         'selectionitem_id' temp_alias_keys,
         'no' add_temporal_join,
         'lew_core' lkp_table_area,
         '' KEYSPACE_SCHEMA,
         '' KEYSPACE_SUBJECT_AREA,
         '' KEYSPACE_KEY_TYPE,
         '' KEYSPACE_NATURAL_KEY_NAME,
         '' KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_2               = src.country_2
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
  KEYSPACE_KEY_TYPE  = src.KEYSPACE_KEY_TYPE,
  KEYSPACE_NATURAL_KEY_NAME = src.KEYSPACE_NATURAL_KEY_NAME,
  KEYSPACE_SID_KEY_NAME = src.KEYSPACE_SID_KEY_NAME
WHEN NOT MATCHED THEN
INSERT
VALUES 
  (src.country_2, src.target_table, src.source_system, src.source_unique_name, src.sid_alias, src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area,src.KEYSPACE_SCHEMA,src.KEYSPACE_SUBJECT_AREA,src.KEYSPACE_KEY_TYPE,src.KEYSPACE_NATURAL_KEY_NAME,src.KEYSPACE_SID_KEY_NAME)
;
