INSERT INTO LDL_DATA_PRODUCTION.${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (int_org_key_type_cd, int_org_natural_key, int_org_hierarchy_type_cd, parent_int_org_key_type_cd, parent_int_org_natural_key, source_system, extraction_dt, dwh_mapping_tmsp, tf_error_fg, deleted_fg, record_id, filename, dwh_node_cd, dwh_load_id)
  with dedupe_src as (
    select
        /* n countries could be related to n SIDs, for example CS/ES, so dedupe the source first via a keys lookup.
        */
        keys.party_sid as country_sid,
        'COUNTRY' as int_org_key_type_cd,
        max(upper(trim(land, ' '))) as int_org_natural_key,
        'CNTRY_GRP_CNTRY_ORG' as int_org_hierarchy_type_cd,
        'COUNTRY_GRP' as parent_int_org_key_type_cd,
        max(trim(vs_landergruppen_id, ' ')) as parent_int_org_natural_key,
        'BIZREF' as source_system,
        current_date() as extraction_dt,
        current_timestamp() as dwh_valid_from_tmsp,
        numeric '0' as tf_error_fg,
        numeric '0' as deleted_fg,
        numeric '0' as record_id,
        't_${src_input_table}' as filename,
        'EXTERNAL_CSV' as dwh_node_cd,
        '${load_id}' as dwh_load_id
      from
        ldl_data_production.${temp_db}.t_${src_input_table} as src
        inner join ldl_data_production.meta.t_party_key as keys on upper(trim(land, ' ')) = upper(keys.party_nat_key_nr)
         and upper(keys.party_key_type_cd) = 'COUNTRY'
         and dwh_valid_fg = 'TRUE'
      group by 1
  )
  select
      dedupe_src.int_org_key_type_cd,
      dedupe_src.int_org_natural_key,
      dedupe_src.int_org_hierarchy_type_cd,
      dedupe_src.parent_int_org_key_type_cd,
      dedupe_src.parent_int_org_natural_key,
      dedupe_src.source_system,
      dedupe_src.extraction_dt,
      dedupe_src.dwh_valid_from_tmsp,
      dedupe_src.tf_error_fg,
      dedupe_src.deleted_fg,
      dedupe_src.record_id,
      dedupe_src.filename,
      dedupe_src.dwh_node_cd,
      dedupe_src.dwh_load_id
    from
      dedupe_src
;
