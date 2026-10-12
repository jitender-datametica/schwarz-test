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
#                                        (logic combining buying price with sales_2 data for longer ago than 600 days back moved to view)                                    
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_avg_buy_price_wh_day_itm_2 AS WITH CTE_AGG_POS_WH_ORIG_ITM_DAY AS (SELECT
   EJR.client_id,
   ITM.orig_item_nr,
   ITM.dat_valid_from,
   EJR.loc_sid_wh,
   EJR.dwh_cal_dt,
   EXTRACT(QUARTER FROM EJR.dwh_cal_dt) AS dat_quarter,
   SUM(CASE
     WHEN EJR.discount_sid = - 1
     THEN EJR.sales_weight_qty + EJR.sales_piece_qty + EJR.return_qty
     ELSE 0
     END) AS sales_net_qty,
   SUM((EJR.sales_net_val + EJR.return_net_val) / CRY.rate_currency_exchange) AS sales_net_val
  FROM ldl_p_lew_bil_ac.v_agg_pos_wh_day_item_asis_2 AS EJR
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON EJR.client_id = CRY.client_id AND CURRENT_DATE
     BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_2 AS ITM ON EJR.client_id = ITM.client_id AND EJR.item_sid = ITM.item_id
  WHERE EJR.dwh_cal_dt BETWEEN (SELECT MIN(cal_dt)
     FROM ldl_p_lew_core_ac.v_cal_calendarday_2
     WHERE busyear_seq = - 3) AND (DATE_SUB(CURRENT_DATE, INTERVAL 601 DAY))
   AND CRY.currency_iso_cd = 'EUR'
  GROUP BY EJR.client_id,
   EJR.loc_sid_wh,
   ITM.orig_item_nr,
   ITM.dat_valid_from,
   EJR.dwh_cal_dt
  HAVING IF(sales_net_qty = 0, NULL, sales_net_qty) IS NOT NULL AND IF(sales_net_val = 0, NULL, sales_net_val)
   IS NOT NULL), CTE_AVG_BUY_PRIC_STR AS (SELECT ejr.client_id,
    ejr.loc_sid_wh,
    ejr.orig_item_nr,
    ejr.dat_valid_from,
    ejr.dwh_cal_dt,
    ejr.sales_net_qty,
    ejr.sales_net_val,
    EK_PRC.ek_price_val
   FROM CTE_AGG_POS_WH_ORIG_ITM_DAY AS ejr
    INNER JOIN ldl_p_lew_mart_lead.t_agg_avg_buy_val_qty_wh_day_itm_2 AS EK_PRC ON ejr.client_id = EK_PRC.client_id AND
         ejr.orig_item_nr = EK_PRC.orig_item_nr AND ejr.dat_valid_from = EK_PRC.dat_valid_from AND ejr.loc_sid_wh =
       EK_PRC.loc_sid_wh AND ejr.dwh_cal_dt = EK_PRC.dwh_cal_dt
   WHERE ejr.dwh_cal_dt < DATE_SUB(CURRENT_DATE, INTERVAL 600 DAY)
   UNION ALL
   SELECT client_id,
    loc_sid_wh,
    orig_item_nr,
    dat_valid_from,
    dwh_cal_dt,
    sales_net_qty,
    sales_net_val,
    ek_price_val
   FROM ldl_p_lew_mart_lead.t_agg_avg_buy_price_wh_day_itm_2
   WHERE dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 600 DAY) AND (CURRENT_DATE)), CTE_CURR0 AS (SELECT client_id
   ,
   currency_iso_cd,
   to_currency_iso_cd,
   rate_currency_exchange
  FROM ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2
  WHERE currency_iso_cd = 'EUR'
   AND CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end), CTE_CURR1 AS (SELECT client_id,
   'EUR' AS currency_iso_cd,
   'EUR' AS to_currency_iso_cd,
   1.00 AS rate_currency_exchange
  FROM CTE_CURR0), CTE_CURR AS (SELECT *
   FROM CTE_CURR0
   UNION DISTINCT
   SELECT *
   FROM CTE_CURR1) (SELECT we.client_id,
   we.orig_item_nr,
   we.dat_valid_from,
   WH.src_wh_id AS wh_id,
   we.dwh_cal_dt,
   we.sales_net_qty,
    we.sales_net_val * curr.rate_currency_exchange AS sales_net_val,
    we.ek_price_val * curr.rate_currency_exchange AS ek_price_val,
     we.ek_price_val * curr.rate_currency_exchange * we.sales_net_qty AS buying_prc_sales_val,
     we.sales_net_val * curr.rate_currency_exchange - we.ek_price_val * curr.rate_currency_exchange * we.sales_net_qty
   AS sales_buying_diff,
   curr.to_currency_iso_cd AS currency_iso_cd
  FROM CTE_AVG_BUY_PRIC_STR AS we
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON we.client_id = WH.client_id AND we.loc_sid_wh = WH.loc_sid_wh AND WH
     .dwh_actual_fg = 1
   INNER JOIN CTE_CURR AS curr ON we.client_id = curr.client_id);