/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_RECEIPTLINE_2
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

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_RECEIPTLINE_2 AS	
   SELECT	
      r.client_id
   , r.receiptline_nr AS orig_receipt_serial_nr_ejr
   , r.loc_sid AS store_id
   , r.register_id  AS pos_terminal_id
   , r.dwh_cal_dt AS dat_formdate
   , to_time(r.receipt_tmsp) AS time_receipt_ejr
   , r.ean_barcode AS barcode
   , ean.ean_item_desc
   , EXTRACT(HOUR FROM time_receipt_ejr)*100 +	
      (	
        CASE WHEN (EXTRACT(MINUTE FROM (time_receipt_ejr)) < 30)	
             THEN 0	
             ELSE 30	
        END	
      ) AS time_halfhour_id
   , CAST(r.client_id AS VARCHAR(2)) --MaxVal 34 	
     || CAST(r.loc_sid AS VARCHAR(6)) --MaxVal 17208 	
     || CAST(r.register_id AS VARCHAR(3)) --MaxVal 86 	
     || CAST(LEFT(r.receipt_id,6) AS VARCHAR(6)) --MaxVal 51200751 	
     || TO_CHAR(r.receipt_tmsp, 'YYYYMMDDHH24MISS' ) AS receipt_for_count_id
   , r.receipt_id AS orig_receipt_nr_ejr
   , r.timezone_id AS timezone_cd
   , r.dwh_cal_dt AS dat_dayend
   , r.cashier_id AS checker_id
   , r.transaction_type_cd AS transactiontype_id
   , r.item_sid AS item_id
   , r.main_item_grp_cd AS mainitemgroup_id
   , CAST (NULL AS VARCHAR)AS dat_adv -- receiptline dat_adv ???	
   , CASE WHEN r.weight_item_fg = 0	
           THEN r.sales_piece_qty	
           ELSE 0	
      END AS qty_piece_ejr
   , CASE WHEN r.weight_item_fg = 1	
           THEN r.sales_weight_qty	
           ELSE 0	
      END AS qty_weight_ejr
   , r.vat_pct_val AS pct_vat_ejr
   , COALESCE(100/ CASE WHEN CAST(r.vat_pct_val AS DECIMAL(19,6))+100 = 0 THEN NULL ELSE CAST(r.vat_pct_val AS DECIMAL(19,6))+100 END, 1) AS pct_factor_dec_vat_ejr
   , r.item_unit_price / cry.rate_currency_exchange AS price_retail_ejr
   , CAST(r.item_unit_price * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) AS price_retail_net_ejr
   , r.item_unit_price_adjust / cry.rate_currency_exchange AS price_retail_adjstd_ejr
   , CAST(r.item_unit_price_adjust * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) AS price_retail_net_adjstd_ejr
   , NULL AS price_type_ejr -- receiptline: price_type_ejr ist immer NULL	
   , r.weight_item_fg AS mis_weight_fg -- ist in der Praxis immer gleich gefüllt	
   , r.sales_val / cry.rate_currency_exchange AS val_retail_ejr
   , CAST (r.sales_val * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) AS val_retail_net_ejr
   , CASE WHEN r.discount_sid IS NOT NULL AND r.discount_weight_qty <> 0	
           THEN  r.discount_val / cry.rate_currency_exchange	
           ELSE 0	
      END AS val_discount_ejr
   , CASE WHEN r.discount_sid IS NOT NULL AND r.discount_weight_qty <> 0	
           THEN CAST(r.discount_val * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5))	
           ELSE 0	
      END AS val_discount_net_ejr
   , CASE WHEN r.discount_sid IS NOT NULL AND r.discount_piece_qty <> 0	
           THEN r.discount_val / cry.rate_currency_exchange
           ELSE 0	
      END AS val_discount_hq_ejr
   , CASE WHEN r.discount_sid IS NOT NULL AND r.discount_piece_qty <> 0	
           THEN Cast(r.discount_val * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5))	
           ELSE 0	
      END AS val_discount_hq_net_ejr
   , 0 AS ejr_cd -- receiptline ejr_cd immer 0	
   , r.discount_sid AS discount_id
   , r.sales_orig_val / cry.rate_currency_exchange AS val_retail_orig_ejr
   , CAST(r.sales_orig_val * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) AS val_retail_orig_net_ejr
   , r.discount_base_val / cry.rate_currency_exchange AS val_discount_base_ejr
   , CAST(r.discount_base_val * pct_factor_dec_vat_ejr / cry.rate_currency_exchange AS DECIMAL(19,5)) AS val_discount_base_net_ejr
   , r.discount_weight_qty AS qty_discount_pos_ejr
   , r.discount_piece_qty AS qty_discount_hq_ejr
   , r.return_reason_cd AS return_reason_cd_ejr
   , r.item_scan_begin_tmsp AS timestamp_begin_ejr
   , r.item_scan_end_tmsp AS timestamp_end_ejr
   , r.item_entry_method_cd AS item_entry_method_cd_ejr
   , r.price_entry_method_cd AS price_entry_method_cd_ejr
   , r.receiptline_voided AS parent_line_nr_ejr
   , r.receiptline_voided_by AS voided_by_line_nr_ejr
   , cry.currency_iso_cd
   , r.orig_receipt_id AS orig_receipt_id_ejr_sales --added original recept id to link it with returened receipts.	
   FROM  p_lew_core_ac.v_pos_receiptline_2 AS r	
   INNER JOIN  p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry	
   ON r.client_id = cry.client_id	
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end	
   LEFT OUTER JOIN  p_lew_mart_msi.v_itm_ean_2 AS ean_2	
   ON r.client_id = ean.client_id	
   AND r.item_sid = ean.item_id	
   AND r.ean_barcode = ean.ean_2	
	
 WHERE r.turnover_relevant_fg = 1
 AND r.dwh_cal_dt < CURRENT_DATE
;