CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_FACT_TURNOVER_BY_STORE_OPEN_DAY(
cal_dt COMMENT 'The business date to which the measures are related.'
,store_sid COMMENT 'Th,e unique identifier (surrogate key) for a store.'
,country_org_cd COMMENT 'The code of the business country for which thIS country organizatiON IS responsible. (The business country IS not identical to a political country.)'
,store_open_fg COMMENT 'If the store IS open ON the given day. '
,store_open_fg_bytd_cnt COMMENT 'The business-year-to-date sum of store open flag'
,store_open_py_fg COMMENT 'If the store IS open  ON the same calendar date one year ago.'
,store_open_py_fg_bytd_cnt COMMENT 'The business-year-to-date sum of previous year store open flag'
,store_open_py_swday_fg COMMENT 'If the store IS open ON the same weekday one year ago'
,store_open_py_swday_fg_bytd_cnt COMMENT 'The business-year-to-date sum of previous year same week day store open flag'
,turnover_net_val COMMENT 'The net turnover which wAS generated for that store ON the given day. (ThIS IS the consolidated amount after applying the priority logic.)'
,turnover_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover for that store up to the given day. (ThIS IS the consolidated amount after applying the priority logic.)'
,turnover_py_net_val COMMENT 'The net turnover which wAS generated for that store ON the same calendar date one year ago. (ThIS IS the consolidated amount after applying the priority logic.)'
,turnover_py_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover for that store up to the same calendar date one year ago. (ThIS IS the consolidated amount after applying the priority logic.)'
,turnover_py_swday_net_val COMMENT 'The net turnover which wAS generated for that store ON the same weekday one year ago. (ThIS IS the consolidated amount after applying the priority logic.)'
,turnover_py_swday_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover for that store up to the same weekday one year ago. (ThIS IS the consolidated amount after applying the priority logic.)'
,curr_cd COMMENT 'The code identifying the currency according to ISO-4217.'
,curr_group_fg COMMENT 'Flag for Group Currency'
,curr_local_fg COMMENT 'Flag for Local Currency'
) COMMENT='The Store day level view for Turnover for average turnover calculatiON per week' AS 
WITH 
facts_with_flags AS
(
    SELECT 
        f.int_org_sid AS int_org_sid
        ,f.bus_dt AS bus_dt
        ,f.country_org_cd AS country_org_cd
        ,f.turnover_net_val AS turnover_net_val
        ,CASE
            WHEN f.bus_dt >= re.open_dt AND f.bus_dt <= re.close_dt THEN 1
            WHEN f.bus_dt >= re.open_dt AND re.close_dt IS NULL THEN 1
            ELSE 0
        END AS store_open_fg
    FROM CORE_DIM.T_FACT_TURNOVER_BY_STORE_DAY f
    INNER JOIN CORE_DIM.T_DIM_CALENDAR_DATE cd 
        ON cd.cal_dt = f.bus_dt
    LEFT JOIN CORE_REL.T_INTERNAL_ORGANIZATION_REAL_ESTATE iore
        ON iore.int_org_sid = f.int_org_sid
        AND iore.dwh_valid_from_tmsp <= f.bus_dt
        AND iore.dwh_valid_to_tmsp >= f.bus_dt
    LEFT JOIN CORE_REL.T_REAL_ESTATE re
        ON re.real_estate_sid = iore.real_estate_sid
        AND re.dwh_valid_from_tmsp <= f.bus_dt
        AND re.dwh_valid_to_tmsp >= f.bus_dt
        AND re.real_estate_type_cd = 'STORE'
)
,py_fwf AS
(
    SELECT 
        fwf.int_org_sid AS int_org_sid
        ,py.cal_dt      AS bus_dt           
        ,py.cal_dt_adjust_type_cd AS cal_dt_adjust_type_cd
        ,fwf.country_org_cd AS country_org_cd
        ,SUM(fwf.turnover_net_val) AS turnover_net_val
        ,MAX(fwf.store_open_fg)  AS store_open_fg
    FROM CORE_REL.T_CAL_DATE_ADJUSTED_RELATIONSHIP py
    INNER JOIN facts_with_flags fwf 
    ON fwf.bus_dt = py.rel_cal_dt          
    WHERE py.bus_year_diff = 1
    AND py.cal_dt_adjust_type_cd IN ('M', 'W', 'WC', 'MC')
    AND py.cal_dt < CURRENT_DATE
    GROUP BY
    fwf.int_org_sid
    ,py.cal_dt
    ,py.cal_dt_adjust_type_cd
    ,fwf.country_org_cd
)
SELECT 
    fwf.bus_dt AS cal_dt
    ,fwf.int_org_sid AS store_sid
    ,fwf.country_org_cd AS country_org_cd
    ,fwf.store_open_fg AS store_open_fg
    ,SUM(fwf.store_open_fg)
        OVER (PARTITION BY  f.int_org_sid, cd.bus_year, f.country_org_cd
            ORDER BY f.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS store_open_fg_bytd_cnt
    ,py_m.store_open_fg   AS store_open_py_fg
    ,SUM(py_mc.store_open_fg)
        OVER (PARTITION BY  f.int_org_sid, cd.bus_year, f.country_org_cd
            ORDER BY f.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)    AS store_open_py_fg_bytd_cnt

    ,py_w.store_open_fg  AS store_open_py_swday_fg
    ,SUM(py_wc.store_open_fg)
        OVER (PARTITION BY  f.int_org_sid, cd.bus_year, f.country_org_cd
            ORDER BY f.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)    AS store_open_py_swday_fg_bytd_cnt
    ,CASE
        WHEN fwf.store_open_fg AND f.turnover_net_val > 0 THEN f.turnover_net_val / fer.exchange_rate
        ELSE NULL
    END AS pstv_turnover_net_val
    ,SUM(pstv_turnover_net_val)
        OVER (PARTITION BY  f.int_org_sid, cd.bus_year, f.country_org_cd
            ORDER BY f.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)     AS pstv_turnover_bytd_net_val
    ,CASE
        WHEN py_m.store_open_fg AND py_m.turnover_net_val > 0 THEN py_m.turnover_net_val / fer.exchange_rate
        ELSE NULL
    END AS pstv_turnover_py_net_val
    ,SUM(DECODE(py_mc.store_open_fg, true, GREATEST(py_mc.turnover_net_val / fer.exchange_rate,0), 0))
        OVER (PARTITION BY  f.int_org_sid, cd.bus_year, f.country_org_cd
            ORDER BY f.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)     AS pstv_turnover_py_bytd_net_val
    ,CASE
        WHEN py_w.store_open_fg AND py_w.turnover_net_val > 0 THEN py_w.turnover_net_val / fer.exchange_rate
        ELSE NULL
    END AS pstv_turnover_py_swday_net_val
    ,SUM(DECODE(py_wc.store_open_fg, true, GREATEST(py_wc.turnover_net_val / fer.exchange_rate,0), 0))
        OVER (PARTITION BY  f.int_org_sid, cd.bus_year, f.country_org_cd
            ORDER BY f.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS pstv_turnover_py_swday_bytd_net_val
    ,fer.src_curr_cd AS curr_cd
    ,DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
    ,DECODE(fer.src_curr_cd,fer.tgt_curr_cd,1,0) AS curr_local_fg
FROM CORE_DIM.T_FACT_TURNOVER_BY_STORE_DAY f
INNER JOIN CORE_DIM.T_DIM_CALENDAR_DATE cd 
ON cd.cal_dt = f.bus_dt
INNER JOIN facts_with_flags fwf 
ON f.bus_dt = fwf.bus_dt
AND f.int_org_sid = fwf.int_org_sid
AND f.country_org_cd = fwf.country_org_cd
LEFT JOIN py_fwf py_m
ON py_m.int_org_sid = fwf.int_org_sid
AND py_m.bus_dt = fwf.bus_dt
AND py_m.cal_dt_adjust_type_cd = 'M'
AND py_m.country_org_cd = fwf.country_org_cd
LEFT JOIN py_fwf py_mc
ON py_mc.int_org_sid = fwf.int_org_sid
AND py_mc.bus_dt = fwf.bus_dt
AND py_mc.cal_dt_adjust_type_cd = 'MC'
AND py_m.country_org_cd = fwf.country_org_cd
LEFT JOIN py_fwf py_w
ON py_w.int_org_sid = fwf.int_org_sid
AND py_w.bus_dt = fwf.bus_dt
AND py_w.cal_dt_adjust_type_cd = 'W'
AND py_w.country_org_cd = fwf.country_org_cd
LEFT JOIN py_fwf py_wc
ON py_wc.int_org_sid = fwf.int_org_sid
AND py_wc.bus_dt = fwf.bus_dt
AND py_wc.cal_dt_adjust_type_cd = 'WC'
AND py_wc.country_org_cd = fwf.country_org_cd
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE fer
ON f.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE
;

