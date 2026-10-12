CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_retail_by_store_hour_live_1 AS WITH dt AS (SELECT
    rel_cal_dt AS cal_dt,
    cal_dt AS dis_dt,
    0 AS curr_year_fg
   FROM ldl_data_production_core_rel.t_cal_date_adjusted_relationship_1
   WHERE cal_dt = CURRENT_DATE
    AND cal_dt_adjust_type_cd = 'W'
    AND bus_year_diff = 1
   UNION ALL
   SELECT CURRENT_DATE AS cal_dt,
    CURRENT_DATE AS dis_dt,
    1 AS curr_year_fg), fact AS (SELECT re.store_sid,
   t4.dis_dt AS cal_dt,
   EXTRACT(HOUR FROM re.event_end_tmsp) AS hr,
   MAX(re.country_org_sid) AS country_org_sid,
   MAX(re.country_org_cd) AS country_org_cd,
   MAX(re.curr_cd) AS curr_cd,
   SUM(CASE
     WHEN t4.curr_year_fg = 1
     THEN re.txn_net_val
     ELSE NULL
     END) AS turnover_net_val,
   SUM(CASE
     WHEN t4.curr_year_fg = 1
     THEN 1
     ELSE NULL
     END) AS receipt_cnt,
   SUM(CASE
     WHEN t4.curr_year_fg = 0
     THEN re.txn_net_val
     ELSE NULL
     END) AS turnover_py_swday_net_val,
   SUM(CASE
     WHEN t4.curr_year_fg = 0
     THEN 1
     ELSE NULL
     END) AS receipt_py_swday_cnt,
   MAX(re.event_end_tmsp) AS last_receipt_tmsp
  FROM dt AS t4
   INNER JOIN ldl_data_production_core_rel.t_retail_event_1 AS re_1 ON t4.cal_dt = re.bus_dt AND re.turnover_relevant_fg
   INNER JOIN ldl_data_production_core_rel.t_internal_organization_1 AS org ON re.store_sid = org.int_org_sid AND org.dwh_valid_fg
    
  GROUP BY re.store_sid,
   cal_dt,
   hr), closed_hr AS (SELECT country_org_sid,
   MAX(last_receipt_tmsp) AS max_receipt_tmsp
  FROM fact
  GROUP BY country_org_sid
  HAVING DATE(max_receipt_tmsp) >= CURRENT_DATE) (SELECT t8.store_sid,
   t8.cal_dt,
   t8.hr,
   t8.country_org_sid,
   t8.country_org_cd,
   fer.src_curr_cd AS curr_cd,
    CASE
    WHEN fer.src_curr_cd = 'EUR'
    THEN 1
    ELSE 0
    END AS curr_group_fg,
    CASE
    WHEN fer.src_curr_cd = fer.tgt_curr_cd
    THEN 1
    ELSE 0
    END AS curr_local_fg,
    t8.turnover_net_val / fer.exchange_rate AS turnover_net_val,
   t8.receipt_cnt,
    t8.turnover_py_swday_net_val / fer.exchange_rate AS turnover_py_swday_net_val,
   t8.receipt_py_swday_cnt,
   t8.last_receipt_tmsp,
    CASE
    WHEN EXTRACT(HOUR FROM t23.max_receipt_tmsp) > t8.hr
    THEN 1
    ELSE 0
    END AS is_closed_hour
  FROM fact AS t8
   INNER JOIN closed_hr AS t23 ON t8.country_org_sid = t23.country_org_sid
   INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_1 AS fer ON t8.curr_cd = fer.tgt_curr_cd
  WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
   AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
   AND fer.active_fg);