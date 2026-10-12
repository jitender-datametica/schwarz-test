create or replace view LDL_DATA_PRODUCTION.ETL.V_TURNOVER_BY_STORE_DAY_RAW_DELTA(
	INT_ORG_SID,
	BUS_DT,
	BUS_YEAR,
	INT_ORG_TYPE_CD,
	COUNTRY_ORG_CD,
	CURR_CD,
	BOOKED_TURNOVER_NET_VAL,
	BOOKED_RECEIPT_CNT,
	EOD_TURNOVER_NET_VAL,
	EOD_RECEIPT_CNT,
	EOD_TURNOVER_GROSS_VAL,
	CASH_REGISTER_TURNOVER_GROSS_VAL,
	CASH_REGISTER_TURNOVER_NET_VAL,
	CASH_REGISTER_RECEIPT_CNT,
	TURNOVER_NET_VAL,
	TURNOVER_GROSS_VAL,
	RECEIPT_CNT
) as
with
delta_keys(INT_ORG_SID, BUS_DT) as
(
    SELECT
        DISTINCT
        loc_sid
        ,dwh_cal_dt
    FROM etl.VT1
)
,src_rev_accr as
(
    SELECT 
        src.bus_dt
        ,src.int_org_sid
        ,src.int_org_type_cd
        ,src.country_org_cd
        ,src.curr_cd
        ,sum(turnover_net_val)     as booked_turnover_net_val
        ,sum(receipt_cnt)          as booked_receipt_cnt
    FROM core_rel.T_REVENUE_ACCRUAL src
        join delta_keys dk
                on dk.INT_ORG_SID = src.INT_ORG_SID
                and dk.BUS_DT = src.BUS_DT
    WHERE src.curr_accrual_fg = True
        AND (src.int_org_type_cd = 'STORE'
            or (src.int_org_type_cd = 'COMPANY' and src.int_org_sid = src.country_org_sid)
        )
    GROUP BY 
        src.bus_dt
        ,src.int_org_sid
        ,src.int_org_type_cd
        ,src.country_org_cd
        ,src.curr_cd
        
)
,src_rev_stat as
(
    SELECT 
        src.bus_dt
        ,src.store_sid                 as int_org_sid
        ,'STORE'                   as int_org_type_cd
        ,src.country_org_cd
        ,src.curr_cd
        ,sum(turnover_gross_val)   as eod_turnover_gross_val
        ,sum(turnover_net_val)     as eod_turnover_net_val
        ,sum(receipt_cnt)          as eod_receipt_cnt
    FROM core_rel.T_REVENUE_STATISTICS src
        join delta_keys dk
                on dk.INT_ORG_SID = src.STORE_SID
                and dk.BUS_DT = src.BUS_DT
    WHERE src.stat_src_cd = 'WAWI'
    GROUP BY 
        src.bus_dt
        ,src.store_sid
        ,src.country_org_cd
        ,src.curr_cd
)
,tmp_rev_acc_rev_stat as
(
    SELECT 
        nvl(sra.bus_dt, srs.bus_dt)                       as bus_dt
        ,nvl(sra.int_org_sid, srs.int_org_sid)            as int_org_sid
        ,nvl(sra.int_org_type_cd, srs.int_org_type_cd)    as int_org_type_cd
        ,nvl(sra.country_org_cd, srs.country_org_cd)      as country_org_cd
        ,nvl(sra.curr_cd, srs.curr_cd)                    as curr_cd
        
        ,sra.booked_turnover_net_val
        ,sra.booked_receipt_cnt
        ,srs.eod_turnover_net_val
        ,srs.eod_receipt_cnt
        ,srs.eod_turnover_gross_val
    FROM src_rev_accr sra
        full outer join src_rev_stat srs
                    on sra.bus_dt = srs.bus_dt
                    and sra.int_org_sid = srs.int_org_sid
                    
)
,src_prod_rtl_line as
(
    SELECT
        src.bus_dt
        ,src.store_sid  as int_org_sid
        ,src.country_org_cd
        ,src.curr_cd
        ,sum(retail_line_gross_val)         as cash_register_turnover_gross_val
        ,sum(retail_line_net_val)           as cash_register_turnover_net_val
    FROM core_rel.T_PRODUCT_RETAIL_LINE src
        join delta_keys dk
                on dk.INT_ORG_SID = src.STORE_SID
                and dk.BUS_DT = src.BUS_DT
    WHERE src.turnover_relevant_fg = True
    GROUP BY 
        src.bus_dt
        ,src.store_sid
        ,src.country_org_cd
        ,src.curr_cd
)
,src_rtl_event as
(
    SELECT 
        src.bus_dt
        ,src.store_sid     as int_org_sid
        ,src.country_org_cd
        ,src.curr_cd
        ,count(*)      as cash_register_receipt_cnt
    FROM core_rel.T_RETAIL_EVENT src
        join delta_keys dk
                on dk.INT_ORG_SID = src.STORE_SID
                and dk.BUS_DT = src.BUS_DT
    WHERE  1=1
        AND src.turnover_relevant_fg = True
        AND src.retail_event_type_cd = 'S'
    GROUP BY 
        src.bus_dt
        ,src.store_sid
        ,src.country_org_cd
        ,src.curr_cd
)
,tmp_rtl_line_rtl_event as
(
    SELECT
        nvl(prl.bus_dt, re.bus_dt)                       as bus_dt
        ,nvl(prl.int_org_sid, re.int_org_sid)            as int_org_sid
        ,'STORE'                                         as int_org_type_cd
        ,nvl(prl.country_org_cd, re.country_org_cd)      as country_org_cd
        ,nvl(prl.curr_cd, re.curr_cd)                    as curr_cd
        
        ,prl.cash_register_turnover_gross_val
        ,prl.cash_register_turnover_net_val
        ,re.cash_register_receipt_cnt
    FROM src_prod_rtl_line prl
        full outer join src_rtl_event re
                on re.bus_dt = prl.bus_dt
                and re.int_org_sid = prl.int_org_sid
)
,all_facts as
(
    SELECT
        nvl(rev.bus_dt, rtl.bus_dt)                         as bus_dt
        ,nvl(rev.int_org_sid, rtl.int_org_sid)              as int_org_sid
        ,nvl(rev.int_org_type_cd, rtl.int_org_type_cd)      as int_org_type_cd
        ,nvl(rev.country_org_cd, rtl.country_org_cd)        as country_org_cd
        ,nvl(rev.curr_cd, rtl.curr_cd)                      as curr_cd
        
        ,rev.booked_turnover_net_val
        ,rev.booked_receipt_cnt
        ,rev.eod_turnover_net_val
        ,rev.eod_receipt_cnt
        ,rev.eod_turnover_gross_val
        ,rtl.cash_register_turnover_gross_val
        ,rtl.cash_register_turnover_net_val
        ,rtl.cash_register_receipt_cnt
        
        ,coalesce(
            rev.booked_turnover_net_val
            ,rev.eod_turnover_net_val
            ,rtl.cash_register_turnover_net_val
            )                                               as turnover_net_val 
        ,coalesce(
            rev.eod_turnover_gross_val
            ,rtl.cash_register_turnover_gross_val
            )                                               as turnover_gross_val
        ,coalesce(
            rev.booked_receipt_cnt
            ,rev.eod_receipt_cnt
            ,rtl.cash_register_receipt_cnt
            )                                               as receipt_cnt

    FROM tmp_rev_acc_rev_stat rev
        full outer join tmp_rtl_line_rtl_event rtl
                on rev.bus_dt = rtl.bus_dt
                and rev.int_org_sid = rtl.int_org_sid 
)
-- if we have changes for 05.04.2022 we will also generate rows for the rest of F2022
-- so for each changed date we get in which financial/business year it is
,int_org_bus_year as
(
    SELECT 
        af.int_org_sid
        ,c.bus_year
        ,af.int_org_type_cd
        ,af.country_org_cd
        ,af.curr_cd
        ,min(min(af.bus_dt)) over (partition by af.int_org_sid) as  absolut_int_org_min_dt
    FROM all_facts af
        join core_dim.T_DIM_CALENDAR_DATE c on c.CAL_DT = af.BUS_DT
    GROUP BY   
        af.int_org_sid
        ,c.bus_year
        ,af.int_org_type_cd
        ,af.country_org_cd
        ,af.curr_cd

    UNION 
    -- if we have data for an Organization for 2022 then we should make sure we generate dates from same organization for 2023
    -- this way we are sure we will allocate the records from 2022 as ""PY"" in 2023
    SELECT 
        af.int_org_sid
        ,c.bus_year + 1
        ,af.int_org_type_cd
        ,af.country_org_cd
        ,af.curr_cd
        ,min(min(af.bus_dt)) over (partition by af.int_org_sid) as  absolut_int_org_min_dt
    FROM all_facts af
        join core_dim.T_DIM_CALENDAR_DATE c on c.CAL_DT = af.BUS_DT
    GROUP BY   
        af.int_org_sid
        ,c.bus_year
        ,af.int_org_type_cd
        ,af.country_org_cd
        ,af.curr_cd
)
SELECT 
    ioby.INT_ORG_SID
    ,c.CAL_DT            as BUS_DT
    ,c.BUS_YEAR
    ,ioby.INT_ORG_TYPE_CD
    ,ioby.COUNTRY_ORG_CD
    ,ioby.CURR_CD
    
    ,af.BOOKED_TURNOVER_NET_VAL
    ,af.BOOKED_RECEIPT_CNT
    ,af.EOD_TURNOVER_NET_VAL
    ,af.EOD_RECEIPT_CNT
    ,af.EOD_TURNOVER_GROSS_VAL
    ,af.CASH_REGISTER_TURNOVER_GROSS_VAL
    ,af.CASH_REGISTER_TURNOVER_NET_VAL
    ,af.CASH_REGISTER_RECEIPT_CNT
    
    ,af.TURNOVER_NET_VAL
    ,af.TURNOVER_GROSS_VAL
    ,af.RECEIPT_CNT
FROM int_org_bus_year ioby
    join core_dim.T_DIM_CALENDAR_DATE c 
                on c.BUS_YEAR = ioby.BUS_YEAR
                and c.CAL_DT >= ioby.absolut_int_org_min_dt
                and c.CAL_DT < CURRENT_DATE
    left join all_facts af 
                on af.INT_ORG_SID = ioby.INT_ORG_SID
                and af.BUS_DT = c.CAL_DT
;