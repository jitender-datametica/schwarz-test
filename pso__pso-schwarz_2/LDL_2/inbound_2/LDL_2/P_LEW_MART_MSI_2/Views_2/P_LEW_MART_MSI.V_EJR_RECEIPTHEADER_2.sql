/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_RECEIPTHEADER_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  ----
#DescStart#	
#$Revision: 8540 $, $LastChangedBy: cmarose $	
#SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
#DescEnd#	
#
#  1.1  27.06.2024    Marcin Malec              Filtering out live and future data; User Story 641977: [BE] - Umsatz EJR (1104001.02) is showing live data
#
#----------------------------------------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_RECEIPTHEADER_2
AS
    SELECT	
     r.client_id	
    ,r.loc_sid AS store_id	
    ,1 AS header_collection	
    ,r.register_id AS pos_terminal_id	
    ,CAST(SUBSTRING(CAST(CAST(receipt_tmsp AS TIME(6)) AS VARCHAR(30)), 1, 8) AS TIME(0)) AS time_receipt_ejr	
    ,(EXTRACT(HOUR From time_receipt_ejr)*100 + (CASE WHEN (EXTRACT(MINUTE From (time_receipt_ejr)) < 30) THEN 0 ELSE 30 END)) AS time_halfhour_id	
    ,CAST(r.client_id AS VARCHAR(6)) || CAST(r.loc_sid AS VARCHAR(11)) || CAST(r.register_id AS VARCHAR(6)) || CAST(r.receipt_id AS VARCHAR(6)) || CAST(r.receipt_dt AS VARCHAR(11)) || SUBSTRING(CAST(time_receipt_ejr AS VARCHAR(20)), 1, 8) AS receipt_for_count_id	
    ,r.receipt_id AS orig_receipt_nr_ejr	
    ,-9 AS orig_receipt_serial_nr_ejr -- receiptheader: orig_receipt_serial_nr_ejr 99,99% haben den Wert -9	
    ,r.timezone_id AS timezone_cd	
    ,r.dwh_cal_dt AS dat_dayend	
    ,r.dwh_cal_dt AS dat_formdate	
    ,r.cashier_id AS checker_id	
    ,r.transaction_type_cd AS transactiontype_id	
    ,r.cnt_receiptlines_total AS cnt_receiptline_ejr	
    ,r.cnt_receiptlines_sales AS cnt_selling_position_ejr	
    ,r.cnt_receiptlines_discounts AS cnt_discount_ejr	
    ,r.cnt_receiptlines_deposits AS cnt_deposit_ejr	
    ,r.cnt_receiptlines_returns AS cnt_return_ejr	
    ,r.cnt_receiptlines_voids AS cnt_void_ejr	
    ,r.cnt_distinct_eans AS cnt_ean_ejr	
    ,r.cnt_distinct_items AS cnt_item_ejr	
    ,r.cnt_distinct_weight_items AS cnt_item_weight_ejr	
    ,r.cnt_distinct_item_grp_ints AS cnt_mainitemgroup_ejr	
    ,r.cnt_piece_qty AS qty_piece_ejr	
    ,r.total_gross_val / cry.rate_currency_exchange AS val_retail_ejr	
    ,r.total_net_val / cry.rate_currency_exchange AS val_retail_net_ejr	
    ,r.sales_gross_val / cry.rate_currency_exchange AS val_retail_pos_ejr	
    ,r.sales_net_val / cry.rate_currency_exchange AS val_retail_net_pos_ejr	
    ,r.deposit_gross_val / cry.rate_currency_exchange AS val_deposit_ejr	
    ,r.deposit_net_val / cry.rate_currency_exchange AS val_deposit_net_ejr	
    ,r.discount_gross_val / cry.rate_currency_exchange AS val_discount_ejr	
    ,r.discount_net_val / cry.rate_currency_exchange AS val_discount_net_ejr	
    ,r.resumed_receipt_store_id AS resumed_trans_store_id_ejr	
    ,r.resumed_receipt_register_id AS resumed_trans_terminal_id_ejr	
    ,r.resumed_receipt_dt AS resumed_trans_date_ejr	
    ,r.resumed_receipt_id AS resumed_trans_receipt_nr_ejr	
    ,r.dur_item_scan AS dur_service_time_ejr	
    ,r.dur_payment AS dur_pay_change_time_ejr	
    ,CAST(SUBSTRING(CAST(transaction_begin_tmsp AS VARCHAR(50)), 1, 19) AS TIMESTAMP) AS timestamp_begin_ejr	
    ,CAST(SUBSTRING(CAST(transaction_end_tmsp AS VARCHAR(50)), 1, 19) AS TIMESTAMP) AS timestamp_end_ejr	
    ,cry.currency_iso_cd	
    ,r.customer_cd AS customer_nr	
    ,r.lidlplus_customer_cd AS lidlplus_customer_cd	
    ,r.lidlplus_ident_type_cd AS lidlplus_ident_type_cd	
    FROM p_lew_core_ac.v_pos_receiptheader_2 AS r	

    JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry	
    ON r.client_id = cry.client_id	
    AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end	

    WHERE r.turnover_relevant_fg = 1	
    AND r.dwh_cal_dt < CURRENT_DATE
;