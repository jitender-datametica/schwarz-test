CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_fact_turnover_by_store_open_day (cal_dt
OPTIONS(description='The business date to which the measures are related.'), store_sid
OPTIONS(description='Th,e unique identifier (surrogate key) for a store.'), country_org_cd
OPTIONS(description='The code of the business country for which thIS country organizatiON IS responsible. (The business country IS not identical to a political country.)'),
store_open_fg OPTIONS(description='If the store IS open ON the given day. '), store_open_fg_bytd_cnt
OPTIONS(description='The business-year-to-date sum of store open flag'), store_open_py_fg
OPTIONS(description='If the store IS open  ON the same calendar date one year ago.'), store_open_py_fg_bytd_cnt
OPTIONS(description='The business-year-to-date sum of previous year store open flag'), store_open_py_swday_fg
OPTIONS(description='If the store IS open ON the same weekday one year ago'), store_open_py_swday_fg_bytd_cnt
OPTIONS(description='The business-year-to-date sum of previous year same week day store open flag'), turnover_net_val
OPTIONS(description='The net turnover which wAS generated for that store ON the given day. (ThIS IS the consolidated amount after applying the priority logic.)'),
turnover_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the given day. (ThIS IS the consolidated amount after applying the priority logic.)'),
turnover_py_net_val
OPTIONS(description='The net turnover which wAS generated for that store ON the same calendar date one year ago. (ThIS IS the consolidated amount after applying the priority logic.)'),
turnover_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same calendar date one year ago. (ThIS IS the consolidated amount after applying the priority logic.)'),
turnover_py_swday_net_val
OPTIONS(description='The net turnover which wAS generated for that store ON the same weekday one year ago. (ThIS IS the consolidated amount after applying the priority logic.)'),
turnover_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same weekday one year ago. (ThIS IS the consolidated amount after applying the priority logic.)'),
curr_cd OPTIONS(description='The code identifying the currency according to ISO-4217.'), curr_group_fg
OPTIONS(description='Flag for Group Currency'), curr_local_fg OPTIONS(description='Flag for Local Currency'))
OPTIONS(DESCRIPTION = `THE STORE DAY LEVEL VIEW FOR TURNOVER FOR AVERAGE TURNOVER CALCULATION PER WEEK`) AS WITH
 FACTS_WITH_FLAGS AS (SELECT F0.int_org_sid,
   F0.bus_dt,
   F0.country_org_cd,
   F0.turnover_net_val,
    CASE
    WHEN F0.bus_dt >= RE.open_dt AND F0.bus_dt <= RE.close_dt OR F0.bus_dt >= RE.open_dt AND RE.close_dt IS NULL
    THEN 1
    ELSE 0
    END AS store_open_fg
  FROM ldl_data_core_dim.t_fact_retail_by_store_day AS F0
   INNER JOIN ldl_data_core_dim.t_dim_calendar_date AS CD0 ON F0.bus_dt = CD0.cal_dt
   LEFT JOIN ldl_data_core_rel.t_internal_organization_real_estate AS IORE ON F0.int_org_sid = IORE.int_org_sid AND IORE
      .dwh_valid_from_tmsp <= CAST(F0.bus_dt AS TIMESTAMP) AND IORE.dwh_valid_to_tmsp >= CAST(F0.bus_dt AS TIMESTAMP)
     
   LEFT JOIN ldl_data_core_rel.t_real_estate AS RE ON IORE.real_estate_sid = RE.real_estate_sid AND RE.dwh_valid_from_tmsp
        <= CAST(F0.bus_dt AS TIMESTAMP) AND RE.dwh_valid_to_tmsp >= CAST(F0.bus_dt AS TIMESTAMP)
       AND RE.real_estate_type_cd = 'STORE'), PY_FWF AS (SELECT fwf.int_org_sid,
   PY.cal_dt AS bus_dt,
   PY.cal_dt_adjust_type_cd,
   fwf.country_org_cd,
   SUM(fwf.turnover_net_val) AS turnover_net_val,
   MAX(fwf.store_open_fg) AS store_open_fg
  FROM ldl_data_core_rel.t_cal_date_adjusted_relationship AS PY
   INNER JOIN FACTS_WITH_FLAGS AS fwf ON PY.rel_cal_dt = fwf.bus_dt
  WHERE PY.bus_year_diff = 1
   AND PY.cal_dt_adjust_type_cd IN ('M', 'W', 'WC', 'MC')
   AND PY.cal_dt < CURRENT_DATE
  GROUP BY fwf.int_org_sid,
   bus_dt,
   PY.cal_dt_adjust_type_cd,
   fwf.country_org_cd) (SELECT fwf.bus_dt AS cal_dt,
   fwf.int_org_sid AS store_sid,
   fwf.country_org_cd,
   fwf.store_open_fg,
   SUM(fwf.store_open_fg) OVER (PARTITION BY CAST(F.int_org_sid AS STRING), CAST(CD.bus_year AS STRING), F.country_org_cd
      ORDER BY F.bus_dt IS NULL, F.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS store_open_fg_bytd_cnt,
   py_m.store_open_fg AS store_open_py_fg,
   SUM(py_mc.store_open_fg) OVER (PARTITION BY CAST(F.int_org_sid AS STRING), CAST(CD.bus_year AS STRING), F.country_org_cd
      ORDER BY F.bus_dt IS NULL, F.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS store_open_py_fg_bytd_cnt
   ,
   py_w.store_open_fg AS store_open_py_swday_fg,
   SUM(py_wc.store_open_fg) OVER (PARTITION BY CAST(F.int_org_sid AS STRING), CAST(CD.bus_year AS STRING), F.country_org_cd
      ORDER BY F.bus_dt IS NULL, F.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   store_open_py_swday_fg_bytd_cnt,
    CASE
    WHEN fwf.store_open_fg <> 0 AND F.turnover_net_val > 0
    THEN F.turnover_net_val / FER.exchange_rate
    ELSE NULL
    END AS pstv_turnover_net_val,
   SUM(CASE
     WHEN fwf.store_open_fg <> 0 AND F.turnover_net_val > 0
     THEN F.turnover_net_val / FER.exchange_rate
     ELSE NULL
     END) OVER (PARTITION BY CAST(F.int_org_sid AS STRING), CAST(CD.bus_year AS STRING), F.country_org_cd ORDER BY F.bus_dt
      IS NULL, F.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS pstv_turnover_bytd_net_val,
    CASE
    WHEN py_m.store_open_fg <> 0 AND py_m.turnover_net_val > 0
    THEN py_m.turnover_net_val / FER.exchange_rate
    ELSE NULL
    END AS pstv_turnover_py_net_val,
   SUM(CASE
     WHEN py_mc.store_open_fg <> 0 OR py_mc.store_open_fg IS NULL
     THEN GREATEST(py_mc.turnover_net_val / FER.exchange_rate, 0)
     ELSE 0
     END) OVER (PARTITION BY CAST(F.int_org_sid AS STRING), CAST(CD.bus_year AS STRING), F.country_org_cd ORDER BY F.bus_dt
      IS NULL, F.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS pstv_turnover_py_bytd_net_val,
    CASE
    WHEN py_w.store_open_fg <> 0 AND py_w.turnover_net_val > 0
    THEN py_w.turnover_net_val / FER.exchange_rate
    ELSE NULL
    END AS pstv_turnover_py_swday_net_val,
   SUM(CASE
     WHEN py_wc.store_open_fg <> 0 OR py_wc.store_open_fg IS NULL
     THEN GREATEST(py_wc.turnover_net_val / FER.exchange_rate, 0)
     ELSE 0
     END) OVER (PARTITION BY CAST(F.int_org_sid AS STRING), CAST(CD.bus_year AS STRING), F.country_org_cd ORDER BY F.bus_dt
      IS NULL, F.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS pstv_turnover_py_swday_bytd_net_val,
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
    END AS curr_local_fg
  FROM ldl_data_core_dim.t_fact_retail_by_store_day AS F
   INNER JOIN ldl_data_core_dim.t_dim_calendar_date AS CD ON F.bus_dt = CD.cal_dt
   INNER JOIN FACTS_WITH_FLAGS AS fwf ON F.bus_dt = fwf.bus_dt AND F.int_org_sid = fwf.int_org_sid AND F.country_org_cd
     = fwf.country_org_cd
   LEFT JOIN PY_FWF AS py_m ON fwf.int_org_sid = py_m.int_org_sid AND fwf.bus_dt = py_m.bus_dt AND py_m.cal_dt_adjust_type_cd
       = 'M' AND fwf.country_org_cd = py_m.country_org_cd
   LEFT JOIN PY_FWF AS py_mc ON fwf.int_org_sid = py_mc.int_org_sid AND fwf.bus_dt = py_mc.bus_dt AND py_mc.cal_dt_adjust_type_cd
       = 'MC' AND py_m.country_org_cd = fwf.country_org_cd
   LEFT JOIN PY_FWF AS py_w ON fwf.int_org_sid = py_w.int_org_sid AND fwf.bus_dt = py_w.bus_dt AND py_w.cal_dt_adjust_type_cd
       = 'W' AND fwf.country_org_cd = py_w.country_org_cd
   LEFT JOIN PY_FWF AS py_wc ON fwf.int_org_sid = py_wc.int_org_sid AND fwf.bus_dt = py_wc.bus_dt AND py_wc.cal_dt_adjust_type_cd
       = 'WC' AND fwf.country_org_cd = py_wc.country_org_cd
   INNER JOIN ldl_data_core_dim.t_fact_exchange_rate AS FER ON F.curr_cd = FER.tgt_curr_cd
  WHERE FER.exchange_rate_type_cd = 'BEW_ISK'
   AND (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd)
   AND FER.active_fg);