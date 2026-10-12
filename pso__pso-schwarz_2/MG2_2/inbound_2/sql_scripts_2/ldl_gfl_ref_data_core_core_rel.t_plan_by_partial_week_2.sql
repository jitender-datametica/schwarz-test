MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_2,
         't_plan_by_partial_week_2'                target_table, -- Only Required For Foreign Key Specifications (populate with table being populated)
         'kpges'                        source_system,
         'xx'                           source_unique_name,
         'real_estate_sid'              sid_alias,
         'real_estate_sid'              sid_name,  -- The SID field we are looking to populate
         'xx'                           table_name, -- The table we are populating for primary SIDs or the table we are "relating to" for for FK SIDs
         'real_estate_derived_nk'       natural_keys,
         'real_estate_derived_nk'       temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'    KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'     KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'            KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_2               = src.country_2
  AND tgt.target_table          = src.target_table
  AND tgt.source_system         = src.source_system
  AND tgt.source_unique_name    = src.source_unique_name
  AND tgt.sid_alias             = src.sid_alias
  AND tgt.sid_name              = src.sid_name
WHEN MATCHED THEN UPDATE 
SET 
  table_name                    = src.table_name,
  natural_keys                  = src.natural_keys,
  temp_alias_keys               = src.temp_alias_keys,
  add_temporal_join             = src.add_temporal_join,
  lkp_table_area                = src.lkp_table_area,
  KEYSPACE_SCHEMA               = src.KEYSPACE_SCHEMA,
  KEYSPACE_SUBJECT_AREA         = src.KEYSPACE_SUBJECT_AREA,
  KEYSPACE_KEY_TYPE_CD          = src.KEYSPACE_KEY_TYPE_CD,
  KEYSPACE_NATURAL_KEY_NAME     = src.KEYSPACE_NATURAL_KEY_NAME,
  KEYSPACE_SID_KEY_NAME         = src.KEYSPACE_SID_KEY_NAME
WHEN NOT MATCHED THEN
INSERT
VALUES 
  (     src.country_2, 
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;


MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_2,
         't_plan_by_partial_week_2'       target_table, -- Only Required For Foreign Key Specifications
         'kpges'                        source_system,
         'xx'                           source_unique_name,
         'int_org_sid'                  sid_alias,
         'int_org_sid'                  sid_name,  -- The SID field we are looking to populate
         't_internal_organization_2'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'src_org_derived_nk'           natural_keys,
         'src_org_derived_nk'           temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_2               = src.country_2
  AND tgt.target_table          = src.target_table
  AND tgt.source_system         = src.source_system
  AND tgt.source_unique_name    = src.source_unique_name
  AND tgt.sid_alias             = src.sid_alias
  AND tgt.sid_name              = src.sid_name
WHEN MATCHED THEN UPDATE 
SET 
  table_name                    = src.table_name,
  natural_keys                  = src.natural_keys,
  temp_alias_keys               = src.temp_alias_keys,
  add_temporal_join             = src.add_temporal_join,
  lkp_table_area                = src.lkp_table_area,
  KEYSPACE_SCHEMA               = src.KEYSPACE_SCHEMA,
  KEYSPACE_SUBJECT_AREA         = src.KEYSPACE_SUBJECT_AREA,
  KEYSPACE_KEY_TYPE_CD          = src.KEYSPACE_KEY_TYPE_CD,
  KEYSPACE_NATURAL_KEY_NAME     = src.KEYSPACE_NATURAL_KEY_NAME,
  KEYSPACE_SID_KEY_NAME         = src.KEYSPACE_SID_KEY_NAME
WHEN NOT MATCHED THEN
INSERT
VALUES 
  (     src.country_2, 
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_2,
         't_plan_by_partial_week_2'       target_table, -- Only Required For Foreign Key Specifications - the related table that (should) contain the related row
         'kpges'                        source_system,
         'xx'                           source_unique_name,
         'planned_val_type_sid'         sid_alias,
         'planned_val_type_sid'         sid_name,  -- The SID field we are looking to populate
         't_planned_value_type_2'         table_name, -- The table on which that SID field resides
         'src_ind_derived_nk'           natural_keys,
         'src_ind_derived_nk'           temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'planned_value_type'           KEYSPACE_SUBJECT_AREA,
         'planned_val_type_key_type_cd' KEYSPACE_KEY_TYPE_CD,
         'planned_val_type_nat_key_nr'  KEYSPACE_NATURAL_KEY_NAME,
         'planned_val_type_sid'         KEYSPACE_SID_KEY_NAME) src -- SID Name on the Key table
  ON  tgt.country_2               = src.country_2
  AND tgt.target_table          = src.target_table
  AND tgt.source_system         = src.source_system
  AND tgt.source_unique_name    = src.source_unique_name
  AND tgt.sid_alias             = src.sid_alias
  AND tgt.sid_name              = src.sid_name
WHEN MATCHED THEN UPDATE 
SET 
  table_name                    = src.table_name,
  natural_keys                  = src.natural_keys,
  temp_alias_keys               = src.temp_alias_keys,
  add_temporal_join             = src.add_temporal_join,
  lkp_table_area                = src.lkp_table_area,
  KEYSPACE_SCHEMA               = src.KEYSPACE_SCHEMA,
  KEYSPACE_SUBJECT_AREA         = src.KEYSPACE_SUBJECT_AREA,
  KEYSPACE_KEY_TYPE_CD          = src.KEYSPACE_KEY_TYPE_CD,
  KEYSPACE_NATURAL_KEY_NAME     = src.KEYSPACE_NATURAL_KEY_NAME,
  KEYSPACE_SID_KEY_NAME         = src.KEYSPACE_SID_KEY_NAME
WHEN NOT MATCHED THEN
INSERT
VALUES 
  (     src.country_2, 
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

