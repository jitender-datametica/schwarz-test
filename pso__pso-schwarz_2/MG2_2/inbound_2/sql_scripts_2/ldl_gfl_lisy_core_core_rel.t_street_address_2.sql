MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx'                                   COUNTRY_2,
         't_street_address_2'                     target_table, -- Only Required For Foreign Key Specifications
         'lisy'                                 source_system,
         'xx'                                   source_unique_name,
         'street_addr_sid'                      sid_alias,
         'street_addr_sid'                      sid_name,  -- The SID field we are looking to populate
         'xx'                                   table_name, -- Only for key_generaion = ON (rare/legacy)
         'street_addr_nk'                       natural_keys,
         'street_addr_nk'                       temp_alias_keys,
         'no'                                   add_temporal_join,
         'meta'                                 lkp_table_area,
         'meta'                                 KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'address_2'                              KEYSPACE_SUBJECT_AREA,
         'addr_key_type_cd'                     KEYSPACE_KEY_TYPE_CD,
         'addr_nat_key_nr'                      KEYSPACE_NATURAL_KEY_NAME,
         'addr_sid'                             KEYSPACE_SID_KEY_NAME) src 
  ON  TGT.COUNTRY_2               = SRC.COUNTRY_2
  AND TGT.TARGET_TABLE          = SRC.TARGET_TABLE
  AND TGT.SOURCE_SYSTEM         = SRC.SOURCE_SYSTEM
  AND TGT.SOURCE_UNIQUE_NAME    = SRC.SOURCE_UNIQUE_NAME
  AND TGT.SID_ALIAS             = SRC.SID_ALIAS
  AND TGT.SID_NAME              = SRC.SID_NAME
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
         'xx'                                   country_2,
         't_street_address_2'                     target_table, -- Only Required For Foreign Key Specifications
         'lisy'                                 source_system,
         'xx'                                   source_unique_name,
         'country_sid'                          sid_alias,
         'country_sid'                          sid_name,  -- The SID field we are looking to populate
         'xx'                                   table_name, -- Only for key_generaion = ON (rare/legacy)
         'igl_isocode2'                         natural_keys,
         'igl_isocode2'                         temp_alias_keys,
         'no'                                   add_temporal_join,
         'meta'                                 lkp_table_area,
         'meta'                                 KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'                    KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'                 KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'                  KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                         KEYSPACE_SID_KEY_NAME) src 
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
         'xx'                                   country_2,
         't_street_address_2'                     target_table, -- Only Required For Foreign Key Specifications
         'lisy'                                 source_system,
         'xx'                                   source_unique_name,
         'city_sid'                             sid_alias,
         'city_sid'                             sid_name,  -- The SID field we are looking to populate
         'xx'                                   table_name, -- Only for key_generaion = ON (rare/legacy)
         'igl_isocode2,city_name'               natural_keys,
         'igl_isocode2,city_name'               temp_alias_keys,
         'no'                                   add_temporal_join,
         'meta'                                 lkp_table_area,
         'meta'                                 KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'                    KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'                 KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'                  KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                         KEYSPACE_SID_KEY_NAME) src 
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
         'xx'                                      country_2,
         't_street_address_2'                        target_table, -- Only Required For Foreign Key Specifications
         'lisy'                                    source_system,
         'xx'                                      source_unique_name,
         'district_sid'                            sid_alias,
         'district_sid'                            sid_name,  -- The SID field we are looking to populate
         'xx'                                      table_name, -- Only for key_generaion = ON (rare/legacy)
         'district_nk'                             natural_keys,
         'district_nk'                             temp_alias_keys,
         'no'                                      add_temporal_join,
         'meta'                                    lkp_table_area,
         'meta'                                    KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'                       KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'                    KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'                     KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                            KEYSPACE_SID_KEY_NAME) src 
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
         'xx'                                      country_2,
         't_street_address_2'                        target_table, -- Only Required For Foreign Key Specifications
         'lisy'                                    source_system,
         'xx'                                      source_unique_name,
         'postal_cd_area_sid'                      sid_alias,
         'postal_cd_area_sid'                      sid_name,  -- The SID field we are looking to populate
         'xx'                                      table_name, -- Only for key_generaion = ON (rare/legacy)
         'igl_isocode2,zip'                        natural_keys,
         'igl_isocode2,zip'                        temp_alias_keys,
         'no'                                      add_temporal_join,
         'meta'                                    lkp_table_area,
         'meta'                                    KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'                       KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'                    KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'                     KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                            KEYSPACE_SID_KEY_NAME) src 
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
         'xx'                                      country_2,
         't_street_address_2'                        target_table, -- Only Required For Foreign Key Specifications
         'lisy'                                    source_system,
         'xx'                                      source_unique_name,
         'reporting_country_sid'                   sid_alias,
         'reporting_country_sid'                   sid_name,  -- The SID field we are looking to populate
         'xx'                                      table_name, -- Only for key_generaion = ON (rare/legacy)
         'igl_isocode2'                            natural_keys,
         'igl_isocode2'                            temp_alias_keys,
         'no'                                      add_temporal_join,
         'meta'                                    lkp_table_area,
         'meta'                                    KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'                       KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'                    KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'                     KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                            KEYSPACE_SID_KEY_NAME) src 
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
