/*  This step is executed in order to remove records loaded from P_LEW_CORE for which we now have OSO data because we 
    want to avoid a situation where we have multiple EMP_SIDs representing the same person (one generated from P_LEW_CORE 
    based on firstname || lastname, and one generated from OSO based on the e-mail) for the same job_role_sid.
*/
delete from core_rel.t_employee_job_role ejr
where ejr.emp_sid in (select party_sid
                        from meta.t_party_key
                       where party_key_type_cd = 'PERSON'
--                         and dwh_node_cd = 'P_LEW_CORE'
                         and translate( PARTY_NAT_KEY_NR, ' 0123456789()|-', '') in ( select translate( upper(first_name || '|' || family_name), ' 0123456789()|-', '')
                                                     from core_rel.t_person
                                                     where dwh_node_cd = 'OSO')
                     );

INSERT INTO   ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (      
      emp_nat_key_nr,
      emp_key_type_cd, 
      job_role_nat_key_nr,
      job_role_key_type_cd,  
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

, src_with_sid as (
select
      store.countrycode || store.organumber as store_nr
    , lower(smd.mail) as sm_emp_nat_key_nr
    , lower(amd.mail) as am_emp_nat_key_nr
--    , lower(cmd.mail) as cm_emp_nat_key_nr
    , smd.firstname || ' ' || smd.lastname as sales_manager_name
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
    , smd.extraction_timestamp as sm_extraction_tmsp
    , amd.extraction_timestamp as am_extraction_tmsp
    , substr(lisycomp.igl_associationnumber, 1,2) || '|' || to_number(regexp_replace(lisycomp.igl_associationnumber, '[^0-9]', '')) as sales_comp_nat_key_nr
    , lisycomp.extraction_ts as sales_comp_extraction_tmsp
    , amd.parent_id
    , store.parentorgaunitid
 from stores_dedup store
        join etl.t_tcache_oso_employees smd --- joining stores with sales managers (OSO)
            on store.employeeid = smd.id
            and smd.orgaunitid = store.parentorgaunitid -- take only the sales managers associated with the parentorgaunit of the respective store (one sales manager can be associated with more than one company)
        join etl.t_tcache_oso_employees amd --- joining sales managers with account managers (OSO)
            on smd.parent_id = amd.id
            and amd.orgaunitid = store.parentorgaunitid -- take only the account managers associated with the parentorgaunit of the respective store (one account manager can be associated with more than one company)
--        join etl.t_tcache_oso_employees cmd --- joining account managers with company managers (the manager of the given sales company) (OSO)
--            on amd.parent_id = cmd.id
--            and cmd.orgaunitid = store.parentorgaunitid -- take only the company managers associated with the parentorgaunit of the respective store (one company manager can be associated with more than one company)
        join etl_process.t_tcache_lisy_cds_account_snap lisystore --joining OSO stores with LISY store data
            on store.countrycode || store.organumber = upper(substr(lisystore.igl_number, 1, 2)) || to_number(substr(lisystore.igl_number,3,5)) 
        join etl_process.t_tcache_lisy_cds_company_snap lisycomp -- joining LISY sales companies because OSO companies are unreliable, as they aren't always sales companies
            on lisystore.igl_salesassocid = lisycomp.id
)


-- get all relations between store - sales manager - account manager - company manager & sales company
, src_with_sid_cm as (
select store.*
     , lower(cmd.mail) as cm_emp_nat_key_nr
  from src_with_sid store
  join etl.t_tcache_oso_employees cmd --- joining account managers with company managers (the manager of the given sales company) (OSO)
    on store.parent_id = cmd.id
   and store.parentorgaunitid = cmd.orgaunitid  -- take only the company managers associated with the parentorgaunit of the respective store (one company manager can be associated with more than one company)
)

/* sales manager employee job role */
select 
      sm_emp_nat_key_nr as emp_nat_key_nr -- look up EMP_SID in t_party_key where party_key_type_cd = 'PERSON'
    , 'PERSON' as emp_key_type_cd 
    , translate(upper(sales_manager_nat_key_nr)
                , sc.country_from_special_char_list
                , sc.country_to_special_char_list) as job_role_nat_key_nr --- look up job_role_sid in meta.t_job_role_key where job_role_key_type_cd = 'COMPANY_MANAGER'
    , 'SALES_MANAGER' as job_role_key_type_cd            
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
, etl_process.t_country_special_char as sc
qualify row_number() over (partition by emp_nat_key_nr, job_role_nat_key_nr order by sales_comp_extraction_tmsp) = 1

UNION ALL

/* account manager employee job role */
select 
      am_emp_nat_key_nr as emp_nat_key_nr -- look up EMP_SID in t_party_key where party_key_type_cd = 'PERSON'
    , 'PERSON' as emp_key_type_cd 
    , translate(upper(account_manager_nat_key_nr)
                , sc.country_from_special_char_list
                , sc.country_to_special_char_list) as job_role_nat_key_nr --- look up job_role_sid in meta.t_job_role_key where job_role_key_type_cd = 'COMPANY_MANAGER'
    , 'ACCOUNT_MANAGER' as job_role_key_type_cd            
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
, etl_process.t_country_special_char as sc
qualify row_number() over (partition by emp_nat_key_nr, job_role_nat_key_nr order by sales_comp_extraction_tmsp) = 1

UNION ALL

/* company manager job role */
select 
      cm_emp_nat_key_nr as emp_nat_key_nr -- look up EMP_SID in t_party_key where party_key_type_cd = 'PERSON'
    , 'PERSON' as emp_key_type_cd 
    , translate(upper(sales_comp_nat_key_nr)
                , sc.country_from_special_char_list
                , sc.country_to_special_char_list) as job_role_nat_key_nr --- look up job_role_sid in meta.t_job_role_key where job_role_key_type_cd = 'COMPANY_MANAGER'
    , 'COMPANY_MANAGER' as job_role_key_type_cd            
           /*  */
     , 'OSO' AS SOURCE_SYSTEM
     , CURRENT_DATE AS EXTRACTION_DT
     , sm_extraction_tmsp AS DWH_MAPPING_TMSP 
     , 0 AS TF_ERROR_FG
     , 0 AS DELETED_FG
     , 0 AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}' AS FILENAME
     , 'OSO' AS DWH_NODE_CD
     , '${LOAD_ID}' AS DWH_LOAD_ID
from src_with_sid_cm src
, etl_process.t_country_special_char as sc
qualify row_number() over (partition by emp_nat_key_nr, job_role_nat_key_nr order by sales_comp_extraction_tmsp) = 1
;

