
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_inv_item_wh_sales
AS
SELECT RTL.client_id,
 RTL.src_wh_id AS wh_id,
 1 AS inv_id,
 RTL.dwh_cal_dt AS inv_start_date,
 RTL.dwh_cal_dt AS inv_end_date,
 RTL.item_sid AS item_id,
  SUM(RTL.retail_val) / CURRH.exchange_rate AS val_retail,
  SUM(RTL.retail_net_val) / CURRH.exchange_rate AS val_retail_net,
 0 AS val_return,
 0 AS val_return_net,
 CURRH.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil_ac.v_agg_item_store_day AS RTL
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist AS CURRH ON RTL.client_id = CURRH.client_id AND CURRENT_DATE
    BETWEEN CURRH.active_from_dt AND CURRH.active_to_dt AND CURRENT_DATE BETWEEN CURRH.dwh_valid_from AND CURRH.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS CURRT ON RTL.client_id = CURRT.client_id AND CURRH.x_rate_type_sid
     = CURRT.x_rate_type_sid AND CURRT.src_kurst = '@BEWE'
WHERE RTL.retail_val IS NOT NULL
 OR RTL.retail_net_val IS NOT NULL
GROUP BY RTL.client_id,
 wh_id,
 inv_start_date,
 item_id,
 CURRH.exchange_rate,
 currency_iso_cd;

