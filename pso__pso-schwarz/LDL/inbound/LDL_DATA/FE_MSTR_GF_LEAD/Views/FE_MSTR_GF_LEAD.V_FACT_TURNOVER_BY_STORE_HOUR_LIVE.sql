CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_FACT_TURNOVER_BY_STORE_HOUR_LIVE
(
    store_sid                 COMMENT 'The unique identifier (surrogate key) for a store.'
  , cal_dt                    COMMENT 'The business date to which the measures are related.'
  , hr                        COMMENT 'Hour of a day to which the measures are related.'
  , country_org_sid           COMMENT 'The unique identifier (surrogate key) for a country.'
  , country_org_cd            COMMENT 'The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)'
  , curr_cd                   COMMENT 'The code identifying the currency according to ISO-4217.'
  , curr_group_fg             COMMENT 'Flag for Group Currency'
  , curr_local_fg             COMMENT 'Flag for Local Currency'
  , turnover_net_val          COMMENT 'The net turnover which was generated for that store on the given day and hour.'
  , receipt_cnt               COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day and hour.'
  , turnover_py_swday_net_val COMMENT 'The net turnover which was generated for that store on the same weekday and hour one year ago.'
  , receipt_py_swday_cnt      COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the same weekday and hour one year ago.'
  , last_receipt_tmsp         COMMENT 'The timestamp of last sales transaction in that store on the given day and hour.'
  , is_closed_hour            COMMENT '1 if there are already receipts from a following hour in given country, 0 otherwise.'
)
AS
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
      , Max(re.country_org_sid)                                                     AS country_org_sid
      , Max(re.country_org_cd)                                                      AS country_org_cd
      , Max(re.curr_cd)                                                             AS curr_cd
      , Sum(CASE WHEN dt.curr_year_fg = 1 THEN re.txn_net_val END)                  AS turnover_net_val
      , Sum(CASE WHEN dt.curr_year_fg = 1 THEN 1 END)                               AS receipt_cnt
      , Sum(CASE WHEN dt.curr_year_fg = 0 THEN re.txn_net_val END)                  AS turnover_py_swday_net_val
      , Sum(CASE WHEN dt.curr_year_fg = 0 THEN 1 END)                               AS receipt_py_swday_cnt
      , Max(re.event_end_tmsp)                                                      AS last_receipt_tmsp
    FROM dt
    INNER JOIN CORE_REL.t_retail_event AS re
    ON  dt.cal_dt = re.bus_dt
    INNER JOIN CORE_REL.t_internal_organization AS org
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
INNER JOIN CORE_DIM.t_fact_exchange_rate AS fer
ON  fact.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE
;