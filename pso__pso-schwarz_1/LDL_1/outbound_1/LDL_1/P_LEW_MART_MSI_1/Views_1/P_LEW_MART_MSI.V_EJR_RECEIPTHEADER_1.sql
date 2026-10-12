/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_RECEIPTHEADER_1
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


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_receiptheader_1 AS SELECT R.client_id,
 R.loc_sid AS store_id,
 1 AS header_collection,
 R.register_id AS pos_terminal_id,
 CAST(TRIM(SUBSTR(CAST(CAST(R.receipt_tmsp AS TIME) AS STRING), 1, 8)) AS TIME) AS time_receipt_ejr,
   EXTRACT(HOUR FROM CAST(TRIM(SUBSTR(CAST(CAST(R.receipt_tmsp AS TIME) AS STRING), 1, 8)) AS TIME)) * 100 + CASE
   WHEN EXTRACT(MINUTE FROM CAST(TRIM(SUBSTR(CAST(CAST(R.receipt_tmsp AS TIME) AS STRING), 1, 8)) AS TIME)) < 30
   THEN 0
   ELSE 30
   END AS time_halfhour_id,
      CAST(R.client_id AS STRING) || CAST(R.loc_sid AS STRING) || CAST(R.register_id AS STRING) || CAST(R.receipt_id AS STRING) || CAST(R.receipt_dt AS STRING) || SUBSTR(CAST(CAST(TRIM(SUBSTR(CAST(CAST(R.receipt_tmsp AS TIME) AS STRING), 1, 8)) AS TIME) AS STRING), 1, 8) AS receipt_for_count_id,
 R.receipt_id AS orig_receipt_nr_ejr,
 - 9 AS orig_receipt_serial_nr_ejr,
 R.timezone_id AS timezone_cd,
 R.dwh_cal_dt AS dat_dayend,
 R.dwh_cal_dt AS dat_formdate,
 R.cashier_id AS checker_id,
 R.transaction_type_cd AS transactiontype_id,
 R.cnt_receiptlines_total AS cnt_receiptline_ejr,
 R.cnt_receiptlines_sales AS cnt_selling_position_ejr,
 R.cnt_receiptlines_discounts AS cnt_discount_ejr,
 R.cnt_receiptlines_deposits AS cnt_deposit_ejr,
 R.cnt_receiptlines_returns AS cnt_return_ejr,
 R.cnt_receiptlines_voids AS cnt_void_ejr,
 R.cnt_distinct_eans AS cnt_ean_ejr,
 R.cnt_distinct_items AS cnt_item_ejr,
 R.cnt_distinct_weight_items AS cnt_item_weight_ejr,
 R.cnt_distinct_item_grp_ints AS cnt_mainitemgroup_ejr,
 R.cnt_piece_qty AS qty_piece_ejr,
  R.total_gross_val / CRY.rate_currency_exchange AS val_retail_ejr,
  R.total_net_val / CRY.rate_currency_exchange AS val_retail_net_ejr,
  R.sales_gross_val / CRY.rate_currency_exchange AS val_retail_pos_ejr,
  R.sales_net_val / CRY.rate_currency_exchange AS val_retail_net_pos_ejr,
  R.deposit_gross_val / CRY.rate_currency_exchange AS val_deposit_ejr,
  R.deposit_net_val / CRY.rate_currency_exchange AS val_deposit_net_ejr,
  R.discount_gross_val / CRY.rate_currency_exchange AS val_discount_ejr,
  R.discount_net_val / CRY.rate_currency_exchange AS val_discount_net_ejr,
 R.resumed_receipt_store_id AS resumed_trans_store_id_ejr,
 R.resumed_receipt_register_id AS resumed_trans_terminal_id_ejr,
 R.resumed_receipt_dt AS resumed_trans_date_ejr,
 R.resumed_receipt_id AS resumed_trans_receipt_nr_ejr,
 R.dur_item_scan AS dur_service_time_ejr,
 R.dur_payment AS dur_pay_change_time_ejr,
 CAST(SUBSTR(CAST(R.transaction_begin_tmsp AS STRING), 1, 19) AS DATETIME) AS timestamp_begin_ejr,
 CAST(SUBSTR(CAST(R.transaction_end_tmsp AS STRING), 1, 19) AS DATETIME) AS timestamp_end_ejr,
 CRY.currency_iso_cd,
 R.customer_cd AS customer_nr,
 R.lidlplus_customer_cd,
 R.lidlplus_ident_type_cd
FROM ldl_p_lew_core_ac.v_pos_receiptheader_1 AS R
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON R.client_id = CRY.client_id AND CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
WHERE R.turnover_relevant_fg = 1
 AND R.dwh_cal_dt < CURRENT_DATE;