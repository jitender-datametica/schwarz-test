INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 country_org_key_type_cd, bus_dt, country_org_cd, cancel_fg, emp_tm_period_type_natural_key,
 emp_tm_period_type_key_type_cd, break_min_cnt, emp_tm_tracking_type_cd, emp_start_tm_booking_type_cd,
 emp_tm_event_type_cd, tm_tracking_tmsp, emp_hash, int_org_key_type_cd, hr_cnt, int_org_natural_key, period_start_tmsp,
 emp_tm_tracking_nr, period_end_tmsp, emp_end_tm_tracking_method_cd, emp_end_tm_booking_type_cd, tm_booking_tmsp,
 emp_start_tm_tracking_method_cd, country_org_natural_key)
WITH wh_lkp AS (SELECT DISTINCT x.storeno,
    b.int_org_sid AS sales_company_sid,
      SUBSTR(x.int_org_nr, 1, 2) || '|' || SUBSTR(x.int_org_nr, 3, (LENGTH(x.int_org_nr) - 2)) AS warehouse_nk
   FROM ldl_data_production_etl_process.t_tcache_ptm_missingtimes_snap AS x
    LEFT JOIN ldl_data_production_meta.t_party_key_2 AS y ON y.party_nat_key_nr = x.bic_zmlila || '|' || CAST(x.storeno AS STRING)
        AND y.party_key_type_cd = 'STORE'
    LEFT JOIN ldl_data_production_core_rel.t_internal_organization_hierarchy_2 AS a ON y.party_sid = a.int_org_sid AND x.int_org_hierarchy_type_cd
       = 'DELIVCMP_STORE'
    LEFT JOIN ldl_data_production_core_rel.t_internal_organization_2 AS b ON a.parent_int_org_sid = b.int_org_sid) (SELECT
    'SAP_PTM' AS dwh_node_cd,
    0 AS tf_error_fg,
    '${LOAD_ID}' AS dwh_load_id,
    'SAP_PTM' AS source_system,
    CURRENT_DATE AS extraction_dt,
    CAST(0 AS BOOL) AS deleted_fg,
    CAST(0 AS STRING) AS record_id,
    CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
    't_${SRC_INPUT_TABLE}' AS filename,
    'COUNTRY_2' AS country_org_key_type_cd,
    src.working_date AS bus_dt,
    UPPER(src.bic_zmlila) AS country_org_cd,
      CASE
      WHEN src.validfor = 0
      THEN 1
      ELSE 0
      END <> 0 AS cancel_fg,
      t1.warehouse_nk || '|' || LTRIM(TRIM(SUBSTR(CAST(src.missing_id AS STRING), 1, 16), ''), '0') AS
    emp_tm_period_type_natural_key,
    'PTM' AS emp_tm_period_type_key_type_cd,
    NULL AS break_min_cnt,
    'WT' AS emp_tm_tracking_type_cd,
    CAST(NULL AS STRING) AS emp_end_tm_booking_type_cd,
    CAST(NULL AS STRING) AS emp_tm_event_type_cd,
    CAST(NULL AS TIMESTAMP) AS tm_tracking_tmsp,
    src.mis_key AS emp_hash,
    'STORE' AS int_org_key_type_cd,
    NULL AS hr_cnt,
      UPPER(src.bic_zmlila) || '|' || LTRIM(REGEXP_REPLACE(src.storeno, '[^0-9]', ''), '0') AS int_org_natural_key,
    CAST(COALESCE(CAST(src.date_from AS STRING) || ' ' || src.time_from, '9999-12-30 23:59:59') AS
     TIMESTAMP) AS period_start_tmsp,
    LTRIM(SUBSTR(CAST(src.missing_id AS STRING), 1, 16), '0') AS emp_tm_tracking_nr,
    CAST(COALESCE(CAST(src.date_to AS STRING) || ' ' || src.time_to, '9999-12-30 23:59:59') AS
     TIMESTAMP) AS period_end_tmsp,
    CAST(NULL AS STRING) AS emp_end_tm_tracking_method_cd,
    CAST(NULL AS STRING) AS emp_end_tm_booking_type_cd28,
    CAST(src.change_date AS STRING) AS tm_booking_tmsp,
    CAST(NULL AS STRING) AS emp_start_tm_tracking_method_cd,
    UPPER(src.bic_zmlila) AS country_org_natural_key
   FROM ldl_data_production_etl_process.t_${src_input_table} AS src
    INNER JOIN wh_lkp AS t1_2 ON src.storeno = t1.storeno);