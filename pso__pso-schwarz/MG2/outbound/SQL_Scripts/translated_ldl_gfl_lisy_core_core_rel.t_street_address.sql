MERGE INTO ${configuration_table} AS tgt USING (
  SELECT
      'xx' AS country,
      't_street_address' AS target_table, -- Only Required For Foreign Key Specifications
      'lisy' AS source_system,
      'xx' AS source_unique_name,
      'street_addr_sid' AS sid_alias,
      'street_addr_sid' AS sid_name, -- The SID field we are looking to populate
      'xx' AS table_name, -- Only for key_generaion = ON (rare/legacy)
      'street_addr_nk' AS natural_keys,
      'street_addr_nk' AS temp_alias_keys,
      'no' AS add_temporal_join,
      'meta' AS lkp_table_area,
      'meta' AS keyspace_schema, -- Following and remaining details are from the key table definition
      'address' AS keyspace_subject_area,
      'addr_key_type_cd' AS keyspace_key_type_cd,
      'addr_nat_key_nr' AS keyspace_natural_key_name,
      'addr_sid' AS keyspace_sid_key_name
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

MERGE INTO ${configuration_table} AS tgt USING (
  SELECT
      'xx' AS country,
      't_street_address' AS target_table, -- Only Required For Foreign Key Specifications
      'lisy' AS source_system,
      'xx' AS source_unique_name,
      'country_sid' AS sid_alias,
      'country_sid' AS sid_name, -- The SID field we are looking to populate
      'xx' AS table_name, -- Only for key_generaion = ON (rare/legacy)
      'igl_isocode2' AS natural_keys,
      'igl_isocode2' AS temp_alias_keys,
      'no' AS add_temporal_join,
      'meta' AS lkp_table_area,
      'meta' AS keyspace_schema, -- Following and remaining details are from the key table definition
      'geographical_area' AS keyspace_subject_area,
      'geo_area_key_type_cd' AS keyspace_key_type_cd,
      'geo_area_nat_key_nr' AS keyspace_natural_key_name,
      'geo_area_sid' AS keyspace_sid_key_name
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
    INSERT (country, target_table, source_system, source_unique_name, sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema, keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
    VALUES (src.country, src.target_table, src.source_system, src.source_unique_name, src.sid_alias, src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema, src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name)
;

MERGE INTO ${configuration_table} AS tgt USING (
  SELECT
      'xx' AS country,
      't_street_address' AS target_table, -- Only Required For Foreign Key Specifications
      'lisy' AS source_system,
      'xx' AS source_unique_name,
      'city_sid' AS sid_alias,
      'city_sid' AS sid_name, -- The SID field we are looking to populate
      'xx' AS table_name, -- Only for key_generaion = ON (rare/legacy)
      'igl_isocode2,city_name' AS natural_keys,
      'igl_isocode2,city_name' AS temp_alias_keys,
      'no' AS add_temporal_join,
      'meta' AS lkp_table_area,
      'meta' AS keyspace_schema, -- Following and remaining details are from the key table definition
      'geographical_area' AS keyspace_subject_area,
      'geo_area_key_type_cd' AS keyspace_key_type_cd,
      'geo_area_nat_key_nr' AS keyspace_natural_key_name,
      'geo_area_sid' AS keyspace_sid_key_name
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
    INSERT (country, target_table, source_system, source_unique_name, sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema, keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
    VALUES (src.country, src.target_table, src.source_system, src.source_unique_name, src.sid_alias, src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema, src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name)
;

MERGE INTO ${configuration_table} AS tgt USING (
  SELECT
      'xx' AS country,
      't_street_address' AS target_table, -- Only Required For Foreign Key Specifications
      'lisy' AS source_system,
      'xx' AS source_unique_name,
      'district_sid' AS sid_alias,
      'district_sid' AS sid_name, -- The SID field we are looking to populate
      'xx' AS table_name, -- Only for key_generaion = ON (rare/legacy)
      'district_nk' AS natural_keys,
      'district_nk' AS temp_alias_keys,
      'no' AS add_temporal_join,
      'meta' AS lkp_table_area,
      'meta' AS keyspace_schema, -- Following and remaining details are from the key table definition
      'geographical_area' AS keyspace_subject_area,
      'geo_area_key_type_cd' AS keyspace_key_type_cd,
      'geo_area_nat_key_nr' AS keyspace_natural_key_name,
      'geo_area_sid' AS keyspace_sid_key_name
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
    INSERT (country, target_table, source_system, source_unique_name, sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema, keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
    VALUES (src.country, src.target_table, src.source_system, src.source_unique_name, src.sid_alias, src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema, src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name)
;

MERGE INTO ${configuration_table} AS tgt USING (
  SELECT
      'xx' AS country,
      't_street_address' AS target_table, -- Only Required For Foreign Key Specifications
      'lisy' AS source_system,
      'xx' AS source_unique_name,
      'postal_cd_area_sid' AS sid_alias,
      'postal_cd_area_sid' AS sid_name, -- The SID field we are looking to populate
      'xx' AS table_name, -- Only for key_generaion = ON (rare/legacy)
      'igl_isocode2,zip' AS natural_keys,
      'igl_isocode2,zip' AS temp_alias_keys,
      'no' AS add_temporal_join,
      'meta' AS lkp_table_area,
      'meta' AS keyspace_schema, -- Following and remaining details are from the key table definition
      'geographical_area' AS keyspace_subject_area,
      'geo_area_key_type_cd' AS keyspace_key_type_cd,
      'geo_area_nat_key_nr' AS keyspace_natural_key_name,
      'geo_area_sid' AS keyspace_sid_key_name
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
    INSERT (country, target_table, source_system, source_unique_name, sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema, keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
    VALUES (src.country, src.target_table, src.source_system, src.source_unique_name, src.sid_alias, src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema, src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name)
;

MERGE INTO ${configuration_table} AS tgt USING (
  SELECT
      'xx' AS country,
      't_street_address' AS target_table, -- Only Required For Foreign Key Specifications
      'lisy' AS source_system,
      'xx' AS source_unique_name,
      'reporting_country_sid' AS sid_alias,
      'reporting_country_sid' AS sid_name, -- The SID field we are looking to populate
      'xx' AS table_name, -- Only for key_generaion = ON (rare/legacy)
      'igl_isocode2' AS natural_keys,
      'igl_isocode2' AS temp_alias_keys,
      'no' AS add_temporal_join,
      'meta' AS lkp_table_area,
      'meta' AS keyspace_schema, -- Following and remaining details are from the key table definition
      'geographical_area' AS keyspace_subject_area,
      'geo_area_key_type_cd' AS keyspace_key_type_cd,
      'geo_area_nat_key_nr' AS keyspace_natural_key_name,
      'geo_area_sid' AS keyspace_sid_key_name
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
    INSERT (country, target_table, source_system, source_unique_name, sid_alias, sid_name, table_name, natural_keys, temp_alias_keys, add_temporal_join, lkp_table_area, keyspace_schema, keyspace_subject_area, keyspace_key_type_cd, keyspace_natural_key_name, keyspace_sid_key_name)
    VALUES (src.country, src.target_table, src.source_system, src.source_unique_name, src.sid_alias, src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema, src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name)
;
