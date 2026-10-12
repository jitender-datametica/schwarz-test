MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'xx' AS country_2,
    't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'real_estate_sid' AS sid_alias,
    'real_estate_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  VALUES(
    src.country_2,
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
    src.keyspace_sid_key_name
  )
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'xx' AS country_2,
    't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'retail_event_sid' AS sid_alias,
    'retail_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS natural_keys,
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'xx' AS country_2,
    't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'store_sid' AS sid_alias,
    'store_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'xx' AS country_2,
    't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'country_org_sid' AS sid_alias,
    'country_org_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'xx' AS country_2,
    't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cust_sid' AS sid_alias,
    'cust_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,lidlplus_customer_cd' AS natural_keys,
    'context_country,lidlplus_customer_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'xx' AS country_2,
    't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cash_register_sid' AS sid_alias,
    'cash_register_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'cash_register_natural_key' AS natural_keys,
    'cash_register_natural_key' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'xx' AS country_2,
    't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'prod_return_reason_sid' AS sid_alias,
    'prod_return_reason_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,return_reason_cd' AS natural_keys,
    'context_country,return_reason_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'product_return_reason' AS keyspace_subject_area,
    'prod_return_reason_key_type_cd' AS keyspace_key_type_cd,
    'prod_return_reason_nat_key_nr' AS keyspace_natural_key_name,
    'prod_return_reason_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'xx' AS country_2,
    't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'orig_sales_event_sid' AS sid_alias,
    'orig_sales_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS natural_keys,
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'xx' AS country_2,
    't_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'geo_area_sid' AS sid_alias,
    'geo_area_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'geographical_area' AS keyspace_subject_area,
    'geo_area_key_type_cd' AS keyspace_key_type_cd,
    'geo_area_nat_key_nr' AS keyspace_natural_key_name,
    'geo_area_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos01' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'real_estate_sid' AS sid_alias,
    'real_estate_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos01' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'retail_event_sid' AS sid_alias,
    'retail_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS natural_keys,
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos01' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'store_sid' AS sid_alias,
    'store_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos01' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'country_org_sid' AS sid_alias,
    'country_org_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos01' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cust_sid' AS sid_alias,
    'cust_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,lidlplus_customer_cd' AS natural_keys,
    'context_country,lidlplus_customer_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos01' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cash_register_sid' AS sid_alias,
    'cash_register_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'cash_register_natural_key' AS natural_keys,
    'cash_register_natural_key' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos01' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'prod_return_reason_sid' AS sid_alias,
    'prod_return_reason_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,return_reason_cd' AS natural_keys,
    'context_country,return_reason_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'product_return_reason' AS keyspace_subject_area,
    'prod_return_reason_key_type_cd' AS keyspace_key_type_cd,
    'prod_return_reason_nat_key_nr' AS keyspace_natural_key_name,
    'prod_return_reason_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos01' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'orig_sales_event_sid' AS sid_alias,
    'orig_sales_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS natural_keys,
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos01' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'geo_area_sid' AS sid_alias,
    'geo_area_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'geographical_area' AS keyspace_subject_area,
    'geo_area_key_type_cd' AS keyspace_key_type_cd,
    'geo_area_nat_key_nr' AS keyspace_natural_key_name,
    'geo_area_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos08' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'real_estate_sid' AS sid_alias,
    'real_estate_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos08' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'retail_event_sid' AS sid_alias,
    'retail_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS natural_keys,
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos08' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'store_sid' AS sid_alias,
    'store_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos08' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'country_org_sid' AS sid_alias,
    'country_org_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos08' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cust_sid' AS sid_alias,
    'cust_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,lidlplus_customer_cd' AS natural_keys,
    'context_country,lidlplus_customer_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos08' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cash_register_sid' AS sid_alias,
    'cash_register_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'cash_register_natural_key' AS natural_keys,
    'cash_register_natural_key' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos08' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'prod_return_reason_sid' AS sid_alias,
    'prod_return_reason_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,return_reason_cd' AS natural_keys,
    'context_country,return_reason_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'product_return_reason' AS keyspace_subject_area,
    'prod_return_reason_key_type_cd' AS keyspace_key_type_cd,
    'prod_return_reason_nat_key_nr' AS keyspace_natural_key_name,
    'prod_return_reason_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos08' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'orig_sales_event_sid' AS sid_alias,
    'orig_sales_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS natural_keys,
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos08' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'geo_area_sid' AS sid_alias,
    'geo_area_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'geographical_area' AS keyspace_subject_area,
    'geo_area_key_type_cd' AS keyspace_key_type_cd,
    'geo_area_nat_key_nr' AS keyspace_natural_key_name,
    'geo_area_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos09' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'real_estate_sid' AS sid_alias,
    'real_estate_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos09' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'retail_event_sid' AS sid_alias,
    'retail_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS natural_keys,
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos09' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'store_sid' AS sid_alias,
    'store_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos09' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'country_org_sid' AS sid_alias,
    'country_org_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos09' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cust_sid' AS sid_alias,
    'cust_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,lidlplus_customer_cd' AS natural_keys,
    'context_country,lidlplus_customer_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos09' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cash_register_sid' AS sid_alias,
    'cash_register_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'cash_register_natural_key' AS natural_keys,
    'cash_register_natural_key' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos09' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'prod_return_reason_sid' AS sid_alias,
    'prod_return_reason_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,return_reason_cd' AS natural_keys,
    'context_country,return_reason_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'product_return_reason' AS keyspace_subject_area,
    'prod_return_reason_key_type_cd' AS keyspace_key_type_cd,
    'prod_return_reason_nat_key_nr' AS keyspace_natural_key_name,
    'prod_return_reason_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos09' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'orig_sales_event_sid' AS sid_alias,
    'orig_sales_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS natural_keys,
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos09' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'geo_area_sid' AS sid_alias,
    'geo_area_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'geographical_area' AS keyspace_subject_area,
    'geo_area_key_type_cd' AS keyspace_key_type_cd,
    'geo_area_nat_key_nr' AS keyspace_natural_key_name,
    'geo_area_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos10' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'real_estate_sid' AS sid_alias,
    'real_estate_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos10' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'retail_event_sid' AS sid_alias,
    'retail_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS natural_keys,
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos10' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'store_sid' AS sid_alias,
    'store_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos10' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'country_org_sid' AS sid_alias,
    'country_org_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos10' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cust_sid' AS sid_alias,
    'cust_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,lidlplus_customer_cd' AS natural_keys,
    'context_country,lidlplus_customer_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos10' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cash_register_sid' AS sid_alias,
    'cash_register_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'cash_register_natural_key' AS natural_keys,
    'cash_register_natural_key' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos10' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'prod_return_reason_sid' AS sid_alias,
    'prod_return_reason_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,return_reason_cd' AS natural_keys,
    'context_country,return_reason_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'product_return_reason' AS keyspace_subject_area,
    'prod_return_reason_key_type_cd' AS keyspace_key_type_cd,
    'prod_return_reason_nat_key_nr' AS keyspace_natural_key_name,
    'prod_return_reason_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos10' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'orig_sales_event_sid' AS sid_alias,
    'orig_sales_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS natural_keys,
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos10' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_2' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'geo_area_sid' AS sid_alias,
    'geo_area_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'geographical_area' AS keyspace_subject_area,
    'geo_area_key_type_cd' AS keyspace_key_type_cd,
    'geo_area_nat_key_nr' AS keyspace_natural_key_name,
    'geo_area_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos05' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'real_estate_sid' AS sid_alias,
    'real_estate_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos05' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'retail_event_sid' AS sid_alias,
    'retail_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or the target we are relating to for foreign key SIDs 
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS natural_keys,
    'context_country,orig_store_nr,pos_terminal_id,orig_receipt_nr,receipt_business_date' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos05' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'store_sid' AS sid_alias,
    'store_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,orig_store_nr' AS natural_keys,
    'context_country,orig_store_nr' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos05' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'country_org_sid' AS sid_alias,
    'country_org_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos05' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cust_sid' AS sid_alias,
    'cust_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,lidlplus_customer_cd' AS natural_keys,
    'context_country,lidlplus_customer_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'party' AS keyspace_subject_area,
    'party_key_type_cd' AS keyspace_key_type_cd,
    'party_nat_key_nr' AS keyspace_natural_key_name,
    'party_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos05' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'cash_register_sid' AS sid_alias,
    'cash_register_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'cash_register_natural_key' AS natural_keys,
    'cash_register_natural_key' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'resource_item' AS keyspace_subject_area,
    'resource_item_key_type_cd' AS keyspace_key_type_cd,
    'resource_item_nat_key_nr' AS keyspace_natural_key_name,
    'resource_item_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos05' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'prod_return_reason_sid' AS sid_alias,
    'prod_return_reason_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,return_reason_cd' AS natural_keys,
    'context_country,return_reason_cd' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'product_return_reason' AS keyspace_subject_area,
    'prod_return_reason_key_type_cd' AS keyspace_key_type_cd,
    'prod_return_reason_nat_key_nr' AS keyspace_natural_key_name,
    'prod_return_reason_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos05' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'orig_sales_event_sid' AS sid_alias,
    'orig_sales_event_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS natural_keys,
    'context_country,original_orig_store_nr,original_pos_terminal_id,original_orig_receipt_nr,original_dat_formdate' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'retail_event' AS keyspace_subject_area,
    'retail_event_key_type_cd' AS keyspace_key_type_cd,
    'retail_event_nat_key_nr' AS keyspace_natural_key_name,
    'retail_event_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);

MERGE INTO xxx_configuration_table_zzz AS tgt
USING (
  SELECT
    'pos05' AS country_2,
    't_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos05' AS target_table,-- Only Required For Foreign Key Specifications 
    'ejr' AS source_system,
    'xx' AS source_unique_name,
    'geo_area_sid' AS sid_alias,
    'geo_area_sid' AS sid_name,-- The SID field we are looking to populate 
    'xx' AS table_name,-- The table we are populating for primry SIDs or teh target we are relating to for foreoh key SIDs 
    'context_country' AS natural_keys,
    'context_country' AS temp_alias_keys,
    'no' AS add_temporal_join,
    'meta' AS lkp_table_area,
    'meta' AS keyspace_schema,-- Following and remaining details are from the key table definition 
    'geographical_area' AS keyspace_subject_area,
    'geo_area_key_type_cd' AS keyspace_key_type_cd,
    'geo_area_nat_key_nr' AS keyspace_natural_key_name,
    'geo_area_sid' AS keyspace_sid_key_name
) AS src
ON tgt.country_2 = src.country_2
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
WHEN NOT MATCHED THEN INSERT (
  country_2,
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
  keyspace_key_type_cd,
  keyspace_natural_key_name,
  keyspace_sid_key_name
) VALUES (
  src.country_2,
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
  src.keyspace_sid_key_name
);