
/*  */


/*  */


-- no historical record exists, therefore we take the default 1900-01-01 as start of validity_2


-- there are some historical records, so if there is a change in some attribute, it is valid from this moment


-- FROM THE FILTERED STORES, WE TAKE THE LATEST RECORD AS PER EXTRACTION DATE   


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, country_org_cd, int_org_sid, int_org_type_cd,
 dwh_ending_tmsp, is_country_org_fg, legal_name, vat_nr, is_owner_company_fg, planned_open_dt, int_org_name, is_trust_fg
 , is_bal_sheet_company_fg, comment_txt, int_org_nr, close_dt, country_org_name, open_dt, is_sales_company_fg,
 is_expansion_company_fg, int_org_short_name, is_deliv_company_fg, curr_cd, holiday_store_fg)
(SELECT 'OSO' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'OSO' AS source_system,
  CURRENT_DATE AS extraction_dt,
   CASE
   WHEN tgt.int_org_sid IS NULL
   THEN CAST(PARSE_DATETIME('%F', '1900-01-01') AS TIMESTAMP)
   ELSE src.extraction_tmsp
   END AS dwh_mapping_tmsp,
  src.country_org_cd,
  src.int_org_sid,
  src.int_org_type_cd,
  COALESCE(tgt.dwh_valid_to_tmsp, CAST('0000-01-01 00:00:00' AS DATETIME)) AS dwh_ending_tmsp,
  src.is_country_org_fg,
  src.legal_name,
  src.vat_nr,
  src.is_owner_company_fg,
  src.planned_open_dt,
  src.int_org_name,
  src.is_trust_fg,
  src.is_bal_sheet_company_fg,
  src.comment_txt,
  src.int_org_nr,
  src.close_dt,
  src.country_org_name,
  src.open_dt,
  src.is_sales_company_fg,
  src.is_expansion_company_fg,
  src.int_org_short_name,
  src.is_deliv_company_fg,
  src.curr_cd,
  src.holiday_store_fg
 FROM ldl_data_production_etl.t_tcache_oso_internal_organization_2 AS src
  LEFT JOIN ldl_data_production_core_rel.t_internal_organization_2 AS tgt ON src.int_org_sid = tgt.int_org_sid AND src.dwh_node_cd
      = tgt.dwh_node_cd AND src.extraction_tmsp BETWEEN tgt.dwh_valid_from_tmsp AND tgt.dwh_valid_to_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(src.int_org_sid AS STRING), src.int_org_type_cd ORDER BY CASE
        WHEN tgt.int_org_sid IS NULL
        THEN CAST(PARSE_DATETIME('%F', '1900-01-01') AS TIMESTAMP)
        ELSE src.extraction_tmsp
        END IS NULL DESC, CASE
        WHEN tgt.int_org_sid IS NULL
        THEN CAST(PARSE_DATETIME('%F', '1900-01-01') AS TIMESTAMP)
        ELSE src.extraction_tmsp
        END DESC)) = 1);