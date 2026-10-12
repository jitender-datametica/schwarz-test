CREATE OR REPLACE VIEW fe_mstr_master.v_fact_turnover_by_store_hour_live_2 (store_sid
OPTIONS(description='The unique identifier (surrogate key) for a store.'), cal_dt
OPTIONS(description='The business date to which the measures are related.'), hr
OPTIONS(description='Hour of a day to which the measures are related.'), country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for a country.'), country_org_cd
OPTIONS(description='The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)'),
curr_cd OPTIONS(description='The code identifying the currency according to ISO-4217.'), curr_group_fg
OPTIONS(description='Flag for Group Currency'), curr_local_fg OPTIONS(description='Flag for Local Currency'),
turnover_net_val OPTIONS(description='The net turnover which was generated for that store on the given day and hour.'),
receipt_cnt
OPTIONS(description='The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day and hour.'),
turnover_py_swday_net_val
OPTIONS(description='The net turnover which was generated for that store on the same weekday and hour one year ago.'),
receipt_py_swday_cnt
OPTIONS(description='The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the same weekday and hour one year ago.'),
last_receipt_tmsp
OPTIONS(description='The timestamp of last sales_2 transaction in that store on the given day and hour.'), is_closed_hour
OPTIONS(description='1 if there are already receipts from a following hour in given country_2, 0 otherwise.')) AS WITH DT
 AS (SELECT rel_cal_dt AS cal_dt,
    cal_dt AS dis_dt,
    0 AS curr_year_fg
   FROM ldl_data_core_rel.t_cal_date_adjusted_relationship_2
   WHERE cal_dt = CURRENT_DATE
    AND cal_dt_adjust_type_cd = 'W'
    AND bus_year_diff = 1
   UNION ALL
   SELECT CURRENT_DATE AS cal_dt,
    CURRENT_DATE AS dis_dt,
    1 AS curr_year_fg), FACT AS (SELECT RE.store_sid,
   t4.dis_dt AS cal_dt,
   EXTRACT(HOUR FROM RE.event_end_tmsp) AS hr,
   MAX(RE.country_org_sid) AS country_org_sid,
   MAX(RE.country_org_cd) AS country_org_cd,
   MAX(RE.curr_cd) AS curr_cd,
   SUM(CASE
     WHEN t4.curr_year_fg = 1
     THEN RE.txn_net_val
     ELSE NULL
     END) AS turnover_net_val,
   SUM(CASE
     WHEN t4.curr_year_fg = 1
     THEN 1
     ELSE NULL
     END) AS receipt_cnt,
   SUM(CASE
     WHEN t4.curr_year_fg = 0
     THEN RE.txn_net_val
     ELSE NULL
     END) AS turnover_py_swday_net_val,
   SUM(CASE
     WHEN t4.curr_year_fg = 0
     THEN 1
     ELSE NULL
     END) AS receipt_py_swday_cnt,
   MAX(RE.event_end_tmsp) AS last_receipt_tmsp
  FROM DT AS t4
   INNER JOIN ldl_data_core_rel.t_retail_event_2 AS RE_2 ON t4.cal_dt = RE.bus_dt AND RE.turnover_relevant_fg
  GROUP BY RE.store_sid,
   cal_dt,
   hr), CLOSED_HR AS (SELECT country_org_sid,
   MAX(last_receipt_tmsp) AS max_receipt_tmsp
  FROM FACT
  GROUP BY country_org_sid
  HAVING DATE(max_receipt_tmsp) >= CURRENT_DATE) (SELECT t8.store_sid,
   t8.cal_dt,
   t8.hr,
   t8.country_org_sid,
   t8.country_org_cd,
   FER.src_curr_cd AS curr_cd,
    CASE
    WHEN FER.src_curr_cd = 'EUR'
    THEN 1
    ELSE 0
    END AS curr_group_fg,
    CASE
    WHEN FER.src_curr_cd = FER.tgt_curr_cd
    THEN 1
    ELSE 0
    END AS curr_local_fg,
    t8.turnover_net_val / FER.exchange_rate AS turnover_net_val,
   t8.receipt_cnt,
    t8.turnover_py_swday_net_val / FER.exchange_rate AS turnover_py_swday_net_val,
   t8.receipt_py_swday_cnt,
   t8.last_receipt_tmsp,
    CASE
    WHEN EXTRACT(HOUR FROM t23.max_receipt_tmsp) > t8.hr
    THEN 1
    ELSE 0
    END AS is_closed_hour
  FROM FACT AS t8
   INNER JOIN CLOSED_HR AS t23 ON t8.country_org_sid = t23.country_org_sid
   INNER JOIN ldl_data_core_dim.t_fact_exchange_rate_2 AS FER ON t8.curr_cd = FER.tgt_curr_cd
  WHERE FER.exchange_rate_type_cd = 'BEW_ISK'
   AND (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd)
   AND FER.active_fg);