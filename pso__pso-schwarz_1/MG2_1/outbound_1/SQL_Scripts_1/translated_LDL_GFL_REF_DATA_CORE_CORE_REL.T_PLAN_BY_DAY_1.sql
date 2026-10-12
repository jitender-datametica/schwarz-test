MERGE INTO ${CONFIGURATION_TABLE}  AS tgt
USING (SELECT 'xx' AS country_1,
  't_plan_by_day_1' AS target_table,
  -- Only Required For Foreign Key Specifications (populate with table being populated)
 'kpges' AS source_system,
  'xx' AS source_unique_name,
  'real_estate_sid' AS sid_alias,
  'real_estate_sid' AS sid_name,
  -- The SID field we are looking to populate
 'xx' AS table_name,
  -- The table we are populating for primary SIDs or the table we are "relating to" for for FK SIDs

  'real_estate_derived_nk' AS natural_keys,
  'real_estate_derived_nk' AS temp_alias_keys,
  'no' AS add_temporal_join,
  'meta' AS lkp_table_area,
  'meta' AS keyspace_schema,
  -- Following and remaining details are from the key table definition
 'resource_item' AS keyspace_subject_area,
  'resource_item_key_type_cd' AS keyspace_key_type_cd,
  'resource_item_nat_key_nr' AS keyspace_natural_key_name,
  'resource_item_sid' AS keyspace_sid_key_name) AS src
ON tgt.country_1 = src.country_1 AND tgt.target_table = src.target_table AND tgt.source_system = src.source_system AND tgt.source_unique_name
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
WHEN NOT MATCHED THEN INSERT VALUES(src.country_1, src.target_table, src.source_system, src.source_unique_name, src.sid_alias
 , src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema
 , src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name);


MERGE INTO ${CONFIGURATION_TABLE}  AS tgt
USING (SELECT 'xx' AS country_1,
  't_plan_by_day_1' AS target_table,
  -- Only Required For Foreign Key Specifications
 'kpges' AS source_system,
  'xx' AS source_unique_name,
  'int_org_sid' AS sid_alias,
  'int_org_sid' AS sid_name,
  -- The SID field we are looking to populate
 'xx' AS table_name,
  -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs

  'src_org_derived_nk' AS natural_keys,
  'src_org_derived_nk' AS temp_alias_keys,
  'no' AS add_temporal_join,
  'meta' AS lkp_table_area,
  'meta' AS keyspace_schema,
  -- Following and remaining details are from the key table definition
 'party' AS keyspace_subject_area,
  'party_key_type_cd' AS keyspace_key_type_cd,
  'party_nat_key_nr' AS keyspace_natural_key_name,
  'party_sid' AS keyspace_sid_key_name) AS src
ON tgt.country_1 = src.country_1 AND tgt.target_table = src.target_table AND tgt.source_system = src.source_system AND tgt.source_unique_name
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
WHEN NOT MATCHED THEN INSERT VALUES(src.country_1, src.target_table, src.source_system, src.source_unique_name, src.sid_alias
 , src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema
 , src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name);


-- SID Name on the Key table
 MERGE INTO ${temp_schema}.${CONFIGURATION_TABLE}
AS tgt
USING (SELECT 'xx' AS country_1,
  't_plan_by_day_1' AS target_table,
  -- Only Required For Foreign Key Specifications - the related table that (should) contain the related row
 'kpges' AS
  source_system,
  'xx' AS source_unique_name,
  'planned_val_type_sid' AS sid_alias,
  'planned_val_type_sid' AS sid_name,
  -- The SID field we are looking to populate
 't_planned_value_type_1' AS table_name,
  -- The table on which that SID field resides
 'src_ind_derived_nk' AS natural_keys,
  'src_ind_derived_nk' AS temp_alias_keys,
  'no' AS add_temporal_join,
  'meta' AS lkp_table_area,
  'meta' AS keyspace_schema,
  -- Following and remaining details are from the key table definition
 'planned_value_type' AS keyspace_subject_area,
  'planned_val_type_key_type_cd' AS keyspace_key_type_cd,
  'planned_val_type_nat_key_nr' AS keyspace_natural_key_name,
  'planned_val_type_sid' AS keyspace_sid_key_name) AS src
ON tgt.country_1 = src.country_1 AND tgt.target_table = src.target_table AND tgt.source_system = src.source_system AND tgt.source_unique_name
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
WHEN NOT MATCHED THEN INSERT VALUES(src.country_1, src.target_table, src.source_system, src.source_unique_name, src.sid_alias
 , src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema
 , src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name);