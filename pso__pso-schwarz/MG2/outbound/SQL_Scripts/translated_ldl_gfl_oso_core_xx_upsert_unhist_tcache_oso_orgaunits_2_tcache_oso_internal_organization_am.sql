/* MANUAL OSO - Account Manager */
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
       int_org_natural_key
     , int_org_key_type_cd
     , int_org_type_cd
     , int_org_nr
     , int_org_name
     , open_dt
     , planned_open_dt
     , close_dt
     , curr_cd
     , holiday_store_fg
     , legal_name
     , vat_nr
     , country_org_cd
     , comment_txt
     , is_sales_company_fg
     , is_deliv_company_fg
     , is_country_org_fg
     , is_expansion_company_fg
     , is_bal_sheet_company_fg
     , is_owner_company_fg
     , is_trust_fg
     , int_org_short_name
     , country_org_name
     , extraction_tmsp
     , lvl
     , source_system
     , extraction_dt
     , dwh_mapping_tmsp
     , tf_error_fg
     , deleted_fg
     , record_id
     , filename
     , dwh_node_cd
     , dwh_load_id
)
WITH
stores_dedup AS (
  SELECT *
    FROM etl.t_tcache_oso_orgaunits
   WHERE type0 = 'STORE'
   QUALIFY ROW_NUMBER() OVER (PARTITION BY orgaunitid ORDER BY extraction_timestamp DESC) = 1
),
orgaunits_wh_dedup AS (
  SELECT *
    FROM etl.t_tcache_oso_orgaunits
   WHERE type0 = 'WAREHOUSE'
   QUALIFY ROW_NUMBER() OVER (PARTITION BY orgaunitid ORDER BY extraction_timestamp DESC) = 1
),
orgaunits_wh_empl AS (
  SELECT DISTINCT
       wh.orgaunitid
      ,wh.countrycode
      ,wh.organumber
      ,wh.type0
      ,wh.name AS wh_name
      ,wh.parentorgaunitid
      ,wh.extraction_timestamp
      --
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.id') AS id
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.parentEmployeeId') AS parent_id
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.adName') AS adName
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.firstName') AS firstName
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.lastName') AS lastName
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.deputyEmployeeId') AS deputyEmployeeId
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.mail') AS mail
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.phone') AS phone
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.role') AS empl_role
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.workforceId') AS workforceId
      ,JSON_EXTRACT(emp_list.value, '$.childrenEmployees') AS child_empl_list
  FROM orgaunits_wh_dedup AS wh,
       UNNEST(wh.employees) AS emp_list
  WHERE JSON_EXTRACT_SCALAR(emp_list.value, '$.testEmployee') = 'false'
),
src_with_sid AS (
  SELECT
        store.countrycode || '|' || store.organumber AS store_nat_key_nr
      , lisystore.igl_neodate AS store_opening_dt
      , smd.countrycode
      , smd.firstname || ' ' || smd.lastname AS sales_manager_name
      , amd.firstname || ' ' || amd.lastname AS account_manager_name
      , SUBSTR(lisycomp.igl_associationnumber, 1, 2) || CAST(REGEXP_REPLACE(lisycomp.igl_associationnumber, '[^0-9]', '') AS STRING) AS sales_company_nr
      , smd.firstname || ' ' || smd.lastname
          || ' (' 
          || IFNULL(amd.firstname || ' ' || amd.lastname, 'VL ' || lisycomp.igl_name)
          || ' ('
          || SUBSTR(lisycomp.igl_associationnumber, 1, 2) || CAST(REGEXP_REPLACE(lisycomp.igl_associationnumber, '[^0-9]', '') AS STRING)
          || '))' AS sales_manager_nat_key_nr
      , smd.workforceid AS sales_manager_id
      , smd.extraction_timestamp AS sm_extraction_tmsp
      , IFNULL(amd.firstname || ' ' || amd.lastname, 'VL ' || lisycomp.igl_name)
          || ' ('
          || SUBSTR(lisycomp.igl_associationnumber, 1, 2) || CAST(REGEXP_REPLACE(lisycomp.igl_associationnumber, '[^0-9]', '') AS STRING)
          || ')' AS account_manager_nat_key_nr
      , amd.workforceid AS account_manager_id
      , amd.extraction_timestamp AS am_extraction_tmsp
      , SUBSTR(lisycomp.igl_associationnumber, 1, 2) || '|' || CAST(REGEXP_REPLACE(lisycomp.igl_associationnumber, '[^0-9]', '') AS STRING) AS sales_comp_nat_key_nr
      , lisycomp.extraction_ts AS comp_extraction_tmsp
      , relhist.igl_validfromdate
      , relhist.igl_validtodate
  FROM stores_dedup AS store
       JOIN orgaunits_wh_empl AS smd  -- joining stores with sales managers (OSO)
         ON store.employeeid = smd.id
        AND store.parentorgaunitid = smd.orgaunitid
       JOIN orgaunits_wh_empl AS amd  -- joining sales managers with account managers (OSO)
         ON smd.parent_id = amd.id
       JOIN etl_process.t_tcache_lisy_cds_account_snap AS lisystore  --joining OSO stores with LISY store data
         ON store.countrycode || store.organumber = UPPER(SUBSTR(lisystore.igl_number, 1, 2)) || CAST(REGEXP_REPLACE(SUBSTR(lisystore.igl_number, 3, 5), '[^0-9]', '') AS STRING)
       JOIN etl_process.t_tcache_lisy_cds_regionrelationhistory_snap AS relhist
         ON relhist.igl_accountid = lisystore.accountid
        AND relhist.igl_companytypecode = 285540002
       JOIN etl_process.t_tcache_lisy_cds_company_snap AS lisycomp  -- joining LISY sales companies
         ON relhist.igl_regionid = lisycomp.id
   QUALIFY ROW_NUMBER() OVER (
     PARTITION BY store_nat_key_nr, sales_manager_nat_key_nr, account_manager_nat_key_nr, sales_comp_nat_key_nr
     ORDER BY sm_extraction_tmsp DESC
   ) = 1
)
SELECT DISTINCT
       UPPER(account_manager_nat_key_nr) AS int_org_natural_key
     , 'ACCOUNT_MANAGER' AS int_org_key_type_cd
     , 'ACCOUNT_MANAGER' AS int_org_type_cd
     , s.countrycode || s.account_manager_id AS int_org_nr
     , s.account_manager_nat_key_nr AS int_org_name
     , NULL AS open_dt
     , NULL AS planned_open_dt
     , NULL AS close_dt
     , NULL AS curr_cd
     , NULL AS holiday_store_fg
     , NULL AS legal_name
     , NULL AS vat_nr
     , CASE
         WHEN s.countrycode = 'LU' THEN 'BE'
         ELSE s.countrycode
       END AS country_org_cd
     , NULL AS comment_txt
     , NULL AS is_sales_company_fg
     , NULL AS is_deliv_company_fg
     , NULL AS is_country_org_fg
     , NULL AS is_expansion_company_fg
     , NULL AS is_bal_sheet_company_fg
     , NULL AS is_owner_company_fg
     , NULL AS is_trust_fg
     , NULL AS int_org_short_name
     , CASE
         WHEN s.countrycode = 'LU' THEN 'Belgien'
         WHEN s.countrycode = 'NI' THEN 'Nordirland'
         ELSE cntr.country_name
       END AS country_org_name
     , s.am_extraction_tmsp AS extraction_tmsp
     , 'AM' AS lvl
     , 'OSO' AS source_system
     , CURRENT_DATE() AS extraction_dt
     , CURRENT_TIMESTAMP() AS dwh_mapping_tmsp
     , 0 AS tf_error_fg
     , 0 AS deleted_fg
     , 0 AS record_id
     , 't_${SRC_INPUT_TABLE}' AS filename
     , 'OSO' AS dwh_node_cd
     , '${LOAD_ID}' AS dwh_load_id
  FROM src_with_sid AS s
  LEFT JOIN core_rel.t_country AS cntr
    ON cntr.iso_country_cd = s.countrycode
   AND cntr.dwh_valid_fg = TRUE;
