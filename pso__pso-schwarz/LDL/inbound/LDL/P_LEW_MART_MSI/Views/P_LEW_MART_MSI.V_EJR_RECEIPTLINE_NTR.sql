CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_RECEIPTLINE_NTR	
/*
DescStart	
$Revision: 10107 $, $LastChangedBy: umeister $	
SubjectAreas: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
DescEnd	
*/	
(	
client_id	
, orig_receipt_serial_nr_ejr	
, store_id	
, pos_terminal_id	
, dat_formdate	
, time_receipt_ejr	
, barcode	
, ean_item_desc	
, time_halfhour_id	
, receipt_for_count_id	
, orig_receipt_nr_ejr	
, timezone_cd	
, dat_dayend	
, checker_id	
, transactiontype_id	
, item_id	
, mainitemgroup_id	
, qty_piece_ejr	
, qty_weight_ejr	
, pct_vat_ejr	
, pct_factor_dec_vat_ejr	
, price_retail_ejr	
, price_retail_net_ejr	
, price_retail_adjstd_ejr	
, price_retail_net_adjstd_ejr	
, price_type_ejr	
, mis_weight_fg	
, val_retail_ejr	
, val_retail_net_ejr	
, val_discount_ejr	
, val_discount_net_ejr	
, val_discount_hq_ejr	
, val_discount_hq_net_ejr	
, ejr_cd	
, discount_id	
, val_retail_orig_ejr	
, val_retail_orig_net_ejr	
, val_discount_base_ejr	
, val_discount_base_net_ejr	
, qty_discount_pos_ejr	
, qty_discount_hq_ejr	
, return_reason_cd_ejr	
, timestamp_begin_ejr	
, timestamp_end_ejr	
, item_entry_method_cd_ejr	
, price_entry_method_cd_ejr	
, parent_line_nr_ejr	
, voided_by_line_nr_ejr	
, currency_iso_cd	
)	
AS	
   SELECT	
   rcl.client_id,	
   rcl.receiptline_nr AS orig_receipt_serial_nr_ejr,	
   rcl.loc_sid AS store_id,	
   rcl.register_id AS pos_terminal_id,	
   rcl.dwh_cal_dt AS dat_formdate,	
   CAST(rcl.receipt_tmsp AS TIME(6)) AS time_receipt_ejr,	
   rcl.ean_barcode AS barcode,	
   ean.ean_item_desc,	
   (EXTRACT(HOUR	
   FROM time_receipt_ejr)*100 + (	
   CASE	
   WHEN (EXTRACT(MINUTE	
   FROM (time_receipt_ejr)) < 30) THEN 0 ELSE 30	
   END)) AS time_halfhour_id,	
   CAST(rcl.client_id AS VARCHAR(6)) || CAST(rcl.loc_sid AS VARCHAR(11)) || CAST(rcl.register_id AS VARCHAR(6)) || CAST(rcl.receipt_id AS VARCHAR(6)) || CAST(rcl.receipt_dt AS VARCHAR(11)) || SUBSTRING(CAST(time_receipt_ejr AS VARCHAR(20)), 1, 8) AS receipt_for_count_id,	
   rcl.receipt_id AS orig_receipt_nr_ejr,	
   rcl.timezone_id AS timezone_cd,	
   rcl.dwh_cal_dt AS dat_dayend,	
   rcl.cashier_id AS checker_id,	
   rcl.transaction_type_cd AS transactiontype_id,	
   rcl.item_sid AS item_id,	
   rcl.main_item_grp_cd AS mainitemgroup_id,	
	
   CASE	
   WHEN rcl.weight_item_fg = 0	
   THEN rcl.sales_piece_qty	
   ELSE 0	
   END AS qty_piece_ejr,	
	
   CASE	
   WHEN rcl.weight_item_fg = 1	
   THEN rcl.sales_weight_qty	
   ELSE 0	
   END AS qty_weight_ejr,	
   rcl.vat_pct_val AS pct_vat_ejr,	
   COALESCE(100/ CASE WHEN CAST(rcl.vat_pct_val AS DECIMAL(19,6))+100 = 0 THEN null ELSE CAST(rcl.vat_pct_val AS DECIMAL(19,6))+100 END, 1) AS pct_factor_dec_vat_ejr,	
   rcl.item_unit_price / cry.rate_currency_exchange AS price_retail_ejr,	
   CAST(rcl.item_unit_price * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) AS price_retail_net_ejr,	
   rcl.item_unit_price_adjust / cry.rate_currency_exchange AS price_retail_adjstd_ejr,	
   CAST(rcl.item_unit_price_adjust * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) AS price_retail_net_adjstd_ejr,	
   NULL AS price_type_ejr -- receiptline: price_type_ejr ist immer NULL	
   ,	
   rcl.weight_item_fg                                      AS mis_weight_fg -- ist in der Praxis immer gleich gefüllt	
   ,	
   rcl.sales_val / cry.rate_currency_exchange AS val_retail_ejr,	
   CAST (rcl.sales_val * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) AS val_retail_net_ejr,	
	
   CASE	
   WHEN rcl.discount_sid IS NOT NULL AND rcl.discount_weight_qty <> 0 THEN rcl.discount_val / cry.rate_currency_exchange ELSE 0	
   END AS val_discount_ejr,	
	
   CASE	
   WHEN rcl.discount_sid IS NOT NULL AND rcl.discount_weight_qty <> 0 THEN CAST(rcl.discount_val * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) ELSE 0	
   END AS val_discount_net_ejr,	
	
   CASE	
   WHEN rcl.discount_sid IS NOT NULL AND rcl.discount_piece_qty <> 0 THEN rcl.discount_val / cry.rate_currency_exchange ELSE 0	
   END AS val_discount_hq_ejr,	
	
   CASE	
   WHEN rcl.discount_sid IS NOT NULL AND rcl.discount_piece_qty <> 0 THEN CAST(rcl.discount_val * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) ELSE 0	
   END AS val_discount_hq_net_ejr,	
   0 AS ejr_cd -- receiptline ejr_cd immer 0	
   ,	
   rcl.discount_sid AS discount_id,	
   rcl.sales_orig_val / cry.rate_currency_exchange AS val_retail_orig_ejr,	
   CAST(rcl.sales_orig_val * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) AS val_retail_orig_net_ejr,	
   rcl.discount_base_val / cry.rate_currency_exchange AS val_discount_base_ejr,	
   CAST(rcl.discount_base_val * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) AS val_discount_base_net_ejr,	
   rcl.discount_weight_qty AS qty_discount_pos_ejr,	
   rcl.discount_piece_qty AS qty_discount_hq_ejr,	
   rcl.return_reason_cd AS return_reason_cd_ejr,	
   rcl.item_scan_begin_tmsp AS timestamp_begin_ejr,	
   rcl.item_scan_end_tmsp AS timestamp_end_ejr,	
   rcl.item_entry_method_cd AS item_entry_method_cd_ejr,	
   rcl.price_entry_method_cd AS price_entry_method_cd_ejr,	
   rcl.receiptline_voided AS parent_line_nr_ejr,	
   rcl.receiptline_voided_by AS voided_by_line_nr_ejr,	
   cry.currency_iso_cd	
   FROM p_lew_core_ac.v_pos_receiptline AS rcl	
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry	
   ON rcl.client_id = cry.client_id	
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end	
   LEFT OUTER JOIN p_lew_mart_msi.v_itm_ean AS ean	
   ON rcl.client_id = ean.client_id	
   AND rcl.item_sid = ean.item_id	
   AND rcl.ean_barcode = ean.ean	
   WHERE rcl.turnover_relevant_fg = 0	
;