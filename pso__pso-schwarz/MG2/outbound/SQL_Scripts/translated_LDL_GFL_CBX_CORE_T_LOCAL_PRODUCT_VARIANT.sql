
CREATE OR REPLACE TABLE t_tcache_t215_int_itemnr (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c215_int_itemnr STRING(20) NOT NULL,
c215_itemnr STRING(18) NOT NULL,
c215_int_itemdesc STRING(100),
c215_casesize NUMERIC(10,5),
c215_moddate DATETIME,
c215_moduser STRING(8),
c215_int_itemnrsho STRING(4),
c215_active INTEGER,
c215_is_main_link INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
extraction_dt DATE,
dwh_created_tmsp DATETIME NOT NULL,
dwh_updated_tmsp DATETIME NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_node_cd STRING(20) NOT NULL
);


MERGE INTO ldl_data_production_etl_process.t_etl_pset_responsible AS tgt
USING (SELECT 'ldl' AS division,
  'ldl_gfl_cbx_core' AS project,
  'LDL_GFL_CBX_CORE' AS application,
  'cbx-data' AS system_group,
  't215_int_itemnr' AS interface,
  'xx_upsert_unhist_t215_int_itemnr_2_tcache_t215_int_itemnr' AS pset,
  'rene.pereira_ext@mail.schwarz' AS email_developer,
  'petar.katsarov@mail.schwarz' AS email_team_lead,
  'danijel.jelic@mail.schwarz' AS email_bse,
  CURRENT_DATE AS last_reject_at,
  CURRENT_DATE AS dwh_created_tmsp) AS src
ON tgt.division = src.division AND tgt.project = src.project AND tgt.pset = src.pset
WHEN MATCHED THEN UPDATE SET
 application = src.application,
 system_group = src.system_group,
 interface = src.interface,
 email_developer = src.email_developer,
 email_team_lead = src.email_team_lead,
 email_bse = src.email_bse,
 last_reject_at = CAST(src.last_reject_at AS DATETIME),
 dwh_created_tmsp = CAST(src.dwh_created_tmsp AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(src.division, src.project, src.application, src.system_group, src.interface, src.pset
 , src.email_developer, src.email_team_lead, src.email_bse, CAST(src.last_reject_at AS DATETIME), CAST(src.dwh_created_tmsp AS DATETIME)
 );


MERGE INTO ${configuration_table} AS tgt
USING (SELECT 'xx' AS country,
  't_local_product_variant' AS target_table,
  'cbx' AS source_system,
  'xx' AS source_unique_name,
  'prod_variant_sid' AS sid_alias,
  'prod_variant_sid' AS sid_name,
  'xx' AS table_name,
  'local_prod_variant_nr' AS natural_keys,
  'local_prod_variant_nr' AS temp_alias_keys,
  'no' AS add_temporal_join,
  'meta' AS lkp_table_area,
  'meta' AS keyspace_schema,
  'product_variant' AS keyspace_subject_area,
  'prod_variant_key_type_cd' AS keyspace_key_type_cd,
  'prod_variant_nat_key_nr' AS keyspace_natural_key_name,
  'prod_variant_sid' AS keyspace_sid_key_name) AS src
ON tgt.country = src.country AND tgt.target_table = src.target_table AND tgt.source_system = src.source_system AND tgt.source_unique_name
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
WHEN NOT MATCHED THEN INSERT VALUES(src.country, src.target_table, src.source_system, src.source_unique_name, src.sid_alias
 , src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema
 , src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name);


MERGE INTO ${configuration_table} AS tgt
USING (SELECT 'xx' AS country,
  't_local_product_variant' AS target_table,
  'cbx' AS source_system,
  'xx' AS source_unique_name,
  'prod_sid' AS sid_alias,
  'prod_sid' AS sid_name,
  'xx' AS table_name,
  'local_prod_nr' AS natural_keys,
  'local_prod_nr' AS temp_alias_keys,
  'no' AS add_temporal_join,
  'meta' AS lkp_table_area,
  'meta' AS keyspace_schema,
  'product' AS keyspace_subject_area,
  'prod_key_type_cd' AS keyspace_key_type_cd,
  'prod_nat_key_nr' AS keyspace_natural_key_name,
  'prod_sid' AS keyspace_sid_key_name) AS src
ON tgt.country = src.country AND tgt.target_table = src.target_table AND tgt.source_system = src.source_system AND tgt.source_unique_name
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
WHEN NOT MATCHED THEN INSERT VALUES(src.country, src.target_table, src.source_system, src.source_unique_name, src.sid_alias
 , src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema
 , src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name);


MERGE INTO ${configuration_table} AS tgt
USING (SELECT 'xx' AS country,
  't_local_product_variant' AS target_table,
  'cbx' AS source_system,
  'xx' AS source_unique_name,
  'int_org_sid' AS sid_alias,
  'party_sid' AS sid_name,
  'xx' AS table_name,
  'ctrcode' AS natural_keys,
  'ctrcode' AS temp_alias_keys,
  'no' AS add_temporal_join,
  'meta' AS lkp_table_area,
  'meta' AS keyspace_schema,
  'party' AS keyspace_subject_area,
  'party_key_type_cd' AS keyspace_key_type_cd,
  'party_nat_key_nr' AS keyspace_natural_key_name,
  'party_sid' AS keyspace_sid_key_name) AS src
ON tgt.country = src.country AND tgt.target_table = src.target_table AND tgt.source_system = src.source_system AND tgt.source_unique_name
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
WHEN NOT MATCHED THEN INSERT VALUES(src.country, src.target_table, src.source_system, src.source_unique_name, src.sid_alias
 , src.sid_name, src.table_name, src.natural_keys, src.temp_alias_keys, src.add_temporal_join, src.lkp_table_area, src.keyspace_schema
 , src.keyspace_subject_area, src.keyspace_key_type_cd, src.keyspace_natural_key_name, src.keyspace_sid_key_name);