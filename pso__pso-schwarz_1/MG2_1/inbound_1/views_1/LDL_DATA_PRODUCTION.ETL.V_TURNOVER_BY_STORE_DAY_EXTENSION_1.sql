create or replace view LDL_DATA_PRODUCTION.ETL.V_TURNOVER_BY_STORE_DAY_EXTENSION_1(
	INT_ORG_SID,
	BUS_DT,
	BUS_YEAR,
	INT_ORG_TYPE_CD,
	COUNTRY_ORG_CD,
	CURR_CD,
	TURNOVER_NET_VAL,
	TURNOVER_GROSS_VAL,
	RECEIPT_CNT,
	TURNOVER_BYTD_NET_VAL,
	TURNOVER_BYTD_GROSS_VAL,
	RECEIPT_BYTD_CNT,
	BOOKED_TURNOVER_NET_VAL,
	BOOKED_RECEIPT_CNT,
	EOD_TURNOVER_NET_VAL,
	EOD_RECEIPT_CNT,
	EOD_TURNOVER_GROSS_VAL,
	CASH_REGISTER_TURNOVER_GROSS_VAL,
	CASH_REGISTER_TURNOVER_NET_VAL,
	CASH_REGISTER_RECEIPT_CNT,
	TURNOVER_PY_NET_VAL,
	TURNOVER_PY_GROSS_VAL,
	RECEIPT_PY_CNT,
	TURNOVER_PY_BYTD_NET_VAL,
	TURNOVER_PY_BYTD_GROSS_VAL,
	RECEIPT_PY_BYTD_CNT,
	TURNOVER_PY_SWDAY_NET_VAL,
	TURNOVER_PY_SWDAY_GROSS_VAL,
	RECEIPT_PY_SWDAY_CNT,
	TURNOVER_PY_SWDAY_BYTD_NET_VAL,
	TURNOVER_PY_SWDAY_BYTD_GROSS_VAL,
	RECEIPT_PY_SWDAY_BYTD_CNT
) as 
with
last_x_days as
(
    SELECT 
        days.BUS_DT
        ,c.BUS_YEAR
    FROM
    (
        SELECT 
            ROW_NUMBER() OVER (order by 1) rn
            ,CURRENT_DATE - rn as bus_dt
        FROM table(generator(rowcount => getvariable('DELTA_DAYS_CNT')::NUMBER))
    ) days
        join core_dim.T_DIM_CALENDAR_DATE_1 c on c.CAL_DT = days.BUS_DT
)
,last_target_day as
(
    SELECT
        trg.INT_ORG_SID
        ,trg.BUS_DT
        ,trg.INT_ORG_TYPE_CD
        ,trg.COUNTRY_ORG_CD
        ,trg.CURR_CD
        
        ,trg.TURNOVER_BYTD_NET_VAL
        ,trg.TURNOVER_BYTD_GROSS_VAL
        ,trg.RECEIPT_BYTD_CNT
        
    FROM core_dim.T_FACT_TURNOVER_BY_STORE_DAY trg
    WHERE BUS_DT >= CURRENT_DATE - (getvariable('DELTA_DAYS_CNT')::NUMBER+1)
    QUALIFY ROW_NUMBER() OVER (partition by INT_ORG_SID order by BUS_DT desc) = 1
    
)
-- if for some dates until today we didn't have rows in the target table
-- we will generate them with NULL for daily values and the values of the last existing rows for BYTD cols
,extended_target_rows as
(
    SELECT
        trg.INT_ORG_SID
        ,d.BUS_DT
        ,d.BUS_YEAR
        ,trg.INT_ORG_TYPE_CD
        ,trg.COUNTRY_ORG_CD
        ,trg.CURR_CD
        
        ,trg.TURNOVER_BYTD_NET_VAL
        ,trg.TURNOVER_BYTD_GROSS_VAL
        ,trg.RECEIPT_BYTD_CNT

    FROM 
        last_target_day trg
        ,last_x_days d
    WHERE 
        d.BUS_DT > trg.BUS_DT
)
-- then we need to take last-years values and put them as PY_ values in this row
,extended_py_cols as
(
    SELECT 
        f.INT_ORG_SID
        ,f.BUS_DT
        
        ,sum(f_m.TURNOVER_NET_VAL)          as TURNOVER_PY_NET_VAL
        ,sum(f_m.TURNOVER_GROSS_VAL)        as TURNOVER_PY_GROSS_VAL
        ,sum(f_m.RECEIPT_CNT)               as RECEIPT_PY_CNT
        
    FROM extended_target_rows f
        join core_rel.T_CAL_DATE_ADJUSTED_RELATIONSHIP_1 py_m
                    on py_m.CAL_DT = f.BUS_DT
                    and py_m.BUS_YEAR_DIFF = 1
                    and py_m.CAL_DT_ADJUST_TYPE_CD = 'M'
        join core_dim.T_FACT_TURNOVER_BY_STORE_DAY f_m
                    on f_m.INT_ORG_SID = f.INT_ORG_SID
                    and f_m.BUS_DT = py_m.REL_CAL_DT
    GROUP BY
        f.INT_ORG_SID
        ,f.BUS_DT  
)
,extended_py_bytd_cols as
(
    SELECT 
        f.INT_ORG_SID
        ,f.BUS_DT
        ,f.BUS_YEAR
        
        -- ,sum(f_mc.TURNOVER_BYTD_NET_VAL)         as TURNOVER_PY_BYTD_NET_VAL
        -- ,sum(f_mc.TURNOVER_BYTD_GROSS_VAL)       as TURNOVER_PY_BYTD_GROSS_VAL
        -- ,sum(f_mc.RECEIPT_BYTD_CNT)              as RECEIPT_PY_BYTD_CNT
        
        ,sum(sum(f_mc.TURNOVER_NET_VAL))  
            OVER (partition by f.INT_ORG_SID, f.BUS_YEAR
                ORDER BY f.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as TURNOVER_PY_BYTD_NET_VAL
        ,sum(sum(f_mc.TURNOVER_GROSS_VAL))  
            OVER (partition by f.INT_ORG_SID, f.BUS_YEAR
                ORDER BY f.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as TURNOVER_PY_BYTD_GROSS_VAL
        ,sum(sum(f_mc.RECEIPT_CNT))  
            OVER (partition by f.INT_ORG_SID, f.BUS_YEAR
                ORDER BY f.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as RECEIPT_PY_BYTD_CNT
        
    FROM core_dim.T_FACT_TURNOVER_BY_STORE_DAY f_mc
        join core_rel.T_CAL_DATE_ADJUSTED_RELATIONSHIP_1 py_mc
                    on f_mc.BUS_DT = py_mc.REL_CAL_DT
                    and py_mc.BUS_YEAR_DIFF = 1
                    and py_mc.CAL_DT_ADJUST_TYPE_CD = 'MC'
        join core_dim.T_DIM_CALENDAR_DATE_1 c
                    on c.CAL_DT = py_mc.CAL_DT
        join extended_target_rows f 
                    on f.INT_ORG_SID = f_mc.INT_ORG_SID
                    and f.BUS_YEAR = c.BUS_YEAR
                    and c.CAL_DT <= f.BUS_DT
    GROUP BY
        f.INT_ORG_SID
        ,f.BUS_DT
        ,f.BUS_YEAR
)
,extended_py_swday_cols as
(
    SELECT 
        f.INT_ORG_SID
        ,f.BUS_DT
        
        ,sum(f_w.TURNOVER_NET_VAL)          as TURNOVER_PY_SWDAY_NET_VAL
        ,sum(f_w.TURNOVER_GROSS_VAL)        as TURNOVER_PY_SWDAY_GROSS_VAL
        ,sum(f_w.RECEIPT_CNT)               as RECEIPT_PY_SWDAY_CNT
        
    FROM extended_target_rows f
        join core_rel.T_CAL_DATE_ADJUSTED_RELATIONSHIP_1 py_w
                    on py_w.CAL_DT = f.BUS_DT
                    and py_w.BUS_YEAR_DIFF = 1
                    and py_w.CAL_DT_ADJUST_TYPE_CD = 'W'
        join core_dim.T_FACT_TURNOVER_BY_STORE_DAY f_w
                    on f_w.INT_ORG_SID = f.INT_ORG_SID
                    and f_w.BUS_DT = py_w.REL_CAL_DT
    GROUP BY
        f.INT_ORG_SID
        ,f.BUS_DT  
)
,extended_py_swday_bytd_cols as
(
    SELECT 
        f.INT_ORG_SID
        ,f.BUS_DT
        ,f.BUS_YEAR
        
        ,sum(sum(f_wc.TURNOVER_NET_VAL))  
            OVER (partition by f.INT_ORG_SID, f.BUS_YEAR
                ORDER BY f.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as TURNOVER_PY_SWDAY_BYTD_NET_VAL
        ,sum(sum(f_wc.TURNOVER_GROSS_VAL))
            OVER (partition by f.INT_ORG_SID, f.BUS_YEAR
                ORDER BY f.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as TURNOVER_PY_SWDAY_BYTD_GROSS_VAL
        ,sum(sum(f_wc.RECEIPT_CNT))  
            OVER (partition by f.INT_ORG_SID, f.BUS_YEAR
                ORDER BY f.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as RECEIPT_PY_SWDAY_BYTD_CNT
        
    FROM core_dim.T_FACT_TURNOVER_BY_STORE_DAY f_wc
        join core_rel.T_CAL_DATE_ADJUSTED_RELATIONSHIP_1 py_wc
                    on f_wc.BUS_DT = py_wc.REL_CAL_DT
                    and py_wc.BUS_YEAR_DIFF = 1
                    and py_wc.CAL_DT_ADJUST_TYPE_CD = 'WC'
        join core_dim.T_DIM_CALENDAR_DATE_1 c
                    on c.CAL_DT = py_wc.CAL_DT
        join extended_target_rows f 
                    on f.INT_ORG_SID = f_wc.INT_ORG_SID
                    and f.BUS_YEAR = c.BUS_YEAR
                    and c.CAL_DT <= f.BUS_DT
    GROUP BY
        f.INT_ORG_SID
        ,f.BUS_DT
        ,f.BUS_YEAR
)
SELECT 
    etr.INT_ORG_SID
    ,etr.BUS_DT
    ,etr.BUS_YEAR
    ,etr.INT_ORG_TYPE_CD
    ,etr.COUNTRY_ORG_CD
    ,etr.CURR_CD

    ,NULL       as TURNOVER_NET_VAL
    ,NULL       as TURNOVER_GROSS_VAL
    ,NULL       as RECEIPT_CNT
    ,etr.TURNOVER_BYTD_NET_VAL
    ,etr.TURNOVER_BYTD_GROSS_VAL
    ,etr.RECEIPT_BYTD_CNT
    
    ,NULL       as BOOKED_TURNOVER_NET_VAL 
    ,NULL       as BOOKED_RECEIPT_CNT
    ,NULL       as EOD_TURNOVER_NET_VAL
    ,NULL       as EOD_RECEIPT_CNT
    ,NULL       as EOD_TURNOVER_GROSS_VAL
    ,NULL       as CASH_REGISTER_TURNOVER_GROSS_VAL
    ,NULL       as CASH_REGISTER_TURNOVER_NET_VAL
    ,NULL       as CASH_REGISTER_RECEIPT_CNT
    
    ,m.TURNOVER_PY_NET_VAL
    ,m.TURNOVER_PY_GROSS_VAL
    ,m.RECEIPT_PY_CNT
    
    ,mc.TURNOVER_PY_BYTD_NET_VAL
    ,mc.TURNOVER_PY_BYTD_GROSS_VAL
    ,mc.RECEIPT_PY_BYTD_CNT
    
    ,w.TURNOVER_PY_SWDAY_NET_VAL
    ,w.TURNOVER_PY_SWDAY_GROSS_VAL
    ,w.RECEIPT_PY_SWDAY_CNT
    
    ,wc.TURNOVER_PY_SWDAY_BYTD_NET_VAL
    ,wc.TURNOVER_PY_SWDAY_BYTD_GROSS_VAL
    ,wc.RECEIPT_PY_SWDAY_BYTD_CNT
    
FROM extended_target_rows etr
    left join extended_py_cols m
                on m.BUS_DT = etr.BUS_DT 
                and m.INT_ORG_SID = etr.INT_ORG_SID
    left join extended_py_bytd_cols mc
                on mc.BUS_DT = etr.BUS_DT 
                and mc.INT_ORG_SID = etr.INT_ORG_SID
    left join extended_py_swday_cols w
                on w.BUS_DT = etr.BUS_DT 
                and w.INT_ORG_SID = etr.INT_ORG_SID
    left join extended_py_swday_bytd_cols wc
                on wc.BUS_DT = etr.BUS_DT 
                and wc.INT_ORG_SID = etr.INT_ORG_SID
;