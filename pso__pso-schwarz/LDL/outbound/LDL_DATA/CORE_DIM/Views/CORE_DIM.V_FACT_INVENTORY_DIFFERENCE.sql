/* 
This view calculates all inventory turnovers and inventory differences for all stores (actual values, business year cumulations and variances from plan values).
*/

CREATE OR REPLACE VIEW ldl_data_core_dim.v_fact_inventory_difference (country_org_cd
OPTIONS(description='The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.)'),
int_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the store or warehouse, where the inventory was done.'),
int_org_type_cd OPTIONS(description='The code identifying the discriminators for internal organizations'),
curr_int_org_nr
OPTIONS(description='The number by which the internal organization is currently known to business. (This number may change over time)'),
int_org_name OPTIONS(description='The name of the internal organization.'), cal_dt
OPTIONS(description='The date for which the inventory was done.'), bus_year
OPTIONS(description='Business year of the inventory'), cal_month OPTIONS(description='Calendar month of the inventory'),
cal_week OPTIONS(description='Calendar week of the inventory'), last_day_of_bus_year_fg
OPTIONS(description='An indicator showing if this is the last day of the containing business year.'),
last_day_of_month_fg OPTIONS(description='An indicator showing if this is the last day of the containing month.'),
last_day_of_week_fg OPTIONS(description='An indicator showing if this is the last day of the containing week.'),
last_inv_of_day_fg OPTIONS(description='An indicator showing if this is the last inventory of the day.'), cal_month_py
OPTIONS(description='Calendar month of the inventory in the previous year'), cal_week_py
OPTIONS(description='Calendar week of the inventory in the previous year'), inv_period_start_dt
OPTIONS(description='The inventory period is the business period between last full inventory and the current inventory. This attribute is the start date of this period.'),
inv_period_end_dt
OPTIONS(description='The inventory period is the business period between last full inventory and the current inventory. This attribute is the end date of this period.'),
inv_type_cd
OPTIONS(description='The code identifying the subtype discriminator for inventories. It distinguishes between full and partial inventories.'),
inv_sid OPTIONS(description='The unique identifier (surrogate key) for the inventory event.'), inv_nr
OPTIONS(description='The number which identifies the inventory event in a given country.'), curr_cd
OPTIONS(description='The code identifying the currency according to ISO-4217.'), inv_net_val
OPTIONS(description='The total value of all products which have been counted as part of the inventory process in this internal organization (i.e. store or warehouse) on the inventory date. The value is based on the net sales price that applies to this organization and and on the counted quantity. This measure is not additive across time! It is not necessarily in sync with the sum of the inventory amounts on product level.'),
inv_turnover_net_val
OPTIONS(description='The net turnover amount in the given currency which was generated in this internal organization (i.e. store or warehouse) for the inventory period. This is the consolidated amount after applying the priority logic. The turnover is the difference of sales and returns. (In case the internal organization references a warehouse, this is only that portion of the turnover which was generated directly in the warehouse. Turnover of stores which are managed by this warehouse, are not included.) The inventory period is the time interval between the last full inventory and this inventory. This measure is not necessarily in sync with the sum of the inventory turnover on product level.'),
inv_diff_net_val
OPTIONS(description='The net amount of the inventory difference, i.e. the difference between the value of the calculated stock and the counted stock. This measure is not necessarily in sync with the sum of the inventory differences on product level.'),
inv_cnt OPTIONS(description='Number of inventories for an inventory which serves as an indicator'),
inv_turnover_net_val_sum_by OPTIONS(description='The absolute sum of net turnover amount for the current business year'),
inv_turnover_net_val_sum_mth OPTIONS(description='The absolute sum of net turnover amount for the current month'),
inv_turnover_net_val_sum_wk OPTIONS(description='The absolute sum of net turnover amount for the current week'),
inv_diff_net_val_sum_by
OPTIONS(description='The absolute sum of net inventory difference amount for the current business year'),
inv_diff_net_val_sum_mth
OPTIONS(description='The absolute sum of net inventory difference amount for the current month'),
inv_diff_net_val_sum_wk OPTIONS(description='The absolute sum of net inventory difference amount for the current week'),
inv_cnt_sum_by OPTIONS(description='The absolute number of inventories for the current business year'), inv_cnt_sum_mth
OPTIONS(description='The absolute number of inventories for the current month'), inv_cnt_sum_wk
OPTIONS(description='The absolute number of inventories for the current week'), inv_turnover_net_val_cum_by
OPTIONS(description='The cumulated sum of net turnover amount for the current business year'),
inv_turnover_net_val_cum_mth OPTIONS(description='The cumulated sum of net turnover amount for the current month'),
inv_turnover_net_val_cum_wk OPTIONS(description='The cumulated sum of net turnover amount for the current week'),
inv_turnover_net_val_cum_inv
OPTIONS(description='The cumulated sum of net turnover amount for the current inventory day'), inv_diff_net_val_cum_by
OPTIONS(description='The cumulated sum of net inventory difference amount for the current business year'),
inv_diff_net_val_cum_mth
OPTIONS(description='The cumulated sum of net inventory difference amount for the current month'),
inv_diff_net_val_cum_wk OPTIONS(description='The cumulated sum of net inventory difference amount for the current week'),
inv_diff_net_val_cum_inv OPTIONS(description='The cumulated sum of net turnover amount for the current inventory day'),
inv_cnt_cum_by OPTIONS(description='The cumulated number of inventories for the current business year'), inv_cnt_cum_mth
OPTIONS(description='The cumulated number of inventories for the current month'), inv_cnt_cum_wk
OPTIONS(description='The cumulated number of inventories for the current week'), inv_cnt_cum_inv
OPTIONS(description='The cumulated number of inventories for the current inventory day'),
inv_turnover_net_val_sum_mth_py
OPTIONS(description='The absolute sum of net turnover amount for the current month of previous business year'),
inv_turnover_net_val_sum_wk_py
OPTIONS(description='The absolute sum of net turnover amount for the current week of previous business year'),
inv_diff_net_val_sum_mth_py
OPTIONS(description='The absolute sum of net inventory difference amount for the current month of previous business year'),
inv_diff_net_val_sum_wk_py
OPTIONS(description='The absolute sum of net inventory difference amount for the current week of previous business year'),
inv_cnt_sum_mth_py
OPTIONS(description='The absolute number of inventories for the current month of previous business year'),
inv_cnt_sum_wk_py
OPTIONS(description='The absolute number of inventories for the current week of previous business year'),
inv_turnover_net_val_cum_mth_py
OPTIONS(description='The cumulated sum of net turnover amount for the current month of previous business year'),
inv_turnover_net_val_cum_wk_py
OPTIONS(description='The cumulated sum of net turnover amount for the current week of previous business year'),
inv_diff_net_val_cum_mth_py
OPTIONS(description='The cumulated sum of net inventory difference amount for the current month of previous business year'),
inv_diff_net_val_cum_wk_py
OPTIONS(description='The cumulated sum of net inventory difference amount for the current week of previous business year'),
inv_cnt_cum_mth_py
OPTIONS(description='The cumulated number of inventories for the current month of previous business year'),
inv_cnt_cum_wk_py
OPTIONS(description='The cumulated number of inventories for the current week of previous business year'))
OPTIONS(DESCRIPTION = `CALCULATIONS OF ALL INVENTORY TURNOVERS AND INVENTORY DIFFERENCES FOR ALL STORES (ACTUAL VALUES, BUSINESS YEAR CUMULATIONS, YEAR-TO-YEAR COMPARISON AND VARIANCES FROM PLAN VALUES).`)
AS WITH LIMITATION_TIME_PERIOD AS (SELECT D.cal_dt,
   D.bus_year,
   D.cal_month,
   D.cal_week -- , d.prev_1y_cal_dt
,
   D.last_day_of_bus_year_fg,
   D.last_day_of_month_fg,
   D.last_day_of_week_fg,
   D.bus_year_offset,
   D.cal_dt_offset,
   M.prev_1y_cal_month AS cal_month_py,
   W.prev_1y_cal_week AS cal_week_py
  FROM ldl_data_core_dim.t_dim_calendar_date AS D
   LEFT JOIN ldl_data_core_dim.t_dim_calendar_month AS M USING (cal_month)
   LEFT JOIN ldl_data_core_dim.t_dim_calendar_week AS W USING (cal_week)
  WHERE D.bus_year_offset BETWEEN - 5 AND 0
   AND D.cal_dt_offset <= 0 -- until current day
 -- last 5 business years and current business year
),
 LIMITATION_INVENTORIES AS (SELECT I.country_org_sid,
   I.country_org_cd,
   I.int_org_sid,
   I.int_org_type_cd,
   I.inv_sid,
   I.inv_nr,
   I.inv_dt,
   t.bus_year -- needed to filter out irrelevant data later
,
   I.inv_period_start_dt -- important to differentiate between two inventories on the same day regarding time order
,
   I.inv_period_end_dt,
   I.inv_type_cd,
   I.inv_reason_id -- , dwh_created_tmsp
 -- , dwh_updated_tmsp

  FROM ldl_data_core_dim.t_dim_inventory AS I
   INNER JOIN LIMITATION_TIME_PERIOD AS t ON I.inv_dt = t.cal_dt -- PK: inv_sid

  WHERE I.inv_type_cd = 'FULL' -- inventory facts are only available for full inventories anyway
),
 LIMITATION_ORGANIZATION AS (SELECT country_org_cd -- , country_org_sid
,
   int_org_sid,
   int_org_type_cd,
   curr_int_org_nr,
   int_org_name,
   dwh_valid_from_tmsp -- , dwh_valid_to_tmsp
,
   dwh_valid_fg -- , int_org_type_descr
 -- , int_org_status_cd
 -- , iso_country_cd

  FROM ldl_data_core_dim.t_dim_internal_organization AS O
  WHERE dwh_valid_fg
   AND int_org_type_cd = 'STORE'
   AND EXISTS (SELECT 1 -- consider only stores that have an inventory at all and therefore are relevant

    FROM LIMITATION_INVENTORIES AS i
    WHERE O.int_org_sid = int_org_sid)), LIST_OF_RELEVANT_COMBINATIONS AS (SELECT t21.country_org_cd,
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
  FROM (
    SELECT o.*, t.*
    FROM LIMITATION_ORGANIZATION AS o
    INNER JOIN LIMITATION_TIME_PERIOD AS t ON TRUE
    WHERE (
      (t.last_day_of_week_fg OR t.last_day_of_month_fg OR t.last_day_of_bus_year_fg) 
      AND EXISTS (
        SELECT 1 FROM LIMITATION_INVENTORIES AS i
        WHERE o.int_org_sid = i.int_org_sid 
          AND t.bus_year = i.bus_year          
      )
    ) OR EXISTS (
      SELECT 1 FROM LIMITATION_INVENTORIES AS i
      WHERE o.int_org_sid = i.int_org_sid 
        AND t.cal_dt = i.inv_dt                
    )
  ) AS t21
   LEFT JOIN LIMITATION_INVENTORIES AS i ON t21.int_org_sid = i.int_org_sid AND t21.cal_dt = i.inv_dt
     -- considering also inventories that are conducted on the same day
), FACTS_INVENTORY_DIFFERENCES AS (SELECT D4.country_org_cd
   ,
   D4.int_org_type_cd,
   D4.inv_sid,
   D4.inv_dt,
   D4.inv_type_cd,
   D4.curr_cd -- There only is the local currency for each country.
 -- , d.calc_stock_net_val
,
   D4.inv_net_val,
   D4.inv_diff_net_val -- Inventurdifferenz
,
   D4.turnover_net_val -- Inventurumsatz
,
   D4.dwh_created_tmsp,
   D4.dwh_updated_tmsp
  FROM ldl_data_core_dim.t_fact_inventory_difference AS D4
   INNER JOIN LIMITATION_TIME_PERIOD AS t ON D4.inv_dt = t.cal_dt), FACT_CUMULATIONS AS (SELECT l.country_org_cd,
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
   d.curr_cd -- There only is the local currency for each country.
,
   d.inv_net_val,
   d.turnover_net_val -- Inventurumsatz
,
   d.inv_diff_net_val -- Inventurdifferenz
,
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
  FROM LIST_OF_RELEVANT_COMBINATIONS AS l
   LEFT JOIN FACTS_INVENTORY_DIFFERENCES AS d USING (inv_sid)), FACT_CONSOLIDATION AS (SELECT c.country_org_cd,
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
   c.turnover_net_val -- absolute value for inventory day
,
   c.inv_diff_net_val -- absolute value for inventory day
,
   c.inv_cnt -- absolute value for inventory day
,
   c.turnover_net_val_sum_by -- absolute value for year
,
   c.turnover_net_val_sum_mth -- absolute value for month
,
   c.turnover_net_val_sum_wk -- absolute value for week
,
   c.inv_diff_net_val_sum_by -- absolute value for year
,
   c.inv_diff_net_val_sum_mth -- absolute value for month
,
   c.inv_diff_net_val_sum_wk -- absolute value for week
,
   c.inv_cnt_sum_by -- absolute value for year
,
   c.inv_cnt_sum_mth -- absolute value for month
,
   c.inv_cnt_sum_wk -- absolute value for week

   -- , c.turnover_net_val_cum -- only used to calculate cumulation once for all rows

   -- , c.inv_diff_net_val_cum -- only used to calculate cumulation once for all rows

   -- , c.inv_cnt_cum -- only used to calculate cumulation once for all rows
,
   c.turnover_net_val_cum_by -- relative value for year
,
   c.turnover_net_val_cum_mth -- relative value for month
,
   c.turnover_net_val_cum_wk -- relative value for week
,
   c.turnover_net_val_cum_inv -- relative value for inventory day
,
   c.inv_diff_net_val_cum_by -- relative value for year
,
   c.inv_diff_net_val_cum_mth -- relative value for month
,
   c.inv_diff_net_val_cum_wk -- relative value for week
,
   c.inv_diff_net_val_cum_inv -- relative value for inventory day
,
   c.inv_cnt_cum_by -- relative value for year
,
   c.inv_cnt_cum_mth -- relative value for month
,
   c.inv_cnt_cum_wk -- relative value for week
,
   c.inv_cnt_cum_inv -- relative value for inventory day
,
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
  FROM FACT_CUMULATIONS AS c
   LEFT JOIN FACT_CUMULATIONS AS pym ON c.int_org_sid = pym.int_org_sid AND c.cal_month_py = pym.cal_month
         -- mapping month values from previous year
 AND c.last_day_of_month_fg AND (c.inv_sid IS NULL OR c.last_inv_of_day_fg
        ) AND pym.last_day_of_month_fg AND (pym.inv_sid IS NULL OR pym.last_inv_of_day_fg)
   LEFT JOIN FACT_CUMULATIONS AS pyw ON c.int_org_sid = pyw.int_org_sid AND c.cal_week_py = pyw.cal_week
         -- mapping week values from previous year
 AND c.last_day_of_week_fg AND (c.inv_sid IS NULL OR c.last_inv_of_day_fg
        ) AND pyw.last_day_of_week_fg AND (pyw.inv_sid IS NULL OR pyw.last_inv_of_day_fg)) (/* Preselection of relevant time period and identification of the inventory period */
  -- , m.bus_year AS bus_year_py
 -- , m.cal_month_begin_dt
 -- , m.cal_month_end_dt
 -- , w.cal_week_begin_dt

  -- , w.cal_week_end_dt
 -- PK cal_dt
 -- PK cal_month
 -- PK cal_week
 /* Preselection of all relevant inventories */
  /* Preselection of relevant stores that have an inventory */ -- PK: int_org_sid, dwh_valid_from_tmsp

  /* Definition of the overall data row level with regard to store, day and inventory if two inventories are done on the same day (FE attributes for organisation, time and inventory) */
  -- last inventory is valid if two full inventories happen on one day in a store

  -- for cumulation on week level at the end of each week
 -- for cumulation on month level at the end of each month

  -- all last days of all weeks, months and business years

  -- but excluding business years without an inventory, for example when a store has not been existing yet

  -- including days on which inventories took place
 /* Preselection of all facts regarding inventory differences */
  -- PK: inv_sid
 /* Preselection of defined planning data for inventories */
  /* planning_data AS (
	SELECT p.int_org_sid
		, p.int_org_type_cd
		--, p.real_estate_sid
		, p.cal_month
		, p.planned_val_type_sid
		--, p.plan_pos_nr
		, p.planned_kpi_meas
		, p.dwh_valid_from_tmsp
		, p.dwh_valid_to_tmsp
		, p.dwh_valid_fg
		--, p.dwh_created_tmsp
		--, p.dwh_updated_tmsp
		, pvt.planned_val_type_descr
	FROM LDL_DATA.core_rel.t_plan_by_month p -- PK: planned_val_type_sid, real_estate_sid, cal_month, int_org_sid, plan_pos_nr, dwh_valid_from_tmsp 
	JOIN LDL_DATA.core_rel.t_planned_value_type pvt 
		ON p.planned_val_type_sid = pvt.planned_val_type_sid
			AND pvt.planned_val_type_sid = 000 -- TO BE DETERMINED BECAUSE THE PLANNING VALUES ARE NOT EXISTING AT THE MOMENT!!! 
	JOIN limitation_time_period t
		USING (cal_month)
	), */
  /* Cumulation of relevant facts per business year and calculation of plan deltas using the leading possible comnbinations of store and day (organization, time and inventory) */
  /* Total sums per each year, month and week for inventory turnover, inventory difference and number of inventories */
  -- for inventory turnover
 -- for inventory difference
 -- for number of inventories

  /* Continuously cumulated value per business year for each row */
  /* Cumulated values shown only for relevant time rows of year, month, week or day of inventory */
  -- for inventory turnover
 -- for inventory difference
 -- for number of inventories

  /* Corresponding facts in the past for the inventory period of previous business year */
  -- absolute value for month py
 -- absolute value for week py
 -- absolute value for month py

  -- absolute value for week py
 -- absolute value for month py
 -- absolute value for week py

  -- relative value for month
 -- relative value for week
 -- relative value for month
 -- relative value for week

  -- relative value for month
 -- relative value for week
 /* Final columns */ -- ORDER BY country_org_cd

  -- , int_org_sid
 -- , cal_dt
 -- , inv_nr
 SELECT country_org_cd,
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
   inv_cnt_cum_wk_py -- , dwh_created_tmsp
 -- , dwh_updated_tmsp

  FROM FACT_CONSOLIDATION);

