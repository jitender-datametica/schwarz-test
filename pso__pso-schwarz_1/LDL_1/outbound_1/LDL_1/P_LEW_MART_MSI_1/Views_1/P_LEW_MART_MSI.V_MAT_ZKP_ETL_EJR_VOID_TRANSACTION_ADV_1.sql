/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_VOID_TRANSACTION_ADV_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.01.2024    Szewczyk,Milosz          AP0182639 : Creating a separate view for voided lines without last position filter (QUALIFY void_line_nr_ejr > last_sale_line) - based on P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_VOID_TRANSACTION_1
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_void_transaction_adv_1 (client_id, store_id, pos_terminal_id,
time_receipt_ejr, dat_formdate, orig_receipt_nr_ejr, wh_id, checker_id, is_voided_after_subtotal,
cnt_void_after_subtotal, is_voided_item_innext, total_value_void, is_pay_exact, is_subtotal_bef_storno,
is_void_not_authorised, is_highest_val, is_alk_tab, is_voided_value_aft_subtotal_2, is_1_itm_2, is_outside_hours,
is_man_discount, cnt_void_ejr, is_man_discount_item) AS
/* Storni nicht Obst und Gemuese und Bake-Off | removed COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line AND from CASE statement: */
/* Part of Filial metric / Anz Bons mit Stornovorgang / Anzahl Storni nach Zwichensumme | removed COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line AND from CASE statement: */
/* Storn Artikel_1 auf Folgebon | removed COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line AND from CASE statement: */
/* Gesamtwert Storno: */ /* Bon glatt Bezahlt: */ /* Zwischensumme vor Storno: */
/* Storno nicht authorisierungspflichtig: */ /* Storno hoechster Einzelwert: */ /* Storno Tabak/ Alkohol: */
/* Gesamtsumme der stornierten Artikel_1 > X LW new: */ /* Bonsumme<X LW + 1 Artikel_1 new: */
/* Bons außerhalb der Öffnungszeit: */ /* Bons mit manuellem Rabatt: */ -- only discounts
 -- exclude scanned discounts

/* Anzahl Stornozeilen */ /* Stornierter Artikel_1 mit manuellem Rabatt verkauft */
-- Difference between last position of change and last payment position.

-- Timestamp of the last subtotal before Storno

-- last part is void_line_nr_ejr (SF does not accept use of alias in a subquery)
 -- follower of current receipt

/* Look for series (subsequent lines with same item_1) "Doppeltipper" */ -- when 0 : all quantities are equal

-- when 0 : all weights are equal

-- this indicates whether current record is a part of series (previous or next line has the same item_1)

-- only discounts
 -- exclude scanned discounts
 SELECT t2.client_id,
 t2.store_id,
 t2.pos_terminal_id,
 t2.time_receipt_ejr,
 t2.dat_formdate,
 t2.orig_receipt_nr_ejr,
 MAX(t2.wh_id) AS wh_id,
 MAX(t2.checker_id) AS checker_id,
 MAX(CASE
   WHEN t2.transactiontype_id IN ('170', '172') AND t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1
   THEN 1
   ELSE 0
   END) AS is_voided_after_subtotal,
 SUM(CASE
   WHEN t2.transactiontype_id IN ('170', '172') AND (t2.subitemgroup_id = 74 OR t2.mainitemgroup_id = 1)
   THEN 1
   ELSE 0
   END) AS cnt_void_after_subtotal,
 SUM(CASE
   WHEN t2.transactiontype_id IN ('170', '172')
   THEN COALESCE(rl.saled_item, 0)
   ELSE 0
   END) AS is_voided_item_innext,
 MAX(t2.val_all_voided_line) AS total_value_void,
 MAX(CASE
   WHEN t2.val_total_retail_ejr > 0 AND t2.chg_aft_pay < 0 OR t2.val_total_retail_ejr < 0 AND t2.chg_aft_pay > 0
   THEN 1
   ELSE 0
   END) AS is_pay_exact,
 MAX(CASE
   WHEN t2.last_subtot_bef_void < t2.timestamp_begin_ejr
   THEN 1
   ELSE 0
   END) AS is_subtotal_bef_storno,
  CASE
  WHEN AVG(CASE
     WHEN t2.authority_id IS NULL
     THEN 1
     ELSE 0
     END) = 1
  THEN 1
  ELSE 0
  END AS is_void_not_authorised,
 MAX(CASE
   WHEN t2.highest_val_void = t2.highest_val
   THEN 1
   ELSE 0
   END) AS is_highest_val,
 MAX(CASE
   WHEN t2.subitemgroup_id IN (60, 61, 63, 80) AND t2.transactiontype_id IN ('170', '172')
   THEN 1
   ELSE 0
   END) AS is_alk_tab,
  CASE
  WHEN SUM(CASE
     WHEN t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1
     THEN ABS(t2.val_retail_ejr)
     ELSE 0
     END) > MAX(TR0.void_tot_val_cnt)
  THEN 1
  ELSE 0
  END AS is_voided_value_aft_subtotal_2,
 MAX(CASE
   WHEN t2.cnt_sale_aft_void = 1 AND t2.val_total_retail_ejr < TR0.void_1itm_receipt_val_2
   THEN 1
   ELSE 0
   END) AS is_1_itm_2,
 MAX(CASE
   WHEN t2.time_receipt_ejr <= CASE
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 1
      THEN LH1.mon_closing_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 2
      THEN LH1.tue_closing_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 3
      THEN LH1.wed_closing_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 4
      THEN LH1.thu_closing_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 5
      THEN LH1.fri_closing_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 6
      THEN LH1.sat_closing_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 7
      THEN LH1.sun_closing_tm
      ELSE NULL
      END AND t2.time_receipt_ejr >= CASE
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 1
      THEN LH1.mon_opening_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 2
      THEN LH1.tue_opening_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 3
      THEN LH1.wed_opening_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 4
      THEN LH1.thu_opening_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 5
      THEN LH1.fri_opening_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 6
      THEN LH1.sat_opening_tm
      WHEN EXTRACT(DAYOFWEEK FROM t2.dat_formdate) - 1 = 7
      THEN LH1.sun_opening_tm
      ELSE NULL
      END
   THEN 0
   ELSE 1
   END) AS is_outside_hours,
 MAX(CASE
   WHEN CAST(t2.transactiontype_id AS INTEGER) IN (401, 402, 441, 442, 470, 502, 570, 472, 482, 572, 580, 582) AND (t2.barcode
         NOT LIKE '55%' AND t2.barcode NOT LIKE '56%' OR NOT LENGTH(t2.barcode) BETWEEN 15 AND 17) AND ABS(t2.val_discount_ejr
      ) > 0.01
   THEN 1
   ELSE 0
   END) AS is_man_discount,
 MAX(t2.cnt_void_ejr) AS cnt_void,
 MAX(CASE
   WHEN rl3.is_man_discount_item = 1
   THEN 1
   ELSE 0
   END) AS is_man_discount_item
FROM (SELECT x.client_id,
   x.orig_receipt_serial_nr_ejr,
   x.store_id,
   x.pos_terminal_id,
   x.dat_formdate,
   x.time_receipt_ejr,
   x.orig_receipt_nr_ejr,
   x.dat_dayend,
   x.checker_id,
   x.transactiontype_id,
   x.item_id,
   x.mainitemgroup_id,
   x.subitemgroup_id,
   x.val_retail_ejr,
   x.parent_line_nr_ejr,
   x.voided_by_line_nr_ejr,
   x.barcode,
   x.val_discount_ejr,
   y.val_all_voided_line,
   y.cnt_void_ejr,
   TR.void_itm_cnt,
   y.next_orig_receipt_nr_ejr,
   y.next_time_receipt_ejr,
   y.transactiontype_id AS header_transactiontype_id,
   REVSTR.wh_id,
   y.val_retail_ejr AS val_total_retail_ejr,
    (SELECT COALESCE(MAX(CASE
         WHEN cnt_payment_ejr = 0
         THEN orig_receipt_serial_nr_ejr
         ELSE 0
         END), 0) - COALESCE(MAX(CASE
         WHEN cnt_payment_ejr = 1
         THEN orig_receipt_serial_nr_ejr
         ELSE 0
         END), 0)
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_1 AS P
    WHERE y.store_id = store_id
     AND y.client_id = client_id
     AND y.pos_terminal_id = pos_terminal_id
     AND y.dat_formdate = dat_formdate
     AND y.time_receipt_ejr = time_receipt_ejr
     AND y.orig_receipt_nr_ejr = orig_receipt_nr_ejr) AS chg_aft_pay,
   x.authority_id,
   MAX(CASE
     WHEN x.transactiontype_id IN ('101', '102', '120', '122', '170')
     THEN x.val_retail_ejr
     ELSE 0
     END) OVER (PARTITION BY x.client_id, x.store_id, x.pos_terminal_id, x.time_receipt_ejr, x.dat_formdate, x.orig_receipt_nr_ejr
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS highest_val,
   MAX(CASE
     WHEN x.transactiontype_id IN ('170')
     THEN x.val_retail_ejr
     ELSE 0
     END) OVER (PARTITION BY x.client_id, x.store_id, x.pos_terminal_id, x.time_receipt_ejr, x.dat_formdate, x.orig_receipt_nr_ejr
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS highest_val_void,
    (SELECT MAX(timestamp_begin_ejr)
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_subtotal_extract_1 AS S
    WHERE y.store_id = store_id
     AND y.client_id = client_id
     AND y.pos_terminal_id = pos_terminal_id
     AND y.dat_formdate = dat_formdate
     AND y.time_receipt_ejr = time_receipt_ejr
     AND y.orig_receipt_nr_ejr = orig_receipt_nr_ejr
     AND timestamp_begin_ejr < CASE
       WHEN x.transactiontype_id IN ('171', '173')
       THEN x.timestamp_begin_ejr
       ELSE NULL
       END) AS last_subtot_bef_void,
   SUM(CASE
     WHEN x.transactiontype_id IN ('101', '102', '120', '122') AND x.orig_receipt_serial_nr_ejr > COALESCE(x.parent_line_nr_ejr
        , 0)
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY x.client_id, x.store_id, x.pos_terminal_id, x.time_receipt_ejr, x.dat_formdate, x.orig_receipt_nr_ejr
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_sale_aft_void,
   x.qty_piece_ejr,
   x.timestamp_begin_ejr,
   y.cnt_voided_line,
   y.receipt_foll
  FROM (SELECT store_id,
     client_id,
     pos_terminal_id,
     dat_formdate,
     time_receipt_ejr,
     orig_receipt_nr_ejr,
     orig_receipt_serial_nr_ejr,
     timezone_cd,
     dat_dayend,
     checker_id,
     transactiontype_id,
     barcode,
     item_id,
     mainitemgroup_id,
     weight_item_fg,
     mis_weight_fg,
     price_retail_ejr,
     price_retail_adjstd_ejr,
     price_type_ejr,
     qty_piece_ejr,
     qty_weight_ejr,
     val_retail_ejr,
     val_discount_ejr,
     pct_vat_ejr,
     val_vat_ejr,
     type_vat_ejr,
     discount_sid,
     val_retail_orig_ejr,
     val_discount_base_ejr,
     qty_discount_pos_ejr,
     qty_discount_hq_ejr,
     return_reason_cd_ejr,
     timestamp_begin_ejr,
     timestamp_end_ejr,
     item_entry_method_cd_ejr,
     price_entry_method_cd_ejr,
     parent_line_nr_ejr,
     voided_by_line_nr_ejr,
     authority_id,
     accounting_disposition_cd_ejr,
     original_orig_store_nr_ejr,
     original_dat_formdate_ejr,
     original_orig_receipt_nr_ejr,
     original_pos_terminal_id_ejr,
     subitemgroup_id,
     load_id,
     RANK() OVER (PARTITION BY client_id, store_id, checker_id, dat_formdate, orig_receipt_nr_ejr ORDER BY
        timestamp_begin_ejr IS NULL, timestamp_begin_ejr, orig_receipt_serial_nr_ejr IS NULL, orig_receipt_serial_nr_ejr
        ) AS rank_by_timestamp
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1) AS x
   INNER JOIN (SELECT store_id,
     client_id,
     pos_terminal_id,
     dat_formdate,
     time_receipt_ejr,
     orig_receipt_nr_ejr,
     timezone_cd,
     dat_dayend,
     checker_id,
     transactiontype_id,
     cnt_receiptline_ejr,
     cnt_selling_position_ejr,
     cnt_discount_ejr,
     cnt_deposit_ejr,
     cnt_return_ejr,
     cnt_void_ejr,
     cnt_ean_ejr,
     cnt_item_ejr,
     cnt_item_weight_ejr,
     cnt_mainitemgroup_ejr,
     qty_piece_ejr,
     val_retail_ejr,
     val_retail_pos_ejr,
     val_deposit_ejr,
     val_discount_ejr,
     val_discount_net_ejr,
     resumed_trans_store_id_ejr,
     resumed_trans_terminal_id_ejr,
     resumed_trans_date_ejr,
     resumed_trans_receipt_nr_ejr,
     dur_service_time_ejr,
     dur_pay_change_time_ejr,
     val_retail_net_ejr,
     timestamp_begin_ejr,
     timestamp_end_ejr,
     next_transactiontype_id,
     rank_login_nr,
     rank_logoff_nr,
     next_orig_receipt_nr_ejr,
     next_val_retail_ejr,
     prev_orig_receipt_nr_ejr,
     next_time_receipt_ejr,
     prev_time_receipt_ejr,
     cnt_all_deposit_back,
     cnt_ke_deposit_back,
     cnt_sc_deposit_back,
     val_all_deposit_back,
     val_all_deposit_back_net,
     val_ke_deposit_back,
     val_ke_deposit_back_net,
     val_sc_deposit_back,
     cnt_all_deposit_sell,
     cnt_ke_deposit_sell,
     cnt_sc_deposit_sell,
     val_all_deposit_sell,
     val_all_deposit_sell_net,
     val_ke_deposit_sell,
     val_sc_deposit_sell,
     cnt_wo_deposit_voided_line,
     amt_sell_item,
     cnt_sell_item,
     val_sell_item,
     cnt_voided_line,
     cnt_all_voided_line,
     amt_voided_item,
     amt_all_voided_item,
     val_voided_line,
     val_voided_line_net,
     val_all_voided_line,
     val_all_voided_line_net,
     is_voided_gt_4,
     is_implausible_deposit,
     is_implausible_depositv1,
     is_implausible_depositv2,
     implausible_depositv1_val,
     implausible_depositv2_val,
     is_deposit_1itm,
     is_deposit_1itmv,
     is_deposit_1itmc,
     qty_return_ejr,
     rank_terminal_login_nr,
     rank_terminal_logoff_nr,
     scenario_id,
     turnover_relevant_fg,
     is_aborted_gt10_fg,
     is_voided_gt10_fg,
     is_lowval_fg,
     cy_week,
     cy_month,
     authority_id,
     qty_ke_return_ejr,
     qty_sc_return_ejr,
     val_ke_return_ejr,
     val_sc_return_ejr,
     prev_transactiontype_id,
      (SELECT MIN(orig_receipt_nr_ejr)
      FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS TR_NEXT
      WHERE TR_FOLL.client_id = client_id
       AND TR_FOLL.store_id = store_id
       AND TR_FOLL.pos_terminal_id = pos_terminal_id
       AND TR_FOLL.dat_formdate = dat_formdate
       AND TR_FOLL.checker_id = checker_id
       AND orig_receipt_nr_ejr > TR_FOLL.orig_receipt_nr_ejr
       AND CAST(transactiontype_id AS INTEGER) NOT IN (400, 405, 420, 425, 430, 480)) AS receipt_foll
    FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS TR_FOLL) AS y ON x.store_id = y.store_id AND x.client_id = y
         .client_id AND x.pos_terminal_id = y.pos_terminal_id AND x.dat_formdate = y.dat_formdate AND x.time_receipt_ejr
       = y.time_receipt_ejr AND x.orig_receipt_nr_ejr -- CROSS JOIN to *load_store to get only the relevant stores
 = y
     .orig_receipt_nr_ejr
   INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON y.store_id = REVSTR.store_id
     AND y.client_id = REVSTR.client_id AND y.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
     
   INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS TR ON y.client_id = TR.client_id
  WHERE y.transactiontype_id = '100'
   AND y.cnt_void_ejr >= TR.void_itm_cnt
   AND y.val_retail_ejr <> 0
   AND 100 * y.val_all_voided_line / y.val_retail_ejr >= TR.void_tot_itm_in_receipt
   AND y.val_all_voided_line >= TR.void_tot_val_cnt) AS t2
 LEFT JOIN (SELECT t16.client_id,
   t16.store_id,
   t16.pos_terminal_id,
   t16.dat_formdate,
   t16.orig_receipt_nr_ejr,
   t16.item_id,
   COUNT(*) AS nb_in_series,
   AVG(t16.is_rp) AS avg_rp,
   AVG(t16.is_manual) AS avg_manual,
   STDDEV(t16.qty_piece_ejr) AS stdev_qty_sold,
   STDDEV(t16.qty_weight_ejr) AS stdev_wgt_sold,
   SUM(t16.is_scanned) AS is_scanned
  FROM (SELECT rle.client_id,
     rle.store_id,
     rle.pos_terminal_id,
     rle.dat_formdate,
     rle.orig_receipt_nr_ejr,
     rle.item_id,
      CASE
      WHEN (LEAD(rle.item_id) OVER (ORDER BY rle.client_id IS NULL, rle.client_id, rle.store_id IS NULL, rle.store_id,
            rle.dat_formdate IS NULL, rle.dat_formdate, rle.orig_receipt_nr_ejr IS NULL, rle.orig_receipt_nr_ejr, rle.rank_by_timestamp
            IS NULL, rle.rank_by_timestamp)) = rle.item_id OR (LAG(rle.item_id) OVER (ORDER BY rle.client_id IS NULL,
            rle.client_id, rle.store_id IS NULL, rle.store_id, rle.dat_formdate IS NULL, rle.dat_formdate, rle.orig_receipt_nr_ejr
            IS NULL, rle.orig_receipt_nr_ejr, rle.rank_by_timestamp IS NULL, rle.rank_by_timestamp)) = rle.item_id
      THEN 1
      ELSE 0
      END AS series,
      CASE
      WHEN rle.item_entry_method_cd_ejr = 'RP'
      THEN 1
      ELSE 0
      END AS is_rp,
      CASE
      WHEN rle.item_entry_method_cd_ejr = 'KE'
      THEN 1
      ELSE 0
      END AS is_manual,
     rle.qty_piece_ejr,
     rle.qty_weight_ejr,
      CASE
      WHEN rle.item_entry_method_cd_ejr = 'SC'
      THEN 1
      ELSE 0
      END AS is_scanned
    FROM (SELECT store_id,
       client_id,
       pos_terminal_id,
       dat_formdate,
       time_receipt_ejr,
       orig_receipt_nr_ejr,
       orig_receipt_serial_nr_ejr,
       timezone_cd,
       dat_dayend,
       checker_id,
       transactiontype_id,
       barcode,
       item_id,
       mainitemgroup_id,
       weight_item_fg,
       mis_weight_fg,
       price_retail_ejr,
       price_retail_adjstd_ejr,
       price_type_ejr,
       qty_piece_ejr,
       qty_weight_ejr,
       val_retail_ejr,
       val_discount_ejr,
       pct_vat_ejr,
       val_vat_ejr,
       type_vat_ejr,
       discount_sid,
       val_retail_orig_ejr,
       val_discount_base_ejr,
       qty_discount_pos_ejr,
       qty_discount_hq_ejr,
       return_reason_cd_ejr,
       timestamp_begin_ejr,
       timestamp_end_ejr,
       item_entry_method_cd_ejr,
       price_entry_method_cd_ejr,
       parent_line_nr_ejr,
       voided_by_line_nr_ejr,
       authority_id,
       accounting_disposition_cd_ejr,
       original_orig_store_nr_ejr,
       original_dat_formdate_ejr,
       original_orig_receipt_nr_ejr,
       original_pos_terminal_id_ejr,
       subitemgroup_id,
       load_id,
       RANK() OVER (PARTITION BY client_id, store_id, checker_id, dat_formdate, orig_receipt_nr_ejr ORDER BY
          timestamp_begin_ejr IS NULL, timestamp_begin_ejr, orig_receipt_serial_nr_ejr IS NULL,
          orig_receipt_serial_nr_ejr) AS rank_by_timestamp
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1) AS rle
     INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR0 ON rle.store_id = REVSTR0.store_id
         AND rle.client_id = REVSTR0.client_id AND rle.dat_formdate BETWEEN REVSTR0.dat_formdate_from AND REVSTR0.dat_formdate_until
       
    WHERE rle.transactiontype_id IN ('170', '101') -- only voided lines

    QUALIFY CASE
       WHEN (LEAD(rle.item_id) OVER (ORDER BY rle.client_id IS NULL, rle.client_id, rle.store_id IS NULL, rle.store_id,
             rle.dat_formdate IS NULL, rle.dat_formdate, rle.orig_receipt_nr_ejr IS NULL, rle.orig_receipt_nr_ejr, rle.rank_by_timestamp
             IS NULL, rle.rank_by_timestamp)) = rle.item_id OR (LAG(rle.item_id) OVER (ORDER BY rle.client_id IS NULL,
             rle.client_id, rle.store_id IS NULL, rle.store_id, rle.dat_formdate IS NULL, rle.dat_formdate, rle.orig_receipt_nr_ejr
             IS NULL, rle.orig_receipt_nr_ejr, rle.rank_by_timestamp IS NULL, rle.rank_by_timestamp)) = rle.item_id
       THEN 1
       ELSE 0
       END = 1 -- select only series (at least 2 subsequent receipt lines with the same item_1)
) AS t16
  GROUP BY t16.client_id,
   t16.store_id,
   t16.pos_terminal_id,
   t16.dat_formdate,
   t16.orig_receipt_nr_ejr,
   t16.item_id
  HAVING stdev_qty_sold = 0 AND stdev_wgt_sold = 0 AND avg_rp = 0 AND avg_manual < 1) AS rls ON t2.client_id = rls.client_id
        AND t2.store_id = rls.store_id AND t2.pos_terminal_id = rls.pos_terminal_id AND t2.dat_formdate = rls.dat_formdate
      AND t2.orig_receipt_nr_ejr = rls.orig_receipt_nr_ejr AND t2.item_id
   /* Ermittlung der stornierten Artikel_1 im Folgebon */ = rls.item_id
 LEFT JOIN (SELECT client_id,
   store_id,
   pos_terminal_id,
   time_receipt_ejr,
   dat_formdate,
   orig_receipt_nr_ejr,
   item_id,
   1 AS saled_item
  FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS RLX
  GROUP BY store_id,
   client_id,
   pos_terminal_id,
   dat_formdate,
   time_receipt_ejr,
   orig_receipt_nr_ejr,
   item_id) AS rl ON t2.client_id = rl.client_id AND t2.store_id = rl.store_id AND t2.pos_terminal_id = rl.pos_terminal_id
       AND t2.dat_formdate = rl.dat_formdate AND t2.receipt_foll = rl.orig_receipt_nr_ejr AND t2.item_id = rl.item_id
 INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS TR0 ON t2.client_id /* Bons außerhalb der Öffnungszeit */ =
  TR0.client_id
 LEFT JOIN ldl_p_lew_core_ac.v_location_hist_1 AS LH1 ON t2.store_id = LH1.loc_sid AND t2.dat_formdate <= LH1.dwh_valid_to
     AND t2.dat_formdate >= LH1.dwh_valid_from
   /* Stornierter Artikel_1 wird nicht auf demselben Bon mit manuellem Rabatt verkauft */
 LEFT JOIN (SELECT RL1.client_id,
   RL1.store_id,
   RL1.pos_terminal_id,
   RL1.dat_formdate,
   RL1.item_id,
   RL1.orig_receipt_nr_ejr,
   1 AS is_man_discount_item
  FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS RL1
   INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS LS ON RL1.client_id = LS.client_id AND
     RL1.store_id = LS.store_id
  WHERE CAST(RL1.transactiontype_id AS INTEGER) IN (401, 402, 441, 442, 470, 502, 570, 472, 482, 572, 580, 582)
   AND (RL1.barcode NOT LIKE '55%' AND RL1.barcode NOT LIKE '56%' OR NOT LENGTH(RL1.barcode) BETWEEN 15 AND 17)
   AND ABS(RL1.val_discount_ejr) > 0.01) AS rl3 ON t2.client_id = rl3.client_id AND t2.store_id = rl3.store_id AND t2.pos_terminal_id
        = rl3.pos_terminal_id AND t2.dat_formdate = rl3.dat_formdate AND t2.item_id = rl3.item_id AND t2.orig_receipt_nr_ejr
     = rl3.orig_receipt_nr_ejr AND t2.cnt_void_ejr > 0
WHERE t2.header_transactiontype_id = '100'
GROUP BY t2.client_id,
 t2.store_id,
 t2.pos_terminal_id,
 t2.time_receipt_ejr,
 t2.dat_formdate,
 t2.orig_receipt_nr_ejr
HAVING is_voided_value_aft_subtotal_2 = 1
  AND    is_voided_item_innext <> cnt_void
  AND    cnt_void_after_subtotal <> cnt_void
  AND MAX(t2.cnt_void_ejr) - COUNTIF(t2.transactiontype_id IN ('170', '172') AND rls.stdev_qty_sold = 0 AND rls.stdev_wgt_sold = 0 
  AND rls.avg_rp = 0 AND rls.avg_manual < 1 AND rls.nb_in_series > 1) - COUNTIF(t2.transactiontype_id IN ('171', '173') AND t2.qty_piece_ejr < -50) 
>= MAX(t2.void_itm_cnt) -- no Doppeltipper or more than 50 articles.
;