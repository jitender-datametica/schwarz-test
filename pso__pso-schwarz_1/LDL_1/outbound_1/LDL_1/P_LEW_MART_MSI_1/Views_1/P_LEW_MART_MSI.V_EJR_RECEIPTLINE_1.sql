/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_RECEIPTLINE_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  ----
#   DescStart	
#   $Revision: 13214 $, $LastChangedBy: knagmote $	
#   SubjectAreas: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
#   DescEnd	
#
#  1.1  05.07.2024    Marcin Malec              Filtering out live and future data; User Story 641977: [BE] - Umsatz EJR (1104001.02) is showing live data
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_receiptline_1 AS -- MaxVal 34
 -- MaxVal 17208
 -- MaxVal 86

-- MaxVal 51200751
 -- receiptline dat_adv ???
 -- receiptline: price_type_ejr ist immer NULL

-- ist in der Praxis immer gleich gefüllt
 -- receiptline ejr_cd immer 0

-- added original recept id to link it with returened receipts.
 SELECT R.client_id,
 R.receiptline_nr AS orig_receipt_serial_nr_ejr,
 R.loc_sid AS store_id,
 R.register_id AS pos_terminal_id,
 R.dwh_cal_dt AS dat_formdate,
 TIME(R.receipt_tmsp) AS time_receipt_ejr,
 R.ean_barcode AS barcode,
 EAN.ean_item_desc,
   EXTRACT(HOUR FROM TIME(R.receipt_tmsp)) * 100 + CASE
   WHEN EXTRACT(MINUTE FROM TIME(R.receipt_tmsp)) < 30
   THEN 0
   ELSE 30
   END AS time_halfhour_id,
     CAST(R.client_id AS STRING) || CAST(R.loc_sid AS STRING) || CAST(R.register_id AS STRING) || CAST(LEFT(SUBSTR(CAST(R.receipt_id AS STRING)
      , 1, 39), 6) AS STRING) || FORMAT_DATETIME('%Y%m%d%H%M%S', R.receipt_tmsp) AS receipt_for_count_id,
 R.receipt_id AS orig_receipt_nr_ejr,
 R.timezone_id AS timezone_cd,
 R.dwh_cal_dt AS dat_dayend,
 R.cashier_id AS checker_id,
 R.transaction_type_cd AS transactiontype_id,
 R.item_sid AS item_id,
 R.main_item_grp_cd AS mainitemgroup_id,
 CAST(NULL AS STRING) AS dat_adv,
  CASE
  WHEN R.weight_item_fg = 0
  THEN R.sales_piece_qty
  ELSE 0
  END AS qty_piece_ejr,
  CASE
  WHEN R.weight_item_fg = 1
  THEN R.sales_weight_qty
  ELSE 0
  END AS qty_weight_ejr,
 R.vat_pct_val AS pct_vat_ejr,
 COALESCE(100 / CASE
    WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0
    THEN NULL
    ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
    END, 1) AS pct_factor_dec_vat_ejr,
  R.item_unit_price / CRY.rate_currency_exchange AS price_retail_ejr,
 CAST(R.item_unit_price * COALESCE(100 / CASE
       WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
       END, 1) / CRY.rate_currency_exchange AS NUMERIC) AS price_retail_net_ejr,
  R.item_unit_price_adjust / CRY.rate_currency_exchange AS price_retail_adjstd_ejr,
 CAST(R.item_unit_price_adjust * COALESCE(100 / CASE
       WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
       END, 1) / CRY.rate_currency_exchange AS NUMERIC) AS price_retail_net_adjstd_ejr,
 NULL AS price_type_ejr,
 R.weight_item_fg AS mis_weight_fg,
  R.sales_val / CRY.rate_currency_exchange AS val_retail_ejr,
 CAST(R.sales_val * COALESCE(100 / CASE
       WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
       END, 1) / CRY.rate_currency_exchange AS NUMERIC) AS val_retail_net_ejr,
  CASE
  WHEN R.discount_sid IS NOT NULL AND R.discount_weight_qty <> 0
  THEN R.discount_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_ejr,
  CASE
  WHEN R.discount_sid IS NOT NULL AND R.discount_weight_qty <> 0
  THEN CAST(R.discount_val * COALESCE(100 / CASE
        WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0
        THEN NULL
        ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
        END, 1) / CRY.rate_currency_exchange AS NUMERIC)
  ELSE 0
  END AS val_discount_net_ejr,
  CASE
  WHEN R.discount_sid IS NOT NULL AND R.discount_piece_qty <> 0
  THEN R.discount_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_hq_ejr,
  CASE
  WHEN R.discount_sid IS NOT NULL AND R.discount_piece_qty <> 0
  THEN CAST(R.discount_val * COALESCE(100 / CASE
        WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0
        THEN NULL
        ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
        END, 1) / CRY.rate_currency_exchange AS NUMERIC)
  ELSE 0
  END AS val_discount_hq_net_ejr,
 0 AS ejr_cd,
 R.discount_sid AS discount_id,
  R.sales_orig_val / CRY.rate_currency_exchange AS val_retail_orig_ejr,
 CAST(R.sales_orig_val * COALESCE(100 / CASE
       WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
       END, 1) / CRY.rate_currency_exchange AS NUMERIC) AS val_retail_orig_net_ejr,
  R.discount_base_val / CRY.rate_currency_exchange AS val_discount_base_ejr,
 CAST(R.discount_base_val * COALESCE(100 / CASE
       WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0
       THEN NULL
       ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
       END, 1) / CRY.rate_currency_exchange AS NUMERIC) AS val_discount_base_net_ejr,
 R.discount_weight_qty AS qty_discount_pos_ejr,
 R.discount_piece_qty AS qty_discount_hq_ejr,
 R.return_reason_cd AS return_reason_cd_ejr,
 R.item_scan_begin_tmsp AS timestamp_begin_ejr,
 R.item_scan_end_tmsp AS timestamp_end_ejr,
 R.item_entry_method_cd AS item_entry_method_cd_ejr,
 R.price_entry_method_cd AS price_entry_method_cd_ejr,
 R.receiptline_voided AS parent_line_nr_ejr,
 R.receiptline_voided_by AS voided_by_line_nr_ejr,
 CRY.currency_iso_cd,
 R.orig_receipt_id AS orig_receipt_id_ejr_sales
FROM ldl_p_lew_core_ac.v_pos_receiptline_1 AS R
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON R.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 LEFT JOIN ldl_p_lew_mart_msi.v_itm_ean_1 AS EAN_1 ON R.client_id = EAN.client_id AND R.item_sid = EAN.item_id AND R.ean_barcode
    = EAN.ean_1
WHERE R.turnover_relevant_fg = 1
 AND R.dwh_cal_dt < CURRENT_DATE;