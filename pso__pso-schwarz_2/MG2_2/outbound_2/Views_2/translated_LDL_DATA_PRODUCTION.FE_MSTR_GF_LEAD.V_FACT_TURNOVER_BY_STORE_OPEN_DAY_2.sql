CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_turnover_by_store_open_day_2 AS WITH facts_with_flags AS
  (SELECT f0.int_org_sid,
   f0.bus_dt,
   f0.country_org_cd,
   f0.turnover_net_val,
    CASE
    WHEN f0.bus_dt >= re.open_dt AND f0.bus_dt <= re.close_dt OR f0.bus_dt >= re.open_dt AND re.close_dt IS NULL
    THEN 1
    ELSE 0
    END AS store_open_fg
  FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_2 AS f0
   INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date_2 AS cd0 ON f0.bus_dt = cd0.cal_dt
   LEFT JOIN ldl_data_production_core_rel.t_internal_organization_real_estate_2 AS iore ON f0.int_org_sid = iore.int_org_sid
       AND iore.dwh_valid_from_tmsp <= CAST(f0.bus_dt AS TIMESTAMP) AND iore.dwh_valid_to_tmsp >= CAST(f0.bus_dt AS TIMESTAMP)
     
   LEFT JOIN ldl_data_production_core_rel.t_real_estate_2 AS re_2 ON iore.real_estate_sid = re.real_estate_sid AND re.dwh_valid_from_tmsp
        <= CAST(f0.bus_dt AS TIMESTAMP) AND re.dwh_valid_to_tmsp >= CAST(f0.bus_dt AS TIMESTAMP)
       AND re.real_estate_type_cd = 'STORE'), py_fwf AS (SELECT fwf.int_org_sid,
   py.cal_dt AS bus_dt,
   py.cal_dt_adjust_type_cd,
   fwf.country_org_cd,
   SUM(fwf.turnover_net_val) AS turnover_net_val,
   MAX(fwf.store_open_fg) AS store_open_fg
  FROM ldl_data_production_core_rel.t_cal_date_adjusted_relationship_2 AS py
   INNER JOIN facts_with_flags AS fwf ON py.rel_cal_dt = fwf.bus_dt
  WHERE py.bus_year_diff = 1
   AND py.cal_dt_adjust_type_cd IN ('M', 'W', 'WC', 'MC')
   AND py.cal_dt < CURRENT_DATE
  GROUP BY fwf.int_org_sid,
   bus_dt,
   py.cal_dt_adjust_type_cd,
   fwf.country_org_cd) (SELECT fwf.bus_dt AS cal_dt,
   fwf.int_org_sid AS store_sid,
   fwf.country_org_cd,
   fwf.store_open_fg,
   SUM(fwf.store_open_fg) OVER (PARTITION BY f.int_org_sid, CAST(cd.bus_year AS STRING), f.country_org_cd ORDER BY f.bus_dt
      IS NULL, f.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS store_open_fg_bytd_cnt,
   py_m.store_open_fg AS store_open_py_fg,
   SUM(py_mc.store_open_fg) OVER (PARTITION BY f.int_org_sid, CAST(cd.bus_year AS STRING), f.country_org_cd ORDER BY f.bus_dt
      IS NULL, f.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS store_open_py_fg_bytd_cnt,
   py_w.store_open_fg AS store_open_py_swday_fg,
   SUM(py_wc.store_open_fg) OVER (PARTITION BY f.int_org_sid, CAST(cd.bus_year AS STRING), f.country_org_cd ORDER BY f.bus_dt
      IS NULL, f.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS store_open_py_swday_fg_bytd_cnt,
    CASE
    WHEN fwf.store_open_fg <> 0 AND f.turnover_net_val > 0
    THEN f.turnover_net_val / fer.exchange_rate
    ELSE NULL
    END AS pstv_turnover_net_val,
   SUM(CASE
     WHEN fwf.store_open_fg <> 0 AND f.turnover_net_val > 0
     THEN f.turnover_net_val / fer.exchange_rate
     ELSE NULL
     END) OVER (PARTITION BY f.int_org_sid, CAST(cd.bus_year AS STRING), f.country_org_cd ORDER BY f.bus_dt IS NULL, f.bus_dt
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS pstv_turnover_bytd_net_val,
    CASE
    WHEN py_m.store_open_fg <> 0 AND py_m.turnover_net_val > 0
    THEN py_m.turnover_net_val / fer.exchange_rate
    ELSE NULL
    END AS pstv_turnover_py_net_val,
   SUM(CASE
     WHEN py_mc.store_open_fg <> 0 OR py_mc.store_open_fg IS NULL
     THEN GREATEST(py_mc.turnover_net_val / fer.exchange_rate, 0)
     ELSE 0
     END) OVER (PARTITION BY f.int_org_sid, CAST(cd.bus_year AS STRING), f.country_org_cd ORDER BY f.bus_dt IS NULL, f.bus_dt
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS pstv_turnover_py_bytd_net_val,
    CASE
    WHEN py_w.store_open_fg <> 0 AND py_w.turnover_net_val > 0
    THEN py_w.turnover_net_val / fer.exchange_rate
    ELSE NULL
    END AS pstv_turnover_py_swday_net_val,
   SUM(CASE
     WHEN py_wc.store_open_fg <> 0 OR py_wc.store_open_fg IS NULL
     THEN GREATEST(py_wc.turnover_net_val / fer.exchange_rate, 0)
     ELSE 0
     END) OVER (PARTITION BY f.int_org_sid, CAST(cd.bus_year AS STRING), f.country_org_cd ORDER BY f.bus_dt IS NULL, f.bus_dt
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS pstv_turnover_py_swday_bytd_net_val,
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
    END AS curr_local_fg
  FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_2 AS f
   INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date_2 AS cd ON f.bus_dt = cd.cal_dt
   INNER JOIN facts_with_flags AS fwf ON f.bus_dt = fwf.bus_dt AND f.int_org_sid = fwf.int_org_sid AND f.country_org_cd
     = fwf.country_org_cd
   LEFT JOIN py_fwf AS py_m ON fwf.int_org_sid = py_m.int_org_sid AND fwf.bus_dt = py_m.bus_dt AND py_m.cal_dt_adjust_type_cd
       = 'M' AND fwf.country_org_cd = py_m.country_org_cd
   LEFT JOIN py_fwf AS py_mc ON fwf.int_org_sid = py_mc.int_org_sid AND fwf.bus_dt = py_mc.bus_dt AND py_mc.cal_dt_adjust_type_cd
       = 'MC' AND py_m.country_org_cd = fwf.country_org_cd
   LEFT JOIN py_fwf AS py_w ON fwf.int_org_sid = py_w.int_org_sid AND fwf.bus_dt = py_w.bus_dt AND py_w.cal_dt_adjust_type_cd
       = 'W' AND fwf.country_org_cd = py_w.country_org_cd
   LEFT JOIN py_fwf AS py_wc ON fwf.int_org_sid = py_wc.int_org_sid AND fwf.bus_dt = py_wc.bus_dt AND py_wc.cal_dt_adjust_type_cd
       = 'WC' AND fwf.country_org_cd = py_wc.country_org_cd
   INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer ON f.curr_cd = fer.tgt_curr_cd
  WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
   AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
   AND fer.active_fg);