
-- for every row for each INT_ORG_SID (Company) see if this row represents ACTIVE or INACTIVE company (HAS_ANY_FG)


-- and then in columm 'PREV_HAS_ANY_FG' see if the previous history records was ACTIVE or INACTIVE


-- and then in column HAS_CHANGE_FG see if the two consequite history intervals represetn a change in the state of the company


-- IF WE HAVE SEVERAL HISTORY RECORDS FOR THE SAME COMPANY WITH SAME STATUS_1 (ACTIVE OR INACTIVE) THEN ASSIGN SAME ""GROUP_ID"" TO THESE CONSEQUTIVE STATUES


-- SO IN THE END WE WILL MERGE THESE CONSEQUTIVE HISTORICAL ROWS WITH SAME STATUS_1 INTO ONE ROW FOR THE WHOLE INTERVAL


INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id
 , source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, party_sid, party_status_type_cd,
 party_type_cd)
WITH base_with_change_fg AS (SELECT int_org_sid,
     int_org_nr,
     dwh_valid_from_tmsp,
     dwh_valid_to_tmsp,
           IFNULL(is_sales_company_fg, FALSE) OR IFNULL(is_deliv_company_fg, FALSE) OR IFNULL(is_country_org_fg, FALSE)
         OR IFNULL(is_expansion_company_fg, FALSE) OR IFNULL(is_bal_sheet_company_fg, FALSE) OR IFNULL(is_owner_company_fg
        , FALSE) OR IFNULL(is_trust_fg, FALSE) AS has_any_fg,
     LAG(IFNULL(is_sales_company_fg, FALSE) OR IFNULL(is_deliv_company_fg, FALSE) OR IFNULL(is_country_org_fg, FALSE) OR
          IFNULL(is_expansion_company_fg, FALSE) OR IFNULL(is_bal_sheet_company_fg, FALSE) OR IFNULL(is_owner_company_fg
         , FALSE) OR IFNULL(is_trust_fg, FALSE)) OVER (PARTITION BY CAST(int_org_sid AS STRING) ORDER BY
        dwh_valid_from_tmsp IS NULL, dwh_valid_from_tmsp) AS prev_has_any_fg,
      CASE
      WHEN NOT EQUAL_NULL(IFNULL(is_sales_company_fg, FALSE) OR IFNULL(is_deliv_company_fg, FALSE) OR IFNULL(is_country_org_fg
             , FALSE) OR IFNULL(is_expansion_company_fg, FALSE) OR IFNULL(is_bal_sheet_company_fg, FALSE) OR IFNULL(is_owner_company_fg
          , FALSE) OR IFNULL(is_trust_fg, FALSE), LAG(IFNULL(is_sales_company_fg, FALSE) OR IFNULL(is_deliv_company_fg,
               FALSE) OR IFNULL(is_country_org_fg, FALSE) OR IFNULL(is_expansion_company_fg, FALSE) OR IFNULL(is_bal_sheet_company_fg
            , FALSE) OR IFNULL(is_owner_company_fg, FALSE) OR IFNULL(is_trust_fg, FALSE)) OVER (PARTITION BY CAST(int_org_sid AS STRING)
          ORDER BY dwh_valid_from_tmsp IS NULL, dwh_valid_from_tmsp))
      THEN 1
      ELSE 0
      END AS has_change_fg
    FROM ldl_data_production_core_rel.t_internal_organization_1
    WHERE int_org_type_cd = 'COMPANY'
     AND SUBSTR(int_org_nr, 1, 2) NOT IN ('AL', 'BA', 'ME', 'MK', 'XK')
    UNION ALL
    SELECT int_org_sid,
     int_org_nr,
     dwh_valid_from_tmsp,
     dwh_valid_to_tmsp,
     TRUE AS has_any_fg,
     TRUE AS prev_has_any_fg,
     0 AS has_change_fg
    FROM ldl_data_production_core_rel.t_internal_organization_1
    WHERE int_org_type_cd = 'COMPANY'
     AND SUBSTR(int_org_nr, 1, 2) IN ('AL', 'BA', 'ME', 'MK', 'XK')), base_with_group_id AS (SELECT int_org_sid,
    int_org_nr,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    has_any_fg,
    prev_has_any_fg,
    has_change_fg,
    SUM(has_change_fg) OVER (PARTITION BY CAST(int_org_sid AS STRING) ORDER BY dwh_valid_from_tmsp IS NULL,
       dwh_valid_from_tmsp ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM base_with_change_fg) (SELECT 'LISY' AS dwh_node_cd,
    0 AS tf_error_fg,
    '${LOAD_ID}' AS dwh_load_id,
    'LISY' AS source_system,
    CURRENT_DATE AS extraction_dt,
    CAST(0 AS BOOL) AS deleted_fg,
    CAST(0 AS STRING) AS record_id,
    MIN(dwh_valid_from_tmsp) AS dwh_mapping_tmsp,
    't_tcache_lisy_cds_account_snap_1' AS filename,
    int_org_sid,
     CASE
     WHEN SUBSTR(int_org_nr, 1, 2) IN ('AL', 'BA', 'ME', 'MK', 'XK')
     THEN 'PRE-PROCESS'
     ELSE CASE
      WHEN has_any_fg = TRUE
      THEN 'ACTIVE'
      ELSE 'INACTIVE'
      END
     END AS party_status_type_cd,
    'INT_ORG' AS party_type_cd
   FROM base_with_group_id
   GROUP BY int_org_sid,
    int_org_nr,
    has_any_fg,
    group_id);