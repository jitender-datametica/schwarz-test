CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_SUP_DELIV_LOYALTY_1
   ( client_id
    ,wh_loc_sid
    ,wh_id
    ,loc_sid_wh
    ,aspect_id
    ,sup_sid
    ,item_sid
    ,business_year
    ,cy_month
    ,week_id
    ,cal_dat    
    ,qty_total_rcv_day
    ,qty_order_day
    ,qty_total_rcv_bytd
    ,qty_order_bytd
    ,qty_total_rcv_pym
    ,qty_order_pym
    ,qty_total_rcv_pyw
    ,qty_order_pyw
    ,sum_qty_total_rcv_pybytd
    ,sum_qty_order_pybytd
   )
AS 
SELECT
  spdl.client_id
, spdl.wh_loc_sid
, spdl.wh_id
, spdl.loc_sid_wh
, spdl.aspect_id
, spdl.sup_sid
, spdl.item_sid
, spdl.business_year
, spdl.cy_month
, spdl.week_id
, spdl.cal_dat
, SUM(spdl.qty_total_rcv_day) 
, SUM(spdl.qty_order_day)
, MAX(spdl.qty_total_rcv_bytd)
, MAX(spdl.qty_order_bytd)
, SUM(spdl.qty_total_rcv_pym)
, SUM(spdl.qty_order_pym)
, SUM(spdl.qty_total_rcv_pyw)
, SUM(spdl.qty_order_pyw)
, MAX(spdl.sum_qty_total_rcv_pybytd)
, MAX(spdl.sum_qty_order_pybytd)
FROM(
    SELECT
      sdl0.client_id
    , sdl0.wh_loc_sid
    , sdl0.wh_id
    , sdl0.loc_sid_wh
    , CAST(1 AS BYTEINT)   AS aspect_id --BEGES
    , sdl0.sup_sid
    , sdl0.item_sid
    , cal.business_year
    , cal.cy_month
    , cal.week_id
    , sdl0.cal_dat
    , cal.cnt_dat_adj_increase
    , cal.month_sequence       AS month_seq
    --as is day
    , CASE WHEN cal.dup_fg = 1  THEN NULL ELSE sdl.sum_qty_total_rcv_day END   AS qty_total_rcv_day
    , CASE WHEN cal.dup_fg = 1  THEN NULL ELSE sdl.sum_qty_order         END   AS qty_order_day
    --asis cumulativ - bytd
    ,SUM(qty_total_rcv_day) Over(PARTITION BY sdl0.client_id, sdl0.wh_loc_sid, sdl0.sup_sid, sdl0.item_sid, cal.business_year
                                     ORDER BY sdl0.cal_dat, cal.cnt_dat_adj_increase ROWS BETWEEN Unbounded Preceding AND CURRENT ROW )   AS qty_total_rcv_bytd                                 
    ,SUM(qty_order_day)     Over(PARTITION BY sdl0.client_id, sdl0.wh_loc_sid, sdl0.sup_sid, sdl0.item_sid, cal.business_year
                                     ORDER BY sdl0.cal_dat, cal.cnt_dat_adj_increase ROWS BETWEEN Unbounded Preceding AND CURRENT ROW )   AS qty_order_bytd
    --py month comparision
    ,CASE WHEN cal.dup_fg_mth = 1 THEN NULL  ELSE sdlpym.sum_qty_total_rcv_day  END AS qty_total_rcv_pym
    ,CASE WHEN cal.dup_fg_mth = 1 THEN NULL  ELSE sdlpym.sum_qty_order          END AS qty_order_pym
    --py week comparison
    ,CASE WHEN cal.dup_fg = 1 THEN NULL  ELSE sdlpyw.sum_qty_total_rcv_day END AS qty_total_rcv_pyw
    ,CASE WHEN cal.dup_fg = 1 THEN NULL  ELSE sdlpyw.sum_qty_order         END AS qty_order_pyw
    --py bytd values - calculated by month comparision
    ,SUM(qty_total_rcv_pym) Over(PARTITION BY sdl0.client_id, sdl0.wh_loc_sid, sdl0.sup_sid, sdl0.item_sid, cal.business_year
                                 ORDER BY sdl0.cal_dat, cal.cnt_dat_adj_increase ROWS BETWEEN Unbounded Preceding AND CURRENT ROW )     AS sum_qty_total_rcv_pybytd        
    ,SUM(qty_order_pym )    Over(PARTITION BY sdl0.client_id, sdl0.wh_loc_sid, sdl0.sup_sid, sdl0.item_sid, cal.business_year
                                 ORDER BY sdl0.cal_dat, cal.cnt_dat_adj_increase ROWS BETWEEN Unbounded Preceding AND CURRENT ROW )     AS sum_qty_order_pybytd
    FROM (SELECT wsdl.client_id
           , wsdl.wh_loc_sid
           , loc.src_wh_id AS wh_id
           , loc.loc_sid AS loc_sid_wh
           , wsdl.sup_sid
           , wsdl.item_sid
           , pd_sdl AS cal_dat
           --, Begin(pd2_sdl) AS cal_dat
          FROM (SELECT client_id
                 , wh_loc_sid
                 , sup_sid
                 , item_sid
                 , MIN(target_deliv_date)AS pd_sdl 
               -- , PERIOD(MIN(target_deliv_date), CURRENT_DATE + 1) AS pd_sdl 
                FROM p_lew_core_ac.v_wawi_sup_deliv_loyalty_1
                GROUP BY client_id, wh_loc_sid, sup_sid, item_sid
               ) AS wsdl
          INNER JOIN p_lew_core_ac.v_location_1 loc ON loc.client_id = wsdl.client_id AND loc.loc_sid = wsdl.wh_loc_sid AND wh_store_label = 'Warehouse'
          and (wsdl.pd_sdl between (SELECT MIN(cal_Dat) FROM p_lew_mart_lead_ac.v_calendar_lead_1 WHERE byr_sequence = (-3)) and current_date)
          --EXPAND ON wsdl.pd_sdl AS pd2_sdl  -- act + last 3 business years
          --FOR PERIOD((SELECT MIN(cal_Dat) FROM p_lew_mart_lead_ac.v_calendar_lead_1 WHERE byr_sequence = (-3)), CURRENT_DATE ) 
         )  AS sdl0
        
    INNER JOIN (SELECT cld.cal_dat
                 , cld.prev1y_cmd
                 , cld.week_id
                 , cld.cy_month
                 , cld.bus_year AS business_year
                 , cld.month_sequence
                 , cld.prev1y_cwd
                 , cld.cnt_dat_adj_increase
                 , CASE WHEN ROW_NUMBER() Over(PARTITION BY cld.cal_dat,  cld.prev1y_cwd 
                                               ORDER BY cld.cnt_dat_adj_increase)              > 1 THEN 1 ELSE 0 END AS dup_fg     --to avoid double count of 28th Feb after a leap year
                 , CASE WHEN ROW_NUMBER() Over(PARTITION BY cld.cy_month, cld.prev1y_cmd 
                                               ORDER BY  cld.cal_dat,cld.cnt_dat_adj_increase) > 1 THEN 1 ELSE 0 END AS dup_fg_mth --to avoid double count of 28th Feb of previos year of a leap year
                FROM p_lew_mart_lead_ac.v_calendar_lead_1 AS cld 
                WHERE cld.cnt_dat_adj_increase_week IS NOT NULL
                AND   cld.cal_Dat              BETWEEN DATE '2015-06-01'  -- fact table contains only data since june '15
                                                   AND CURRENT_DATE
                AND   cld.byr_sequence              >= (-3)) AS cal -- max. 3 business years
     ON  sdl0.cal_dat =  cal.cal_dat     

    LEFT OUTER JOIN p_lew_core_ac.v_wawi_sup_deliv_loyalty_1 AS sdl --asis data
        ON  sdl0.cal_dat    = sdl.target_deliv_date
        AND sdl0.client_id  = sdl.client_id
        AND sdl0.wh_loc_sid = sdl.wh_loc_sid
        AND sdl0.item_sid   = sdl.item_sid
        AND sdl0.sup_sid    = sdl.sup_sid
        
    LEFT OUTER JOIN p_lew_core_ac.v_wawi_sup_deliv_loyalty_1 AS sdlpym --py month comparison data
        ON   cal.prev1y_cmd = sdlpym.target_deliv_date
        AND sdl0.client_id  = sdlpym.client_id
        AND sdl0.wh_loc_sid = sdlpym.wh_loc_sid
        AND sdl0.item_sid   = sdlpym.item_sid
        AND sdl0.sup_sid    = sdlpym.sup_sid
        
    LEFT OUTER JOIN p_lew_core_ac.v_wawi_sup_deliv_loyalty_1 AS sdlpyw --py week comparison data
        ON  cal.prev1y_cwd = sdlpyw.target_deliv_date
        AND sdl0.client_id  = sdlpyw.client_id
        AND sdl0.wh_loc_sid = sdlpyw.wh_loc_sid
        AND sdl0.item_sid   = sdlpyw.item_sid
        AND sdl0.sup_sid    = sdlpyw.sup_sid
        
    WHERE COALESCE(sdl.sup_sid, sdlpym.sup_sid, sdlpyw.sup_sid)  IS NOT NULL
    QUALIFY month_seq >= (-36) -- only 36 month / 3 complete years + the act. month
    ) AS spdl
GROUP BY  spdl.client_id
, spdl.wh_loc_sid
, spdl.wh_id
, spdl.loc_sid_wh
, spdl.aspect_id 
, spdl.sup_sid
, spdl.item_sid
, spdl.business_year
, spdl.cy_month
, spdl.week_id
, spdl.cal_dat
;