TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE}; 

INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
      ORGAUNITID
    , COUNTRYCODE
    , ORGANUMBER
    , TYPE0
    , WH_NAME
    , PARENTORGAUNITID
    , ID
    , PARENT_ID
    , ADNAME
    , FIRSTNAME
    , LASTNAME
    , DEPUTYEMPLOYEEID
    , MAIL
    , PHONE
    , EMPL_ROLE
    , WORKFORCEID
    , CHILD_EMPL_LIST
    , EXTRACTION_TIMESTAMP
    --------------------------------
    , SOURCE_SYSTEM
    , EXTRACTION_DT
    , DWH_MAPPING_TMSP
    , TF_ERROR_FG
    , DELETED_FG
    , RECORD_ID
    , FILENAME
    , DWH_NODE_CD
    , DWH_LOAD_ID
) 
 with OrgaUnits_WH_Dedup as (
select *
   from ${TEMP_DB}.T_${SRC_INPUT_TABLE}
  where TYPE0 = 'WAREHOUSE' 
qualify row_number() over (partition by orgaunitid order by extraction_timestamp desc) = 1
)
, OrgaUnits_WH_Empl as (
select distinct 
     wh.orgaunitid
    ,wh.countrycode
    ,wh.organumber
    ,wh.type0 
    ,wh.name as wh_name
    ,wh.parentorgaunitid
    ,wh.EXTRACTION_TIMESTAMP
    --
    ,emp_list.value:id::VARCHAR                   as id
    ,emp_list.value:parentEmployeeId::VARCHAR     as parent_id
    ,emp_list.value:adName::VARCHAR               as adName
    ,emp_list.value:firstName::VARCHAR            as firstName
    ,emp_list.value:lastName::VARCHAR             as lastName
    ,emp_list.value:deputyEmployeeId::VARCHAR     as deputyEmployeeId
    ,emp_list.value:mail::VARCHAR                 as mail
    ,emp_list.value:phone::VARCHAR                as phone
    ,emp_list.value:role::VARCHAR                 as empl_role
    ,emp_list.value:workforceId::VARCHAR          as workforceId
    ,emp_list.value:testEmployee::VARCHAR         as testEmployee    
    ,emp_list.value:childrenEmployees             as child_empl_list 
from OrgaUnits_WH_Dedup as wh
   , LATERAL FLATTEN(INPUT => employees) as emp_list
where testemployee = false 
)

SELECT 
      ORGAUNITID
    , COUNTRYCODE
    , ORGANUMBER
    , TYPE0
    , WH_NAME
    , PARENTORGAUNITID
    , ID
    , PARENT_ID
    , ADNAME
    , FIRSTNAME
    , LASTNAME
    , DEPUTYEMPLOYEEID
    , MAIL
    , substr( PHONE,1,20) as PHONE 
    , EMPL_ROLE
    , WORKFORCEID
    , CHILD_EMPL_LIST
    , EXTRACTION_TIMESTAMP
    --------------------------------
    , 'OSO'                              AS SOURCE_SYSTEM
    , CURRENT_DATE                       AS EXTRACTION_DT
    , current_timestamp                  AS DWH_MAPPING_TMSP
    , 0                                  AS TF_ERROR_FG
    , 0                                  AS DELETED_FG
    , 0                                  AS RECORD_ID
    , '${SRC_INPUT_TABLE}'               AS FILENAME
    , 'OSO'                              AS DWH_NODE_CD
    , '${LOAD_ID}'                       AS DWH_LOAD_ID
FROM OrgaUnits_WH_Empl src
;
