-- etl_process.t_lookup_instr
MERGE INTO ${configuration_table} AS tgt USING (
  SELECT
      'xx' AS country,
      't_product' /* Only Required For Foreign Key Specifications*/ AS target_table,
      'cbx' AS source_system,
      'xx' AS source_unique_name,
      'prod_sid' AS sid_alias,
      'prod_sid' /* The SID field we are looking to populate*/ AS sid_name,
      'xx' /* Only for key_generaion = ON (rare)*/ AS table_name,
      'prod_nr' AS natural_keys,
      'prod_nr' AS temp_alias_keys,
      'no' AS add_temporal_join,
      'meta' AS lkp_table_area,
      'meta' /* Following and remaining details are from the key table definition*/ AS keyspace_schema,
      'product' AS keyspace_subject_area,
      'prod_key_type_cd' AS keyspace_key_type_cd,
      'prod_nat_key_nr' AS keyspace_natural_key_name,
      'prod_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country = src.country
 AND tgt.target_table = src.target_table
 AND tgt.source_system = src.source_system
 AND tgt.source_unique_name = src.source_unique_name
 AND tgt.sid_alias = src.sid_alias
 AND tgt.sid_name = src.sid_name
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
   WHEN NOT MATCHED BY TARGET THEN
    INSERT
    VALUES (src.country, src.target_table, src.source_system, src.source_unique_name, src.sid_alias, src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema, src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name)
;
