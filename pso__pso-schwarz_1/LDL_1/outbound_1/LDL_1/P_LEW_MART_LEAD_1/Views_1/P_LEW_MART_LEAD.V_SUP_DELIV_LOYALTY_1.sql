CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_sup_deliv_loyalty_1 (client_id, wh_loc_sid, wh_id, loc_sid_wh, aspect_id,
sup_sid, item_sid, business_year, cy_month, week_id, cal_dat, qty_total_rcv_day, qty_order_day, qty_total_rcv_bytd,
qty_order_bytd, qty_total_rcv_pym, qty_order_pym, qty_total_rcv_pyw, qty_order_pyw, sum_qty_total_rcv_pybytd,
sum_qty_order_pybytd) AS -- BEGES
 -- as is day
 -- asis cumulativ - bytd
 -- py month comparision

-- py week comparison
 -- py bytd values - calculated by month comparision
 -- , Begin(pd2_sdl) AS cal_dat

-- , PERIOD(MIN(target_deliv_date), CURRENT_DATE + 1) AS pd_sdl

-- EXPAND ON wsdl.pd_sdl AS pd2_sdl  -- act + last 3 business years

-- FOR PERIOD((SELECT MIN(cal_Dat) FROM LDL.p_lew_mart_lead_ac.v_calendar_lead_1 WHERE byr_sequence = (-3)), CURRENT_DATE )

-- to avoid double count of 28th Feb after a leap year

-- to avoid double count of 28th Feb of previos year of a leap year
 -- max. 3 business years

-- only 36 month / 3 complete years + the act. month
 SELECT client_id,
 wh_loc_sid,
 wh_id,
 loc_sid_wh,
 aspect_id,
 sup_sid,
 item_sid,
 business_year,
 cy_month,
 week_id,
 cal_dat,
 SUM(qty_total_rcv_day) AS qty_total_rcv_day,
 SUM(qty_order_day) AS qty_order_day,
 MAX(qty_total_rcv_bytd) AS qty_total_rcv_bytd,
 MAX(qty_order_bytd) AS qty_order_bytd,
 SUM(qty_total_rcv_pym) AS qty_total_rcv_pym,
 SUM(qty_order_pym) AS qty_order_pym,
 SUM(qty_total_rcv_pyw) AS qty_total_rcv_pyw,
 SUM(qty_order_pyw) AS qty_order_pyw,
 MAX(sum_qty_total_rcv_pybytd) AS sum_qty_total_rcv_pybytd,
 MAX(sum_qty_order_pybytd) AS sum_qty_order_pybytd
FROM (SELECT sdl0.client_id,
   sdl0.wh_loc_sid,
   sdl0.wh_id,
   sdl0.loc_sid_wh,
   1 AS aspect_id,
   sdl0.sup_sid,
   sdl0.item_sid,
   cal.business_year,
   cal.cy_month,
   cal.week_id,
   sdl0.cal_dat,
   cal.cnt_dat_adj_increase,
   cal.month_sequence AS month_seq,
    CASE
    WHEN cal.dup_fg = 1
    THEN NULL
    ELSE SDL.sum_qty_total_rcv_day
    END AS qty_total_rcv_day,
    CASE
    WHEN cal.dup_fg = 1
    THEN NULL
    ELSE SDL.sum_qty_order
    END AS qty_order_day,
   SUM(CASE
     WHEN cal.dup_fg = 1
     THEN NULL
     ELSE SDL.sum_qty_total_rcv_day
     END) OVER (PARTITION BY CAST(sdl0.client_id AS STRING), CAST(sdl0.wh_loc_sid AS STRING), CAST(sdl0.sup_sid AS STRING)
      , CAST(sdl0.item_sid AS STRING), CAST(cal.business_year AS STRING) ORDER BY sdl0.cal_dat IS NULL, sdl0.cal_dat,
      cal.cnt_dat_adj_increase IS NULL, cal.cnt_dat_adj_increase ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   qty_total_rcv_bytd,
   SUM(CASE
     WHEN cal.dup_fg = 1
     THEN NULL
     ELSE SDL.sum_qty_order
     END) OVER (PARTITION BY CAST(sdl0.client_id AS STRING), CAST(sdl0.wh_loc_sid AS STRING), CAST(sdl0.sup_sid AS STRING)
      , CAST(sdl0.item_sid AS STRING), CAST(cal.business_year AS STRING) ORDER BY sdl0.cal_dat IS NULL, sdl0.cal_dat,
      cal.cnt_dat_adj_increase IS NULL, cal.cnt_dat_adj_increase ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   qty_order_bytd,
    CASE
    WHEN cal.dup_fg_mth = 1
    THEN NULL
    ELSE SDLPYM.sum_qty_total_rcv_day
    END AS qty_total_rcv_pym,
    CASE
    WHEN cal.dup_fg_mth = 1
    THEN NULL
    ELSE SDLPYM.sum_qty_order
    END AS qty_order_pym,
    CASE
    WHEN cal.dup_fg = 1
    THEN NULL
    ELSE SDLPYW.sum_qty_total_rcv_day
    END AS qty_total_rcv_pyw,
    CASE
    WHEN cal.dup_fg = 1
    THEN NULL
    ELSE SDLPYW.sum_qty_order
    END AS qty_order_pyw,
   SUM(CASE
     WHEN cal.dup_fg_mth = 1
     THEN NULL
     ELSE SDLPYM.sum_qty_total_rcv_day
     END) OVER (PARTITION BY CAST(sdl0.client_id AS STRING), CAST(sdl0.wh_loc_sid AS STRING), CAST(sdl0.sup_sid AS STRING)
      , CAST(sdl0.item_sid AS STRING), CAST(cal.business_year AS STRING) ORDER BY sdl0.cal_dat IS NULL, sdl0.cal_dat,
      cal.cnt_dat_adj_increase IS NULL, cal.cnt_dat_adj_increase ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   sum_qty_total_rcv_pybytd,
   SUM(CASE
     WHEN cal.dup_fg_mth = 1
     THEN NULL
     ELSE SDLPYM.sum_qty_order
     END) OVER (PARTITION BY CAST(sdl0.client_id AS STRING), CAST(sdl0.wh_loc_sid AS STRING), CAST(sdl0.sup_sid AS STRING)
      , CAST(sdl0.item_sid AS STRING), CAST(cal.business_year AS STRING) ORDER BY sdl0.cal_dat IS NULL, sdl0.cal_dat,
      cal.cnt_dat_adj_increase IS NULL, cal.cnt_dat_adj_increase ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   sum_qty_order_pybytd
  FROM (SELECT t5.client_id,
     t5.wh_loc_sid,
     LOC.src_wh_id AS wh_id,
     LOC.loc_sid AS loc_sid_wh,
     t5.sup_sid,
     t5.item_sid,
     t5.pd_sdl AS cal_dat
    FROM (SELECT *
      FROM (SELECT client_id,
         wh_loc_sid,
         sup_sid,
         item_sid,
         MIN(target_deliv_date) AS pd_sdl
        FROM ldl_p_lew_core_ac.v_wawi_sup_deliv_loyalty_1
        GROUP BY sup_sid,
         item_sid,
         client_id,
         wh_loc_sid) AS wsdl
      WHERE pd_sdl BETWEEN (SELECT MIN(cal_dat)
         FROM ldl_p_lew_mart_lead_ac.v_calendar_lead_1
         WHERE byr_sequence = - 3) AND (CURRENT_DATE)) AS t5
     INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON TRUE
    WHERE LOC.client_id = t5.client_id
     AND LOC.loc_sid = t5.wh_loc_sid
     AND LOC.wh_store_label = 'Warehouse') AS sdl0
   INNER JOIN (SELECT cal_dat,
     prev1y_cmd,
     week_id,
     cy_month,
     bus_year AS business_year,
     month_sequence,
     prev1y_cwd,
     cnt_dat_adj_increase,
      CASE
      WHEN (ROW_NUMBER() OVER (PARTITION BY cal_dat, prev1y_cwd ORDER BY cnt_dat_adj_increase IS NULL,
           cnt_dat_adj_increase)) > 1
      THEN 1
      ELSE 0
      END AS dup_fg,
      CASE
      WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(cy_month AS STRING), prev1y_cmd ORDER BY cal_dat IS NULL, cal_dat,
           cnt_dat_adj_increase IS NULL, cnt_dat_adj_increase)) > 1
      THEN 1
      ELSE 0
      END AS dup_fg_mth
    FROM ldl_p_lew_mart_lead_ac.v_calendar_lead_1 AS CLD
    WHERE cnt_dat_adj_increase_week IS NOT NULL
     AND cal_dat BETWEEN DATE '2015-06-01' -- fact table contains only data since june '15
 AND (CURRENT_DATE)
     AND byr_sequence >= - 3) AS cal ON sdl0.cal_dat = cal.cal_dat
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_sup_deliv_loyalty_1 AS SDL ON sdl0.cal_dat = SDL.target_deliv_date AND sdl0.client_id
         = SDL.client_id AND sdl0.wh_loc_sid = SDL.wh_loc_sid AND sdl0.item_sid = SDL.item_sid AND sdl0.sup_sid = SDL.sup_sid
     -- asis data

   LEFT JOIN ldl_p_lew_core_ac.v_wawi_sup_deliv_loyalty_1 AS SDLPYM ON cal.prev1y_cmd = SDLPYM.target_deliv_date AND sdl0
        .client_id = SDLPYM.client_id AND sdl0.wh_loc_sid = SDLPYM.wh_loc_sid AND sdl0.item_sid = SDLPYM.item_sid AND
     sdl0.sup_sid = SDLPYM.sup_sid -- py month comparison data

   LEFT JOIN ldl_p_lew_core_ac.v_wawi_sup_deliv_loyalty_1 AS SDLPYW ON cal.prev1y_cwd = SDLPYW.target_deliv_date AND sdl0
        .client_id = SDLPYW.client_id AND sdl0.wh_loc_sid = SDLPYW.wh_loc_sid AND sdl0.item_sid = SDLPYW.item_sid AND
     sdl0.sup_sid = SDLPYW.sup_sid -- py week comparison data

  WHERE COALESCE(SDL.sup_sid, SDLPYM.sup_sid, SDLPYW.sup_sid) IS NOT NULL) AS t11
WHERE t11.month_seq >= - 36
GROUP BY client_id,
 wh_loc_sid,
 wh_id,
 loc_sid_wh,
 aspect_id,
 sup_sid,
 item_sid,
 business_year,
 cy_month,
 week_id,
 cal_dat;