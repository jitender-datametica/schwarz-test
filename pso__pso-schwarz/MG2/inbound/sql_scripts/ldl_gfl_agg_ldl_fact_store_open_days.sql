!SET exit_on_error=True;

BEGIN WORK;

DELETE FROM core_dim.T_FACT_STORE_OPEN_DAYS;

INSERT into core_dim.T_FACT_STORE_OPEN_DAYS
(
    BUS_DT
    ,STORE_SID
    ,REAL_ESTATE_SID
    --BUS_YEAR
    ,COUNTRY_ORG_CD
    
    ,STORE_OPEN_FG
    ,STORE_OPEN_DAYS_BYTD_CNT
    ,STORE_OPEN_PY_FG
    ,STORE_OPEN_DAYS_PY_BYTD_CNT
    ,STORE_OPEN_PY_SWDAY_FG
    ,STORE_OPEN_DAYS_PY_SWDAY_BYTD_CNT
    
    ,RELEVANT_FOR_COMP_FG
    ,RELEVANT_FOR_COMP_PY_FG
    ,RELEVANT_FOR_COMP_PY_SWDAY_FG
    
    ,OPEN_TM
    ,CLOSE_TM
    ,BREAK_START_TM
    ,BREAK_END_TM
    
    ,OPEN_HR_CNT
    ,OPEN_HR_BYTD_CNT
    ,OPEN_HR_PY_CNT
    ,OPEN_HR_PY_BYTD_CNT
    ,OPEN_HR_PY_SWDAY_CNT
    ,OPEN_HR_PY_SWDAY_BYTD_CNT
    ,EMP_HR_CNT
    ,EMP_HR_BYTD_CNT
    ,EMP_HR_PY_CNT
    ,EMP_HR_PY_BYTD_CNT
    ,EMP_HR_PY_SWDAY_CNT
    ,EMP_HR_PY_SWDAY_BYTD_CNT
    ,REAL_ESTATE_STATUS_CD
    ,REAL_ESTATE_EVENT_REASON_CD
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
)
with 
store_interval AS 
(
    SELECT
        STORE_SID
        ,max(COUNTRY_ORG_CD) AS COUNTRY_ORG_CD
        ,min(open_dt)        AS STORE_OPEN_DT
        ,max(close_dt)       AS STORE_CLOSE_DT
        ,store_open_dt - DayOfWeekISO(store_open_dt) + 1 + 364 + 7 AS store_open_53w_later_dt  -- Monday of the week + 52 weeks + 1 week
        ,least(store_close_dt - DayOfWeekISO(store_close_dt) + 7,DATE'9999-12-31')           AS store_close_sunday_dt    -- Sunday of the week
    FROM
    (
        SELECT
            int_org_sid as STORE_SID
            ,coalesce(sh.PARENT_COUNTRY_ORG_CD
                    ,dh.PARENT_COUNTRY_ORG_CD
                    ,nkch.PARENT_COUNTRY_ORG_CD )as COUNTRY_ORG_CD
            ,open_dt
            ,nvl(close_dt, DATE'9999-12-31') as close_dt
        FROM core_rel.T_INTERNAL_ORGANIZATION io
            left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY sh
                        on sh.CHILD_ORG_SID = io.INT_ORG_SID
                        and sh.DWH_VALID_FROM_TMSP <= io.DWH_VALID_TO_TMSP
                        and sh.DWH_VALID_TO_TMSP >= io.DWH_VALID_FROM_TMSP
                        and sh.top_hierarchy_type_cd = 'CNTRY_ORG_REGION'
                        and sh.LEVELS_ABOVE_LEAF = 5
            left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY dh
                        on dh.CHILD_ORG_SID = io.INT_ORG_SID
                        and dh.DWH_VALID_FROM_TMSP <= io.DWH_VALID_TO_TMSP
                        and dh.DWH_VALID_TO_TMSP >= io.DWH_VALID_FROM_TMSP
                        and dh.top_hierarchy_type_cd = 'CNTRY_ORG_REGION'
                        and dh.LEVELS_ABOVE_LEAF = 3
            left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY nkch
                        on nkch.CHILD_ORG_SID = io.INT_ORG_SID
                        and nkch.DWH_VALID_FROM_TMSP <= io.DWH_VALID_TO_TMSP
                        and nkch.DWH_VALID_TO_TMSP >= io.DWH_VALID_FROM_TMSP
                        and nkch.top_hierarchy_type_cd = 'CNTRY_ORG_STORE'
                        and nkch.LEVELS_ABOVE_LEAF = 1
        WHERE int_org_nr <> '@'
            AND int_org_type_cd = 'STORE'
        QUALIFY ROW_NUMBER() OVER 
                (PARTITION BY int_org_sid, int_org_nr
                ORDER BY (CASE WHEN dwh_valid_fg THEN 1 ELSE 2 END) asc, io.dwh_valid_from_tmsp DESC) = 1
    )
    GROUP BY STORE_SID
)
,store_days as 
(
    SELECT 
        
        si.store_sid
        ,iore.REAL_ESTATE_SID
        ,cd.CAL_DT         as BUS_DT
        ,cd.BUS_YEAR
        ,cd.DAY_OF_WEEK
        ,si.COUNTRY_ORG_CD
        ,res.REAL_ESTATE_STATUS_CD
		,res.REAL_ESTATE_STATUS_REASON_CD
        ,CASE
                WHEN cd.CAL_DT between STORE_OPEN_DT and STORE_CLOSE_DT THEN 1
                ELSE 0
            END            as STORE_OPEN_FG

        ,sum(STORE_OPEN_FG)
            over(partition by si.STORE_SID, iore.REAL_ESTATE_SID, cd.BUS_YEAR
            order by cd.CAL_DT asc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)    as STORE_OPEN_DAYS_BYTD_CNT
        ,CASE
                WHEN cd.CAL_DT between store_open_53w_later_dt and store_close_sunday_dt then 1
                ELSE 0
            END            as RELEVANT_FOR_COMP_FG

        ,decode(STORE_OPEN_FG, 1, soh.OPEN_TM, null) as STORE_OPEN_TM
        ,decode(STORE_OPEN_FG, 1, soh.CLOSE_TM, null) as STORE_CLOSE_TM
        ,decode(STORE_OPEN_FG, 1, soh.BREAK_START_TM, null) as STORE_BREAK_START_TM
        ,decode(STORE_OPEN_FG, 1, soh.BREAK_END_TM, null) as STORE_BREAK_END_TM
        ,TIMEDIFF('minute', STORE_OPEN_TM, STORE_CLOSE_TM) / 60 as OPEN_HR_CNT
        ,sum(OPEN_HR_CNT)
            over(partition by si.STORE_SID, iore.REAL_ESTATE_SID, cd.BUS_YEAR
            order by cd.CAL_DT asc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)    as OPEN_HR_BYTD_CNT
    FROM store_interval si
        join core_dim.T_DIM_CALENDAR_DATE cd
                    on cd.CAL_DT >= si.store_open_dt
                    --and cd.CAL_DT <= si.store_close_dt
                    and cd.CAL_DT <= CURRENT_DATE
        left join core_rel.T_STORE_OPENING_HOURS soh 
                    on soh.STORE_SID = si.STORE_SID
                    and soh.DAY_OF_WEEK = cd.DAY_OF_WEEK
                    and soh.DWH_VALID_FROM_TMSP <= cd.CAL_DT
                    and soh.DWH_VALID_TO_TMSP >= cd.CAL_DT
        left join core_rel.T_INTERNAL_ORGANIZATION_REAL_ESTATE iore
                    on iore.INT_ORG_SID = si.STORE_SID
                    and iore.DWH_VALID_FROM_TMSP <= cd.CAL_DT
                    and iore.DWH_VALID_TO_TMSP >= cd.CAL_DT
                    and iore.int_org_real_estate_usg_type_cd = 'USED_BY'
        left join core_rel.T_REAL_ESTATE_STATUS res
                    on res.REAL_ESTATE_SID = iore.REAL_ESTATE_SID
                    and res.DWH_VALID_FROM_TMSP <= cd.CAL_DT
                    and res.DWH_VALID_TO_TMSP >= cd.CAL_DT
                    and res.REAL_ESTATE_STATUS_CATEG_CD = 'BS'

)
,py_m as
(
    SELECT
        c.CAL_DT        as BUS_DT
        ,sod.STORE_SID
        ,sod.REAL_ESTATE_SID
        ,max(sod.STORE_OPEN_FG)           as STORE_OPEN_PY_FG
        ,max(sod.RELEVANT_FOR_COMP_FG)    as RELEVANT_FOR_COMP_PY_FG
        ,sum(OPEN_HR_CNT)                 as OPEN_HR_PY_CNT
    FROM store_days sod
        join core_rel.T_CAL_DATE_ADJUSTED_RELATIONSHIP c
                on sod.BUS_DT = c.REL_CAL_DT
                and c.CAL_DT_ADJUST_TYPE_CD = 'M'
                and c.BUS_YEAR_DIFF = 1
    GROUP BY
        c.CAL_DT
        ,sod.STORE_SID
        ,sod.REAL_ESTATE_SID

)
,py_mc as
(
    SELECT
        c.CAL_DT        as BUS_DT
        ,sod.STORE_SID
        ,sod.REAL_ESTATE_SID
        ,sum(max(sod.STORE_OPEN_FG))
            over(partition by sod.STORE_SID, sod.REAL_ESTATE_SID, sod.BUS_YEAR
                order by c.CAL_DT asc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)    as STORE_OPEN_DAYS_PY_BYTD_CNT
        ,sum(sum(sod.OPEN_HR_CNT))
            over(partition by sod.STORE_SID, sod.REAL_ESTATE_SID, sod.BUS_YEAR
                order by c.CAL_DT asc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)    as OPEN_HR_PY_BYTD_CNT
    FROM store_days sod
        join core_rel.T_CAL_DATE_ADJUSTED_RELATIONSHIP c
                on sod.BUS_DT = c.REL_CAL_DT
                and c.CAL_DT_ADJUST_TYPE_CD = 'MC'
                and c.BUS_YEAR_DIFF = 1
    GROUP BY
        c.CAL_DT
        ,sod.STORE_SID
        ,sod.REAL_ESTATE_SID
        ,sod.BUS_YEAR

)
,py_w as
(
    SELECT
        c.CAL_DT                        as BUS_DT
        ,sod.STORE_SID
        ,sod.REAL_ESTATE_SID
        ,max(sod.STORE_OPEN_FG)              as STORE_OPEN_PY_SWDAY_FG
        ,max(sod.RELEVANT_FOR_COMP_FG)       as RELEVANT_FOR_COMP_PY_SWDAY_FG
        ,sum(sod.OPEN_HR_CNT)                as OPEN_HR_PY_SWDAY_CNT
    FROM store_days sod
        join core_rel.T_CAL_DATE_ADJUSTED_RELATIONSHIP c
                on sod.BUS_DT = c.REL_CAL_DT
                and c.CAL_DT_ADJUST_TYPE_CD = 'W'
                and c.BUS_YEAR_DIFF = 1
    GROUP BY
        c.CAL_DT
        ,sod.STORE_SID
        ,sod.REAL_ESTATE_SID

)
,py_wc as
(
    SELECT
        c.CAL_DT        as BUS_DT
        ,sod.STORE_SID
        ,sod.REAL_ESTATE_SID
        ,sum(max(sod.STORE_OPEN_FG))
            over(partition by sod.STORE_SID, sod.REAL_ESTATE_SID, sod.BUS_YEAR
                order by c.CAL_DT asc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)    as STORE_OPEN_DAYS_PY_SWDAY_BYTD_CNT
        ,sum(sum(sod.OPEN_HR_CNT))
            over(partition by sod.STORE_SID, sod.REAL_ESTATE_SID, sod.BUS_YEAR
                order by c.CAL_DT asc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)    as OPEN_HR_PY_SWDAY_BYTD_CNT
    FROM store_days sod
        join core_rel.T_CAL_DATE_ADJUSTED_RELATIONSHIP c
                on sod.BUS_DT = c.REL_CAL_DT
                and c.CAL_DT_ADJUST_TYPE_CD = 'WC'
                and c.BUS_YEAR_DIFF = 1
    GROUP BY
        c.CAL_DT
        ,sod.STORE_SID
        ,sod.REAL_ESTATE_SID
        ,sod.BUS_YEAR
)
select 
    sod.BUS_DT
    ,sod.STORE_SID
    ,nvl(sod.REAL_ESTATE_SID,-1)
    --,sod.BUS_YEAR
    ,nvl(sod.COUNTRY_ORG_CD, '@')
    
    ,sod.STORE_OPEN_FG
    ,sod.STORE_OPEN_DAYS_BYTD_CNT
    ,nvl(py_m.STORE_OPEN_PY_FG, 0)
    ,nvl(py_mc.STORE_OPEN_DAYS_PY_BYTD_CNT, 0)
    ,nvl(py_w.STORE_OPEN_PY_SWDAY_FG, 0)
    ,nvl(py_wc.STORE_OPEN_DAYS_PY_SWDAY_BYTD_CNT, 0)

    ,nvl(sod.RELEVANT_FOR_COMP_FG, 0)
    ,nvl(py_m.RELEVANT_FOR_COMP_PY_FG, 0)
    ,nvl(py_w.RELEVANT_FOR_COMP_PY_SWDAY_FG, 0)

    ,sod.STORE_OPEN_TM
    ,sod.STORE_CLOSE_TM
    ,sod.STORE_BREAK_START_TM
    ,sod.STORE_BREAK_END_TM
    
    ,sod.OPEN_HR_CNT
    ,sod.OPEN_HR_BYTD_CNT
    ,py_m.OPEN_HR_PY_CNT
    ,py_mc.OPEN_HR_PY_BYTD_CNT
    ,py_w.OPEN_HR_PY_SWDAY_CNT
    ,py_wc.OPEN_HR_PY_SWDAY_BYTD_CNT
    
    ,NULL as EMP_HR_CNT
    ,NULL as EMP_HR_BYTD_CNT
    ,NULL as EMP_HR_PY_CNT
    ,NULL as EMP_HR_PY_BYTD_CNT
    ,NULL as EMP_HR_PY_SWDAY_CNT
    ,NULL as EMP_HR_PY_SWDAY_BYTD_CNT
    
    ,nvl(sod.REAL_ESTATE_STATUS_CD, '@') as REAL_ESTATE_STATUS_CD
    ,nvl(sod.REAL_ESTATE_STATUS_REASON_CD, '@') as REAL_ESTATE_EVEN_REASON_CD
             
    ,CURRENT_TIMESTAMP as DWH_CREATED_TMSP
    ,CURRENT_TIMESTAMP as DWH_UPDATED_TMSP
    ,-1                as DWH_LOAD_ID
    ,'CORE_REL'        as DWH_NODE_CD
from store_days sod

    left join py_m
                on py_m.STORE_SID = sod.STORE_SID
                and py_m.REAL_ESTATE_SID = sod.REAL_ESTATE_SID
                and py_m.BUS_DT = sod.BUS_DT
    left join py_mc
                on py_mc.STORE_SID = sod.STORE_SID
                and py_mc.REAL_ESTATE_SID = sod.REAL_ESTATE_SID
                and py_mc.BUS_DT = sod.BUS_DT
    left join py_w
                on py_w.STORE_SID = sod.STORE_SID
                and py_w.REAL_ESTATE_SID = sod.REAL_ESTATE_SID
                and py_w.BUS_DT = sod.BUS_DT
    left join py_wc
                on py_wc.STORE_SID = sod.STORE_SID
                and py_wc.REAL_ESTATE_SID = sod.REAL_ESTATE_SID
                and py_wc.BUS_DT = sod.BUS_DT
;

COMMIT;
