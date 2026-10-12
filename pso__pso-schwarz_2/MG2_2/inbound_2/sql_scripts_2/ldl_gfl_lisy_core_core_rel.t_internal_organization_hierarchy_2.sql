MERGE INTO ${CONFIGURATION_TABLE} TGT USING 
  (SELECT 
         'xx'                                   COUNTRY_2,
         't_internal_organization_hierarchy_2'    TARGET_TABLE, -- Only Required For Foreign Key Specifications
         'lisy'                                 SOURCE_SYSTEM,
         'xx'                                   SOURCE_UNIQUE_NAME,
         'int_org_sid'                          SID_ALIAS,
         'int_org_sid'                          SID_NAME,  -- The SID field we are looking to populate
         'xx'                                   TABLE_NAME, -- Only for key_generation = ON (rare/legacy)
         'int_org_natural_key'                  NATURAL_KEYS,
         'int_org_natural_key'                  TEMP_ALIAS_KEYS,
         'no'                                   ADD_TEMPORAL_JOIN,
         'meta'                                 LKP_TABLE_AREA,
         'meta'                                 KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                                KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'                    KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'                     KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                            KEYSPACE_SID_KEY_NAME) SRC 
  ON  TGT.COUNTRY_2               = SRC.COUNTRY_2
  AND TGT.TARGET_TABLE          = SRC.TARGET_TABLE
  AND TGT.SOURCE_SYSTEM         = SRC.SOURCE_SYSTEM
  AND TGT.SOURCE_UNIQUE_NAME    = SRC.SOURCE_UNIQUE_NAME
  AND TGT.SID_ALIAS             = SRC.SID_ALIAS
  AND TGT.SID_NAME              = SRC.SID_NAME
WHEN MATCHED THEN UPDATE 
SET 
  TABLE_NAME                    = SRC.TABLE_NAME,
  NATURAL_KEYS                  = SRC.NATURAL_KEYS,
  TEMP_ALIAS_KEYS               = SRC.TEMP_ALIAS_KEYS,
  ADD_TEMPORAL_JOIN             = SRC.ADD_TEMPORAL_JOIN,
  LKP_TABLE_AREA                = SRC.LKP_TABLE_AREA,
  KEYSPACE_SCHEMA               = SRC.KEYSPACE_SCHEMA,
  KEYSPACE_SUBJECT_AREA         = SRC.KEYSPACE_SUBJECT_AREA,
  KEYSPACE_KEY_TYPE_CD          = SRC.KEYSPACE_KEY_TYPE_CD,
  KEYSPACE_NATURAL_KEY_NAME     = SRC.KEYSPACE_NATURAL_KEY_NAME,
  KEYSPACE_SID_KEY_NAME         = SRC.KEYSPACE_SID_KEY_NAME
WHEN NOT MATCHED THEN
INSERT
VALUES 
  (     SRC.COUNTRY_2, 
        SRC.TARGET_TABLE, 
        SRC.SOURCE_SYSTEM, 
        SRC.SOURCE_UNIQUE_NAME, 
        SRC.SID_ALIAS, 
        SRC.SID_NAME, 
        SRC.TABLE_NAME, 
        SRC.NATURAL_KEYS, 
        SRC.TEMP_ALIAS_KEYS, 
        SRC.ADD_TEMPORAL_JOIN, 
        SRC.LKP_TABLE_AREA,
        SRC.KEYSPACE_SCHEMA,
        SRC.KEYSPACE_SUBJECT_AREA,
        SRC.KEYSPACE_KEY_TYPE_CD,
        SRC.KEYSPACE_NATURAL_KEY_NAME,
        SRC.KEYSPACE_SID_KEY_NAME
  )
;

MERGE INTO ${CONFIGURATION_TABLE} TGT USING 
  (SELECT 
         'xx'                                   COUNTRY_2,
         't_internal_organization_hierarchy_2'    TARGET_TABLE, -- Only Required For Foreign Key Specifications
         'lisy'                                 SOURCE_SYSTEM,
         'xx'                                   SOURCE_UNIQUE_NAME,
         'parent_int_org_sid'                   SID_ALIAS,
         'parent_int_org_sid'                   SID_NAME,  -- The SID field we are looking to populate
         'xx'                                   TABLE_NAME, -- Only for key_generation = ON (rare/legacy)
         'parent_int_org_natural_key'           NATURAL_KEYS,
         'parent_int_org_natural_key'           TEMP_ALIAS_KEYS,
         'no'                                   ADD_TEMPORAL_JOIN,
         'meta'                                 LKP_TABLE_AREA,
         'meta'                                 KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                                KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'                    KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'                     KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                            KEYSPACE_SID_KEY_NAME) SRC 
  ON  TGT.COUNTRY_2               = SRC.COUNTRY_2
  AND TGT.TARGET_TABLE          = SRC.TARGET_TABLE
  AND TGT.SOURCE_SYSTEM         = SRC.SOURCE_SYSTEM
  AND TGT.SOURCE_UNIQUE_NAME    = SRC.SOURCE_UNIQUE_NAME
  AND TGT.SID_ALIAS             = SRC.SID_ALIAS
  AND TGT.SID_NAME              = SRC.SID_NAME
WHEN MATCHED THEN UPDATE 
SET 
  TABLE_NAME                    = SRC.TABLE_NAME,
  NATURAL_KEYS                  = SRC.NATURAL_KEYS,
  TEMP_ALIAS_KEYS               = SRC.TEMP_ALIAS_KEYS,
  ADD_TEMPORAL_JOIN             = SRC.ADD_TEMPORAL_JOIN,
  LKP_TABLE_AREA                = SRC.LKP_TABLE_AREA,
  KEYSPACE_SCHEMA               = SRC.KEYSPACE_SCHEMA,
  KEYSPACE_SUBJECT_AREA         = SRC.KEYSPACE_SUBJECT_AREA,
  KEYSPACE_KEY_TYPE_CD          = SRC.KEYSPACE_KEY_TYPE_CD,
  KEYSPACE_NATURAL_KEY_NAME     = SRC.KEYSPACE_NATURAL_KEY_NAME,
  KEYSPACE_SID_KEY_NAME         = SRC.KEYSPACE_SID_KEY_NAME
WHEN NOT MATCHED THEN
INSERT
VALUES 
  (     SRC.COUNTRY_2, 
        SRC.TARGET_TABLE, 
        SRC.SOURCE_SYSTEM, 
        SRC.SOURCE_UNIQUE_NAME, 
        SRC.SID_ALIAS, 
        SRC.SID_NAME, 
        SRC.TABLE_NAME, 
        SRC.NATURAL_KEYS, 
        SRC.TEMP_ALIAS_KEYS, 
        SRC.ADD_TEMPORAL_JOIN, 
        SRC.LKP_TABLE_AREA,
        SRC.KEYSPACE_SCHEMA,
        SRC.KEYSPACE_SUBJECT_AREA,
        SRC.KEYSPACE_KEY_TYPE_CD,
        SRC.KEYSPACE_NATURAL_KEY_NAME,
        SRC.KEYSPACE_SID_KEY_NAME
  )
;
