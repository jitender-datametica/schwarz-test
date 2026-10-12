MERGE INTO ldl_data_production_etl_process.t_lookup_instr tgt
USING (
  SELECT 
    'xx'                                      country,
    't_mdm_item_client_order_hist'            target_table,
    'misc'                                    source_system,
    'xx'                                      source_unique_name,
    'mdm_item_sid'                            sid_alias,
    'mdm_item_sid'                            sid_name,
    't_mdm_item'                              table_name,
    'item_selection_nr'                       natural_keys,
    'selectionitem_id'                        temp_alias_keys,
    'no'                                      add_temporal_join,
    'lew_core'                                lkp_table_area,
    ''                                        keyspace_schema,
    ''                                        keyspace_subject_area,
    ''                                        keyspace_key_type,
    ''                                        keyspace_natural_key_name,
    ''                                        keyspace_sid_key_name
) src
  ON tgt.country               = src.country
     AND tgt.target_table       = src.target_table
     AND tgt.source_system      = src.source_system
     AND tgt.source_unique_name = src.source_unique_name
     AND tgt.sid_alias          = src.sid_alias
     AND tgt.sid_name           = src.sid_name
WHEN MATCHED THEN
  UPDATE SET
    table_name               = src.table_name,
    natural_keys             = src.natural_keys,
    temp_alias_keys          = src.temp_alias_keys,
    add_temporal_join        = src.add_temporal_join,
    lkp_table_area           = src.lkp_table_area,
    keyspace_schema          = src.keyspace_schema,
    keyspace_subject_area    = src.keyspace_subject_area,
    keyspace_key_type_cd     = src.keyspace_key_type,
    keyspace_natural_key_name= src.keyspace_natural_key_name,
    keyspace_sid_key_name    = src.keyspace_sid_key_name
WHEN NOT MATCHED THEN
  INSERT (
    country,
    target_table,
    source_system,
    source_unique_name,
    sid_alias,
    sid_name,
    table_name,
    natural_keys,
    temp_alias_keys,
    add_temporal_join,
    lkp_table_area,
    keyspace_schema,
    keyspace_subject_area,
    keyspace_key_type,
    keyspace_natural_key_name,
    keyspace_sid_key_name
  )
  VALUES (
    src.country,
    src.target_table,
    src.source_system,
    src.source_unique_name,
    src.sid_alias,
    src.sid_name,
    src.table_name,
    src.natural_keys,
    src.temp_alias_keys,
    src.add_temporal_join,
    src.lkp_table_area,
    src.keyspace_schema,
    src.keyspace_subject_area,
    src.keyspace_key_type,
    src.keyspace_natural_key_name,
    src.keyspace_sid_key_name
  )
;
