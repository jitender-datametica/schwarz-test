CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_receiptline_net (client_id, orig_receipt_serial_nr_ejr, store_id,
pos_terminal_id, dat_formdate, time_receipt_ejr, barcode, time_halfhour_id, receipt_for_count_id, orig_receipt_nr_ejr,
timezone_cd, dat_dayend, checker_id, transactiontype_id, item_id, mainitemgroup_id, dat_adv, qty_piece_ejr,
qty_weight_ejr, pct_vat_ejr, pct_factor_dec_vat_ejr, price_retail_ejr, price_retail_net_ejr, price_retail_adjstd_ejr,
price_retail_net_adjstd_ejr, price_type_ejr, mis_weight_fg, val_retail_ejr, val_retail_net_ejr, val_discount_ejr,
val_discount_net_ejr, val_discount_hq_ejr, val_discount_hq_net_ejr, ejr_cd, discount_id, val_retail_orig_ejr,
val_retail_orig_net_ejr, val_discount_base_ejr, val_discount_base_net_ejr, qty_discount_pos_ejr, qty_discount_hq_ejr,
return_reason_cd_ejr, timestamp_begin_ejr, timestamp_end_ejr, item_entry_method_cd_ejr, price_entry_method_cd_ejr,
parent_line_nr_ejr, voided_by_line_nr_ejr) AS SELECT client_id,
 receiptline_nr AS orig_receipt_serial_nr_ejr,
 loc_sid AS store_id,
 register_id AS pos_terminal_id,
 dwh_cal_dt AS dat_formdate,
 CAST(receipt_tmsp AS TIME) AS time_receipt_ejr,
 ean_barcode AS barcode,
   EXTRACT(HOUR FROM CAST(receipt_tmsp AS TIME)) * 100 + CASE
   WHEN EXTRACT(MINUTE FROM CAST(receipt_tmsp AS TIME)) < 30
   THEN 0
   ELSE 30
   END AS time_halfhour_id,
      CAST(client_id AS STRING) || CAST(loc_sid AS STRING) || CAST(register_id AS STRING) || CAST(receipt_id AS STRING)
   || CAST(receipt_dt AS STRING) || SUBSTR(CAST(CAST(receipt_tmsp AS TIME) AS STRING), 1, 8) AS receipt_for_count_id,
 receipt_id AS orig_receipt_nr_ejr,
 timezone_id AS timezone_cd,
 dwh_cal_dt AS dat_dayend,
 cashier_id AS checker_id,
 transaction_type_cd AS transactiontype_id,
 item_sid AS item_id,
 main_item_grp_cd AS mainitemgroup_id,
 NULL AS dat_adv,
  CASE
  WHEN weight_item_fg = 0
  THEN sales_piece_qty
  ELSE 0
  END AS qty_piece_ejr,
  CASE
  WHEN weight_item_fg = 1
  THEN sales_weight_qty
  ELSE 0
  END AS qty_weight_ejr,
 vat_pct_val AS pct_vat_ejr,
 COALESCE(100 / CASE
    WHEN CAST(vat_pct_val AS NUMERIC) + 100 = 0
    THEN NULL
    ELSE CAST(vat_pct_val AS NUMERIC) + 100
    END, 1) AS pct_factor_dec_vat_ejr,
 item_unit_price AS price_retail_ejr,
 ROUND(CAST(item_unit_price * COALESCE(100 / CASE
       WHEN CAST(vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(vat_pct_val AS NUMERIC) + 100
       END, 1) AS NUMERIC), 5) AS price_retail_net_ejr,
 item_unit_price_adjust AS price_retail_adjstd_ejr,
 ROUND(CAST(item_unit_price_adjust * COALESCE(100 / CASE
       WHEN CAST(vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(vat_pct_val AS NUMERIC) + 100
       END, 1) AS NUMERIC), 5) AS price_retail_net_adjstd_ejr,
 NULL AS price_type_ejr,
 weight_item_fg AS mis_weight_fg,
 sales_val AS val_retail_ejr,
 ROUND(CAST(sales_val * COALESCE(100 / CASE
       WHEN CAST(vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(vat_pct_val AS NUMERIC) + 100
       END, 1) AS NUMERIC), 5) AS val_retail_net_ejr,
  CASE
  WHEN discount_sid IS NOT NULL AND discount_weight_qty <> 0
  THEN discount_val
  ELSE 0
  END AS val_discount_ejr,
  CASE
  WHEN discount_sid IS NOT NULL AND discount_weight_qty <> 0
  THEN ROUND(CAST(discount_val * COALESCE(100 / CASE
        WHEN CAST(vat_pct_val AS NUMERIC) + 100 = 0
        THEN NULL
        ELSE CAST(vat_pct_val AS NUMERIC) + 100
        END, 1) AS NUMERIC), 5)
  ELSE 0
  END AS val_discount_net_ejr,
  CASE
  WHEN discount_sid IS NOT NULL AND discount_piece_qty <> 0
  THEN discount_val
  ELSE 0
  END AS val_discount_hq_ejr,
  CASE
  WHEN discount_sid IS NOT NULL AND discount_piece_qty <> 0
  THEN ROUND(CAST(discount_val * COALESCE(100 / CASE
        WHEN CAST(vat_pct_val AS NUMERIC) + 100 = 0
        THEN NULL
        ELSE CAST(vat_pct_val AS NUMERIC) + 100
        END, 1) AS NUMERIC), 5)
  ELSE 0
  END AS val_discount_hq_net_ejr,
 0 AS ejr_cd,
 discount_sid AS discount_id,
 sales_orig_val AS val_retail_orig_ejr,
 ROUND(CAST(sales_orig_val * COALESCE(100 / CASE
       WHEN CAST(vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(vat_pct_val AS NUMERIC) + 100
       END, 1) AS NUMERIC), 5) AS val_retail_orig_net_ejr,
 discount_base_val AS val_discount_base_ejr,
 ROUND(CAST(discount_base_val * COALESCE(100 / CASE
       WHEN CAST(vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(vat_pct_val AS NUMERIC) + 100
       END, 1) AS NUMERIC), 5) AS val_discount_base_net_ejr,
 discount_weight_qty AS qty_discount_pos_ejr,
 discount_piece_qty AS qty_discount_hq_ejr,
 return_reason_cd AS return_reason_cd_ejr,
 item_scan_begin_tmsp AS timestamp_begin_ejr,
 item_scan_end_tmsp AS timestamp_end_ejr,
 item_entry_method_cd AS item_entry_method_cd_ejr,
 price_entry_method_cd AS price_entry_method_cd_ejr,
 receiptline_voided AS parent_line_nr_ejr,
 receiptline_voided_by AS voided_by_line_nr_ejr
FROM ldl_p_lew_core_ac.v_pos_receiptline AS RCL
WHERE turnover_relevant_fg = 1;