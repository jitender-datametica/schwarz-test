CREATE OR REPLACE VIEW ldl_p_lew_bil.v_stock_location_item AS SELECT client_id,
 loc_sid,
 item_sid,
 dwh_cal_dt,
 SUM(stock_calc_qty) AS stock_calc_qty,
 SUM(stock_inv_qty) AS stock_inv_qty,
 SUM(stock_real_qty) AS stock_real_qty,
 SUM(stock_inv_diff_calc) AS stock_inv_diff_calc,
 SUM(price) AS price,
 SUM(price_net) AS price_net,
 SUM(src_space_switch) AS src_space_switch,
 SUM(store_storage_qty) AS store_storage_qty,
 MAX(dwh_valid_from) AS dwh_valid_from,
 MAX(dwh_valid_to) AS dwh_valid_to
FROM (SELECT HIST.client_id,
    HIST.loc_sid,
    HIST.item_sid,
    CAL.cal_dt AS dwh_cal_dt,
    HIST.calc_qty AS stock_calc_qty,
    HIST.inv_qty AS stock_inv_qty,
     CASE
     WHEN IFNULL(HIST.diff_qty_inv_calc, 0) = 0
     THEN HIST.calc_qty
     ELSE HIST.inv_qty
     END AS stock_real_qty,
    HIST.diff_qty_inv_calc AS stock_inv_diff_calc,
    HIST.price,
    HIST.price_net,
    HIST.src_space_switch,
    CAST(NULL AS BIGNUMERIC) AS store_storage_qty,
    HIST.dwh_valid_from,
    HIST.dwh_valid_to
   FROM ldl_p_lew_core_ac.v_cal_calendarday AS CAL
    INNER JOIN ldl_p_lew_core_ac.v_item_location_stock_hist AS HIST ON CAL.cal_dt BETWEEN HIST.dwh_valid_from AND HIST.dwh_valid_to
     
   UNION ALL
   SELECT STK.client_id,
    STK.loc_sid,
    STK.item_sid,
    CAL.cal_dt AS dwh_cal_dt,
    CAST(NULL AS NUMERIC) AS stock_calc_qty,
    CAST(NULL AS NUMERIC) AS stock_inv_qty,
    CAST(NULL AS NUMERIC) AS stock_real_qty,
    CAST(NULL AS NUMERIC) AS stock_inv_diff_calc,
    CAST(NULL AS NUMERIC) AS price,
    CAST(NULL AS NUMERIC) AS price_net,
    CAST(NULL AS BIGNUMERIC) AS src_space_switch,
    STK.store_storage_qty,
    CAST(NULL AS DATE) AS dwh_valid_from,
    CAST(NULL AS DATE) AS dwh_valid_to
   FROM ldl_p_lew_core_ac.v_cal_calendarday AS CAL
    INNER JOIN ldl_p_lew_core_ac.v_item_store_storage_stock_hist AS STK ON CAL.cal_dt BETWEEN STK.dwh_valid_from AND STK
     .dwh_valid_to) AS fes
GROUP BY client_id,
 loc_sid,
 item_sid,
 dwh_cal_dt;