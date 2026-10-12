merge into ${CONFIGURATION_TABLE} tgt using 
(select 
 'xx'                                      country_1,
 't_postal_code_area_1'                      target_table, -- Only Required For Foreign Key Specifications
 'lisy'                                    source_system,
 'xx'                                      source_unique_name,
 'postal_cd_area_sid'                      sid_alias,
 'postal_cd_area_sid'                      sid_name,  -- The SID field we are looking to populate
 'xx'                                      table_name, -- Only for key_generaion = ON (rare/legacy)
 'postal_cd_area_nat_key_nr'               natural_keys,
 'postal_cd_area_nat_key_nr'               temp_alias_keys,
 'no'                                      add_temporal_join,
 'meta'                                    lkp_table_area,
 'meta'                                    keyspace_schema,  -- Following and remaining details are from the key table definition 
 'geographical_area'                       keyspace_subject_area,
 'geo_area_key_type_cd'                    keyspace_key_type_cd,
 'geo_area_nat_key_nr'                     keyspace_natural_key_name,
 'geo_area_sid'                            keyspace_sid_key_name) src 
  on  tgt.country_1               = src.country_1
  and tgt.target_table          = src.target_table
  and tgt.source_system         = src.source_system
  and tgt.source_unique_name    = src.source_unique_name
  and tgt.sid_alias             = src.sid_alias
  and tgt.sid_name              = src.sid_name
when matched then update 
set 
  table_name                    = src.table_name,
  natural_keys                  = src.natural_keys,
  temp_alias_keys               = src.temp_alias_keys,
  add_temporal_join             = src.add_temporal_join,
  lkp_table_area                = src.lkp_table_area,
  keyspace_schema               = src.keyspace_schema,
  keyspace_subject_area         = src.keyspace_subject_area,
  keyspace_key_type_cd          = src.keyspace_key_type_cd,
  keyspace_natural_key_name     = src.keyspace_natural_key_name,
  keyspace_sid_key_name         = src.keyspace_sid_key_name
when not matched then
insert
values 
  (     src.country_1, 
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
        src.keyspace_key_type_cd,
        src.keyspace_natural_key_name,
        src.keyspace_sid_key_name)
;

merge into ${CONFIGURATION_TABLE} tgt using 
  (select 
         'xx'                                   country_1,
         't_postal_code_area_1'                   target_table, -- only required for foreign key specifications
         'lisy'                                 source_system,
         'xx'                                   source_unique_name,
         'country_sid'                          sid_alias,
         'country_sid'                          sid_name,  -- the sid field we are looking to populate
         'xx'                                   table_name, -- only for key_generaion = on (rare/legacy)
         'country_nat_key_nr'                   natural_keys,
         'country_nat_key_nr'                   temp_alias_keys,
         'no'                                   add_temporal_join,
         'meta'                                 lkp_table_area,
         'meta'                                 keyspace_schema,  -- following and remaining details are from the key table definition 
         'geographical_area'                    keyspace_subject_area,
         'geo_area_key_type_cd'                 keyspace_key_type_cd,
         'geo_area_nat_key_nr'                  keyspace_natural_key_name,
         'geo_area_sid'                         keyspace_sid_key_name) src 
  on  tgt.country_1               = src.country_1
  and tgt.target_table          = src.target_table
  and tgt.source_system         = src.source_system
  and tgt.source_unique_name    = src.source_unique_name
  and tgt.sid_alias             = src.sid_alias
  and tgt.sid_name              = src.sid_name
when matched then update 
set 
  table_name                    = src.table_name,
  natural_keys                  = src.natural_keys,
  temp_alias_keys               = src.temp_alias_keys,
  add_temporal_join             = src.add_temporal_join,
  lkp_table_area                = src.lkp_table_area,
  keyspace_schema               = src.keyspace_schema,
  keyspace_subject_area         = src.keyspace_subject_area,
  keyspace_key_type_cd          = src.keyspace_key_type_cd,
  keyspace_natural_key_name     = src.keyspace_natural_key_name,
  keyspace_sid_key_name         = src.keyspace_sid_key_name
when not matched then
insert
values 
  (     src.country_1, 
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
        src.keyspace_key_type_cd,
        src.keyspace_natural_key_name,
        src.keyspace_sid_key_name)
;
