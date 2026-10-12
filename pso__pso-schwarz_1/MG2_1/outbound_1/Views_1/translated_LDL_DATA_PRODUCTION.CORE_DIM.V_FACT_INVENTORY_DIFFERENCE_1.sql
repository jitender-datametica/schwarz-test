CREATE OR REPLACE VIEW ldl_data_production_core_dim.v_fact_inventory_difference_1
OPTIONS(DESCRIPTION = `CALCULATIONS OF ALL INVENTORY TURNOVERS AND INVENTORY DIFFERENCES FOR ALL STORES (ACTUAL VALUES, BUSINESS YEAR CUMULATIONS, YEAR-TO-YEAR COMPARISON AND VARIANCES FROM PLAN VALUES).`)
AS WITH limitation_time_period AS (SELECT d.cal_dt,
   d.bus_year,
   d.cal_month,
   d.cal_week,
   d.last_day_of_bus_year_fg,
   d.last_day_of_month_fg,
   d.last_day_of_week_fg,
   d.bus_year_offset,
   d.cal_dt_offset,
   m.prev_1y_cal_month AS cal_month_py,
   w.prev_1y_cal_week AS cal_week_py
  FROM ldl_data_production_core_dim.t_dim_calendar_date_1 AS d
   LEFT JOIN ldl_data_production_core_dim.t_dim_calendar_month_1 AS m USING (cal_month)
   LEFT JOIN ldl_data_production_core_dim.t_dim_calendar_week_1 AS w USING (cal_week)
  WHERE d.bus_year_offset BETWEEN - 5 AND 0
   AND d.cal_dt_offset <= 0), limitation_inventories AS (SELECT i.country_org_sid,
   i.country_org_cd,
   i.int_org_sid,
   i.int_org_type_cd,
   i.inv_sid,
   i.inv_nr,
   i.inv_dt,
   t.bus_year,
   i.inv_period_start_dt,
   i.inv_period_end_dt,
   i.inv_type_cd,
   i.inv_reason_id
  FROM ldl_data_production_core_dim.t_dim_inventory_1 AS i
   INNER JOIN limitation_time_period AS t ON i.inv_dt = t.cal_dt
  WHERE i.inv_type_cd = 'FULL'), limitation_organization AS (SELECT country_org_cd,
   int_org_sid,
   int_org_type_cd,
   curr_int_org_nr,
   int_org_name,
   dwh_valid_from_tmsp,
   dwh_valid_fg
  FROM ldl_data_production_core_dim.t_dim_internal_organization_1 AS o
  WHERE dwh_valid_fg
   AND int_org_type_cd = 'STORE'
   AND EXISTS (SELECT 1
    FROM limitation_inventories AS i
    WHERE o.int_org_sid = int_org_sid)), list_of_relevant_combinations AS (SELECT t21.country_org_cd,
   t21.int_org_sid,
   t21.int_org_type_cd,
   t21.curr_int_org_nr,
   t21.int_org_name,
   t21.cal_dt,
   t21.bus_year,
   t21.cal_month,
   t21.cal_week,
   t21.last_day_of_bus_year_fg,
   t21.last_day_of_month_fg,
   t21.last_day_of_week_fg,
   t21.cal_month_py,
   t21.cal_week_py,
   i.inv_period_start_dt,
   i.inv_period_end_dt,
   i.inv_type_cd,
   i.inv_sid,
   i.inv_nr,
   IF(i.inv_sid IS NOT NULL AND (ROW_NUMBER() OVER (PARTITION BY CAST(t21.int_org_sid AS STRING), t21.cal_dt ORDER BY i
          .inv_nr IS NULL DESC, i.inv_nr DESC)) = 1, TRUE, FALSE) AS last_inv_of_day_fg
  FROM (SELECT *
    FROM limitation_organization AS o
     INNER JOIN limitation_time_period AS t ON TRUE
    WHERE (t.last_day_of_week_fg OR t.last_day_of_month_fg OR t.last_day_of_bus_year_fg) AND EXISTS (SELECT 1
       FROM limitation_inventories AS i
       WHERE o.int_org_sid = int_org_sid
        AND t.bus_year = bus_year)
     OR EXISTS (SELECT 1
      FROM limitation_inventories AS i
      WHERE o.int_org_sid = int_org_sid
       AND t.cal_dt = inv_dt)) AS t21
   LEFT JOIN limitation_inventories AS i ON t21.int_org_sid = i.int_org_sid AND t21.cal_dt = i.inv_dt),
 facts_inventory_differences AS (SELECT d4.country_org_cd,
   d4.int_org_type_cd,
   d4.inv_sid,
   d4.inv_dt,
   d4.inv_type_cd,
   d4.curr_cd,
   d4.inv_net_val,
   d4.inv_diff_net_val,
   d4.turnover_net_val,
   d4.dwh_created_tmsp,
   d4.dwh_updated_tmsp
  FROM ldl_data_production_core_dim.t_fact_inventory_difference_1 AS d4
   INNER JOIN limitation_time_period AS t ON d4.inv_dt = t.cal_dt), fact_cumulations AS (SELECT l.country_org_cd,
   l.int_org_sid,
   l.int_org_type_cd,
   l.curr_int_org_nr,
   l.int_org_name,
   l.cal_dt,
   l.bus_year,
   l.cal_month,
   l.cal_week,
   l.last_day_of_bus_year_fg,
   l.last_day_of_month_fg,
   l.last_day_of_week_fg,
   l.last_inv_of_day_fg,
   l.cal_month_py,
   l.cal_week_py,
   l.inv_period_start_dt,
   l.inv_period_end_dt,
   l.inv_type_cd,
   l.inv_sid,
   l.inv_nr,
   d.curr_cd,
   d.inv_net_val,
   d.turnover_net_val,
   d.inv_diff_net_val,
   IF(l.inv_sid IS NOT NULL, 1, NULL) AS inv_cnt,
   IF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
    , IFNULL(SUM(d.turnover_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0), NULL) AS turnover_net_val_sum_by,
   IF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(d.turnover_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.cal_month AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0), NULL) AS turnover_net_val_sum_mth,
   IF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(d.turnover_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.cal_week AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0), NULL) AS turnover_net_val_sum_wk,
   IF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
    , IFNULL(SUM(d.inv_diff_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0), NULL) AS inv_diff_net_val_sum_by,
   IF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(d.inv_diff_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.cal_month AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0), NULL) AS inv_diff_net_val_sum_mth,
   IF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(d.inv_diff_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.cal_week AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0), NULL) AS inv_diff_net_val_sum_wk,
   IF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
    , IFNULL(SUM(IF(l.inv_sid IS NOT NULL, 1, NULL)) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0), NULL) AS inv_cnt_sum_by,
   IF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(IF(l.inv_sid IS NOT NULL, 1, NULL)) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.cal_month AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0), NULL) AS inv_cnt_sum_mth,
   IF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(IF(l.inv_sid IS NOT NULL, 1, NULL)) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.cal_week AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0), NULL) AS inv_cnt_sum_wk,
   SUM(d.turnover_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING) ORDER BY l.cal_dt
      IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_net_val_cum,
   SUM(d.inv_diff_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING) ORDER BY l.cal_dt
      IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   inv_diff_net_val_cum,
   SUM(IF(l.inv_sid IS NOT NULL, 1, NULL)) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING)
    ORDER BY l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   inv_cnt_cum,
   IF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
    , IFNULL(SUM(d.turnover_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING)
      ORDER BY l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
     , 0), NULL) AS turnover_net_val_cum_by,
   IF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(d.turnover_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING) ORDER BY
        l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 0),
    NULL) AS turnover_net_val_cum_mth,
   IF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(d.turnover_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING) ORDER BY
        l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 0),
    NULL) AS turnover_net_val_cum_wk,
   IF(l.inv_sid IS NOT NULL, IFNULL(SUM(d.turnover_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING)
        ORDER BY l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ), 0), NULL) AS turnover_net_val_cum_inv,
   IF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
    , IFNULL(SUM(d.inv_diff_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING)
      ORDER BY l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
     , 0), NULL) AS inv_diff_net_val_cum_by,
   IF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(d.inv_diff_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING) ORDER BY
        l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 0),
    NULL) AS inv_diff_net_val_cum_mth,
   IF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(d.inv_diff_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING) ORDER BY
        l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 0),
    NULL) AS inv_diff_net_val_cum_wk,
   IF(l.inv_sid IS NOT NULL, IFNULL(SUM(d.inv_diff_net_val) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING)
        ORDER BY l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ), 0), NULL) AS inv_diff_net_val_cum_inv,
   IF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
    , IFNULL(SUM(IF(l.inv_sid IS NOT NULL, 1, NULL)) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING)
        ORDER BY l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ), 0), NULL) AS inv_cnt_cum_by,
   IF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(IF(l.inv_sid IS NOT NULL, 1, NULL)) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING)
        ORDER BY l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ), 0), NULL) AS inv_cnt_cum_mth,
   IF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE),
    IFNULL(SUM(IF(l.inv_sid IS NOT NULL, 1, NULL)) OVER (PARTITION BY CAST(l.int_org_sid AS STRING), CAST(l.bus_year AS STRING)
        ORDER BY l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ), 0), NULL) AS inv_cnt_cum_wk,
   IF(l.inv_sid IS NOT NULL, IFNULL(SUM(IF(l.inv_sid IS NOT NULL, 1, NULL)) OVER (PARTITION BY CAST(l.int_org_sid AS STRING)
        , CAST(l.bus_year AS STRING) ORDER BY l.cal_dt IS NULL, l.cal_dt, l.inv_nr IS NULL, l.inv_nr ROWS BETWEEN
      UNBOUNDED PRECEDING AND CURRENT ROW), 0), NULL) AS inv_cnt_cum_inv,
   d.dwh_created_tmsp,
   d.dwh_updated_tmsp
  FROM list_of_relevant_combinations AS l
   LEFT JOIN facts_inventory_differences AS d USING (inv_sid)), fact_consolidation AS (SELECT c.country_org_cd,
   c.int_org_sid,
   c.int_org_type_cd,
   c.curr_int_org_nr,
   c.int_org_name,
   c.cal_dt,
   c.bus_year,
   c.cal_month,
   c.cal_week,
   c.last_day_of_bus_year_fg,
   c.last_day_of_month_fg,
   c.last_day_of_week_fg,
   c.last_inv_of_day_fg,
   c.cal_month_py,
   c.cal_week_py,
   c.inv_period_start_dt,
   c.inv_period_end_dt,
   c.inv_type_cd,
   c.inv_sid,
   c.inv_nr,
   c.curr_cd,
   c.inv_net_val,
   c.turnover_net_val,
   c.inv_diff_net_val,
   c.inv_cnt,
   c.turnover_net_val_sum_by,
   c.turnover_net_val_sum_mth,
   c.turnover_net_val_sum_wk,
   c.inv_diff_net_val_sum_by,
   c.inv_diff_net_val_sum_mth,
   c.inv_diff_net_val_sum_wk,
   c.inv_cnt_sum_by,
   c.inv_cnt_sum_mth,
   c.inv_cnt_sum_wk,
   c.turnover_net_val_cum_by,
   c.turnover_net_val_cum_mth,
   c.turnover_net_val_cum_wk,
   c.turnover_net_val_cum_inv,
   c.inv_diff_net_val_cum_by,
   c.inv_diff_net_val_cum_mth,
   c.inv_diff_net_val_cum_wk,
   c.inv_diff_net_val_cum_inv,
   c.inv_cnt_cum_by,
   c.inv_cnt_cum_mth,
   c.inv_cnt_cum_wk,
   c.inv_cnt_cum_inv,
   pym.turnover_net_val_sum_mth AS turnover_net_val_sum_mth_py,
   pyw.turnover_net_val_sum_wk AS turnover_net_val_sum_wk_py,
   pym.inv_diff_net_val_sum_mth AS inv_diff_net_val_sum_mth_py,
   pyw.inv_diff_net_val_sum_wk AS inv_diff_net_val_sum_wk_py,
   pym.inv_cnt_sum_mth AS inv_cnt_sum_mth_py,
   pyw.inv_cnt_sum_wk AS inv_cnt_sum_wk_py,
   pym.turnover_net_val_cum_mth AS turnover_net_val_cum_mth_py,
   pyw.turnover_net_val_cum_wk AS turnover_net_val_cum_wk_py,
   pym.inv_diff_net_val_cum_mth AS inv_diff_net_val_cum_mth_py,
   pyw.inv_diff_net_val_cum_wk AS inv_diff_net_val_cum_wk_py,
   pym.inv_cnt_cum_mth AS inv_cnt_cum_mth_py,
   pyw.inv_cnt_cum_wk AS inv_cnt_cum_wk_py,
   c.dwh_created_tmsp,
   c.dwh_updated_tmsp
  FROM fact_cumulations AS c
   LEFT JOIN fact_cumulations AS pym ON c.int_org_sid = pym.int_org_sid AND c.cal_month_py = pym.cal_month AND c.last_day_of_month_fg
        AND (c.inv_sid IS NULL OR c.last_inv_of_day_fg) AND pym.last_day_of_month_fg AND (pym.inv_sid IS NULL OR pym.last_inv_of_day_fg
      )
   LEFT JOIN fact_cumulations AS pyw ON c.int_org_sid = pyw.int_org_sid AND c.cal_week_py = pyw.cal_week AND c.last_day_of_week_fg
        AND (c.inv_sid IS NULL OR c.last_inv_of_day_fg) AND pyw.last_day_of_week_fg AND (pyw.inv_sid IS NULL OR pyw.last_inv_of_day_fg
      )) (SELECT country_org_cd,
   int_org_sid,
   int_org_type_cd,
   curr_int_org_nr,
   int_org_name,
   cal_dt,
   bus_year,
   cal_month,
   cal_week,
   last_day_of_bus_year_fg,
   last_day_of_month_fg,
   last_day_of_week_fg,
   last_inv_of_day_fg,
   cal_month_py,
   cal_week_py,
   inv_period_start_dt,
   inv_period_end_dt,
   inv_type_cd,
   inv_sid,
   inv_nr,
   curr_cd,
   inv_net_val,
   turnover_net_val AS inv_turnover_net_val,
   inv_diff_net_val,
   inv_cnt,
   turnover_net_val_sum_by AS inv_turnover_net_val_sum_by,
   turnover_net_val_sum_mth AS inv_turnover_net_val_sum_mth,
   turnover_net_val_sum_wk AS inv_turnover_net_val_sum_wk,
   inv_diff_net_val_sum_by,
   inv_diff_net_val_sum_mth,
   inv_diff_net_val_sum_wk,
   inv_cnt_sum_by,
   inv_cnt_sum_mth,
   inv_cnt_sum_wk,
   turnover_net_val_cum_by AS inv_turnover_net_val_cum_by,
   turnover_net_val_cum_mth AS inv_turnover_net_val_cum_mth,
   turnover_net_val_cum_wk AS inv_turnover_net_val_cum_wk,
   turnover_net_val_cum_inv AS inv_turnover_net_val_cum_inv,
   inv_diff_net_val_cum_by,
   inv_diff_net_val_cum_mth,
   inv_diff_net_val_cum_wk,
   inv_diff_net_val_cum_inv,
   inv_cnt_cum_by,
   inv_cnt_cum_mth,
   inv_cnt_cum_wk,
   inv_cnt_cum_inv,
   turnover_net_val_sum_mth_py AS inv_turnover_net_val_sum_mth_py,
   turnover_net_val_sum_wk_py AS inv_turnover_net_val_sum_wk_py,
   inv_diff_net_val_sum_mth_py,
   inv_diff_net_val_sum_wk_py,
   inv_cnt_sum_mth_py,
   inv_cnt_sum_wk_py,
   turnover_net_val_cum_mth_py AS inv_turnover_net_val_cum_mth_py,
   turnover_net_val_cum_wk_py AS inv_turnover_net_val_cum_wk_py,
   inv_diff_net_val_cum_mth_py,
   inv_diff_net_val_cum_wk_py,
   inv_cnt_cum_mth_py,
   inv_cnt_cum_wk_py
  FROM fact_consolidation);