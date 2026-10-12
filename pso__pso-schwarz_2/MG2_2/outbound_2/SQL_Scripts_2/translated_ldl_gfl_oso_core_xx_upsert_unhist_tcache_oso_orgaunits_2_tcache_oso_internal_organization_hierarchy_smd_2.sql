/* MANUAL- Store-to-SMD 2 */
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
       int_org_natural_key
     , int_org_key_type_cd        
     , int_org_hierarchy_type_cd
     , parent_int_org_natural_key
     , parent_int_org_key_type_cd
     , derived_valid_from_tmsp
     , derived_valid_to_tmsp
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
    FROM etl.t_tcache_oso_orgaunits_2
   WHERE type0 = 'STORE'
   QUALIFY ROW_NUMBER() OVER (PARTITION BY orgaunitid ORDER BY extraction_timestamp DESC) = 1
),
orgaunits_wh_dedup AS (
  SELECT *
    FROM etl.t_tcache_oso_orgaunits_2
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
src AS (
  SELECT
        store.countrycode || '|' || store.organumber AS store_nat_key_nr
      , lisystore.igl_neodate AS store_opening_dt
      , smd.firstname || ' ' || smd.lastname AS sales_manager_name
      , amd.firstname || ' ' || amd.lastname AS account_manager_name
      , SUBSTR(lisycomp.igl_associationnumber, 1, 2) || CAST(REGEXP_REPLACE(lisycomp.igl_associationnumber, '[^0-9]', '') AS STRING) AS sales_company_nr
      , smd.firstname || ' ' || smd.lastname
          || ' ('
          || IFNULL(amd.firstname || ' ' || amd.lastname, 'VL ' || lisycomp.igl_name)
          || ' ('
          || SUBSTR(lisycomp.igl_associationnumber, 1, 2) || CAST(REGEXP_REPLACE(lisycomp.igl_associationnumber, '[^0-9]', '') AS STRING)
          || '))' AS sales_manager_nat_key_nr
      , smd.extraction_timestamp AS sm_extraction_tmsp
      , IFNULL(amd.firstname || ' ' || amd.lastname, 'VL ' || lisycomp.igl_name)
          || ' ('
          || SUBSTR(lisycomp.igl_associationnumber, 1, 2) || CAST(REGEXP_REPLACE(lisycomp.igl_associationnumber, '[^0-9]', '') AS STRING)
          || ')' AS account_manager_nat_key_nr
      , amd.extraction_timestamp AS am_extraction_tmsp
      , SUBSTR(lisycomp.igl_associationnumber, 1, 2) || '|' || CAST(REGEXP_REPLACE(lisycomp.igl_associationnumber, '[^0-9]', '') AS STRING) AS sales_comp_nat_key_nr
      , lisycomp.extraction_ts AS comp_extraction_tmsp
      , relhist.igl_validfromdate
      , TO_DATE(GREATEST(lisystore.igl_neodate, relhist.igl_validfromdate)) AS dwh_valid_from_dt
      , TIMESTAMP_SUB(TIMESTAMP_ADD(TIMESTAMP(relhist.igl_validtodate), INTERVAL 1 DAY), INTERVAL 1 MILLISECOND) AS valid_to_tmsp
  FROM stores_dedup store
       JOIN orgaunits_wh_empl smd  -- joining stores with sales_2 managers (OSO)
         ON store.employeeid = smd.id
        AND store.parentorgaunitid = smd.orgaunitid
       JOIN orgaunits_wh_empl amd  -- joining sales_2 managers with account_2 managers (OSO)
         ON smd.parent_id = amd.id
       JOIN etl_process.t_tcache_lisy_cds_account_snap_2 AS lisystore  --joining OSO stores with LISY store data
         ON store.countrycode || store.organumber
            = UPPER(SUBSTR(lisystore.igl_number, 1, 2))
              || CAST(REGEXP_REPLACE(SUBSTR(lisystore.igl_number, 3, 5), '[^0-9]', '') AS STRING)
       JOIN etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_2 AS relhist
         ON relhist.igl_accountid = lisystore.accountid
        AND relhist.igl_companytypecode = 285540002 -- sales_2 company
        -- we include this additional filter because the validity_2 intervals for some stores fall outside their operational lifecycle
       JOIN etl_process.t_tcache_lisy_cds_company_snap_2 AS lisycomp  -- joining LISY sales_2 companies
         ON relhist.igl_regionid = lisycomp.id
    WHERE relhist.igl_validfromdate < relhist.igl_validtodate
    -- we are only interested in relations which were valid when the store opened
    -- or relations which were valid when the store closed
    -- or relations that started at some point after the store opened and the store is still operational. This scenario is different than the first because it aims to include relations that became valid after the initial relation that was active when the store first opened. The first scenario is not going to "catch" them because the open date will fall before the validity_2 start date of the subsequent relation. The second scenario is also not going to "catch" them if the closing date of the store is null.
    -- or relations which were valid when the store closed
    -- or relations that became valid after the store was opened and lost their validity_2 before the store closed
    -- or relations that started at some point after the store opened and the store is still operational. This scenario is different than the first because it aims to include relations that became valid after the initial relation that was active when the store first opened. The first scenario is not going to "catch" them because the open date will fall before the validity_2 start date of the subsequent relation. The second scenario is also not going to "catch" them if the closing date of the store is null.
    -- we want to avoid bad data delivering relations that end before they start or on the day they start
    -- if we get overlapping data about relations of a store with multiple sales_2 companies, we take the most recent relation. Still, we don't want to exclude company relations altogether which is why we take rh.igl_validfromdate in the partitioning clause. E.g. if a store opens on 2020-01-01 and has a relation to sales_2 company X from 2019-01-01 until 2020-01-03 and then to sales_2 company Y from 2020-01-04 until 2200-01-01 we want to take both companies, not just sales_2 company Y.
   QUALIFY ROW_NUMBER() OVER (
     PARTITION BY store_nat_key_nr, account_manager_nat_key_nr, sales_comp_nat_key_nr, relhist.igl_validfromdate
     ORDER BY relhist.igl_validfromdate DESC
   ) = 1
),
src_with_sid AS (
  SELECT
        store_key.party_sid AS store_sid
      , src.store_nat_key_nr
      , src.dwh_valid_from_dt
      , src.valid_to_tmsp
      , src.igl_validfromdate AS rel_valid_from
      , src.sales_manager_nat_key_nr
      , src.account_manager_nat_key_nr
      , src.sales_comp_nat_key_nr
    FROM src
    JOIN meta.t_party_key_2 AS store_key
      ON UPPER(src.store_nat_key_nr) = store_key.party_nat_key_nr
     AND store_key.party_key_type_cd = 'STORE'
    -- if we get overlapping data about relations of a store with multiple companies, we take the most recent relation. This is necessary because there are situations when a store opens on 2020-01-01 and has a relation to sales_2 company X from 2019-01-01 until 2200-01-01 and to sales_2 company Y from 2019-12-01 until 2200-01-01. In such a scenario, we only want to take the latest relation to sales_2 company Y.
   QUALIFY ROW_NUMBER() OVER (
     PARTITION BY store_key.party_sid, src.dwh_valid_from_dt
     ORDER BY rel_valid_from DESC
   ) = 1
),
src_track_changes AS (
  SELECT
        store_sid
      , store_nat_key_nr
      , dwh_valid_from_dt
      , LEAST(
            valid_to_tmsp,
            IFNULL(
              TIMESTAMP_SUB(LEAD(dwh_valid_from_dt) OVER (PARTITION BY store_sid ORDER BY dwh_valid_from_dt), INTERVAL 1 MILLISECOND),
              TIMESTAMP '9999-12-31 23:59:59.999999'
            )
        ) AS dwh_valid_to_tmsp
      , sales_manager_nat_key_nr
      , account_manager_nat_key_nr
      , sales_comp_nat_key_nr
      , SHA256(store_nat_key_nr || '#&#'
              || sales_manager_nat_key_nr || '#&#'
              || account_manager_nat_key_nr || '#&#'
              || sales_comp_nat_key_nr) AS row_hash_for_diff
      , LAG(SHA256(store_nat_key_nr || '#&#'
                   || sales_manager_nat_key_nr || '#&#'
                   || account_manager_nat_key_nr || '#&#'
                   || sales_comp_nat_key_nr)) OVER (
          PARTITION BY store_sid
          ORDER BY dwh_valid_from_dt
        ) AS prev_row_hash_for_diff
      , CASE
          WHEN row_hash_for_diff = prev_row_hash_for_diff THEN 0
          ELSE 1
        END AS has_change_fg
  FROM src_with_sid
),
src_with_groups AS (
  SELECT
      *
    , SUM(has_change_fg) OVER (
        PARTITION BY store_sid
        ORDER BY dwh_valid_from_dt ASC, has_change_fg DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ) AS group_id
  FROM src_track_changes
),
sel AS (
  SELECT
        store_nat_key_nr
      , TO_TIMESTAMP(MIN(dwh_valid_from_dt)) AS dwh_valid_from_tmsp
      , MAX(dwh_valid_to_tmsp) AS dwh_valid_to_tmsp
      , UPPER(sales_manager_nat_key_nr) AS sm_nat_key_nr
    FROM src_with_groups
   GROUP BY store_nat_key_nr, sales_manager_nat_key_nr, group_id
)
SELECT DISTINCT
       store_nat_key_nr AS int_org_natural_key
     , 'STORE' AS int_org_key_type_cd
     , 'SALES_STORE' AS int_org_hierarchy_type_cd
     , UPPER(sm_nat_key_nr) AS parent_int_org_natural_key
     , 'SALES_MANAGER' AS parent_int_org_key_type_cd
     , dwh_valid_from_tmsp AS derived_valid_from_tmsp
     , dwh_valid_to_tmsp AS derived_valid_to_tmsp
     , CURRENT_TIMESTAMP() AS extraction_tmsp
     , 'SMD' AS lvl
     , 'OSO' AS source_system
     , CURRENT_DATE() AS extraction_dt
     , CURRENT_TIMESTAMP() AS dwh_mapping_tmsp
     , 0 AS tf_error_fg
     , 0 AS deleted_fg
     , 0 AS record_id
     , 't_${SRC_INPUT_TABLE}' AS filename
     , 'OSO' AS dwh_node_cd
     , '${LOAD_ID}' AS dwh_load_id
  FROM sel;
