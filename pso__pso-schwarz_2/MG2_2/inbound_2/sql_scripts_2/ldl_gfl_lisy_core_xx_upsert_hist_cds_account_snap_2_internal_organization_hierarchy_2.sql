-- if we get information for the store for this type of relationship from lisy
-- DELETE relationships of type 'DELIVCMP_STORE' from non-lisy sources

DELETE FROM core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2
WHERE 1=1  
    and upper(DWH_NODE_CD) <> 'LISY'
    and INT_ORG_HIERARCHY_TYPE_CD = 'DELIVCMP_STORE' 
    
    and INT_ORG_SID in 
    (
        -- get the SID only if LISY sends us information to which company the CURRENT building of the store is related
SELECT curr_store.PARTY_SID
FROM meta.T_PARTY_KEY_2 curr_store

join (
    select
    ac.igl_number
    , rh.*
    from etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_2 rh
    join etl_process.t_tcache_lisy_cds_account_snap_2 ac
        on rh.igl_accountid = ac.accountid
    where 1=1
        and rh.igl_companytypecode = 285540000
        and rh.statecode = 0
        and rh.igl_regionid is not null
    qualify row_number() over (
    partition by rh.igl_accountid, rh.igl_regionid, rh.igl_companytypecode, rh.igl_validfromdate
    order by rh.sinkmodifiedon desc) = 1
) src on upper(substr(src.igl_number, 1, 2)) || to_number(substr(src.igl_number, 3, length(src.igl_number))) = upper(substr(curr_store.party_nat_key_nr, 1, 2)) || substr(curr_store.party_nat_key_nr, 4, length(curr_store.party_nat_key_nr))

WHERE 1=1
    and curr_store.dwh_valid_fg = TRUE
    and curr_store.party_key_type_cd = 'STORE'
    )
;


-- if we get information for the store for this type of relationship from lisy
-- DELETE relationships of type EXPCMP_STORE from non-lisy sources

DELETE FROM core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2
WHERE 1=1  
    and upper(DWH_NODE_CD) <> 'LISY'
    and INT_ORG_HIERARCHY_TYPE_CD = 'EXPCMP_STORE' 
    
    and INT_ORG_SID in 
    (
        -- get the SID only if LISY sends us information to which company the CURRENT building of the store is related
SELECT curr_store.PARTY_SID
FROM meta.T_PARTY_KEY_2 curr_store

join (
    select
    ac.igl_number
    , rh.*
    from etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_2 rh
    join etl_process.t_tcache_lisy_cds_account_snap_2 ac
        on rh.igl_accountid = ac.accountid
    where 1=1
        and rh.igl_companytypecode = 285540003
        and rh.statecode = 0
        and rh.igl_regionid is not null
    qualify row_number() over (
    partition by rh.igl_accountid, rh.igl_regionid, rh.igl_companytypecode, rh.igl_validfromdate
    order by RH.SINKMODIFIEDON desc) = 1
) src on upper(substr(src.igl_number, 1, 2)) || to_number(substr(src.igl_number, 3, length(src.igl_number))) = upper(substr(curr_store.party_nat_key_nr, 1, 2)) || substr(curr_store.party_nat_key_nr, 4, length(curr_store.party_nat_key_nr))

WHERE 1=1
    and curr_store.dwh_valid_fg = TRUE
    and curr_store.party_key_type_cd = 'STORE'
    )
;

-- if we get information for the store for this type of relationship from lisy
-- DELETE relationships of type EXPCMP_STORE from non-lisy sources

DELETE FROM core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2
WHERE 1=1  
    and upper(DWH_NODE_CD) <> 'LISY'
    and INT_ORG_HIERARCHY_TYPE_CD = 'OWNERCMP_STORE' 
    
    and INT_ORG_SID in 
    (
        -- get the SID only if LISY sends us information to which company the CURRENT building of the store is related
SELECT curr_store.PARTY_SID
FROM meta.T_PARTY_KEY_2 curr_store

join (
    select
    ac.igl_number
    , rh.*
    from etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_2 rh
    join etl_process.t_tcache_lisy_cds_account_snap_2 ac
        on rh.igl_accountid = ac.accountid
    where 1=1
        and rh.igl_companytypecode = 285540005
        and rh.statecode = 0
        and rh.igl_regionid is not null
    qualify row_number() over (
    partition by rh.igl_accountid, rh.igl_regionid, rh.igl_companytypecode, rh.igl_validfromdate
    order by RH.SINKMODIFIEDON desc) = 1
) src on upper(substr(src.igl_number, 1, 2)) || to_number(substr(src.igl_number, 3, length(src.igl_number))) = upper(substr(curr_store.party_nat_key_nr, 1, 2)) || substr(curr_store.party_nat_key_nr, 4, length(curr_store.party_nat_key_nr))

WHERE 1=1
    and curr_store.dwh_valid_fg = TRUE
    and curr_store.party_key_type_cd = 'STORE'

    )
;

-- if we get information for the store for this type of relationship from lisy
-- DELETE relationships of type EXPCMP_STORE from non-lisy sources

DELETE FROM core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2
WHERE 1=1  
    and upper(DWH_NODE_CD) <> 'LISY'
    and INT_ORG_HIERARCHY_TYPE_CD = 'BALSHCMP_STORE' 
    
    and INT_ORG_SID in 
    (
        -- get the SID only if LISY sends us information to which company the CURRENT building of the store is related
SELECT curr_store.PARTY_SID
FROM meta.T_PARTY_KEY_2 curr_store

join (
    select
    ac.igl_number
    , rh.*
    from etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_2 rh
    join etl_process.t_tcache_lisy_cds_account_snap_2 ac
        on rh.igl_accountid = ac.accountid
    where 1=1
        and rh.igl_companytypecode = 285540006
        and rh.statecode = 0
        and rh.igl_regionid is not null
    qualify row_number() over (
    partition by rh.igl_accountid, rh.igl_regionid, rh.igl_companytypecode, rh.igl_validfromdate
    order by RH.SINKMODIFIEDON desc) = 1
) src on upper(substr(src.igl_number, 1, 2)) || to_number(substr(src.igl_number, 3, length(src.igl_number))) = upper(substr(curr_store.party_nat_key_nr, 1, 2)) || substr(curr_store.party_nat_key_nr, 4, length(curr_store.party_nat_key_nr))

WHERE 1=1
    and curr_store.dwh_valid_fg = TRUE
    and curr_store.party_key_type_cd = 'STORE'
    )
;


INSERT INTO  ETL.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        INT_ORG_SID,
        INT_ORG_HIERARCHY_TYPE_CD,
        PARENT_INT_ORG_SID,
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        DWH_ENDING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
)
with 
relhist_dedup as
(
    select
    *
    from etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_2
    qualify row_number() over (
    partition by igl_accountid, igl_regionid, igl_companytypecode, igl_validfromdate
    order by sinkmodifiedon desc) = 1
)
,src as
(
    select 
        act.igl_number
        ,act.igl_neodate
        ,act.igl_closingdate
        ,rh.igl_validfromdate
        ,dateadd(ms, -1, dateadd(day, 1, rh.igl_validtodate)) as valid_to_tmsp
        ,comp.igl_associationnumber
        ,rh.igl_companytypecode
        --- if the relations start before the open date of the store, we want to take the open date as start of validity_2
        ,to_date(greatest(act.igl_neodate, rh.igl_validfromdate)) as dwh_valid_from_dt
        ,to_date(rh.igl_validtodate) as dwh_valid_to_dt
    from relhist_dedup rh
        inner join etl_process.t_tcache_lisy_cds_account_snap_2 act
                on rh.igl_accountid = act.accountid
                -- we include this additional filter because the validity_2 intervals for some stores fall outside their operational lifecycle
                and (
                    -- we are only interested in relations which were valid when the store opened
                    act.igl_neodate between rh.igl_validfromdate and rh.igl_validtodate
                   -- or relations which were valid when the store closed
                    or act.igl_closingdate between rh.igl_validfromdate and rh.igl_validtodate
                    -- or relations that started at some point after the store opened and the store is still operational. This scenario is different than the first because it aims to include relations that became valid after the initial relation that was active when the store first opened. The first scenario is not going to "catch" them because the open date will fall before the validity_2 start date of the subsequent relation. The second scenario is also not going to "catch" them if the closing date of the store is null.
                    or act.igl_closingdate is null and rh.igl_validtodate >= act.igl_neodate
                    -- or relations that became valid after the store was opened and lost their validity_2 before the store closed
                    or rh.igl_validfromdate > act.igl_neodate and rh.igl_validtodate < act.igl_closingdate
                    ) 
        inner join etl_process.t_tcache_lisy_cds_company_snap_2 comp
                on comp.id = rh.igl_regionid    
    where 1=1      
        and act.igl_accounttypecode in (285540000, 285540009) -- real estate associated with stores and special sale stores
        and act.igl_number is not null
        and rh.igl_companytypecode in (285540000, 285540003, 285540005, 285540006) -- delivery companies, expansion companies, owner companies, balance sheet companies
        -- we want to avoid bad data delivering relations that end before they start or on the day they start
        and rh.igl_validfromdate < rh.igl_validtodate
        and (act.igl_neodate is not null or act.igl_closingdate is not null) -- stores that are (or have been) in operation, not merely real estate buildings
    --- if we get overlapping data about relations of a store with multiple companies, we take the most recent relation. Still, we don't want to exclude company relations altogether which is why we take rh.igl_validfromdate in the partitioning clause. E.g. if a store opens on 2020-01-01 and has a relation to a delivery company X from 2019-01-01 until 2020-01-03 and then to delivery company Y from 2020-01-04 until 2200-01-01 we want to take both companies, not just delivery company Y.
    qualify row_number() over (partition by act.igl_number, rh.igl_companytypecode, rh.igl_validfromdate order by rh.igl_validfromdate desc) = 1
)
, src_with_sid as
(
    select 
        src.igl_companytypecode
        ,store_key.party_sid as store_sid
        ,src.igl_validfromdate as rel_valid_from
        ,src.dwh_valid_from_dt
        ,src.valid_to_tmsp
        ,comp_key.party_sid as company_sid
        from src
        join meta.t_party_key_2 store_key 
            on upper(substr(src.igl_number, 1, 2)) ||'|'||to_number(substr(src.igl_number,3,length(src.igl_number)))  = store_key.party_nat_key_nr
        join meta.t_party_key_2 comp_key 
            on comp_key.PARTY_NAT_KEY_NR = substr(src.igl_associationnumber, 1,2)||'|'||to_number(regexp_replace(src.igl_associationnumber, '[^0-9]', ''))
            and comp_key.PARTY_KEY_TYPE_CD = 'COMPANY'
    WHERE 1=1
        and store_key.PARTY_KEY_TYPE_CD = 'STORE'
    --- if we get overlapping data about relations of a store with multiple companies, we take the most recent relation. This is necessary because there are situations when a store opens on 2020-01-01 and has a relation to a delivery company X from 2019-01-01 until 2200-01-01 and to delivery company Y from 2019-12-01 until 2200-01-01. In such a scenario, we only want to take the latest relation to delivery company Y.
    qualify row_number() over (partition by store_sid, src.igl_companytypecode, src.dwh_valid_from_dt order by rel_valid_from desc) = 1
   
)
, src_track_changes as 
(
    select
         igl_companytypecode
        ,store_sid
        ,dwh_valid_from_dt
        ,least(valid_to_tmsp, nvl(dateadd(ms, -1, lead(dwh_valid_from_dt) over (partition by store_sid, igl_companytypecode order by dwh_valid_from_dt)), '9999-12-31 23:23:59.999999999')) as dwh_valid_to_tmsp
        ,company_sid
        ,sha2(store_sid || '#&#' || company_sid) as row_hash_for_diff
        ,lag(row_hash_for_diff)
            over (
                PARTITION BY store_sid, igl_companytypecode
                ORDER BY igl_companytypecode, dwh_valid_from_dt asc
            )                           as prev_row_hash_for_diff
        
        ,CASE
                WHEN row_hash_for_diff = prev_row_hash_for_diff THEN 0
                ELSE 1
            END                         as HAS_CHANGE_FG
    from src_with_sid s
)
, src_with_groups as
(
    select
        *
        , sum(has_change_fg) over (
                partition by store_sid, igl_companytypecode
                order by igl_companytypecode, dwh_valid_from_dt asc, has_change_fg desc
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) as GROUP_ID
    from src_track_changes
), final_sel as (
select 
    igl_companytypecode    
    , store_sid as INT_ORG_SID
    ,to_timestamp(min(dwh_valid_from_dt)) as dwh_valid_from_tmsp
    ,max(dwh_valid_to_tmsp) as dwh_valid_to_tmsp
    ,company_sid as PARENT_INT_ORG_SID
from src_with_groups
group by
    igl_companytypecode    
    , store_sid
    ,company_sid
    ,group_id
)

-- Store-2-DelivComp
SELECT  
        S.INT_ORG_SID      AS STORE_SID,
        'DELIVCMP_STORE' AS INT_ORG_HIERARCHY_TYPE_CD,
        s.PARENT_INT_ORG_SID    AS PARENT_INT_ORG_SID,
        'LISY'           AS SOURCE_SYSTEM,
        CURRENT_DATE     AS EXTRACTION_DT,
        nvl(s.dwh_valid_from_tmsp, '1900-01-01') AS DWH_MAPPING_TMSP,
        s.dwh_valid_to_tmsp AS DWH_ENDING_TMSP,
        0                AS TF_ERROR_FG,
        0                AS DELETED_FG,
        0                AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'LISY' AS DWH_NODE_CD,
        '${LOAD_ID}' AS DWH_LOAD_ID 
FROM final_sel S
where s.igl_companytypecode = 285540000 --- delivery companies

UNION ALL

SELECT  
        S.INT_ORG_SID      AS STORE_SID,
        'EXPCMP_STORE'   AS INT_ORG_HIERARCHY_TYPE_CD,
        s.PARENT_INT_ORG_SID    AS PARENT_INT_ORG_SID,
        'LISY'           AS SOURCE_SYSTEM,
        CURRENT_DATE     AS EXTRACTION_DT,
        nvl(s.dwh_valid_from_tmsp, '1900-01-01') AS DWH_MAPPING_TMSP,
        s.dwh_valid_to_tmsp AS DWH_ENDING_TMSP,
        0                AS TF_ERROR_FG,
        0                AS DELETED_FG,
        0                AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'LISY' AS DWH_NODE_CD,
        '${LOAD_ID}' AS DWH_LOAD_ID 
FROM final_sel S
where s.igl_companytypecode = 285540003 --- expansion companies

UNION ALL

SELECT  
        S.INT_ORG_SID      AS STORE_SID,
        'OWNERCMP_STORE' AS INT_ORG_HIERARCHY_TYPE_CD,
        s.PARENT_INT_ORG_SID    AS PARENT_INT_ORG_SID,
        'LISY'           AS SOURCE_SYSTEM,
        CURRENT_DATE     AS EXTRACTION_DT,
        nvl(s.dwh_valid_from_tmsp, '1900-01-01') AS DWH_MAPPING_TMSP,
        s.dwh_valid_to_tmsp AS DWH_ENDING_TMSP,
        0                AS TF_ERROR_FG,
        0                AS DELETED_FG,
        0                AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'LISY' AS DWH_NODE_CD,
        '${LOAD_ID}' AS DWH_LOAD_ID 
FROM final_sel S
where s.igl_companytypecode = 285540005 --- owner companies

UNION ALL

SELECT  
        S.INT_ORG_SID      AS STORE_SID,
        'BALSHCMP_STORE' AS INT_ORG_HIERARCHY_TYPE_CD,
        s.PARENT_INT_ORG_SID    AS PARENT_INT_ORG_SID,
        'LISY'           AS SOURCE_SYSTEM,
        CURRENT_DATE     AS EXTRACTION_DT,
        nvl(s.dwh_valid_from_tmsp, '1900-01-01') AS DWH_MAPPING_TMSP,
        s.dwh_valid_to_tmsp AS DWH_ENDING_TMSP,
        0                AS TF_ERROR_FG,
        0                AS DELETED_FG,
        0                AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'LISY' AS DWH_NODE_CD,
        '${LOAD_ID}' AS DWH_LOAD_ID 
FROM final_sel S
where s.igl_companytypecode = 285540006 --- balance sheet companies
;
