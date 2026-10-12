create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_TURNOVER_BY_STORE_HOUR_LIVE_2(
	STORE_SID COMMENT 'The unique identifier (surrogate key) for a store.',
	CAL_DT COMMENT 'The business date to which the measures are related.',
	HR COMMENT 'Hour of a day to which the measures are related.',
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for a country.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)',
	CURR_CD COMMENT 'The code identifying the currency according to ISO-4217.',
	CURR_GROUP_FG COMMENT 'Flag for Group Currency',
	CURR_LOCAL_FG COMMENT 'Flag for Local Currency',
	TURNOVER_NET_VAL COMMENT 'The net turnover which was generated for that store on the given day and hour.',
	RECEIPT_CNT COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day and hour.',
	TURNOVER_PY_SWDAY_NET_VAL COMMENT 'The net turnover which was generated for that store on the same weekday and hour one year ago.',
	RECEIPT_PY_SWDAY_CNT COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the same weekday and hour one year ago.',
	LAST_RECEIPT_TMSP COMMENT 'The timestamp of last sales_2 transaction in that store on the given day and hour.',
	IS_CLOSED_HOUR COMMENT '1 if there are already receipts from a following hour in given country_2, 0 otherwise.'
) as
WITH dt AS (
    SELECT rel_cal_dt AS cal_dt, cal_dt AS dis_dt, 0 AS curr_year_fg
    FROM CORE_REL.t_cal_date_adjusted_relationship_2
    WHERE cal_dt = CURRENT_DATE
      AND cal_dt_adjust_type_cd = 'W'
      AND bus_year_diff = 1
    UNION ALL
    SELECT CURRENT_DATE AS cal_dt, CURRENT_DATE AS dis_dt, 1 AS curr_year_fg
), fact AS (
    SELECT
        re.store_sid
      , dt.dis_dt                                                                   AS cal_dt
      , Extract(HOUR FROM re.event_end_tmsp)                                        AS hr
      , Max(re.country_org_sid)                                                     AS country_org_sid
      , Max(re.country_org_cd)                                                      AS country_org_cd
      , Max(re.curr_cd)                                                             AS curr_cd
      , Sum(CASE WHEN dt.curr_year_fg = 1 THEN re.txn_net_val END)                  AS turnover_net_val
      , Sum(CASE WHEN dt.curr_year_fg = 1 THEN 1 END)                               AS receipt_cnt
      , Sum(CASE WHEN dt.curr_year_fg = 0 THEN re.txn_net_val END)                  AS turnover_py_swday_net_val
      , Sum(CASE WHEN dt.curr_year_fg = 0 THEN 1 END)                               AS receipt_py_swday_cnt
      , Max(re.event_end_tmsp)                                                      AS last_receipt_tmsp
    FROM dt
    INNER JOIN CORE_REL.t_retail_event_2 AS re_2
    ON  dt.cal_dt = re.bus_dt
    INNER JOIN CORE_REL.t_internal_organization_2 AS org
    ON re.store_sid = org.int_org_sid
    AND org.dwh_valid_fg
    AND re.turnover_relevant_fg
    GROUP BY 1,2,3
),
closed_hr AS (
    SELECT
        country_org_sid
      , Max(last_receipt_tmsp) AS max_receipt_tmsp
    FROM fact
    GROUP BY 1
    HAVING Cast(max_receipt_tmsp AS DATE) >= CURRENT_DATE
)
SELECT
    fact.store_sid
  , fact.cal_dt
  , fact.hr
  , fact.country_org_sid
  , fact.country_org_cd
  , fer.src_curr_cd AS curr_cd
  , DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
  , DECODE(fer.src_curr_cd,fer.tgt_curr_cd,1,0) AS curr_local_fg
  , fact.turnover_net_val / fer.exchange_rate AS turnover_net_val
  , fact.receipt_cnt
  , fact.turnover_py_swday_net_val / fer.exchange_rate AS turnover_py_swday_net_val
  , fact.receipt_py_swday_cnt
  , fact.last_receipt_tmsp
  , CASE WHEN Extract(HOUR FROM closed_hr.max_receipt_tmsp) > fact.hr THEN 1 ELSE 0 END AS is_closed_hour
FROM fact
INNER JOIN closed_hr
ON  fact.country_org_sid = closed_hr.country_org_sid
INNER JOIN CORE_DIM.t_fact_exchange_rate_2 AS fer
ON  fact.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE
;