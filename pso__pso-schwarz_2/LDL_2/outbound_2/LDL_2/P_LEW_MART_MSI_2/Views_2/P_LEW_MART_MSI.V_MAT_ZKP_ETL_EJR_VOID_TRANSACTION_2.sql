/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_VOID_TRANSACTION_2
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  24.05.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran new columns: total_value_void, is_pay_exact, is_subtotal_bef_storno,is_void_not_authorised, is_highest_val, is_alk_tab, is_1_itm
#  1.3  21.07.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: complete prefixes (t2) in the main query
#  1.4  09.08.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: get values from v_mat0_zkp_etl_ejr_payment_extract_2 as subselect instead of inner join, add 170 to last_sale_line
#  1.5  04.10.2021    Wandtke,Andrzej          20210826_2919_ZKP_Void_Tran_2: is_void_not_authorised: set the flag to 1 only if all voids were not authorised, is_pay_exact: new subquery chg_aft_pay, set the flag to 1 if the last entry was payment (for positive amount) or change (for negative amount: deposit, return etc)
#  1.6  15.06.2022    Wandtke,Andrzej          AP0116400 : Add conditions: less than 50 items in receipt, Storno is no Doppeltipper (with exceptions), ignore 5 transaction types when looking for the follower transaction.
#  1.7  29.09.2023    Wandtke,Andrzej          AP0177530 : Add column rank_by_timestamp - receipt line number counted by stamp (it can differ from orig_receipt_serial_nr_ejr), use it in void_line_nr_ejr and last_sale_line
#  1.8  26.10.2023    Wandtke,Andrzej          AP0177530 : Column is_subtotal_bef_storno: base the logic on timestamp
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_void_transaction_2 AS
/* Ermittlung der letzten Position auf Bon */ -- Difference between last position of change and last payment position.

-- Timestamp of the last subtotal before Storno

-- last part is void_line_nr_ejr (SF does not accept use of alias in a subquery)
 -- follower of current receipt

/* Look for series (subsequent lines with same item_2) "Doppeltipper" */ -- when 0 : all quantities are equal

-- when 0 : all weights are equal

-- this indicates whether current record is a part of series (previous or next line has the same item_2)

-- no Doppeltipper or more than 1 Storno
 SELECT t2.client_id,
 t2.store_id,
 t2.pos_terminal_id,
 t2.time_receipt_ejr,
 t2.dat_formdate,
 t2.orig_receipt_nr_ejr,
 MAX(t2.wh_id) AS wh_id,
 MAX(t2.checker_id) AS checker_id,
 MAX(CASE
   WHEN t2.void_line_nr_ejr > t2.last_sale_line AND t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1
   THEN t2.void_line_nr_ejr
   ELSE 0
   END) AS last_void_line_nr,
 MAX(CASE
   WHEN t2.void_line_nr_ejr > t2.last_sale_line AND t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1
   THEN 1
   ELSE 0
   END) AS is_voided_after_subtotal,
 SUM(CASE
   WHEN t2.void_line_nr_ejr > t2.last_sale_line AND t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1
   THEN 1
   ELSE 0
   END) AS cnt_void_after_subtotal,
 MAX(CASE
   WHEN t2.transactiontype_id IN ('101', '170', '102', '172', '120', '122')
   THEN 1
   ELSE 0
   END) AS is_sale_after_subtotal,
 MAX(t2.last_sale_line) AS last_subtotal_line,
 SUM(CASE
   WHEN t2.void_line_nr_ejr > t2.last_sale_line AND t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1
   THEN ABS(t2.val_retail_ejr)
   ELSE 0
   END) AS voided_value_aft_subtotal,
  CASE
  WHEN SUM(CASE
     WHEN t2.void_line_nr_ejr > t2.last_sale_line AND t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1
     THEN ABS(t2.val_retail_ejr)
     ELSE 0
     END) > MAX(TR.void_tot_val_aft_subtot)
  THEN 1
  ELSE 0
  END AS is_voided_value_aft_subtotal,
 MIN(CASE
   WHEN t2.void_line_nr_ejr > t2.last_sale_line AND t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1
   THEN COALESCE(rl.saled_item, 0)
   ELSE 2
   END) AS is_voided_item_innext,
 SUM(ABS(t2.val_retail_ejr)) AS total_value_void,
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
   WHEN ABS(t2.val_retail_ejr) = t2.highest_val
   THEN 1
   ELSE 0
   END) AS is_highest_val,
 MAX(CASE
   WHEN t2.subitemgroup_id IN (60, 61, 63, 80)
   THEN 1
   ELSE 0
   END) AS is_alk_tab,
 MAX(CASE
   WHEN t2.cnt_sale_aft_void = 1 AND t2.val_total_retail_ejr < TR.void_1itm_receipt_val
   THEN 1
   ELSE 0
   END) AS is_1_itm
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
    CASE
    WHEN x.transactiontype_id IN ('171', '173')
    THEN CAST(x.rank_by_timestamp AS INTEGER)
    ELSE 0
    END AS void_line_nr_ejr,
   MAX(CASE
     WHEN x.transactiontype_id IN ('101', '102', '120', '122', '170')
     THEN CAST(x.rank_by_timestamp AS INTEGER)
     ELSE 0
     END) OVER (PARTITION BY x.client_id, x.store_id, x.pos_terminal_id, x.time_receipt_ejr, x.dat_formdate, x.orig_receipt_nr_ejr
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_sale_line,
   y.cnt_void_ejr,
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
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_2 AS P
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
    (SELECT MAX(timestamp_begin_ejr)
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_subtotal_extract_2 AS S
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
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2) AS x
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
      FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_2 AS TR_NEXT
      WHERE TR_FOLL.client_id = client_id
       AND TR_FOLL.store_id = store_id
       AND TR_FOLL.pos_terminal_id = pos_terminal_id
       AND TR_FOLL.dat_formdate = dat_formdate
       AND TR_FOLL.checker_id = checker_id
       AND orig_receipt_nr_ejr > TR_FOLL.orig_receipt_nr_ejr
       AND CAST(transactiontype_id AS INTEGER) NOT IN (400, 405, 420, 425, 430, 480)) AS receipt_foll
    FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_2 AS TR_FOLL) AS y ON x.store_id = y.store_id AND x.client_id = y
         .client_id AND x.pos_terminal_id = y.pos_terminal_id AND x.dat_formdate = y.dat_formdate AND x.time_receipt_ejr
       = y.time_receipt_ejr AND x.orig_receipt_nr_ejr -- CROSS JOIN to *load_store to get only the relevant stores
 = y
     .orig_receipt_nr_ejr
   INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS REVSTR ON y.store_id = REVSTR.store_id
     AND y.client_id = REVSTR.client_id AND y.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
     
  WHERE y.transactiontype_id = '100'
   AND y.cnt_void_ejr > 0
   AND NOT EXISTS (SELECT 1
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_2 AS P
     INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS REVDAY ON P.dat_formdate = REVDAY.dat_calendar
      
     INNER JOIN (SELECT MIN(dat_calendar) AS a622787332
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS D_MIN) AS t5 ON TRUE
     INNER JOIN (SELECT MAX(dat_calendar) AS a2100252426
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS D_MAX) AS t7 ON TRUE
    WHERE y.store_id = P.store_id
     AND y.client_id = P.client_id
     AND y.pos_terminal_id = P.pos_terminal_id
     AND y.dat_formdate = P.dat_formdate
     AND y.time_receipt_ejr = P.time_receipt_ejr
     AND y.orig_receipt_nr_ejr = P.orig_receipt_nr_ejr
     AND P.tendertype_cd_ejr <> '11'
      -- The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).

      
     AND P.dat_formdate >= t5.a622787332
     AND P.dat_formdate <= t7.a2100252426)
  QUALIFY CASE
     WHEN x.transactiontype_id IN ('171', '173')
     THEN CAST(x.rank_by_timestamp AS INTEGER)
     ELSE 0
     END > (MAX(CASE
       WHEN x.transactiontype_id IN ('101', '102', '120', '122', '170')
       THEN CAST(x.rank_by_timestamp AS INTEGER)
       ELSE 0
       END) OVER (PARTITION BY x.client_id, x.store_id, x.pos_terminal_id, x.time_receipt_ejr, x.dat_formdate, x.orig_receipt_nr_ejr
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t2
 LEFT JOIN (SELECT t24.client_id,
   t24.store_id,
   t24.pos_terminal_id,
   t24.dat_formdate,
   t24.orig_receipt_nr_ejr,
   t24.item_id,
   COUNT(*) AS nb_in_series,
   AVG(t24.is_rp) AS avg_rp,
   AVG(t24.is_manual) AS avg_manual,
   STDDEV(t24.qty_piece_ejr) AS stdev_qty_sold,
   STDDEV(t24.qty_weight_ejr) AS stdev_wgt_sold,
   SUM(t24.is_scanned) AS is_scanned
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
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2) AS rle
     INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS REVSTR0 ON rle.store_id = REVSTR0.store_id
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
       END = 1 -- select only series (at least 2 subsequent receipt lines with the same item_2)
) AS t24
  GROUP BY t24.client_id,
   t24.store_id,
   t24.pos_terminal_id,
   t24.dat_formdate,
   t24.orig_receipt_nr_ejr,
   t24.item_id
  HAVING stdev_qty_sold = 0 AND stdev_wgt_sold = 0 AND avg_rp = 0 AND avg_manual < 1) AS rls ON t2.client_id = rls.client_id
        AND t2.store_id = rls.store_id AND t2.pos_terminal_id = rls.pos_terminal_id AND t2.dat_formdate = rls.dat_formdate
      AND t2.orig_receipt_nr_ejr = rls.orig_receipt_nr_ejr AND t2.item_id
   /* Ermittlung der stornierten Artikel_2 im Folgebon */ = rls.item_id
 LEFT JOIN (SELECT client_id,
   store_id,
   pos_terminal_id,
   time_receipt_ejr,
   dat_formdate,
   orig_receipt_nr_ejr,
   item_id,
   1 AS saled_item
  FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 AS RLX
  GROUP BY store_id,
   client_id,
   pos_terminal_id,
   dat_formdate,
   time_receipt_ejr,
   orig_receipt_nr_ejr,
   item_id) AS rl ON t2.client_id = rl.client_id AND t2.store_id = rl.store_id AND t2.pos_terminal_id = rl.pos_terminal_id
       AND t2.dat_formdate = rl.dat_formdate AND t2.receipt_foll = rl.orig_receipt_nr_ejr AND t2.item_id = rl.item_id
 INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_2 AS TR ON t2.client_id = TR.client_id
WHERE t2.header_transactiontype_id = '100'
 AND ABS(t2.qty_piece_ejr) < 50
GROUP BY t2.client_id,
 t2.store_id,
 t2.pos_terminal_id,
 t2.time_receipt_ejr,
 t2.dat_formdate,
 t2.orig_receipt_nr_ejr
HAVING is_sale_after_subtotal = 0
  AND    is_voided_value_aft_subtotal = 1
  AND    is_voided_item_innext = 0
  AND    is_voided_after_subtotal = 1
  AND (MAX(COALESCE(nb_in_series, 0)) < 2 OR SUM(CASE WHEN t2.transactiontype_id IN ('171', '173') THEN 1 ELSE 0 END) > 1);