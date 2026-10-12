create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_RETAIL_BY_STORE_HOUR_LIVE(
	STORE_SID COMMENT 'The unique identifier (surrogate key) for a store.',
	CAL_DT COMMENT 'The business date to which the measures are related.',
	HR COMMENT 'Hour of a day to which the measures are related.',
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for a country.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)',
	CURR_CD COMMENT 'The code identifying the currency according to ISO-4217.',
	CURR_GROUP_FG COMMENT 'Flag for Group Currency',
	CURR_LOCAL_FG COMMENT 'Flag for Local Currency',
	TURNOVER_NET_VAL COMMENT 'The net turnover which was generated for that store on the given day and hour.',
	RECEIPT_CNT COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day and hour.',
	TURNOVER_PY_SWDAY_NET_VAL COMMENT 'The net turnover which was generated for that store on the same weekday and hour one year ago.',
	RECEIPT_PY_SWDAY_CNT COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the same weekday and hour one year ago.',
	LAST_RECEIPT_TMSP COMMENT 'The timestamp of last sales transaction in that store on the given day and hour.',
	IS_CLOSED_HOUR COMMENT '1 if there are already receipts from a following hour in given country, 0 otherwise.'
) as
WITH dt AS (
    SELECT rel_cal_dt AS cal_dt, cal_dt AS dis_dt, 0 AS curr_year_fg
    FROM CORE_REL.t_cal_date_adjusted_relationship
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
      , MAX(re.country_org_sid)                                                     AS country_org_sid
      , MAX(re.country_org_cd)                                                      AS country_org_cd
      , MAX(re.curr_cd)                                                             AS curr_cd
      , SUM(CASE WHEN dt.curr_year_fg = 1 THEN re.txn_net_val END)                  AS turnover_net_val
      , SUM(CASE WHEN dt.curr_year_fg = 1 THEN 1 END)                               AS receipt_cnt
      , SUM(CASE WHEN dt.curr_year_fg = 0 THEN re.txn_net_val END)                  AS turnover_py_swday_net_val
      , SUM(CASE WHEN dt.curr_year_fg = 0 THEN 1 END)                               AS receipt_py_swday_cnt
      , MAX(re.event_end_tmsp)                                                      AS last_receipt_tmsp
    FROM dt
    INNER JOIN CORE_REL.t_retail_event AS re
    ON  dt.cal_dt = re.bus_dt
    AND re.turnover_relevant_fg
    INNER JOIN core_rel.t_internal_organization AS org
    ON re.store_sid = org.int_org_sid
    AND org.dwh_valid_fg
    GROUP BY 1,2,3
),
closed_hr AS (
    SELECT
        country_org_sid
      , Max(last_receipt_tmsp) AS max_receipt_tmsp
    FROM fact
    GROUP BY 1
    HAVING CAST(max_receipt_tmsp AS DATE) >= CURRENT_DATE
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
INNER JOIN CORE_DIM.t_fact_exchange_rate AS fer
ON  fact.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE
;