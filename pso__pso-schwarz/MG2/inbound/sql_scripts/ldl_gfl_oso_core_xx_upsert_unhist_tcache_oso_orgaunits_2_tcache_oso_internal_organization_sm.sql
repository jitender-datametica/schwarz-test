/* MANUAL OSO - Sales Manager */
INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
       INT_ORG_NATURAL_KEY
     , INT_ORG_KEY_TYPE_CD
     , INT_ORG_TYPE_CD
     , INT_ORG_NR
     , INT_ORG_NAME
     , OPEN_DT
     , PLANNED_OPEN_DT
     , CLOSE_DT
     , CURR_CD
     , HOLIDAY_STORE_FG
     , LEGAL_NAME
     , VAT_NR
     , COUNTRY_ORG_CD
     , COMMENT_TXT
     , IS_SALES_COMPANY_FG
     , IS_DELIV_COMPANY_FG
     , IS_COUNTRY_ORG_FG
     , IS_EXPANSION_COMPANY_FG
     , IS_BAL_SHEET_COMPANY_FG
     , IS_OWNER_COMPANY_FG
     , IS_TRUST_FG
     , int_org_short_name
     , country_org_name
     , EXTRACTION_TMSP
     , LVL
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

with
stores_dedup as (
select *
   from ETL.T_TCACHE_OSO_ORGAUNITS
  where TYPE0 = 'STORE' 
qualify row_number() over (partition by orgaunitid order by extraction_timestamp desc) = 1
)
,OrgaUnits_WH_Dedup as (
select *
   from ETL.T_TCACHE_OSO_ORGAUNITS
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
    ,emp_list.value:testEmployee::VARCHAR        as testEmployee    
    ,emp_list.value:childrenEmployees   as child_empl_list 
from OrgaUnits_WH_Dedup as wh
   , LATERAL FLATTEN(INPUT => employees) as emp_list
where testemployee = false 
)
, src_with_sid as 
(
    select 
        store.countrycode || '|' || store.organumber as store_nat_key_nr
         , lisystore.igl_neodate as store_opening_dt
         , smd.countrycode
         , smd.firstname || ' ' || smd.lastname as sales_manager_name
         , amd.firstname || ' ' || amd.lastname as account_manager_name
         , substr(lisycomp.igl_associationnumber, 1,2) || to_number(regexp_replace(lisycomp.igl_associationnumber, '[^0-9]', '')) as sales_company_nr
         ,  sales_manager_name
            || ' (' 
            ||nvl(account_manager_name, 'VL '||lisycomp.igl_name)
            ||' ('
            ||sales_company_nr
            ||'))'                                  as sales_manager_nat_key_nr
        , smd.workforceid as sales_manager_id
        , smd.extraction_timestamp as sm_extraction_tmsp
        , nvl(account_manager_name, 'VL '||lisycomp.igl_name)
            ||' ('
            ||sales_company_nr
            ||')'                                  as account_manager_nat_key_nr
        , amd.workforceid as account_manager_id
        , amd.extraction_timestamp as am_extraction_tmsp
        , substr(lisycomp.igl_associationnumber, 1,2) || '|' || to_number(regexp_replace(lisycomp.igl_associationnumber, '[^0-9]', '')) as sales_comp_nat_key_nr
        , lisycomp.extraction_ts as comp_extraction_tmsp
        , relhist.igl_validfromdate
        , relhist.igl_validtodate
    from stores_dedup store
        join OrgaUnits_WH_Empl smd --- joining stores with sales managers (OSO)
            on store.employeeid = smd.id
            and store.parentorgaunitid = smd.orgaunitid
        join OrgaUnits_WH_Empl amd --- joining sales managers with account managers (OSO)
            on smd.parent_id = amd.id
        join etl_process.t_tcache_lisy_cds_account_snap lisystore --joining OSO stores with LISY store data
            on store.countrycode || store.organumber = upper(substr(lisystore.igl_number, 1, 2)) || to_number(substr(lisystore.igl_number,3,5)) 
        join etl_process.t_tcache_lisy_cds_regionrelationhistory_snap relhist 
            on relhist.igl_accountid = lisystore.accountid
            and relhist.igl_companytypecode = 285540002
        join etl_process.t_tcache_lisy_cds_company_snap lisycomp -- joining LISY sales companies
            on relhist.igl_regionid = lisycomp.id
    qualify row_number() over (partition by store_nat_key_nr, sales_manager_nat_key_nr, account_manager_nat_key_nr, sales_comp_nat_key_nr order by sm_extraction_tmsp desc) = 1
)

select distinct
       upper(sales_manager_nat_key_nr) as INT_ORG_NATURAL_KEY
     , 'SALES_MANAGER' as INT_ORG_KEY_TYPE_CD
     , 'SALES_MANAGER' as INT_ORG_TYPE_CD
     , s.countrycode || s.sales_manager_id as INT_ORG_NR
     , s.sales_manager_nat_key_nr as INT_ORG_NAME
     , NULL as OPEN_DT
     , NULL as PLANNED_OPEN_DT
     , NULL as CLOSE_DT
     , NULL as CURR_CD
     , NULL as HOLIDAY_STORE_FG
     , NULL as LEGAL_NAME
     , NULL as VAT_NR
     , CASE WHEN s.countrycode = 'LU' THEN 'BE'
            ELSE s.countrycode 
        END as COUNTRY_ORG_CD
     , NULL as COMMENT_TXT
     , NULL as IS_SALES_COMPANY_FG
     , NULL as IS_DELIV_COMPANY_FG
     , NULL as IS_COUNTRY_ORG_FG
     , NULL as IS_EXPANSION_COMPANY_FG
     , NULL as IS_BAL_SHEET_COMPANY_FG
     , NULL as IS_OWNER_COMPANY_FG
     , NULL as IS_TRUST_FG
     , NULL as int_org_short_name
     , CASE WHEN s.countrycode = 'LU' THEN 'Belgien'
            WHEN s.countrycode = 'NI' THEN 'Nordirland'
            ELSE cntr.country_name 
        END as country_org_name
     , sm_extraction_tmsp AS EXTRACTION_TMSP
     , 'SM' as LVL
     , 'OSO' AS SOURCE_SYSTEM
     , CURRENT_DATE AS EXTRACTION_DT
     , CUrrent_timestamp AS DWH_MAPPING_TMSP
     , 0 AS TF_ERROR_FG
     , 0 AS DELETED_FG
     , 0 AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}' AS FILENAME 
     , 'OSO' AS DWH_NODE_CD
     , '${LOAD_ID}' AS DWH_LOAD_ID 
  FROM src_with_sid s
  LEFT JOIN core_rel.t_country cntr
    ON cntr.iso_country_cd = s.countrycode
   and cntr.dwh_valid_fg = true

;
