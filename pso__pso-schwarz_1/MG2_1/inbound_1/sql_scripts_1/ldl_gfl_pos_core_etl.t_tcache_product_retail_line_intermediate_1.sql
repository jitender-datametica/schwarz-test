MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_1,
         't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_1'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'real_estate_sid'                    sid_alias,
         'real_estate_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_1,
         't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_1'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'retail_event_sid'                    sid_alias,
         'retail_event_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     natural_keys,
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;



MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_1,
         't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'store_sid'                    sid_alias,
         'store_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_1,
         't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'country_org_sid'                    sid_alias,
         'country_org_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_1,
         't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cust_sid'                    sid_alias,
         'cust_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,lidlplus_customer_cd'     natural_keys,
         'context_country,lidlplus_customer_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_1,
         't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cash_register_sid'            sid_alias,
         'cash_register_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'cash_register_natural_key'     natural_keys,
         'cash_register_natural_key'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;


MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_1,
         't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'prod_return_reason_sid'            sid_alias,
         'prod_return_reason_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,return_reason_cd'     natural_keys,
         'context_country,return_reason_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'product_return_reason'                        KEYSPACE_SUBJECT_AREA,
         'prod_return_reason_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'prod_return_reason_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'prod_return_reason_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_1,
         't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'orig_sales_event_sid'            sid_alias,
         'orig_sales_event_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     natural_keys,
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'xx' country_1,
         't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'geo_area_sid'            sid_alias,
         'geo_area_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                          KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'                        KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos01' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_1'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'real_estate_sid'                    sid_alias,
         'real_estate_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos01' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_1'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'retail_event_sid'                    sid_alias,
         'retail_event_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     natural_keys,
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;



MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos01' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'store_sid'                    sid_alias,
         'store_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos01' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'country_org_sid'                    sid_alias,
         'country_org_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos01' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cust_sid'                    sid_alias,
         'cust_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,lidlplus_customer_cd'     natural_keys,
         'context_country,lidlplus_customer_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos01' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cash_register_sid'            sid_alias,
         'cash_register_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'cash_register_natural_key'     natural_keys,
         'cash_register_natural_key'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;


MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos01' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'prod_return_reason_sid'            sid_alias,
         'prod_return_reason_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,return_reason_cd'     natural_keys,
         'context_country,return_reason_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'product_return_reason'                        KEYSPACE_SUBJECT_AREA,
         'prod_return_reason_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'prod_return_reason_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'prod_return_reason_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos01' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'orig_sales_event_sid'            sid_alias,
         'orig_sales_event_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     natural_keys,
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos01' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'geo_area_sid'            sid_alias,
         'geo_area_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                          KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'                        KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos08' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_1'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'real_estate_sid'                    sid_alias,
         'real_estate_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos08' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_1'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'retail_event_sid'                    sid_alias,
         'retail_event_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     natural_keys,
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;



MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos08' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'store_sid'                    sid_alias,
         'store_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos08' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'country_org_sid'                    sid_alias,
         'country_org_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos08' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cust_sid'                    sid_alias,
         'cust_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,lidlplus_customer_cd'     natural_keys,
         'context_country,lidlplus_customer_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos08' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cash_register_sid'            sid_alias,
         'cash_register_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'cash_register_natural_key'     natural_keys,
         'cash_register_natural_key'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;


MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos08' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'prod_return_reason_sid'            sid_alias,
         'prod_return_reason_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,return_reason_cd'     natural_keys,
         'context_country,return_reason_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'product_return_reason'                        KEYSPACE_SUBJECT_AREA,
         'prod_return_reason_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'prod_return_reason_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'prod_return_reason_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos08' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'orig_sales_event_sid'            sid_alias,
         'orig_sales_event_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     natural_keys,
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos08' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'geo_area_sid'            sid_alias,
         'geo_area_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                          KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'                        KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos09' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_1'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'real_estate_sid'                    sid_alias,
         'real_estate_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos09' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_1'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'retail_event_sid'                    sid_alias,
         'retail_event_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     natural_keys,
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;



MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos09' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'store_sid'                    sid_alias,
         'store_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos09' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'country_org_sid'                    sid_alias,
         'country_org_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos09' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cust_sid'                    sid_alias,
         'cust_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,lidlplus_customer_cd'     natural_keys,
         'context_country,lidlplus_customer_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos09' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cash_register_sid'            sid_alias,
         'cash_register_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'cash_register_natural_key'     natural_keys,
         'cash_register_natural_key'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;


MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos09' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'prod_return_reason_sid'            sid_alias,
         'prod_return_reason_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,return_reason_cd'     natural_keys,
         'context_country,return_reason_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'product_return_reason'                        KEYSPACE_SUBJECT_AREA,
         'prod_return_reason_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'prod_return_reason_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'prod_return_reason_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos09' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'orig_sales_event_sid'            sid_alias,
         'orig_sales_event_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     natural_keys,
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos09' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'geo_area_sid'            sid_alias,
         'geo_area_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                          KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'                        KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos10' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_1'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'real_estate_sid'                    sid_alias,
         'real_estate_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos10' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_1'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'retail_event_sid'                    sid_alias,
         'retail_event_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     natural_keys,
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;



MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos10' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'store_sid'                    sid_alias,
         'store_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos10' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'country_org_sid'                    sid_alias,
         'country_org_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos10' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cust_sid'                    sid_alias,
         'cust_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,lidlplus_customer_cd'     natural_keys,
         'context_country,lidlplus_customer_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos10' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cash_register_sid'            sid_alias,
         'cash_register_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'cash_register_natural_key'     natural_keys,
         'cash_register_natural_key'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;


MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos10' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'prod_return_reason_sid'            sid_alias,
         'prod_return_reason_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,return_reason_cd'     natural_keys,
         'context_country,return_reason_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'product_return_reason'                        KEYSPACE_SUBJECT_AREA,
         'prod_return_reason_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'prod_return_reason_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'prod_return_reason_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos10' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'orig_sales_event_sid'            sid_alias,
         'orig_sales_event_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     natural_keys,
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos10' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_1'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'geo_area_sid'            sid_alias,
         'geo_area_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                          KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'                        KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos05' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'real_estate_sid'                    sid_alias,
         'real_estate_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos05' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05'       target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'retail_event_sid'                    sid_alias,
         'retail_event_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     natural_keys,
         'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;



MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos05' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'store_sid'                    sid_alias,
         'store_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,orig_store_nr'     natural_keys,
         'context_country,orig_store_nr'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos05' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'country_org_sid'                    sid_alias,
         'country_org_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos05' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cust_sid'                    sid_alias,
         'cust_sid'                    sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,lidlplus_customer_cd'     natural_keys,
         'context_country,lidlplus_customer_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'party'                        KEYSPACE_SUBJECT_AREA,
         'party_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'party_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'party_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos05' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'cash_register_sid'            sid_alias,
         'cash_register_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'cash_register_natural_key'     natural_keys,
         'cash_register_natural_key'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'resource_item'                        KEYSPACE_SUBJECT_AREA,
         'resource_item_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'resource_item_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'resource_item_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;


MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos05' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'prod_return_reason_sid'            sid_alias,
         'prod_return_reason_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,return_reason_cd'     natural_keys,
         'context_country,return_reason_cd'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'product_return_reason'                        KEYSPACE_SUBJECT_AREA,
         'prod_return_reason_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'prod_return_reason_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'prod_return_reason_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos05' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'orig_sales_event_sid'            sid_alias,
         'orig_sales_event_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     natural_keys,
         'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                         KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'retail_event'                        KEYSPACE_SUBJECT_AREA,
         'retail_event_key_type_cd'                KEYSPACE_KEY_TYPE_CD,
         'retail_event_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'retail_event_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;

MERGE INTO ${CONFIGURATION_TABLE} tgt USING 
  (SELECT 
         'pos05' country_1,
         't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05'        target_table, -- Only Required For Foreign Key Specifications
         'ejr'                          source_system,
         'xx'                           source_unique_name,
         'geo_area_sid'            sid_alias,
         'geo_area_sid'            sid_name,  -- The SID field we are looking to populate
         'xx'      table_name, -- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs
         'context_country'     natural_keys,
         'context_country'     temp_alias_keys,
         'no'                           add_temporal_join,
         'meta'                         lkp_table_area,
         'meta'                          KEYSPACE_SCHEMA,  -- Following and remaining details are from the key table definition 
         'geographical_area'                        KEYSPACE_SUBJECT_AREA,
         'geo_area_key_type_cd'            KEYSPACE_KEY_TYPE_CD,
         'geo_area_nat_key_nr'             KEYSPACE_NATURAL_KEY_NAME,
         'geo_area_sid'                    KEYSPACE_SID_KEY_NAME) src 
  ON  tgt.country_1               = src.country_1
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
        src.KEYSPACE_SCHEMA,
        src.KEYSPACE_SUBJECT_AREA,
        src.KEYSPACE_KEY_TYPE_CD,
        src.KEYSPACE_NATURAL_KEY_NAME,
        src.KEYSPACE_SID_KEY_NAME)
;




