CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_EJR_RECEIPTHEADER
(
    client_id
    , store_id
    , header_collection
    , pos_terminal_id
    , time_receipt_ejr
    , time_halfhour_id
    , time_hour_id
    , receipt_for_count_id
    , orig_receipt_nr_ejr
    , orig_receipt_serial_nr_ejr
    , timezone_cd
    , dat_dayend
    , dat_formdate
    , checker_id
    , transactiontype_id
    , cnt_receiptline_ejr
    , cnt_selling_position_ejr
    , cnt_discount_ejr
    , cnt_deposit_ejr
    , cnt_return_ejr
    , cnt_void_ejr
    , cnt_ean_ejr
    , cnt_item_ejr
    , cnt_item_weight_ejr
    , cnt_mainitemgroup_ejr
    , qty_piece_ejr
    , val_retail_ejr
    , val_retail_net_ejr
    , val_retail_pos_ejr
    , val_retail_net_pos_ejr
    , val_deposit_ejr
    , val_deposit_net_ejr
    , val_discount_ejr
    , val_discount_net_ejr
    , resumed_trans_store_id_ejr
    , resumed_trans_terminal_id_ejr
    , resumed_trans_date_ejr
    , resumed_trans_receipt_nr_ejr
    , dur_service_time_ejr
    , dur_pay_change_time_ejr
    , timestamp_begin_ejr
    , timestamp_end_ejr
    , currency_iso_cd
    , customer_nr
    , lidlplus_customer_cd
    , lidlplus_ident_type_cd
)
AS
   SELECT
   r.client_id
   , r.loc_sid AS store_id
   , 1 AS header_collection
   , r.register_id AS pos_terminal_id
   , Cast(SUBSTRING(Cast(Cast(receipt_tmsp AS TIME(6)) AS VARCHAR(30)), 1, 8) AS TIME(0)) AS time_receipt_ejr
   , (Extract(HOUR From time_receipt_ejr)*100 + (CASE WHEN (Extract(MINUTE From (time_receipt_ejr)) < 30) THEN 0 ELSE 30 END)) AS time_halfhour_id
   , EXTRACT(HOUR FROM time_receipt_ejr)  time_hour_id
   , Cast(r.client_id AS VARCHAR(6)) || Cast(r.loc_sid AS VARCHAR(11)) || Cast(r.register_id AS VARCHAR(6)) || Cast(r.receipt_id AS VARCHAR(6)) || Cast(r.receipt_dt AS VARCHAR(11)) || SUBSTRING(Cast(time_receipt_ejr AS VARCHAR(20)), 1, 8) AS receipt_for_count_id
   , r.receipt_id AS orig_receipt_nr_ejr
   , -9 AS orig_receipt_serial_nr_ejr -- receiptheader: orig_receipt_serial_nr_ejr 99,99% haben den Wert -9
   , r.timezone_id AS timezone_cd
   , r.dwh_cal_dt AS dat_dayend
   , r.dwh_cal_dt AS dat_formdate
   , r.cashier_id AS checker_id
   , r.transaction_type_cd AS transactiontype_id
   , r.cnt_receiptlines_total AS cnt_receiptline_ejr
   , r.cnt_receiptlines_sales AS cnt_selling_position_ejr
   , r.cnt_receiptlines_discounts AS cnt_discount_ejr
   , r.cnt_receiptlines_deposits AS cnt_deposit_ejr
   , r.cnt_receiptlines_returns AS cnt_return_ejr
   , r.cnt_receiptlines_voids AS cnt_void_ejr
   , r.cnt_distinct_eans AS cnt_ean_ejr
   , r.cnt_distinct_items AS cnt_item_ejr
   , r.cnt_distinct_weight_items AS cnt_item_weight_ejr
   , r.cnt_distinct_item_grp_ints AS cnt_mainitemgroup_ejr
   , r.cnt_piece_qty AS qty_piece_ejr
   , r.total_gross_val / cry.rate_currency_exchange AS val_retail_ejr
   , r.total_net_val / cry.rate_currency_exchange AS val_retail_net_ejr
   , r.sales_gross_val / cry.rate_currency_exchange AS val_retail_pos_ejr
   , r.sales_net_val / cry.rate_currency_exchange AS val_retail_net_pos_ejr
   , r.deposit_gross_val / cry.rate_currency_exchange AS val_deposit_ejr
   , r.deposit_net_val / cry.rate_currency_exchange AS val_deposit_net_ejr
   , r.discount_gross_val / cry.rate_currency_exchange AS val_discount_ejr
   , r.discount_net_val / cry.rate_currency_exchange AS val_discount_net_ejr
   , r.resumed_receipt_store_id AS resumed_trans_store_id_ejr
   , r.resumed_receipt_register_id AS resumed_trans_terminal_id_ejr
   , r.resumed_receipt_dt AS resumed_trans_date_ejr
   , r.resumed_receipt_id AS resumed_trans_receipt_nr_ejr
   , r.dur_item_scan AS dur_service_time_ejr
   , r.dur_payment AS dur_pay_change_time_ejr
   , Cast(SUBSTRING(Cast(transaction_begin_tmsp AS VARCHAR(50)), 1, 19) AS TIMESTAMP) AS timestamp_begin_ejr
   , Cast(SUBSTRING(Cast(transaction_end_tmsp AS VARCHAR(50)), 1, 19) AS TIMESTAMP) AS timestamp_end_ejr
   , cry.currency_iso_cd
   , r.customer_cd AS customer_nr
   , r.lidlplus_customer_cd AS lidlplus_customer_cd
   , r.lidlplus_ident_type_cd AS lidlplus_ident_type_cd
   FROM p_lew_core_ac.v_pos_receiptheader AS r
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
      ON r.client_id = cry.client_id
      AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end
   WHERE r.turnover_relevant_fg = 1
;