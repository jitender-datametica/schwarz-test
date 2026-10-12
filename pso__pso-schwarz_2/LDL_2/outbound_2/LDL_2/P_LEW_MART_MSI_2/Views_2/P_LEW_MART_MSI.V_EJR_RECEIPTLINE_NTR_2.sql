/* DescStart	
$Revision: 10107 $, $LastChangedBy: umeister $	
SubjectAreas: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
DescEnd */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_receiptline_ntr_2 (client_id, orig_receipt_serial_nr_ejr, store_id,
pos_terminal_id, dat_formdate, time_receipt_ejr, barcode, ean_item_desc, time_halfhour_id, receipt_for_count_id,
orig_receipt_nr_ejr, timezone_cd, dat_dayend, checker_id, transactiontype_id, item_id, mainitemgroup_id, qty_piece_ejr,
qty_weight_ejr, pct_vat_ejr, pct_factor_dec_vat_ejr, price_retail_ejr, price_retail_net_ejr, price_retail_adjstd_ejr,
price_retail_net_adjstd_ejr, price_type_ejr, mis_weight_fg, val_retail_ejr, val_retail_net_ejr, val_discount_ejr,
val_discount_net_ejr, val_discount_hq_ejr, val_discount_hq_net_ejr, ejr_cd, discount_id, val_retail_orig_ejr,
val_retail_orig_net_ejr, val_discount_base_ejr, val_discount_base_net_ejr, qty_discount_pos_ejr, qty_discount_hq_ejr,
return_reason_cd_ejr, timestamp_begin_ejr, timestamp_end_ejr, item_entry_method_cd_ejr, price_entry_method_cd_ejr,
parent_line_nr_ejr, voided_by_line_nr_ejr, currency_iso_cd) AS -- receiptline: price_type_ejr ist immer NULL

-- ist in der Praxis immer gleich gefüllt
 -- receiptline ejr_cd immer 0
 SELECT RCL.client_id,
 RCL.receiptline_nr AS orig_receipt_serial_nr_ejr,
 RCL.loc_sid AS store_id,
 RCL.register_id AS pos_terminal_id,
 RCL.dwh_cal_dt AS dat_formdate,
 CAST(RCL.receipt_tmsp AS TIME) AS time_receipt_ejr,
 RCL.ean_barcode AS barcode,
 EAN.ean_item_desc,
   EXTRACT(HOUR FROM CAST(RCL.receipt_tmsp AS TIME)) * 100 + CASE
   WHEN EXTRACT(MINUTE FROM CAST(RCL.receipt_tmsp AS TIME)) < 30
   THEN 0
   ELSE 30
   END AS time_halfhour_id,
      CAST(RCL.client_id AS STRING) || CAST(RCL.loc_sid AS STRING) || CAST(RCL.register_id AS STRING) || CAST(RCL.receipt_id AS STRING)
     || CAST(RCL.receipt_dt AS STRING) || SUBSTR(CAST(CAST(RCL.receipt_tmsp AS TIME) AS STRING), 1, 8) AS
 receipt_for_count_id,
 RCL.receipt_id AS orig_receipt_nr_ejr,
 RCL.timezone_id AS timezone_cd,
 RCL.dwh_cal_dt AS dat_dayend,
 RCL.cashier_id AS checker_id,
 RCL.transaction_type_cd AS transactiontype_id,
 RCL.item_sid AS item_id,
 RCL.main_item_grp_cd AS mainitemgroup_id,
  CASE
  WHEN RCL.weight_item_fg = 0
  THEN RCL.sales_piece_qty
  ELSE 0
  END AS qty_piece_ejr,
  CASE
  WHEN RCL.weight_item_fg = 1
  THEN RCL.sales_weight_qty
  ELSE 0
  END AS qty_weight_ejr,
 RCL.vat_pct_val AS pct_vat_ejr,
 COALESCE(100 / CASE
    WHEN CAST(RCL.vat_pct_val AS NUMERIC) + 100 = 0
    THEN NULL
    ELSE CAST(RCL.vat_pct_val AS NUMERIC) + 100
    END, 1) AS pct_factor_dec_vat_ejr,
  RCL.item_unit_price / CRY.rate_currency_exchange AS price_retail_ejr,
 CAST(RCL.item_unit_price * COALESCE(100 / CASE
       WHEN CAST(RCL.vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(RCL.vat_pct_val AS NUMERIC) + 100
       END, 1) / CRY.rate_currency_exchange AS NUMERIC) AS price_retail_net_ejr,
  RCL.item_unit_price_adjust / CRY.rate_currency_exchange AS price_retail_adjstd_ejr,
 CAST(RCL.item_unit_price_adjust * COALESCE(100 / CASE
       WHEN CAST(RCL.vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(RCL.vat_pct_val AS NUMERIC) + 100
       END, 1) / CRY.rate_currency_exchange AS NUMERIC) AS price_retail_net_adjstd_ejr,
 NULL AS price_type_ejr,
 RCL.weight_item_fg AS mis_weight_fg,
  RCL.sales_val / CRY.rate_currency_exchange AS val_retail_ejr,
 CAST(RCL.sales_val * COALESCE(100 / CASE
       WHEN CAST(RCL.vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(RCL.vat_pct_val AS NUMERIC) + 100
       END, 1) / CRY.rate_currency_exchange AS NUMERIC) AS val_retail_net_ejr,
  CASE
  WHEN RCL.discount_sid IS NOT NULL AND RCL.discount_weight_qty <> 0
  THEN RCL.discount_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_ejr,
  CASE
  WHEN RCL.discount_sid IS NOT NULL AND RCL.discount_weight_qty <> 0
  THEN CAST(RCL.discount_val * COALESCE(100 / CASE
        WHEN CAST(RCL.vat_pct_val AS NUMERIC) + 100 = 0
        THEN NULL
        ELSE CAST(RCL.vat_pct_val AS NUMERIC) + 100
        END, 1) / CRY.rate_currency_exchange AS NUMERIC)
  ELSE 0
  END AS val_discount_net_ejr,
  CASE
  WHEN RCL.discount_sid IS NOT NULL AND RCL.discount_piece_qty <> 0
  THEN RCL.discount_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_hq_ejr,
  CASE
  WHEN RCL.discount_sid IS NOT NULL AND RCL.discount_piece_qty <> 0
  THEN CAST(RCL.discount_val * COALESCE(100 / CASE
        WHEN CAST(RCL.vat_pct_val AS NUMERIC) + 100 = 0
        THEN NULL
        ELSE CAST(RCL.vat_pct_val AS NUMERIC) + 100
        END, 1) / CRY.rate_currency_exchange AS NUMERIC)
  ELSE 0
  END AS val_discount_hq_net_ejr,
 0 AS ejr_cd,
 RCL.discount_sid AS discount_id,
  RCL.sales_orig_val / CRY.rate_currency_exchange AS val_retail_orig_ejr,
 CAST(RCL.sales_orig_val * COALESCE(100 / CASE
       WHEN CAST(RCL.vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(RCL.vat_pct_val AS NUMERIC) + 100
       END, 1) / CRY.rate_currency_exchange AS NUMERIC) AS val_retail_orig_net_ejr,
  RCL.discount_base_val / CRY.rate_currency_exchange AS val_discount_base_ejr,
 CAST(RCL.discount_base_val * COALESCE(100 / CASE
       WHEN CAST(RCL.vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(RCL.vat_pct_val AS NUMERIC) + 100
       END, 1) / CRY.rate_currency_exchange AS NUMERIC) AS val_discount_base_net_ejr,
 RCL.discount_weight_qty AS qty_discount_pos_ejr,
 RCL.discount_piece_qty AS qty_discount_hq_ejr,
 RCL.return_reason_cd AS return_reason_cd_ejr,
 RCL.item_scan_begin_tmsp AS timestamp_begin_ejr,
 RCL.item_scan_end_tmsp AS timestamp_end_ejr,
 RCL.item_entry_method_cd AS item_entry_method_cd_ejr,
 RCL.price_entry_method_cd AS price_entry_method_cd_ejr,
 RCL.receiptline_voided AS parent_line_nr_ejr,
 RCL.receiptline_voided_by AS voided_by_line_nr_ejr,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_pos_receiptline_2 AS RCL
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON RCL.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 LEFT JOIN ldl_p_lew_mart_msi.v_itm_ean_2 AS EAN_2 ON RCL.client_id = EAN.client_id AND RCL.item_sid = EAN.item_id AND RCL.ean_barcode
    = EAN.ean_2
WHERE RCL.turnover_relevant_fg = 0;