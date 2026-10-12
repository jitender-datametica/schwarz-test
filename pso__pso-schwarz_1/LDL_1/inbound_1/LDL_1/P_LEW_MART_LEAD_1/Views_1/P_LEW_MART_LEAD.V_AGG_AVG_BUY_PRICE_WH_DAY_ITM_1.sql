/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.1   30-06-2023   Aleksander Bialek   Adding this comment and header to the initial version which was deployed approx 15.05.2023 (Azure Devops WI:461587)
#                                        Also fixing Today reported issue with wrong currency conversion (sales_net_val without curr cnversion used to get sales_buying_diff)  
# 1.2   18.09.2023   Aleksander Bialek   Extending the view to optimize ETL performance 
#                                        (logic combining buying price with sales_1 data for longer ago than 600 days back moved to view)                                    
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW p_lew_mart_lead.v_agg_avg_buy_price_wh_day_itm_1
AS
WITH cte_agg_pos_wh_orig_itm_day 
AS (
SELECT 
    ejr.client_id
  , itm.orig_item_nr
  , itm.dat_valid_from
  , loc_sid_wh
  , ejr.dwh_cal_dt
  , QUARTER(ejr.dwh_cal_dt) dat_quarter
  , SUM(CASE WHEN discount_sid = -1 THEN sales_weight_qty+sales_piece_qty+return_qty ELSE 0 END) sales_net_qty
  , SUM((sales_net_val+return_net_val)/cry.rate_currency_exchange) sales_net_val  
  FROM p_lew_bil_ac.v_agg_pos_wh_day_item_asis_1 ejr
  INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry
  ON  ejr.client_id = cry.client_id
  AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
  INNER JOIN p_lew_mart_lead_ac.v_itm_item_1 itm
  ON ejr.client_id = itm.client_id
  AND ejr.item_sid = itm.item_id 
  WHERE ejr.dwh_cal_dt BETWEEN (SELECT MIN(cal_dt) FROM p_lew_core_ac.v_cal_calendarday_1 WHERE busyear_seq = -3) AND CURRENT_DATE()-601
  AND currency_iso_cd = 'EUR'
  GROUP BY 
    ejr.client_id
  , loc_sid_wh
  , itm.orig_item_nr
  , itm.dat_valid_from
  , ejr.dwh_cal_dt
  HAVING NULLIFZERO(sales_net_qty) IS NOT NULL 
  AND NULLIFZERO(SUM((sales_net_val+return_net_val)/cry.rate_currency_exchange)) IS NOT NULL
  ), cte_avg_buy_pric_str
AS (
SELECT 
  ejr.client_id 
, ejr.loc_sid_wh   
, ejr.orig_item_nr 
, ejr.dat_valid_from 
, ejr.dwh_cal_dt 
, sales_net_qty 
, sales_net_val
, ek_price_val
  FROM cte_agg_pos_wh_orig_itm_day ejr
  INNER JOIN p_lew_mart_lead.t_agg_avg_buy_val_qty_wh_day_itm_1 ek_prc
  ON ejr.client_id = ek_prc.client_id
  AND ejr.orig_item_nr = ek_prc.orig_item_nr
  AND ejr.dat_valid_from = ek_prc.dat_valid_from
  AND ejr.loc_sid_wh = ek_prc.loc_sid_wh
  AND ejr.dwh_cal_dt = ek_prc.dwh_cal_dt
WHERE ejr.dwh_cal_dt < CURRENT_DATE()-600
UNION ALL 
SELECT 
  client_id 
, loc_sid_wh   
, orig_item_nr 
, dat_valid_from 
, dwh_cal_dt 
, sales_net_qty 
, sales_net_val
, ek_price_val
  FROM p_lew_mart_lead.t_agg_avg_buy_price_wh_day_itm_1
WHERE dwh_cal_dt BETWEEN CURRENT_DATE()-600 AND CURRENT_DATE()
  )
, cte_curr0
AS (
SELECT
  client_id	
, currency_iso_cd	
, to_currency_iso_cd
, rate_currency_exchange	
FROM p_lew_core_ac.v_wawi_ref_client_currency_rate_1
WHERE currency_iso_cd='EUR'
AND CURRENT_DATE() BETWEEN dat_rec_start AND dat_rec_end
), cte_curr1
AS (
SELECT client_id
, 'EUR' AS currency_iso_cd
, 'EUR' AS to_currency_iso_cd
, 1.00 AS rate_currency_exchange
FROM cte_curr0
), cte_curr
AS (
SELECT
  client_id	
, currency_iso_cd	
, to_currency_iso_cd
, rate_currency_exchange
FROM cte_curr0
UNION  
SELECT
  client_id	
, currency_iso_cd	
, to_currency_iso_cd
, rate_currency_exchange
FROM cte_curr1
)
SELECT 
  we.client_id
, orig_item_nr
, dat_valid_from
, wh.src_wh_id AS wh_id
, dwh_cal_dt
, sales_net_qty
, sales_net_val * rate_currency_exchange AS sales_net_val
, ek_price_val * rate_currency_exchange AS ek_price_val
, (ek_price_val * rate_currency_exchange)*sales_net_qty buying_prc_sales_val
, (we.sales_net_val * rate_currency_exchange)-buying_prc_sales_val sales_buying_diff
, to_currency_iso_cd AS currency_iso_cd
FROM cte_avg_buy_pric_str we
JOIN p_lew_bil_ac.v_warehouse_1 wh 
ON we.client_id = wh.client_id
AND we.loc_sid_wh = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1
JOIN cte_curr curr
  ON we.client_id=curr.client_id;