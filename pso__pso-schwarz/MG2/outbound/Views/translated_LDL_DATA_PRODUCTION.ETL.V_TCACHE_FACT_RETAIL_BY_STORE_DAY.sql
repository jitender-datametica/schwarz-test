CREATE OR REPLACE VIEW ldl_data_production_etl.v_tcache_fact_retail_by_store_day AS WITH pd AS (SELECT f.bus_dt,
   f.store_sid AS int_org_sid,
   ANY_VALUE(f.country_org_sid) AS country_org_sid,
   'STORE' AS int_org_type_cd,
   ANY_VALUE(f.country_org_cd) AS country_org_cd,
   ANY_VALUE(f.curr_cd) AS curr_cd,
   ANY_VALUE(f.uom_cd) AS uom_cd,
   SUM(f.cash_register_sales_gross_val + f.cash_register_return_gross_val) AS turnover_gross_val,
   SUM(f.cash_register_sales_net_val + f.cash_register_return_net_val) AS turnover_net_val,
   SUM(f.cash_register_sales_net_val) AS cash_register_sales_net_val,
   SUM(f.cash_register_return_net_val) AS cash_register_return_net_val,
   SUM(f.cash_register_sales_gross_val) AS cash_register_sales_gross_val,
   SUM(f.cash_register_return_gross_val) AS cash_register_return_gross_val,
   SUM(f.sales_cnt) AS sales_cnt,
   SUM(f.sales_qty) AS sales_qty,
   SUM(f.return_cnt) AS return_cnt,
   SUM(f.return_qty) AS return_qty,
   SUM(f.perf_adj_sales_cnt) AS perf_adj_sales_cnt,
   SUM(f.perf_adj_sales_qty) AS perf_adj_sales_qty,
   SUM(f.perf_adj_return_cnt) AS perf_adj_return_cnt,
   SUM(f.perf_adj_return_qty) AS perf_adj_return_qty,
   SUM(CASE
     WHEN t2.prod_variant_sid IS NOT NULL
     THEN f.cash_register_sales_gross_val + f.cash_register_return_gross_val - f.cash_register_sales_net_val - f.cash_register_return_net_val
      
     ELSE 0
     END) AS exclude_vat_val
  FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_product AS f
   LEFT JOIN (SELECT prod_variant_sid,
     dwh_valid_from_tmsp0 AS dwh_valid_from_tmsp,
     dwh_valid_to_tmsp0 AS dwh_valid_to_tmsp
    FROM (SELECT DISTINCT pv.prod_variant_sid,
       p.dwh_valid_from_tmsp AS dwh_valid_from_tmsp0,
       p.dwh_valid_to_tmsp AS dwh_valid_to_tmsp0
      FROM ldl_data_production_core_rel.t_product_variant AS pv
       INNER JOIN ldl_data_production_core_rel.t_product AS p ON pv.prod_sid = p.prod_sid AND pv.dwh_valid_fg AND p.excl_from_vat_calc_fg
        ) AS ev) AS t2 ON f.sales_variant_sid = t2.prod_variant_sid AND f.bus_dt BETWEEN CAST(t2.dwh_valid_from_tmsp AS DATE)
     AND (CAST(t2.dwh_valid_to_tmsp AS DATE))
  GROUP BY f.bus_dt,
   int_org_sid), re AS (SELECT bus_dt,
   store_sid AS int_org_sid,
   'STORE' AS int_org_type_cd,
   ANY_VALUE(country_org_cd) AS country_org_cd,
   ANY_VALUE(curr_cd) AS curr_cd,
   COUNT(*) AS cash_register_receipt_cnt
  FROM ldl_data_production_core_rel.t_retail_event AS src
  WHERE turnover_relevant_fg
   AND retail_event_type_cd = 'S'
  GROUP BY bus_dt,
   int_org_sid), ra AS (SELECT bus_dt,
   int_org_sid,
   ANY_VALUE(int_org_type_cd) AS int_org_type_cd,
   ANY_VALUE(country_org_cd) AS country_org_cd,
   ANY_VALUE(curr_cd) AS curr_cd,
   SUM(turnover_net_val) AS booked_turnover_net_val,
   SUM(receipt_cnt) AS booked_receipt_cnt
  FROM ldl_data_production_core_rel.t_revenue_accrual AS src
  WHERE curr_accrual_fg
   AND (int_org_type_cd = 'STORE' OR int_org_type_cd = 'COMPANY' AND int_org_sid = country_org_sid)
  GROUP BY int_org_sid,
   bus_dt), rs AS (SELECT bus_dt,
   store_sid AS int_org_sid,
   'STORE' AS int_org_type_cd,
   ANY_VALUE(country_org_cd) AS country_org_cd,
   ANY_VALUE(curr_cd) AS curr_cd,
   SUM(turnover_gross_val) AS eod_turnover_gross_val,
    CASE
    WHEN SUM(CASE
       WHEN turnover_net_val IS NULL
       THEN 1
       ELSE 0
       END) > 0
    THEN NULL
    ELSE SUM(turnover_net_val)
    END AS eod_turnover_net_val,
   SUM(receipt_cnt) AS eod_receipt_cnt
  FROM ldl_data_production_core_rel.t_revenue_statistics AS src
  WHERE stat_src_cd = 'WAWI'
  GROUP BY bus_dt,
   int_org_sid), plr AS (SELECT src.cal_dt AS bus_dt,
    src.int_org_sid,
    ANY_VALUE(src.int_org_type_cd) AS int_org_type_cd,
    ANY_VALUE(ctr.country_org_cd) AS country_org_cd,
    ANY_VALUE(ctr.curr_cd) AS curr_cd,
    SUM(CASE
      WHEN src.planned_val_type_sid IN (7)
      THEN src.planned_kpi_meas
      ELSE NULL
      END) AS plan_turnover_net_val,
    SUM(CASE
      WHEN src.planned_val_type_sid IN (7)
      THEN src.planned_kpi_meas
      ELSE NULL
      END) AS plan_receipt_cnt
   FROM ldl_data_production_core_rel.t_plan_by_day AS src
    INNER JOIN (SELECT party_sid,
      party_key_type_cd,
      dwh_valid_from_tmsp,
      dwh_valid_to_tmsp,
      dwh_valid_fg,
      party_nat_key_nr,
      dwh_created_tmsp,
      dwh_updated_tmsp,
      dwh_load_id,
      dwh_node_cd
     FROM ldl_data_production_meta.t_party_key
     WHERE party_key_type_cd = 'STORE'
      AND dwh_valid_fg
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY party_sid ORDER BY party_nat_key_nr IS NULL, party_nat_key_nr)) = 1) AS
    t24 ON src.int_org_sid = t24.party_sid
    INNER JOIN ldl_data_production_meta.t_party_key AS ckey ON SUBSTR(t24.party_nat_key_nr, 1, 2) = ckey.party_nat_key_nr
        AND ckey.party_key_type_cd = 'COUNTRY' AND ckey.dwh_valid_fg
    INNER JOIN ldl_data_production_core_rel.t_internal_organization AS ctr ON ckey.party_sid = ctr.int_org_sid AND src.cal_dt
      BETWEEN CAST(ctr.dwh_valid_from_tmsp AS DATE) AND (CAST(ctr.dwh_valid_to_tmsp AS DATE))
   WHERE src.planned_val_type_sid IN (7, 17)
    AND src.int_org_type_cd = 'STORE'
   GROUP BY bus_dt,
    src.int_org_sid
   UNION ALL
   SELECT src.cal_dt AS bus_dt,
    src.int_org_sid,
    ANY_VALUE(src.int_org_type_cd) AS int_org_type_cd,
    ANY_VALUE(ctr.country_org_cd) AS country_org_cd,
    ANY_VALUE(ctr.curr_cd) AS curr_cd,
    SUM(CASE
      WHEN src.planned_val_type_sid IN (5, 6)
      THEN src.planned_kpi_meas
      ELSE NULL
      END) AS plan_turnover_net_val,
    SUM(CASE
      WHEN src.planned_val_type_sid IN (5, 6)
      THEN src.planned_kpi_meas
      ELSE NULL
      END) AS plan_receipt_cnt
   FROM ldl_data_production_core_rel.t_plan_by_day AS src
    INNER JOIN (SELECT party_sid,
      party_key_type_cd,
      dwh_valid_from_tmsp,
      dwh_valid_to_tmsp,
      dwh_valid_fg,
      party_nat_key_nr,
      dwh_created_tmsp,
      dwh_updated_tmsp,
      dwh_load_id,
      dwh_node_cd
     FROM ldl_data_production_meta.t_party_key
     WHERE party_key_type_cd = 'COMPANY'
      AND dwh_valid_fg
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY party_sid ORDER BY party_nat_key_nr IS NULL, party_nat_key_nr)) = 1) AS
    t31 ON src.int_org_sid = t31.party_sid
    INNER JOIN ldl_data_production_meta.t_party_key AS ckey ON SUBSTR(t31.party_nat_key_nr, 1, 2) = ckey.party_nat_key_nr
        AND ckey.party_key_type_cd = 'COUNTRY' AND ckey.dwh_valid_fg
    INNER JOIN ldl_data_production_core_rel.t_internal_organization AS ctr ON ckey.party_sid = ctr.int_org_sid AND src.cal_dt
      BETWEEN CAST(ctr.dwh_valid_from_tmsp AS DATE) AND (CAST(ctr.dwh_valid_to_tmsp AS DATE))
   WHERE src.planned_val_type_sid IN (2, 3, 5, 6)
    AND src.int_org_type_cd = 'COMPANY'
   GROUP BY bus_dt,
    src.int_org_sid), vs AS (SELECT bus_dt,
   store_sid,
   ANY_VALUE(country_org_sid) AS country_org_sid,
   'STORE' AS int_org_type_cd,
   ANY_VALUE(country_org_cd) AS country_org_cd,
   ANY_VALUE(curr_cd) AS curr_cd,
   SUM(vat_val) AS vat_val
  FROM (SELECT *
    FROM ldl_data_production_core_rel.t_daily_vat_statistics AS src
    WHERE curr_stat_fg
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY bus_dt, store_sid, real_estate_sid, geo_area_sid, tax_class_cd ORDER BY
          vat_stat_calc_method_cd IS NULL, vat_stat_calc_method_cd)) = 1) AS t39
  GROUP BY store_sid,
   bus_dt), raf AS (SELECT dt0.cal_month,
   src3.country_org_cd,
   MAX(CASE
     WHEN src3.turnover_net_val IS NOT NULL
     THEN 'SAPHANA'
     ELSE NULL
     END) AS ra_flag
  FROM ldl_data_production_core_rel.t_revenue_accrual AS src3
   LEFT JOIN ldl_data_production_core_dim.t_dim_calendar_date AS dt0 ON src3.bus_dt = dt0.cal_dt
  GROUP BY dt0.cal_month,
   src3.country_org_cd) (/* SRC REVENUE_ACCRUAL */ /* SRC REVENUE_STATISTICS */
  /* SRC T_FACT_RETAIL_BY_STORE_DAY_PRODUCT */ /* SRC T_RETAIL_EVENT */ /* SRC PLANNED REVENUE */
  /* SRC T_DAILY_VAT_STATISTICS */
  -- , dt.CAL_YEAR                                                                                                                         AS cal_year

  -- , dt.BUS_YEAR                                                                                                                         AS bus_year

  -- , dt.CAL_MONTH                                                                                                                        AS cal_month

  SELECT COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt, t21.bus_dt, t37.bus_dt, t43.bus_dt) AS bus_dt,
   COALESCE(t6.int_org_sid, t11.int_org_sid, t16.int_org_sid, t21.int_org_sid, t37.int_org_sid, t43.store_sid) AS
   int_org_sid,
   COALESCE(t6.int_org_type_cd, t11.int_org_type_cd, t16.int_org_type_cd, t21.int_org_type_cd, t37.int_org_type_cd, t43
    .int_org_type_cd) AS int_org_type_cd,
   COALESCE(t6.country_org_cd, t11.country_org_cd, t16.country_org_cd, t21.country_org_cd, t37.country_org_cd, t43.country_org_cd
    ) AS country_org_cd,
   COALESCE(t6.curr_cd, t11.curr_cd, t16.curr_cd, t21.curr_cd, t37.curr_cd, t43.curr_cd) AS curr_cd,
    CASE
    WHEN t47.ra_flag = 'SAPHANA'
    THEN COALESCE(t16.booked_turnover_net_val, 0)
    ELSE COALESCE(t16.booked_turnover_net_val, COALESCE(t21.eod_turnover_net_val, t21.eod_turnover_gross_val - t43.vat_val
         + COALESCE(t6.exclude_vat_val, 0)), t6.turnover_net_val)
    END AS turnover_net_val,
    CASE
    WHEN t47.ra_flag = 'SAPHANA'
    THEN COALESCE(t16.booked_turnover_net_val, 0)
    ELSE t16.booked_turnover_net_val
    END AS booked_turnover_net_val,
   COALESCE(t21.eod_turnover_net_val, t21.eod_turnover_gross_val - t43.vat_val + COALESCE(t6.exclude_vat_val, 0)) AS
   eod_turnover_net_val,
   t6.cash_register_sales_net_val,
   t6.cash_register_return_net_val,
   t6.cash_register_sales_gross_val,
   t6.cash_register_return_gross_val,
   COALESCE(t21.eod_turnover_gross_val, t6.turnover_gross_val) AS turnover_gross_val,
   t21.eod_turnover_gross_val,
   COALESCE(t16.booked_receipt_cnt, t21.eod_receipt_cnt, t11.cash_register_receipt_cnt) AS receipt_cnt,
   t16.booked_receipt_cnt,
   t21.eod_receipt_cnt,
   t11.cash_register_receipt_cnt,
   t37.plan_turnover_net_val,
   t37.plan_receipt_cnt,
   t6.sales_cnt,
   t6.sales_qty,
   t6.return_cnt,
   t6.return_qty,
   t6.uom_cd,
   t6.perf_adj_sales_cnt,
   t6.perf_adj_sales_qty,
   t6.perf_adj_return_cnt,
   t6.perf_adj_return_qty,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   1 AS dwh_load_id,
   'CORE_REL' AS dwh_node_cd
  FROM pd AS t6
   FULL JOIN re AS t11 ON t6.bus_dt = t11.bus_dt AND t6.int_org_sid = t11.int_org_sid
   FULL JOIN ra AS t16 ON COALESCE(t6.bus_dt, t11.bus_dt) = t16.bus_dt AND COALESCE(t6.int_org_sid, t11.int_org_sid) =
     t16.int_org_sid
   FULL JOIN rs AS t21 ON COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt) = t21.bus_dt AND COALESCE(t6.int_org_sid, t11.int_org_sid
      , t16.int_org_sid) = t21.int_org_sid
   FULL JOIN plr AS t37 ON COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt, t21.bus_dt) = t37.bus_dt AND COALESCE(t6.int_org_sid
      , t11.int_org_sid, t16.int_org_sid, t21.int_org_sid) = t37.int_org_sid
   FULL JOIN vs AS t43 ON COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt, t21.bus_dt, t37.bus_dt) = t43.bus_dt AND COALESCE(t6
      .int_org_sid, t11.int_org_sid, t16.int_org_sid, t21.int_org_sid, t37.int_org_sid) = t43.store_sid
   LEFT JOIN ldl_data_production_core_dim.t_dim_calendar_date AS dt ON COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt, t21.bus_dt
     , t37.bus_dt, t43.bus_dt) = dt.cal_dt
   LEFT JOIN raf AS t47 ON dt.cal_month = t47.cal_month AND COALESCE(t6.country_org_cd, t11.country_org_cd, t16.country_org_cd
      , t21.country_org_cd, t37.country_org_cd, t43.country_org_cd) = t47.country_org_cd);