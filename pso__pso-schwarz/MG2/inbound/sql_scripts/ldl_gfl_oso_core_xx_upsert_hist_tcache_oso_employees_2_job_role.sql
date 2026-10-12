INSERT INTO   ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
      JOB_ROLE_NAT_KEY_NR,
      JOB_ROLE_KEY_TYPE_CD,
      JOB_ROLE_TYPE_CD,
      JOB_ROLE_NAME,
      INT_ORG_NAT_KEY,
      INT_ORG_KEY_TYPE_CD,
      REPORTS_TO_JOB_ROLE_NAT_KEY_NR,
      REPORTS_TO_JOB_ROLE_KEY_TYPE_CD,
--    FRAMEWORK AND TECHNICAL COLUMNS
      SOURCE_SYSTEM,
      EXTRACTION_DT,
      DWH_MAPPING_TMSP,      
      TF_ERROR_FG,
      DELETED_FG,
      RECORD_ID,
      FILENAME,
      DWH_NODE_CD,
      DWH_LOAD_ID)
with
-- deduplicating all stores coming from OSO
stores_dedup as (
select *
   from ETL.T_TCACHE_OSO_ORGAUNITS
  where TYPE0 = 'STORE' 
qualify row_number() over (partition by orgaunitid order by extraction_timestamp desc) = 1
)

-- get all relations between store - sales manager - account manager - company manager & sales company
, src_with_sid as (
select 
     smd.firstname || ' ' || smd.lastname as sales_manager_name
     , amd.firstname || ' ' || amd.lastname as account_manager_name
     , substr(lisycomp.igl_associationnumber, 1,2) || to_number(regexp_replace(lisycomp.igl_associationnumber, '[^0-9]', '')) as sales_company_nr
     ,  sales_manager_name
        || ' (' 
        ||nvl(account_manager_name, 'VL '||lisycomp.igl_name)
        ||' ('
        ||sales_company_nr
        ||'))'                                  as sales_manager_nat_key_nr
    , nvl(account_manager_name, 'VL '||lisycomp.igl_name)
        ||' ('
        ||sales_company_nr
        ||')'                                  as account_manager_nat_key_nr
    , store.extraction_timestamp as extraction_tmsp
    , substr(lisycomp.igl_associationnumber, 1,2) || '|' || to_number(regexp_replace(lisycomp.igl_associationnumber, '[^0-9]', '')) as sales_comp_nat_key_nr
    , lisycomp.extraction_ts as sales_comp_extraction_tmsp
from stores_dedup store
    join etl.t_tcache_oso_employees smd --- joining stores with sales managers (OSO)
        on store.employeeid = smd.id
        and smd.orgaunitid = store.parentorgaunitid -- take only the sales managers associated with the parentorgaunit of the respective store (one sales manager can be associated with more than one company)
    join etl.t_tcache_oso_employees amd --- joining sales managers with account managers (OSO)
        on smd.parent_id = amd.id
        and amd.orgaunitid = store.parentorgaunitid -- take only the account managers associated with the parentorgaunit of the respective store (one account manager can be associated with more than one company)
--    join etl.t_tcache_oso_employees cmd --- joining account managers with company managers (the manager of the given sales company) (OSO)
--        on amd.parent_id = cmd.id
--        and cmd.orgaunitid = store.parentorgaunitid -- take only the company managers associated with the parentorgaunit of the respective store (one company manager can be associated with more than one company)
    join etl_process.t_tcache_lisy_cds_account_snap lisystore --joining OSO stores with LISY store data
        on store.countrycode || store.organumber = upper(substr(lisystore.igl_number, 1, 2)) || to_number(substr(lisystore.igl_number,3,5)) 
    join etl_process.t_tcache_lisy_cds_company_snap lisycomp -- joining LISY sales companies because OSO companies are unreliable, as they aren't always sales companies
        on lisystore.igl_salesassocid = lisycomp.id
)
-- sales manager job role
select
      translate(upper(sales_manager_nat_key_nr)
                , sc.country_from_special_char_list
                , sc.country_to_special_char_list) as job_role_nat_key_nr --- look up job_role_sid in meta.t_job_role_key where job_role_key_type_cd = 'SALES_MANAGER'
    , 'SALES_MANAGER' AS job_role_key_type_cd
    , 'SALES_MANAGER' as job_role_type_cd
    , 'Verkaufsleiter ' || sales_manager_nat_key_nr as job_role_name
    , translate(upper(sales_manager_nat_key_nr)
                , sc.country_from_special_char_list
                , sc.country_to_special_char_list) as INT_ORG_NAT_KEY --- look up party_sid in meta.t_party_key where party_key_type_cd = 'SALES_MANAGER'
    , 'SALES_MANAGER' as INT_ORG_KEY_TYPE_CD
    , translate(upper(account_manager_nat_key_nr)
    , sc.country_from_special_char_list
    , sc.country_to_special_char_list) as reports_to_job_role_nat_key_nr --- look up job_role_sid in meta.t_job_role_key where job_role_key_type_cd = 'ACCOUNT_MANAGER'
    , 'ACCOUNT_MANAGER' as reports_to_job_role_key_type_cd
       /*  */
     , 'OSO' AS SOURCE_SYSTEM
     , CURRENT_DATE AS EXTRACTION_DT
     , extraction_tmsp AS DWH_MAPPING_TMSP 
     , 0 AS TF_ERROR_FG
     , 0 AS DELETED_FG
     , 0 AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}' AS FILENAME
     , 'OSO' AS DWH_NODE_CD
     , '${LOAD_ID}' AS DWH_LOAD_ID    
from src_with_sid
, etl_process.t_country_special_char as sc
qualify row_number() over (partition by sales_manager_nat_key_nr order by extraction_tmsp desc) = 1

union all

-- account manager job role
select 
    translate(upper(account_manager_nat_key_nr)
                , sc.country_from_special_char_list
                , sc.country_to_special_char_list) as job_role_nat_key_nr --- look up job_role_sid in meta.t_job_role_key where job_role_key_type_cd = 'ACCOUNT_MANAGER'
    , 'ACCOUNT_MANAGER' AS job_role_key_type_cd
    , 'ACCOUNT_MANAGER' as job_role_type_cd
    , 'Vertriebsleiter ' || account_manager_nat_key_nr as job_role_name
    , translate(upper(account_manager_nat_key_nr)
                , sc.country_from_special_char_list
                , sc.country_to_special_char_list) as INT_ORG_NAT_KEY --- look up party_sid in meta.t_party_key where party_key_type_cd = 'ACCOUNT_MANAGER'
    , 'ACCOUNT_MANAGER' as INT_ORG_KEY_TYPE_CD
    , sales_comp_nat_key_nr as reports_to_job_role_nat_key_nr --- look up job_role_sid in meta.t_job_role_key where job_role_key_type_cd = 'COMPANY_MANAGER'
    , 'COMPANY_MANAGER' as reports_to_job_role_key_type_cd
           /*  */
     , 'OSO' AS SOURCE_SYSTEM
     , CURRENT_DATE AS EXTRACTION_DT
     , extraction_tmsp AS DWH_MAPPING_TMSP 
     , 0 AS TF_ERROR_FG
     , 0 AS DELETED_FG
     , 0 AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}' AS FILENAME
     , 'OSO' AS DWH_NODE_CD
     , '${LOAD_ID}' AS DWH_LOAD_ID
from src_with_sid
, etl_process.t_country_special_char as sc
qualify row_number() over (partition by account_manager_nat_key_nr order by extraction_tmsp desc) = 1

union all

-- company manager job role
select
      sales_comp_nat_key_nr as job_role_nat_key_nr --- look up job_role_sid in meta.t_job_role_key where job_role_key_type_cd = 'COMPANY_MANAGER'
    , 'COMPANY_MANAGER' ob_role_key_type_cd 
    , 'COMPANY_MANAGER' as job_role_type_cd
    , 'Geschäftsführer ' || sales_company_nr as job_role_name
    , sales_comp_nat_key_nr as INT_ORG_NAT_KEY --- look up party_sid in meta.t_party_key where party_key_type_cd = 'COMPANY'
    , 'COMPANY' as INT_ORG_KEY_TYPE_CD
    , pk.party_nat_key_nr as reports_to_job_role_nat_key_nr --- look up job_role_sid in meta.t_job_role_key where job_role_key_type_cd = 'REGION_MANAGER'
    , 'REGION_MANAGER' as reports_to_job_role_key_type_cd
           /*  */
     , 'OSO' AS SOURCE_SYSTEM
     , CURRENT_DATE AS EXTRACTION_DT
     , sales_comp_extraction_tmsp AS DWH_MAPPING_TMSP 
     , 0 AS TF_ERROR_FG
     , 0 AS DELETED_FG
     , 0 AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}' AS FILENAME
     , 'OSO' AS DWH_NODE_CD
     , '${LOAD_ID}' AS DWH_LOAD_ID
from src_with_sid src
    -- we need to take the SID of the parent region of the given sales company
    join meta.t_party_key sck
      on sck.party_nat_key_nr = src.sales_comp_nat_key_nr
     and sck.party_key_type_cd = 'COMPANY'
     and sck.dwh_valid_fg
    join core_rel.t_internal_organization_hierarchy ioh
      on sck.party_sid = ioh.int_org_sid
     and ioh.int_org_hierarchy_type_cd = 'REGION_COMPANY'
     and src.sales_comp_extraction_tmsp between ioh.dwh_valid_from_tmsp and ioh.dwh_valid_to_tmsp
    join meta.t_party_key pk
      on pk.party_sid = ioh.parent_int_org_sid
     and pk.party_key_type_cd = 'REGION'
     and pk.dwh_valid_fg
qualify row_number() over (partition by sales_comp_nat_key_nr order by extraction_tmsp desc) = 1
;
