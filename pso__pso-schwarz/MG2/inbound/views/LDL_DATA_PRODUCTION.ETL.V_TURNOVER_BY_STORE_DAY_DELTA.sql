create or replace view LDL_DATA_PRODUCTION.ETL.V_TURNOVER_BY_STORE_DAY_DELTA(
	INT_ORG_SID,
	BUS_DT,
	BUS_YEAR,
	INT_ORG_TYPE_CD,
	COUNTRY_ORG_CD,
	CURR_CD,
	NEW_BOOKED_TURNOVER_NET_VAL,
	NEW_BOOKED_RECEIPT_CNT,
	NEW_EOD_TURNOVER_NET_VAL,
	NEW_EOD_RECEIPT_CNT,
	NEW_EOD_TURNOVER_GROSS_VAL,
	NEW_CASH_REGISTER_TURNOVER_GROSS_VAL,
	NEW_CASH_REGISTER_TURNOVER_NET_VAL,
	NEW_CASH_REGISTER_RECEIPT_CNT,
	NEW_TURNOVER_NET_VAL,
	NEW_TURNOVER_GROSS_VAL,
	NEW_RECEIPT_CNT,
	NEW_TURNOVER_BYTD_NET_VAL,
	NEW_TURNOVER_BYTD_GROSS_VAL,
	NEW_RECEIPT_BYTD_CNT,
	NEW_TURNOVER_PY_NET_VAL,
	NEW_TURNOVER_PY_GROSS_VAL,
	NEW_RECEIPT_PY_CNT,
	NEW_TURNOVER_PY_BYTD_NET_VAL,
	NEW_TURNOVER_PY_BYTD_GROSS_VAL,
	NEW_RECEIPT_PY_BYTD_CNT,
	NEW_TURNOVER_PY_SWDAY_NET_VAL,
	NEW_TURNOVER_PY_SWDAY_GROSS_VAL,
	NEW_RECEIPT_PY_SWDAY_CNT,
	NEW_TURNOVER_PY_SWDAY_BYTD_NET_VAL,
	NEW_TURNOVER_PY_SWDAY_BYTD_GROSS_VAL,
	NEW_RECEIPT_PY_SWDAY_BYTD_CNT
) as
with
src_delta as 
(
    SELECT *
    FROM etl.V_TURNOVER_BY_STORE_DAY_RAW_DELTA
    WHERE 1=1
)
,extended_target as
(
    SELECT
        INT_ORG_SID
        ,BUS_DT
        ,INT_ORG_TYPE_CD
        ,COUNTRY_ORG_CD
        ,CURR_CD
        
        ,TURNOVER_NET_VAL
        ,TURNOVER_GROSS_VAL
        ,RECEIPT_CNT
        ,TURNOVER_BYTD_NET_VAL
        ,TURNOVER_BYTD_GROSS_VAL
        ,RECEIPT_BYTD_CNT
        
        ,TURNOVER_PY_NET_VAL
        ,TURNOVER_PY_GROSS_VAL
        ,RECEIPT_PY_CNT
        ,TURNOVER_PY_BYTD_NET_VAL
        ,TURNOVER_PY_BYTD_GROSS_VAL
        ,RECEIPT_PY_BYTD_CNT
        
        ,TURNOVER_PY_SWDAY_NET_VAL
        ,TURNOVER_PY_SWDAY_GROSS_VAL
        ,RECEIPT_PY_SWDAY_CNT
        ,TURNOVER_PY_SWDAY_BYTD_NET_VAL
        ,TURNOVER_PY_SWDAY_BYTD_GROSS_VAL
        ,RECEIPT_PY_SWDAY_BYTD_CNT
        
        ,BOOKED_TURNOVER_NET_VAL 
        ,BOOKED_RECEIPT_CNT
        ,EOD_TURNOVER_NET_VAL
        ,EOD_RECEIPT_CNT
        ,EOD_TURNOVER_GROSS_VAL
        ,CASH_REGISTER_TURNOVER_GROSS_VAL
        ,CASH_REGISTER_TURNOVER_NET_VAL
        ,CASH_REGISTER_RECEIPT_CNT
    FROM core_dim.T_FACT_TURNOVER_BY_STORE_DAY trg
    
    UNION ALL
    
    SELECT 
        INT_ORG_SID
        ,BUS_DT
        ,INT_ORG_TYPE_CD
        ,COUNTRY_ORG_CD
        ,CURR_CD
        
        ,TURNOVER_NET_VAL
        ,TURNOVER_GROSS_VAL
        ,RECEIPT_CNT
        ,TURNOVER_BYTD_NET_VAL
        ,TURNOVER_BYTD_GROSS_VAL
        ,RECEIPT_BYTD_CNT
        
        ,TURNOVER_PY_NET_VAL
        ,TURNOVER_PY_GROSS_VAL
        ,RECEIPT_PY_CNT
        ,TURNOVER_PY_BYTD_NET_VAL
        ,TURNOVER_PY_BYTD_GROSS_VAL
        ,RECEIPT_PY_BYTD_CNT
        
        ,TURNOVER_PY_SWDAY_NET_VAL
        ,TURNOVER_PY_SWDAY_GROSS_VAL
        ,RECEIPT_PY_SWDAY_CNT
        ,TURNOVER_PY_SWDAY_BYTD_NET_VAL
        ,TURNOVER_PY_SWDAY_BYTD_GROSS_VAL
        ,RECEIPT_PY_SWDAY_BYTD_CNT
        
        ,BOOKED_TURNOVER_NET_VAL 
        ,BOOKED_RECEIPT_CNT
        ,EOD_TURNOVER_NET_VAL
        ,EOD_RECEIPT_CNT
        ,EOD_TURNOVER_GROSS_VAL
        ,CASH_REGISTER_TURNOVER_GROSS_VAL
        ,CASH_REGISTER_TURNOVER_NET_VAL
        ,CASH_REGISTER_RECEIPT_CNT
    FROM etl.V_TURNOVER_BY_STORE_DAY_EXTENSION
)
,rev_facts as
(
    SELECT 
        src.INT_ORG_SID
        ,src.BUS_DT
        ,src.BUS_YEAR
        ,src.INT_ORG_TYPE_CD
        ,src.COUNTRY_ORG_CD
        ,src.CURR_CD
        
        -- for Columns with daily values we just need the new value
        ,nvl(src.BOOKED_TURNOVER_NET_VAL, trg.BOOKED_TURNOVER_NET_VAL)                      as NEW_BOOKED_TURNOVER_NET_VAL
        ,nvl(src.BOOKED_RECEIPT_CNT, trg.BOOKED_RECEIPT_CNT)                                as NEW_BOOKED_RECEIPT_CNT
        ,nvl(src.EOD_TURNOVER_NET_VAL,trg.EOD_TURNOVER_NET_VAL)                             as NEW_EOD_TURNOVER_NET_VAL
        ,nvl(src.EOD_RECEIPT_CNT, trg.EOD_RECEIPT_CNT)                                      as NEW_EOD_RECEIPT_CNT
        ,nvl(src.EOD_TURNOVER_GROSS_VAL, trg.EOD_TURNOVER_GROSS_VAL)                        as NEW_EOD_TURNOVER_GROSS_VAL
        ,nvl(src.CASH_REGISTER_TURNOVER_GROSS_VAL, trg.CASH_REGISTER_TURNOVER_GROSS_VAL)    as NEW_CASH_REGISTER_TURNOVER_GROSS_VAL  
        ,nvl(src.CASH_REGISTER_TURNOVER_NET_VAL, trg.CASH_REGISTER_TURNOVER_NET_VAL)        as NEW_CASH_REGISTER_TURNOVER_NET_VAL
        ,nvl(src.CASH_REGISTER_RECEIPT_CNT, trg.CASH_REGISTER_RECEIPT_CNT)                  as NEW_CASH_REGISTER_RECEIPT_CNT
        
        ,nvl(src.TURNOVER_NET_VAL, trg.TURNOVER_NET_VAL)                                    as NEW_TURNOVER_NET_VAL
        ,nvl(src.TURNOVER_GROSS_VAL, trg.TURNOVER_GROSS_VAL)                                as NEW_TURNOVER_GROSS_VAL
        ,nvl(src.RECEIPT_CNT, trg.RECEIPT_CNT)                                              as NEW_RECEIPT_CNT
    
        
        -- for Columns with accumulated values we will need daily Delta (new - old value) + Old BYTD_ value
        ,NEW_BOOKED_TURNOVER_NET_VAL - nvl(trg.BOOKED_TURNOVER_NET_VAL,0)                       as DELTA_BOOKED_TURNOVER_NET_VAL 
        ,NEW_BOOKED_RECEIPT_CNT - nvl(trg.BOOKED_RECEIPT_CNT,0)                                 as DELTA_BOOKED_RECEIPT_CNT
        ,NEW_EOD_TURNOVER_NET_VAL - nvl(trg.EOD_TURNOVER_NET_VAL,0)                             as DELTA_EOD_TURNOVER_NET_VAL
        ,NEW_EOD_RECEIPT_CNT - nvl(trg.EOD_RECEIPT_CNT,0)                                       as DELTA_EOD_RECEIPT_CNT
        ,NEW_EOD_TURNOVER_GROSS_VAL - nvl(trg.EOD_TURNOVER_GROSS_VAL,0)                         as DELTA_EOD_TURNOVER_GROSS_VAL
        ,NEW_CASH_REGISTER_TURNOVER_GROSS_VAL - nvl(trg.CASH_REGISTER_TURNOVER_GROSS_VAL,0)     as DELTA_CASH_REGISTER_TURNOVER_GROSS_VAL
        ,NEW_CASH_REGISTER_TURNOVER_NET_VAL - nvl(trg.CASH_REGISTER_TURNOVER_NET_VAL,0)         as DELTA_CASH_REGISTER_TURNOVER_NET_VAL
        ,NEW_CASH_REGISTER_RECEIPT_CNT - nvl(trg.CASH_REGISTER_RECEIPT_CNT,0)                   as DELTA_CASH_REGISTER_RECEIPT_CNT
        
        ,NEW_TURNOVER_NET_VAL - nvl(trg.TURNOVER_NET_VAL,0)                                     as DELTA_TURNOVER_NET_VAL
        ,NEW_TURNOVER_GROSS_VAL - nvl(trg.TURNOVER_GROSS_VAL,0)                                 as DELTA_TURNOVER_GROSS_VAL
        ,NEW_RECEIPT_CNT - nvl(trg.RECEIPT_CNT,0)                                               as DELTA_RECEIPT_CNT
        
        ,trg.TURNOVER_BYTD_NET_VAL                                                              as CURR_TURNOVER_BYTD_NET_VAL
        ,trg.TURNOVER_BYTD_GROSS_VAL                                                            as CURR_TURNOVER_BYTD_GROSS_VAL
        ,trg.RECEIPT_BYTD_CNT                                                                   as CURR_RECEIPT_BYTD_CNT
        
        ,trg.TURNOVER_PY_NET_VAL                                                                as CURR_TURNOVER_PY_NET_VAL
        ,trg.TURNOVER_PY_GROSS_VAL                                                              as CURR_TURNOVER_PY_GROSS_VAL
        ,trg.RECEIPT_PY_CNT                                                                     as CURR_RECEIPT_PY_CNT
        ,trg.TURNOVER_PY_BYTD_NET_VAL                                                           as CURR_TURNOVER_PY_BYTD_NET_VAL
        ,trg.TURNOVER_PY_BYTD_GROSS_VAL                                                         as CURR_TURNOVER_PY_BYTD_GROSS_VAL
        ,trg.RECEIPT_PY_BYTD_CNT                                                                as CURR_RECEIPT_PY_BYTD_CNT
                                                                                                   
        ,trg.TURNOVER_PY_SWDAY_NET_VAL                                                          as CURR_TURNOVER_PY_SWDAY_NET_VAL
        ,trg.TURNOVER_PY_SWDAY_GROSS_VAL                                                        as CURR_TURNOVER_PY_SWDAY_GROSS_VAL
        ,trg.RECEIPT_PY_SWDAY_CNT                                                               as CURR_RECEIPT_PY_SWDAY_CNT
        ,trg.TURNOVER_PY_SWDAY_BYTD_NET_VAL                                                     as CURR_TURNOVER_PY_SWDAY_BYTD_NET_VAL
        ,trg.TURNOVER_PY_SWDAY_BYTD_GROSS_VAL                                                   as CURR_TURNOVER_PY_SWDAY_BYTD_GROSS_VAL
        ,trg.RECEIPT_PY_SWDAY_BYTD_CNT                                                          as CURR_RECEIPT_PY_SWDAY_BYTD_CNT
        
    FROM src_delta src
        left join extended_target trg
                    on trg.INT_ORG_SID = src.INT_ORG_SID
                    and trg.BUS_DT = src.BUS_DT
     
    UNION ALL
    
    -- if we do not have delta we still must create rows for today/yesterday with BYTD cols
    SELECT 
        te.INT_ORG_SID
        ,te.BUS_DT
        ,te.BUS_YEAR
        ,te.INT_ORG_TYPE_CD
        ,te.COUNTRY_ORG_CD
        ,te.CURR_CD
        
        -- for Columns with daily values we just need the new value
        ,NULL                           as NEW_BOOKED_TURNOVER_NET_VAL
        ,NULL                           as NEW_BOOKED_RECEIPT_CNT
        ,NULL                           as NEW_EOD_TURNOVER_NET_VAL
        ,NULL                           as NEW_EOD_RECEIPT_CNT
        ,NULL                           as NEW_EOD_TURNOVER_GROSS_VAL
        ,NULL                           as NEW_CASH_REGISTER_TURNOVER_GROSS_VAL  
        ,NULL                           as NEW_CASH_REGISTER_TURNOVER_NET_VAL
        ,NULL                           as NEW_CASH_REGISTER_RECEIPT_CNT
                
        ,NULL                           as NEW_TURNOVER_NET_VAL
        ,NULL                           as NEW_TURNOVER_GROSS_VAL
        ,NULL                           as NEW_RECEIPT_CNT
            
                
        ,NULL                           as DELTA_BOOKED_TURNOVER_NET_VAL 
        ,NULL                           as DELTA_BOOKED_RECEIPT_CNT
        ,NULL                           as DELTA_EOD_TURNOVER_NET_VAL
        ,NULL                           as DELTA_EOD_RECEIPT_CNT
        ,NULL                           as DELTA_EOD_TURNOVER_GROSS_VAL
        ,NULL                           as DELTA_CASH_REGISTER_TURNOVER_GROSS_VAL
        ,NULL                           as DELTA_CASH_REGISTER_TURNOVER_NET_VAL
        ,NULL                           as DELTA_CASH_REGISTER_RECEIPT_CNT
                
        ,NULL                           as DELTA_TURNOVER_NET_VAL
        ,NULL                           as DELTA_TURNOVER_GROSS_VAL
        ,NULL                           as DELTA_RECEIPT_CNT
        
        -- for Columns with accumulated values we will need daily Delta (new - old value) + Old BYTD_ value
        ,te.TURNOVER_BYTD_NET_VAL                   as CURR_TURNOVER_BYTD_NET_VAL
        ,te.TURNOVER_BYTD_GROSS_VAL                 as CURR_TURNOVER_BYTD_GROSS_VAL
        ,te.RECEIPT_BYTD_CNT                        as CURR_RECEIPT_BYTD_CNT
        
        ,te.TURNOVER_PY_NET_VAL                    as CURR_TURNOVER_PY_NET_VAL
        ,te.TURNOVER_PY_GROSS_VAL                  as CURR_TURNOVER_PY_GROSS_VAL
        ,te.RECEIPT_PY_CNT                         as CURR_RECEIPT_PY_CNT
        ,te.TURNOVER_PY_BYTD_NET_VAL               as CURR_TURNOVER_PY_BYTD_NET_VAL
        ,te.TURNOVER_PY_BYTD_GROSS_VAL             as CURR_TURNOVER_PY_BYTD_GROSS_VAL
        ,te.RECEIPT_PY_BYTD_CNT                    as CURR_RECEIPT_PY_BYTD_CNT
                                                   
        ,te.TURNOVER_PY_SWDAY_NET_VAL              as CURR_TURNOVER_PY_SWDAY_NET_VAL
        ,te.TURNOVER_PY_SWDAY_GROSS_VAL            as CURR_TURNOVER_PY_SWDAY_GROSS_VAL
        ,te.RECEIPT_PY_SWDAY_CNT                   as CURR_RECEIPT_PY_SWDAY_CNT
        ,te.TURNOVER_PY_SWDAY_BYTD_NET_VAL         as CURR_TURNOVER_PY_SWDAY_BYTD_NET_VAL
        ,te.TURNOVER_PY_SWDAY_BYTD_GROSS_VAL       as CURR_TURNOVER_PY_SWDAY_BYTD_GROSS_VAL
        ,te.RECEIPT_PY_SWDAY_BYTD_CNT              as CURR_RECEIPT_PY_SWDAY_BYTD_CNT
    FROM etl.V_TURNOVER_BY_STORE_DAY_EXTENSION te 
        left join src_delta src 
                    on te.INT_ORG_SID = src.INT_ORG_SID
                    and te.BUS_DT = src.BUS_DT
    WHERE src.INT_ORG_SID is null
)
-- if we have row in the delta for a change at 20.04.2022, then we must change the PY_cols in 2023
,py_rev as
(
    SELECT 
        rf.INT_ORG_SID
        ,py.CAL_DT                                  as BUS_DT
        ,py.CAL_DT_ADJUST_TYPE_CD   
            
        ,sum(rf.NEW_TURNOVER_NET_VAL)               as NEW_TURNOVER_NET_VAL
        ,sum(rf.NEW_TURNOVER_GROSS_VAL)             as NEW_TURNOVER_GROSS_VAL
        ,sum(rf.NEW_RECEIPT_CNT)                    as NEW_RECEIPT_CNT
            
        ,sum(rf.DELTA_TURNOVER_NET_VAL)             as DELTA_TURNOVER_NET_VAL
        ,sum(rf.DELTA_TURNOVER_GROSS_VAL)           as DELTA_TURNOVER_GROSS_VAL
        ,sum(rf.DELTA_RECEIPT_CNT)                  as DELTA_RECEIPT_CNT
            
        ,sum(rf.CURR_TURNOVER_BYTD_NET_VAL)          as CURR_TURNOVER_BYTD_NET_VAL
        ,sum(rf.CURR_TURNOVER_BYTD_GROSS_VAL)        as CURR_TURNOVER_BYTD_GROSS_VAL
        ,sum(rf.CURR_RECEIPT_BYTD_CNT)               as CURR_RECEIPT_BYTD_CNT
    FROM core_rel.T_CAL_DATE_ADJUSTED_RELATIONSHIP py
        join rev_facts rf 
                    on rf.BUS_DT = py.REL_CAL_DT
    WHERE 1=1
        and py.BUS_YEAR_DIFF = 1
        and py.CAL_DT_ADJUST_TYPE_CD in ('M', 'W', 'WC', 'MC')
        and py.CAL_DT < CURRENT_DATE
    GROUP BY
        rf.INT_ORG_SID
        ,py.CAL_DT
        ,py.CAL_DT_ADJUST_TYPE_CD
)
SELECT 
    rf.INT_ORG_SID
    ,rf.BUS_DT
    ,rf.BUS_YEAR
    ,rf.INT_ORG_TYPE_CD
    ,rf.COUNTRY_ORG_CD
    ,rf.CURR_CD
    
    ,rf.NEW_BOOKED_TURNOVER_NET_VAL 
    ,rf.NEW_BOOKED_RECEIPT_CNT
    ,rf.NEW_EOD_TURNOVER_NET_VAL
    ,rf.NEW_EOD_RECEIPT_CNT
    ,rf.NEW_EOD_TURNOVER_GROSS_VAL
    ,rf.NEW_CASH_REGISTER_TURNOVER_GROSS_VAL
    ,rf.NEW_CASH_REGISTER_TURNOVER_NET_VAL
    ,rf.NEW_CASH_REGISTER_RECEIPT_CNT
    
    ,rf.NEW_TURNOVER_NET_VAL
    ,rf.NEW_TURNOVER_GROSS_VAL
    ,rf.NEW_RECEIPT_CNT
    
    ,CASE
        WHEN rf.CURR_TURNOVER_BYTD_NET_VAL is null
            THEN sum(rf.DELTA_TURNOVER_NET_VAL)   
                OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        ELSE
            rf.CURR_TURNOVER_BYTD_NET_VAL
            + nvl(sum(rf.DELTA_TURNOVER_NET_VAL)   
                OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0)
    END as NEW_TURNOVER_BYTD_NET_VAL
    
    ,CASE
        WHEN rf.CURR_TURNOVER_BYTD_GROSS_VAL is NULL 
            THEN sum(rf.DELTA_TURNOVER_GROSS_VAL) 
                    OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                    ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        ELSE
            rf.CURR_TURNOVER_BYTD_GROSS_VAL
            + nvl(sum(rf.DELTA_TURNOVER_GROSS_VAL) 
            OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0)
    END as NEW_TURNOVER_BYTD_GROSS_VAL
    
    ,CASE
        WHEN rf.CURR_RECEIPT_BYTD_CNT is NULL 
            THEN sum(rf.DELTA_RECEIPT_CNT)        
                    OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                    ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        ELSE
            rf.CURR_RECEIPT_BYTD_CNT
            + nvl(sum(rf.DELTA_RECEIPT_CNT)        
            OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0) 
    END as NEW_RECEIPT_BYTD_CNT


    -- if in the delta we got a record from 2022, then in py_rev_m we have associate this record with 2023
    -- so for 2023 records we say ""if I don't have change in the prev year, take current value. If I had, take last years values as PY_ values now"")
    
    -- TURNOVER_PY_NET_VAL
    ,CASE
        WHEN py_rev_m.INT_ORG_SID is NULL THEN rf.CURR_TURNOVER_PY_NET_VAL
        ELSE py_rev_m.NEW_TURNOVER_NET_VAL
    END                                                                     as NEW_TURNOVER_PY_NET_VAL
    
    -- TURNOVER_PY_GROSS_VAL
    ,CASE
        WHEN py_rev_m.INT_ORG_SID is NULL THEN rf.CURR_TURNOVER_PY_GROSS_VAL
        ELSE py_rev_m.NEW_TURNOVER_GROSS_VAL
    END                                                                     as NEW_TURNOVER_PY_GROSS_VAL
    
    -- RECEIPT_PY_CNT
    ,CASE
        WHEN py_rev_m.INT_ORG_SID is NULL THEN rf.CURR_RECEIPT_PY_CNT
        ELSE py_rev_m.NEW_RECEIPT_CNT
    END                                                                     as NEW_RECEIPT_PY_CNT

    -- TURNOVER_PY_BYTD_NET_VAL
    ,CASE
        -- no records in the delta from the prev year
        WHEN py_rev_mc.INT_ORG_SID is NULL THEN rf.CURR_TURNOVER_PY_BYTD_NET_VAL
        ELSE nvl(py_rev_mc.CURR_TURNOVER_BYTD_NET_VAL, 0) 
                + nvl(sum(py_rev_mc.DELTA_TURNOVER_NET_VAL)   
                        OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                        ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0)
    END                                                                     as NEW_TURNOVER_PY_BYTD_NET_VAL
 
    -- TURNOVER_PY_BYTD_GROSS_VAL
    ,CASE
        -- no records in the delta from the prev year
        WHEN py_rev_mc.INT_ORG_SID is NULL THEN rf.CURR_TURNOVER_PY_BYTD_GROSS_VAL
        ELSE nvl(py_rev_mc.CURR_TURNOVER_BYTD_GROSS_VAL, 0) 
                + nvl(sum(py_rev_mc.DELTA_TURNOVER_GROSS_VAL)   
                        OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                        ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0)
    END                                                                     as NEW_TURNOVER_PY_BYTD_GROSS_VAL

    -- RECEIPT_PY_BYTD_CNT
    ,CASE
        -- no records in the delta from the prev year
        WHEN py_rev_mc.INT_ORG_SID is NULL THEN rf.CURR_RECEIPT_PY_BYTD_CNT
        ELSE nvl(py_rev_mc.CURR_RECEIPT_BYTD_CNT, 0) 
                + nvl(sum(py_rev_mc.DELTA_RECEIPT_CNT)   
                        OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                        ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0)
    END                                                                     as NEW_RECEIPT_PY_BYTD_CNT  


    -- TURNOVER_PY_SWDAY_NET_VAL
    ,CASE
        WHEN py_rev_w.INT_ORG_SID is NULL THEN rf.CURR_TURNOVER_PY_SWDAY_NET_VAL
        ELSE py_rev_w.NEW_TURNOVER_NET_VAL
    END                                                                     as NEW_TURNOVER_PY_SWDAY_NET_VAL
    
    -- TURNOVER_PY_SWDAY_GROSS_VAL
    ,CASE
        WHEN py_rev_w.INT_ORG_SID is NULL THEN rf.CURR_TURNOVER_PY_SWDAY_GROSS_VAL
        ELSE py_rev_w.NEW_TURNOVER_GROSS_VAL
    END                                                                     as NEW_TURNOVER_PY_SWDAY_GROSS_VAL
    
    -- RECEIPT_PY_SWDAY_CNT
    ,CASE
        WHEN py_rev_w.INT_ORG_SID is NULL THEN rf.CURR_RECEIPT_PY_SWDAY_CNT
        ELSE py_rev_w.NEW_RECEIPT_CNT
    END                                                                     as NEW_RECEIPT_PY_SWDAY_CNT
    
    
    -- TURNOVER_PY_SWDAY_BYTD_NET_VAL
    ,CASE
        -- no records in the delta from the prev year
        WHEN py_rev_wc.INT_ORG_SID is NULL THEN rf.CURR_TURNOVER_PY_SWDAY_BYTD_NET_VAL
        ELSE nvl(py_rev_wc.CURR_TURNOVER_BYTD_NET_VAL, 0) 
                + nvl(sum(py_rev_wc.DELTA_TURNOVER_NET_VAL)   
                        OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                        ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0)
    END                                                                     as NEW_TURNOVER_PY_SWDAY_BYTD_NET_VAL
 
    -- TURNOVER_PY_SWDAY_BYTD_GROSS_VAL
    ,CASE
        -- no records in the delta from the prev year
        WHEN py_rev_wc.INT_ORG_SID is NULL THEN rf.CURR_TURNOVER_PY_SWDAY_BYTD_GROSS_VAL
        ELSE nvl(py_rev_wc.CURR_TURNOVER_BYTD_GROSS_VAL, 0) 
                + nvl(sum(py_rev_wc.DELTA_TURNOVER_GROSS_VAL)   
                        OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                        ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0)
    END                                                                     as NEW_TURNOVER_PY_SWDAY_BYTD_GROSS_VAL

    -- RECEIPT_PY_SWDAY_BYTD_CNT
    ,CASE
        -- no records in the delta from the prev year
        WHEN py_rev_wc.INT_ORG_SID is NULL THEN rf.CURR_RECEIPT_PY_SWDAY_BYTD_CNT
        ELSE nvl(py_rev_wc.CURR_RECEIPT_BYTD_CNT, 0) 
                + nvl(sum(py_rev_wc.DELTA_RECEIPT_CNT)   
                        OVER (PARTITION BY rf.INT_ORG_SID, rf.BUS_YEAR
                        ORDER BY rf.BUS_DT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0)
    END                                                                     as NEW_RECEIPT_PY_SWDAY_BYTD_CNT  
    
FROM rev_facts rf
    left outer join py_rev py_rev_m 
            on py_rev_m.INT_ORG_SID = rf.INT_ORG_SID
            and py_rev_m.BUS_DT = rf.BUS_DT
            and py_rev_m.CAL_DT_ADJUST_TYPE_CD = 'M'
    left outer join py_rev py_rev_mc 
            on py_rev_mc.INT_ORG_SID = rf.INT_ORG_SID
            and py_rev_mc.BUS_DT = rf.BUS_DT
            and py_rev_mc.CAL_DT_ADJUST_TYPE_CD = 'MC'
    left outer join py_rev py_rev_w 
            on py_rev_w.INT_ORG_SID = rf.INT_ORG_SID
            and py_rev_w.BUS_DT = rf.BUS_DT
            and py_rev_w.CAL_DT_ADJUST_TYPE_CD = 'W'
    left outer join py_rev py_rev_wc 
            on py_rev_wc.INT_ORG_SID = rf.INT_ORG_SID
            and py_rev_wc.BUS_DT = rf.BUS_DT
            and py_rev_wc.CAL_DT_ADJUST_TYPE_CD = 'WC'
;