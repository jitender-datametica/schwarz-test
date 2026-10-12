CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_FACT_TURNOVER_BY_STORE_DAY_QTR_HR_EXCHANGE_RATE_TYPE_1(
cal_dt COMMENT 'The business date to which the measures are related.'
,store_sid COMMENT 'Th,e unique identifier (surrogate key) for a store.'
,country_org_cd COMMENT 'The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)'
,exchange_rate_type_cd COMMENT 'The Exchange Rate Type Code'
,exchange_bus_year COMMENT 'The Exchange Rate of the business year'
,hr COMMENT ' The hour of day, i.e.a number in the range from 0 to 23.'
,half_hr COMMENT 'The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm_1 the minute component.'
,qtr_hr COMMENT 'The unique identifier for a quarter-hour interval. Format: hhmm, indicating the begin time of the quarter-hour interval, with hh being the hour component and mm_1 the minute component.'
,turnover_net_val COMMENT 'The net turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)'
,turnover_gross_val COMMENT 'The gross turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)'
,curr_cd COMMENT 'The code identifying the currency according to ISO-4217.'
,curr_group_fg COMMENT 'Flag for Group Currency'
,curr_local_fg COMMENT 'Flag for Local Currency'
,receipt_cnt COMMENT 'The number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store on the given day. (This is the consolidated amount after applying the priority logic.)'
) COMMENT='The Store day quarter hour level view for Turnover and customer count based on event tables' AS SELECT 
main.bus_dt AS cal_dt
,main.store_sid AS store_sid
,main.country_org_cd AS country_org_cd
,fer.exchange_rate_type_cd
,fer.bus_year
,HOUR(main.event_end_tmsp)::NUMBER(38,0) AS hr
,HOUR(main.event_end_tmsp) * 100 + FLOOR(MINUTE(main.event_end_tmsp) / 30 ) * 30::NUMBER(38,0) AS half_hr
,HOUR(main.event_end_tmsp) * 100 + FLOOR(MINUTE(main.event_end_tmsp) / 15 ) * 15::NUMBER(38,0) AS qtr_hr
,SUM(main.retail_line_net_val / fer.exchange_rate) AS turnover_net_val
,SUM(main.retail_line_gross_val / fer.exchange_rate) AS turnover_gross_val
,fer.src_curr_cd AS curr_cd
,DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
,DECODE(fer.src_curr_cd,fer.tgt_curr_cd,1,0) AS curr_local_fg
,COUNT(DISTINCT main.retail_event_sid) AS receipt_cnt
FROM CORE_REL.T_PRODUCT_RETAIL_LINE_1 main
INNER JOIN CORE_REL.T_INTERNAL_ORGANIZATION_1 AS org
ON main.store_sid = org.int_org_sid
AND org.dwh_valid_fg
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE_1 fer
ON main.curr_cd = fer.tgt_curr_cd
WHERE (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND main.turnover_relevant_fg = TRUE
GROUP BY main.bus_dt 
,main.store_sid 
,main.country_org_cd 
,hr
,half_hr 
,qtr_hr
,fer.src_curr_cd
,curr_group_fg
,curr_local_fg
,fer.exchange_rate_type_cd
,fer.bus_year;