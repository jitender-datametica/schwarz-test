TRUNCATE TABLE ${target_db}.${tgt_target_table};

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
      orgaunitid
    , countrycode
    , organumber
    , type0
    , wh_name
    , parentorgaunitid
    , id
    , parent_id
    , adname
    , firstname
    , lastname
    , deputyemployeeid
    , mail
    , phone
    , empl_role
    , workforceid
    , child_empl_list
    , extraction_timestamp
    --------------------------------
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
WITH orgaunits_wh_dedup AS (
  SELECT *
    FROM ${temp_db}.t_${src_input_table}
   WHERE type0 = 'WAREHOUSE'
   QUALIFY ROW_NUMBER() OVER (
     PARTITION BY orgaunitid
     ORDER BY extraction_timestamp DESC
   ) = 1
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
      -- JSON extraction in BigQuery
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.id') AS id
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.parentEmployeeId') AS parent_id
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.adName') AS adname
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.firstName') AS firstname
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.lastName') AS lastname
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.deputyEmployeeId') AS deputyemployeeid
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.mail') AS mail
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.phone') AS phone
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.role') AS empl_role
      ,JSON_EXTRACT_SCALAR(emp_list.value, '$.workforceId') AS workforceid
      ,JSON_EXTRACT(emp_list.value, '$.childrenEmployees') AS child_empl_list
  FROM orgaunits_wh_dedup AS wh,
       UNNEST(wh.employees) AS emp_list
  WHERE JSON_EXTRACT_SCALAR(emp_list.value, '$.testEmployee') = 'false'
)

SELECT 
      orgaunitid
    , countrycode
    , organumber
    , type0
    , wh_name
    , parentorgaunitid
    , id
    , parent_id
    , adname
    , firstname
    , lastname
    , deputyemployeeid
    , mail
    , SUBSTR(phone, 1, 20) AS phone
    , empl_role
    , workforceid
    , child_empl_list
    , extraction_timestamp
    --------------------------------
    , 'OSO'                              AS source_system
    , CURRENT_DATE()                     AS extraction_dt
    , CURRENT_TIMESTAMP()                AS dwh_mapping_tmsp
    , 0                                  AS tf_error_fg
    , 0                                  AS deleted_fg
    , 0                                  AS record_id
    , '${SRC_INPUT_TABLE}'          AS filename
    , 'OSO'                              AS dwh_node_cd
    , '${LOAD_ID}'                  AS dwh_load_id
FROM orgaunits_wh_empl AS src;
