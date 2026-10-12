BEGIN TRANSACTION;

-- Note: any record for the previous country organiation that started after the new organization become active should have its flag set to FALSE.
-- records for previous Country Orgs that started before but end after the new organization becomes active should have their end-date adjusted and the gap should be filled with a record for the previous organization with flag FALSE (the insert in ""M5"")

MERGE into core_rel.T_INTERNAL_ORGANIZATION trg
USING
(
    with 
    -- all country organization for given country from the prev loads for this country (excl the last load)
    prev as
    (
        select *
        from core_rel.t_internal_organization
        where is_country_org_fg = TRUE
            and int_org_type_cd = 'COMPANY'
        QUALIFY 1=1
            -- if we have more than one SID as country org for a country
            and count(distinct int_org_sid) over (partition by country_org_cd) > 1
            and rank() over (partition by country_org_cd order by dwh_load_id desc) > 1
            
    )
    -- all country organization for given country from the last load for this country
    , curr as
    (
        select *
        from core_rel.t_internal_organization
        where is_country_org_fg = TRUE
            and int_org_type_cd = 'COMPANY'
        QUALIFY 1=1
            -- if we have more than one SID as country org for a country
            and count(distinct int_org_sid) over (partition by country_org_cd) > 1
            and rank() over (partition by country_org_cd order by dwh_load_id desc) = 1
    )
    select 
        prev.int_org_sid
        ,prev.dwh_valid_from_tmsp prev_valid_from
        ,prev.dwh_valid_to_tmsp prev_valid_to
        ,case
            when prev.dwh_valid_from_tmsp >= min(curr.dwh_valid_from_tmsp) then 'UPD FLAG'
            else 'UPD TMSP'
        end as action_type
        ,min(curr.dwh_valid_from_tmsp) curr_valid_from
        ,dateadd('ns', -1, curr_valid_from) new_valid_to
        ,prev.country_org_cd
    from prev
        join curr on prev.country_org_cd = curr.country_org_cd
                and prev.dwh_valid_to_tmsp > curr.dwh_valid_from_tmsp
    group by 
        prev.int_org_sid
        ,prev.dwh_valid_from_tmsp
        ,prev.dwh_valid_to_tmsp
        ,prev.country_org_cd
) src
on trg.int_org_sid = src.int_org_sid
    and trg.dwh_valid_from_tmsp = src.prev_valid_from
WHEN MATCHED THEN UPDATE
    set trg.is_country_org_fg = decode(src.ACTION_TYPE, 'UPD FLAG', false, true)
        ,trg.dwh_valid_to_tmsp = decode(src.ACTION_TYPE, 'UPD TMSP', new_valid_to, prev_valid_to)
        ,trg.DWH_UPDATED_TMSP = current_timestamp
        ,trg.DWH_LOAD_ID = '${LOAD_ID}'
;

INSERT into core_rel.T_INTERNAL_ORGANIZATION
(
    INT_ORG_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,DWH_VALID_FG
    ,INT_ORG_TYPE_CD
    ,INT_ORG_NR
    ,INT_ORG_NAME
    ,OPEN_DT
    ,PLANNED_OPEN_DT
    ,CLOSE_DT
    ,CURR_CD
    ,HOLIDAY_STORE_FG
    ,LEGAL_NAME
    ,VAT_NR
    ,COUNTRY_ORG_CD
    ,COMMENT_TXT
    ,IS_SALES_COMPANY_FG
    ,IS_DELIV_COMPANY_FG
    ,IS_COUNTRY_ORG_FG
    ,IS_EXPANSION_COMPANY_FG
    ,IS_BAL_SHEET_COMPANY_FG
    ,IS_OWNER_COMPANY_FG
    ,IS_TRUST_FG
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
)
with
other_gaps as
(
    SELECT
        io.*
        ,CASE
            WHEN DWH_VALID_TO_TMSP < TIMESTAMP '9999-12-31 23:59:59.999' then dateadd(ns, 1, DWH_VALID_TO_TMSP)
            ELSE DWH_VALID_TO_TMSP
        END as ADJ_VALID_TO_TMSP
        ,lead(DWH_VALID_FROM_TMSP, 1, TIMESTAMP '9999-12-31 23:59:59.999')
                    over (partition by INT_ORG_SID order by DWH_VALID_FROM_TMSP) as NEXT_VALID_FROM_TSMP 
    FROM core_rel.T_INTERNAL_ORGANIZATION io
    where io.INT_ORG_TYPE_CD = 'COMPANY'
    -- To have a gap, the current row must end more than 1ns before next row begins
    QUALIFY ADJ_VALID_TO_TMSP < NEXT_VALID_FROM_TSMP
        and io.IS_COUNTRY_ORG_FG = TRUE
)
SELECT 
    INT_ORG_SID
    ,ADJ_VALID_TO_TMSP      as DWH_VALID_FROM_TMSP
    ,CASE
        WHEN NEXT_VALID_FROM_TSMP < TIMESTAMP '9999-12-31 23:59:59.999' THEN dateadd(ns, -1, NEXT_VALID_FROM_TSMP)
        ELSE NEXT_VALID_FROM_TSMP
    END                     as CALC_DWH_VALID_TO_TMSP
    ,(current_timestamp between ADJ_VALID_TO_TMSP and CALC_DWH_VALID_TO_TMSP) as DWH_VALID_FG
    ,INT_ORG_TYPE_CD
    ,INT_ORG_NR
    ,io.INT_ORG_NAME
    ,io.OPEN_DT
    ,io.PLANNED_OPEN_DT
    ,io.CLOSE_DT
    ,io.CURR_CD
    ,io.HOLIDAY_STORE_FG
    ,io.LEGAL_NAME
    ,io.VAT_NR
    ,io.COUNTRY_ORG_CD
    ,io.COMMENT_TXT
    ,io.IS_SALES_COMPANY_FG
    ,io.IS_DELIV_COMPANY_FG
    ,FALSE  as IS_COUNTRY_ORG_FG
    ,io.IS_EXPANSION_COMPANY_FG
    ,io.IS_BAL_SHEET_COMPANY_FG
    ,io.IS_OWNER_COMPANY_FG
    ,io.IS_TRUST_FG
    ,current_timestamp
    ,current_timestamp
    ,io.dwh_load_id
    ,'LISY'
    
FROM other_gaps io
;

COMMIT;




