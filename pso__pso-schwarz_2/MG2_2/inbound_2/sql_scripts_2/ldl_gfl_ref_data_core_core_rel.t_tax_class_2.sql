MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
       'xx' country_2,
         't_tax_class_2'       target_table, -- Only Required For Foreign Key Specifications
         'common'                          source_system,
         'xx'                           source_unique_name,
         'geo_area_sid'                 sid_alias,
         'geo_area_sid'                 sid_name,  -- The SID field we are looking to populate
         'xx'                    table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'country_org_cd'                   natural_keys,
         'country_org_cd'                   temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'            KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'         KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'          KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                 KEYSPACE_SID_KEY_NAME) src 
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

