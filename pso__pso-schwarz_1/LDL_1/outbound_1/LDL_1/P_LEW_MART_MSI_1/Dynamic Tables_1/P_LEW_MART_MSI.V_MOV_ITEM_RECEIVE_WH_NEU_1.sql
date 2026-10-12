CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_mov_item_receive_wh_neu_1 AS
SELECT lir.client_id,
 LOC_WH.src_wh_id AS wh_id,
 lir.item_sid AS item_id,
 lir.dwh_cal_dt AS formdate_dat,
 CAST(NULL AS STRING) AS customer_nr,
 CAST(lir.location_item_receipt_id AS BIGNUMERIC) AS rcv_receipt_id,
 CAST(lir.location_item_receipt_pos_id AS BIGNUMERIC) AS rcv_receipt_pos_nr,
 dmy_rcv_ids.receivetype_id,
 CAST(NULL AS BIGNUMERIC) AS currency_nr,
 DATE(NULL) AS dayend_dat,
 lir.dwh_cal_dt AS rcv_entry_dat,
 DATE(NULL) AS rcv_adjustment_dat,
 DATE(NULL) AS rcv_min_durability_dat,
 DATE(NULL) AS rcv_pos_valid_start_dat,
 DATE(NULL) AS rcv_pos_valid_end_dat,
 lir.sup_sid AS supplier_id,
 CAST(NULL AS BIGNUMERIC) AS supplier_pay_id,
 CAST(NULL AS BIGNUMERIC) AS mapping_pos_nr,
 CAST(NULL AS STRING) AS rcv_orig_receipt_id,
 CAST(NULL AS BIGNUMERIC) AS receipt_pos_part_delivery_fg,
 CAST(NULL AS BIGNUMERIC) AS receipt_pos_matchable_fg,
 1 AS receipt_pos_marginrel_fg,
 99 AS status_tg,
 CAST(NULL AS BIGNUMERIC) AS vat_id,
 CAST(NULL AS NUMERIC) AS rcv_vat_pct,
 CAST(NULL AS BIGNUMERIC) AS rcv_tax_id,
 CAST(NULL AS BIGNUMERIC) AS stock_location_id,
 lir.receive_case_qty AS rcv_case_qty,
 CAST(NULL AS NUMERIC) AS rcv_piece_qty,
 lir.receive_piece_qty AS rcv_total_qty,
 CAST(NULL AS NUMERIC) AS rcv_price_buying_val,
 CAST(NULL AS NUMERIC) AS price_buying_euro_val,
 CAST(NULL AS NUMERIC) AS rcv_price_retail_val,
 CAST(NULL AS NUMERIC) AS rcv_price_retail_net_val,
   CASE
   WHEN dmy_rcv_ids.receivetype_id = 1
   THEN lir.pur_development_net_val
   WHEN dmy_rcv_ids.receivetype_id = 4
   THEN lir.carrier_costs_val - lir.refunds_val
   WHEN dmy_rcv_ids.receivetype_id = 5
   THEN lir.tax_val + lir.environmental_levies_val + lir.customs_val
   ELSE NULL
   END / ERKH.exchange_rate AS rcv_buying_val,
 CAST(NULL AS NUMERIC) AS rcv_buying_suppl_val,
 CAST(NULL AS NUMERIC) AS buying_euro_val,
   CASE
   WHEN dmy_rcv_ids.receivetype_id = 1
   THEN lir.sales_gross_val
   ELSE NULL
   END / ERKH.exchange_rate AS rcv_retail_val,
   CASE
   WHEN dmy_rcv_ids.receivetype_id = 1
   THEN lir.sales_net_val
   ELSE NULL
   END / ERKH.exchange_rate AS rcv_retail_net_val,
 CAST(NULL AS NUMERIC) AS rcv_deposit_val,
 CAST(NULL AS NUMERIC) AS case_size_dec,
 CAST(NULL AS BIGNUMERIC) AS package_qty,
 CAST(NULL AS NUMERIC) AS rcv_buying_fa_val,
 CAST(NULL AS NUMERIC) AS rcv_retail_fa_net_val,
 ERKH.curr_cd_from AS currency_iso_cd
FROM (SELECT client_id,
   location_item_receipt_year,
   location_item_receipt_id,
   location_item_receipt_pos_id,
   curr_cd_receipt,
   MAX(loc_sid_wh) AS loc_sid_wh,
   MAX(item_sid) AS item_sid,
   MAX(dwh_cal_dt) AS dwh_cal_dt,
   MAX(sup_sid) AS sup_sid,
   SUM(receive_case_qty) AS receive_case_qty,
   SUM(receive_piece_qty) AS receive_piece_qty,
   SUM(pur_development_net_val) AS pur_development_net_val,
   SUM(carrier_costs_val) AS carrier_costs_val,
   SUM(refunds_val) AS refunds_val,
   SUM(tax_val) AS tax_val,
   SUM(environmental_levies_val) AS environmental_levies_val,
   SUM(customs_val) AS customs_val,
   SUM(sales_gross_val) AS sales_gross_val,
   SUM(sales_net_val) AS sales_net_val
  FROM ldl_p_lew_core_ac.v_location_item_receipt_1
  WHERE dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 40 MONTH)),
     DATE_ADD(CURRENT_DATE, INTERVAL - 40 MONTH))
  GROUP BY client_id,
   location_item_receipt_year,
   location_item_receipt_id,
   location_item_receipt_pos_id /* , bw_cntr */,
   curr_cd_receipt) AS lir
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC_WH ON lir.client_id = LOC_WH.client_id AND lir.loc_sid_wh = LOC_WH.loc_sid
     AND UPPER(LOC_WH.wh_store_mark) = 'B' -- > WHs

 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS ERKH ON lir.client_id = ERKH.client_id AND CURRENT_DATE
     BETWEEN ERKH.active_from_dt AND ERKH.active_to_dt AND CURRENT_DATE BETWEEN ERKH.dwh_valid_from AND ERKH.dwh_valid_to
     AND ERKH.curr_cd_from = ERKH.curr_cd_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS ERT ON ERKH.client_id = ERT.client_id AND ERKH.x_rate_type_sid =
    ERT.x_rate_type_sid AND ERT.src_kurst = '@BEWE'
 INNER JOIN (SELECT 1 AS receivetype_id
   UNION ALL
   SELECT 4 AS receivetype_id
   UNION ALL
   SELECT 5 AS receivetype_id) AS dmy_rcv_ids ON TRUE
 INNER JOIN ldl_p_lew_bil_ac.v_item_1 AS ITEM_1 ON lir.client_id = ITEM.client_id AND lir.item_sid = ITEM.item_sid AND ITEM_1
   .dwh_actual_fg = 1
 LEFT JOIN ldl_p_lew_bil_ac.v_itemgroup_international_1 AS ITIN ON ITEM.client_id = ITIN.client_id AND ITEM.item_grp_int_sid_asis
    = ITIN.item_grp_int_sid
UNION ALL
SELECT RCV.client_id,
 LOC_WH.src_wh_id AS wh_id,
 RCV.item_sid,
 RCV.dat_formdate,
 RCV.customer_nr,
 RCV.receipt_id_rcv,
 RCV.receipt_pos_nr_rcv,
 RCV.receipttype_id AS receivetype_id,
 RCV.currency_id AS currency_nr,
 RCV.dat_dayend,
 RCV.dat_entry_rcv,
 RCV.dat_adjustment_rcv,
 RCV.dat_min_durability_rcv,
 RCV.dat_valid_from AS dat_rcv_pos_valid_start,
 RCV.dat_valid_until AS dat_rcv_pos_valid_end,
 RCV.sup_sid,
 RCV.sup_sid_pay,
 RCV.mapping_pos_nr,
 RCV.orig_receipt_id_rcv,
 RCV.receipt_pos_partdel_fg AS receipt_pos_part_delivery_fg,
 RCV.receipt_pos_matchable_rel_fg AS receipt_pos_matchable_fg,
 RCV.receipt_pos_margin_rel_fg AS receipt_pos_marginrel_fg,
 RCV.status_tg,
 RCV.vat_id,
 RCV.pct_vat_rcv,
 RCV.item_category_id AS tax_id_rcv,
 RCV.stock_location_nr AS stock_location_id,
 RCV.qty_case_rcv,
 RCV.qty_piece_rcv,
 RCV.qty_total_rcv,
  RCV.price_buying_rcv / ERKH.exchange_rate AS price_buying_rcv,
 RCV.price_buying_euro_rcv AS price_buying_euro,
  RCV.price_retail_rcv / ERKH.exchange_rate AS price_retail_rcv,
  RCV.price_retail_net_rcv / ERKH.exchange_rate AS price_retail_net_rcv,
  RCV.val_buying_rcv / ERKH.exchange_rate AS val_buying_rcv,
 RCV.val_buying_sup_rcv AS val_buying_suppl_rcv,
 RCV.val_buying_euro,
  RCV.val_retail_rcv / ERKH.exchange_rate AS val_retail_rcv,
  RCV.val_net_retail_rcv / ERKH.exchange_rate AS val_net_retail_rcv,
  RCV.val_deposit_rcv / ERKH.exchange_rate AS val_deposit_rcv,
 RCV.case_size_dec,
 RCV.package_qty,
  CASE
  WHEN FA.client_id IS NOT NULL
  THEN RCV.val_buying_rcv / ERKH.exchange_rate
  ELSE NULL
  END AS val_buying_fa_rcv,
  CASE
  WHEN FA.client_id IS NOT NULL
  THEN RCV.val_net_retail_rcv / ERKH.exchange_rate
  ELSE NULL
  END AS val_net_retail_fa_rcv,
 ERKH.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving_1 AS RCV
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC_WH ON RCV.client_id = LOC_WH.client_id AND RCV.wh_loc_sid = LOC_WH.loc_sid
     AND UPPER(LOC_WH.wh_store_mark) = 'B' -- > WHs

 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS ERKH ON RCV.client_id = ERKH.client_id AND CURRENT_DATE
     BETWEEN ERKH.active_from_dt AND ERKH.active_to_dt AND CURRENT_DATE BETWEEN ERKH.dwh_valid_from AND ERKH.dwh_valid_to
     AND ERKH.curr_cd_from = ERKH.curr_cd_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS ERT ON ERKH.client_id = ERT.client_id AND ERKH.x_rate_type_sid =
    ERT.x_rate_type_sid AND ERT.src_kurst = '@BEWE'
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_foodaction_asws_act_1 AS FA ON RCV.client_id = FA.client_id AND RCV.item_sid
    = FA.item_sid AND RCV.dat_entry_rcv = FA.dat_valid /* Nur Daten der letzten 40 Monate anzeigen */
WHERE RCV.dat_entry_rcv > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 40 MONTH)
    ), DATE_ADD(CURRENT_DATE, INTERVAL - 40 MONTH));