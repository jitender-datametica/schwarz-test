/* MANUAL- SMD-to-AMD 2 */
INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
       INT_ORG_NATURAL_KEY
     , INT_ORG_KEY_TYPE_CD        
     , INT_ORG_HIERARCHY_TYPE_CD
     , PARENT_INT_ORG_NATURAL_KEY
     , PARENT_INT_ORG_KEY_TYPE_CD
     , DERIVED_VALID_FROM_TMSP
     , DERIVED_VALID_TO_TMSP
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
     , DWH_LOAD_ID )
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
, src as 
(
    select 
        store.countrycode || '|' || store.organumber as store_nat_key_nr
         , lisystore.igl_neodate as store_opening_dt
         , smd.firstname || ' ' || smd.lastname as sales_manager_name
         , amd.firstname || ' ' || amd.lastname as account_manager_name
         , substr(lisycomp.igl_associationnumber, 1,2) || to_number(regexp_replace(lisycomp.igl_associationnumber, '[^0-9]', '')) as sales_company_nr
         ,  sales_manager_name
            || ' (' 
            ||nvl(account_manager_name, 'VL '||lisycomp.igl_name)
            ||' ('
            ||sales_company_nr
            ||'))'                                  as sales_manager_nat_key_nr
        , smd.extraction_timestamp as sm_extraction_tmsp
        , nvl(account_manager_name, 'VL '||lisycomp.igl_name)
            ||' ('
            ||sales_company_nr
            ||')'                                  as account_manager_nat_key_nr
        , amd.extraction_timestamp as am_extraction_tmsp
        , substr(lisycomp.igl_associationnumber, 1,2) || '|' || to_number(regexp_replace(lisycomp.igl_associationnumber, '[^0-9]', '')) as sales_comp_nat_key_nr
        , lisycomp.extraction_ts as comp_extraction_tmsp
        , relhist.igl_validfromdate
        , to_date(greatest(lisystore.igl_neodate, relhist.igl_validfromdate)) as dwh_valid_from_dt
        , dateadd(ms, -1, dateadd(day, 1, relhist.igl_validtodate)) as valid_to_tmsp
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
            and relhist.igl_companytypecode = 285540002 -- sales company
			-- we include this additional filter because the validity intervals for some stores fall outside their operational lifecycle
			and (
				-- we are only interested in relations which were valid when the store opened
				lisystore.igl_neodate between relhist.igl_validfromdate and relhist.igl_validtodate
			   -- or relations which were valid when the store closed
				or lisystore.igl_closingdate between relhist.igl_validfromdate and relhist.igl_validtodate
				-- or relations that started at some point after the store opened and the store is still operational. This scenario is different than the first because it aims to include relations that became valid after the initial relation that was active when the store first opened. The first scenario is not going to "catch" them because the open date will fall before the validity start date of the subsequent relation. The second scenario is also not going to "catch" them if the closing date of the store is null.
				or lisystore.igl_closingdate is null and relhist.igl_validtodate >= lisystore.igl_neodate
				-- or relations that became valid after the store was opened and lost their validity before the store closed
				or relhist.igl_validfromdate > lisystore.igl_neodate and relhist.igl_validtodate < lisystore.igl_closingdate
				) 
        join etl_process.t_tcache_lisy_cds_company_snap lisycomp -- joining LISY sales companies
            on relhist.igl_regionid = lisycomp.id
    where 1=1
    -- we want to avoid bad data delivering relations that end before they start or on the day they start
        and relhist.igl_validfromdate < relhist.igl_validtodate
     --- if we get overlapping data about relations of a store with multiple sales companies, we take the most recent relation. Still, we don't want to exclude company relations altogether which is why we take rh.igl_validfromdate in the partitioning clause. E.g. if a store opens on 2020-01-01 and has a relation to sales company X from 2019-01-01 until 2020-01-03 and then to sales company Y from 2020-01-04 until 2200-01-01 we want to take both companies, not just sales company Y.
    qualify row_number() over (partition by store_nat_key_nr, account_manager_nat_key_nr, sales_comp_nat_key_nr, relhist.igl_validfromdate order by relhist.igl_validfromdate desc) = 1
)
, src_with_sid as
(
	select 
        store_key.party_sid as STORE_SID
        ,src.store_nat_key_nr
        ,src.dwh_valid_from_dt
        ,src.valid_to_tmsp
		,src.igl_validfromdate as rel_valid_from
		,src.sales_manager_nat_key_nr
		,src.account_manager_nat_key_nr
		,src.sales_comp_nat_key_nr
    from src
        join meta.t_party_key store_key 
            on upper(src.store_nat_key_nr)  = store_key.party_nat_key_nr
            and store_key.PARTY_KEY_TYPE_CD = 'STORE'
        --- if we get overlapping data about relations of a store with multiple companies, we take the most recent relation. This is necessary because there are situations when a store opens on 2020-01-01 and has a relation to sales company X from 2019-01-01 until 2200-01-01 and to sales company Y from 2019-12-01 until 2200-01-01. In such a scenario, we only want to take the latest relation to sales company Y.
    qualify row_number() over (partition by store_key.PARTY_SID, src.dwh_valid_from_dt order by rel_valid_from desc) = 1 
)
, src_track_changes as 
(
    select
        sales_manager_nat_key_nr
        ,dwh_valid_from_dt
        ,least(valid_to_tmsp, nvl(dateadd(ms, -1, lead(dwh_valid_from_dt) over (partition by store_sid order by dwh_valid_from_dt)), '9999-12-31 23:23:59.999999999')) as dwh_valid_to_tmsp
		,account_manager_nat_key_nr
		,sales_comp_nat_key_nr
        ,sha2(sales_manager_nat_key_nr || '#&#' ||
			  account_manager_nat_key_nr || '#&#' ||
			  sales_comp_nat_key_nr) as row_hash_for_diff
        ,lag(row_hash_for_diff)
            over (
                PARTITION BY sales_manager_nat_key_nr
                ORDER BY dwh_valid_from_dt asc
            )                           as prev_row_hash_for_diff
        
        ,CASE
                WHEN row_hash_for_diff = prev_row_hash_for_diff THEN 0
                ELSE 1
            END                         as HAS_CHANGE_FG
    from src_with_sid
)
, src_with_groups as
(
    select
        *
        , sum(has_change_fg) over (
                partition by sales_manager_nat_key_nr
                order by dwh_valid_from_dt asc, has_change_fg desc
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) as GROUP_ID
    from src_track_changes
), sel as (
select 
    upper(sales_manager_nat_key_nr) as sm_nat_key_nr
    ,to_timestamp(min(dwh_valid_from_dt)) as dwh_valid_from_tmsp
    ,max(dwh_valid_to_tmsp) as dwh_valid_to_tmsp
    ,upper(account_manager_nat_key_nr) as am_nat_key_nr
from src_with_groups
group by
    sales_manager_nat_key_nr
    ,account_manager_nat_key_nr
    ,group_id
)
select 
       sm_nat_key_nr as INT_ORG_NATURAL_KEY
     , 'SALES_MANAGER' as INT_ORG_KEY_TYPE_CD
     , 'ACCOUNT_SALES' as INT_ORG_HIERARCHY_TYPE_CD
     , am_nat_key_nr as parent_int_org_natural_key
     , 'ACCOUNT_MANAGER' as parent_int_org_natural_type_cd
     , DWH_VALID_FROM_TMSP AS DERIVED_VALID_FROM_TMSP
     , DWH_VALID_TO_TMSP AS DERIVED_VALID_TO_TMSP
     , current_timestamp AS EXTRACTION_TMSP
     , 'AMD' AS LVL
     , 'OSO' AS SOURCE_SYSTEM
     , CURRENT_DATE AS EXTRACTION_DT
     , CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP
     , 0 AS TF_ERROR_FG
     , 0 AS DELETED_FG
     , 0 AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}' AS FILENAME
     , 'OSO' AS DWH_NODE_CD
     , '${LOAD_ID}' AS DWH_LOAD_ID 
  from sel
;
