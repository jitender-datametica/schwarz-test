/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_VOID_TRANSACTION_1
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  24.05.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran new columns: total_value_void, is_pay_exact, is_subtotal_bef_storno,is_void_not_authorised, is_highest_val, is_alk_tab, is_1_itm
#  1.3  21.07.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: complete prefixes (t2) in the main query
#  1.4  09.08.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: get values from v_mat0_zkp_etl_ejr_payment_extract_1 as subselect instead of inner join, add 170 to last_sale_line
#  1.5  04.10.2021    Wandtke,Andrzej          20210826_2919_ZKP_Void_Tran_2: is_void_not_authorised: set the flag to 1 only if all voids were not authorised, is_pay_exact: new subquery chg_aft_pay, set the flag to 1 if the last entry was payment (for positive amount) or change (for negative amount: deposit, return etc)
#  1.6  15.06.2022    Wandtke,Andrzej          AP0116400 : Add conditions: less than 50 items in receipt, Storno is no Doppeltipper (with exceptions), ignore 5 transaction types when looking for the follower transaction.
#  1.7  29.09.2023    Wandtke,Andrzej          AP0177530 : Add column rank_by_timestamp - receipt line number counted by stamp (it can differ from orig_receipt_serial_nr_ejr), use it in void_line_nr_ejr and last_sale_line
#  1.8  26.10.2023    Wandtke,Andrzej          AP0177530 : Column is_subtotal_bef_storno: base the logic on timestamp
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_VOID_TRANSACTION_1
AS
(
SELECT
   t2.client_id
  ,t2.store_id
  ,t2.pos_terminal_id
  ,t2.time_receipt_ejr
  ,t2.dat_formdate
  ,t2.orig_receipt_nr_ejr
  ,MAX(t2.wh_id) AS wh_id
  ,MAX(t2.checker_id) AS checker_id
  ,MAX(CASE WHEN COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line AND t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1 THEN t2.void_line_nr_ejr ELSE 0 END) AS last_void_line_nr
  ,MAX(CASE WHEN COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line AND t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1 THEN 1 ELSE 0 END) AS is_voided_after_subtotal
  ,SUM(CASE WHEN COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line AND t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1 THEN 1 ELSE 0 END) AS cnt_void_after_subtotal
  ,MAX(CASE WHEN t2.transactiontype_id IN ('101', '170', '102', '172','120', '122') THEN 1 ELSE 0 END) AS is_sale_after_subtotal
  ,MAX(t2.last_sale_line) AS last_subtotal_line
  ,SUM(CASE WHEN COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line   AND t2.subitemgroup_id <> 74   AND t2.mainitemgroup_id <> 1 THEN ABS(t2.val_retail_ejr) ELSE 0 END) AS voided_value_aft_subtotal
  ,CASE WHEN SUM(CASE WHEN COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line   AND t2.subitemgroup_id <> 74   AND t2.mainitemgroup_id <> 1 THEN ABS(t2.val_retail_ejr) ELSE 0 END) > MAX(tr.void_tot_val_aft_subtot) THEN 1 ELSE 0 END AS is_voided_value_aft_subtotal
  ,MIN(CASE WHEN COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line   AND t2.subitemgroup_id <> 74   AND t2.mainitemgroup_id <> 1 THEN COALESCE(rl.saled_item,0) ELSE 2 END) AS is_voided_item_innext
  ,SUM(ABS(t2.val_retail_ejr)) AS total_value_void
  ,MAX(CASE WHEN (val_total_retail_ejr > 0 AND chg_aft_pay < 0) OR (val_total_retail_ejr < 0 AND chg_aft_pay > 0) THEN 1 ELSE 0 END) AS is_pay_exact
  ,MAX(CASE WHEN t2.last_subtot_bef_void < t2.timestamp_begin_ejr THEN 1 ELSE 0 END) AS is_subtotal_bef_storno
  ,CASE WHEN AVG(CASE WHEN t2.authority_id IS NULL THEN 1 ELSE 0 END) = 1 THEN 1 ELSE 0 END AS is_void_not_authorised
  ,MAX(CASE WHEN ABS(t2.val_retail_ejr) = t2.highest_val THEN 1 ELSE 0 END) AS is_highest_val
  ,MAX(CASE WHEN t2.subitemgroup_id IN (60,61,63,80) THEN 1 ELSE 0 END) AS is_alk_tab
  ,MAX(CASE WHEN t2.cnt_sale_aft_void = 1 AND t2.val_total_retail_ejr < tr.void_1itm_receipt_val THEN 1 ELSE 0 END) AS is_1_itm
FROM
(
    SELECT
       x.client_id
      ,x.orig_receipt_serial_nr_ejr
      ,x.store_id
      ,x.pos_terminal_id
      ,x.dat_formdate
      ,x.time_receipt_ejr
      ,x.orig_receipt_nr_ejr
      ,x.dat_dayend
      ,x.checker_id
      ,x.transactiontype_id
      ,x.item_id
      ,x.mainitemgroup_id
      ,x.subitemgroup_id
      ,x.val_retail_ejr
      ,x.parent_line_nr_ejr
      ,x.voided_by_line_nr_ejr
      ,CASE WHEN x.transactiontype_id IN ('171', '173') THEN x.rank_by_timestamp ELSE 0 END AS void_line_nr_ejr
     /* Ermittlung der letzten Position auf Bon */
      ,MAX(CASE WHEN x.transactiontype_id IN ('101', '102', '120', '122', '170') THEN x.rank_by_timestamp ELSE 0 END ) OVER (PARTITION BY
           x.client_id
          ,x.store_id
          ,x.pos_terminal_id
          ,x.time_receipt_ejr
          ,x.dat_formdate
          ,x.orig_receipt_nr_ejr) AS last_sale_line
      ,y.cnt_void_ejr
      ,y.next_orig_receipt_nr_ejr
      ,y.next_time_receipt_ejr
      ,y.transactiontype_id AS header_transactiontype_id
      ,revstr.wh_id
      ,y.val_retail_ejr AS val_total_retail_ejr
    ,(SELECT COALESCE(MAX(CASE WHEN p.cnt_payment_ejr = 0 THEN orig_receipt_serial_nr_ejr ELSE 0 END),0) - COALESCE(MAX(CASE WHEN p.cnt_payment_ejr = 1 THEN orig_receipt_serial_nr_ejr ELSE 0 END),0)
     -- Difference between last position of change and last payment position.
        FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_payment_extract_1 p
        WHERE y.store_id = p.store_id
        AND y.client_id = p.client_id
        AND y.pos_terminal_id = p.pos_terminal_id
        AND y.dat_formdate = p.dat_formdate
        AND y.time_receipt_ejr = p.time_receipt_ejr
        AND y.orig_receipt_nr_ejr = p.orig_receipt_nr_ejr) AS chg_aft_pay
      ,x.authority_id
      ,MAX(CASE WHEN x.transactiontype_id IN ('101', '102', '120', '122', '170') THEN x.val_retail_ejr ELSE 0 END ) OVER (PARTITION BY
           x.client_id
          ,x.store_id
          ,x.pos_terminal_id
          ,x.time_receipt_ejr
          ,x.dat_formdate
          ,x.orig_receipt_nr_ejr) AS highest_val
	 ,(SELECT MAX(s.timestamp_begin_ejr) -- Timestamp of the last subtotal before Storno
	  FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_subtotal_extract_1 s
      WHERE y.store_id = s.store_id
      AND y.client_id = s.client_id
      AND y.pos_terminal_id = s.pos_terminal_id
      AND y.dat_formdate = s.dat_formdate
      AND y.time_receipt_ejr = s.time_receipt_ejr
      AND y.orig_receipt_nr_ejr = s.orig_receipt_nr_ejr
	  AND s.timestamp_begin_ejr < CASE WHEN x.transactiontype_id IN ('171', '173') THEN x.timestamp_begin_ejr ELSE NULL END  -- last part is void_line_nr_ejr (SF does not accept use of alias in a subquery)
	  ) AS last_subtot_bef_void
     ,SUM(CASE WHEN x.transactiontype_id IN ('101', '102', '120', '122') AND x.orig_receipt_serial_nr_ejr > COALESCE(x.parent_line_nr_ejr,0) THEN 1 ELSE 0 END ) OVER (PARTITION BY
           x.client_id
          ,x.store_id
          ,x.pos_terminal_id
          ,x.time_receipt_ejr
          ,x.dat_formdate
          ,x.orig_receipt_nr_ejr) AS cnt_sale_aft_void
     ,x.qty_piece_ejr
     ,x.timestamp_begin_ejr
     ,y.cnt_voided_line
     ,y.receipt_foll
	FROM (SELECT *, RANK() OVER ( PARTITION BY client_id,store_id,checker_id,dat_formdate,orig_receipt_nr_ejr 
	                              ORDER BY timestamp_begin_ejr,orig_receipt_serial_nr_ejr) AS rank_by_timestamp
          FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_receiptline_extract_1) x
    INNER JOIN (
      SELECT tr_foll.* 
      ,(SELECT MIN (tr_next.orig_receipt_nr_ejr)
   FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- follower of current receipt
   WHERE tr_foll.client_id = tr_next.client_id
  AND tr_foll.store_id = tr_next.store_id
  AND tr_foll.pos_terminal_id = tr_next.pos_terminal_id
  AND tr_foll.dat_formdate = tr_next.dat_formdate
  AND tr_foll.checker_id = tr_next.checker_id
  AND tr_next.orig_receipt_nr_ejr > tr_foll.orig_receipt_nr_ejr
      AND tr_next.transactiontype_id NOT IN (400, 405, 420, 425, 430, 480)) receipt_foll
      FROM P_LEW_MART_MSI.v_ejr_all_transact_follower_1 tr_foll) y
      ON y.store_id = x.store_id
      AND y.client_id = x.client_id
      AND y.pos_terminal_id = x.pos_terminal_id
      AND y.dat_formdate = x.dat_formdate
      AND y.time_receipt_ejr = x.time_receipt_ejr
      AND y.orig_receipt_nr_ejr = x.orig_receipt_nr_ejr    
	  -- Join to *load_store to get only the relevant stores
    INNER JOIN P_LEW_MART_MSI.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr
    ON y.store_id = revstr.store_id
      AND y.client_id = revstr.client_id
      AND y.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    WHERE y.transactiontype_id = '100'
      AND y.cnt_void_ejr > 0
      AND NOT EXISTS (
                       SELECT 1
                       FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_payment_1 p
                       INNER JOIN P_LEW_MART_MSI.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 revday
                       ON p.dat_formdate = revday.dat_calendar
                       WHERE y.store_id = p.store_id
                         AND y.client_id = p.client_id
                         AND y.pos_terminal_id = p.pos_terminal_id
                         AND y.dat_formdate = p.dat_formdate
                         AND y.time_receipt_ejr = p.time_receipt_ejr
                         AND y.orig_receipt_nr_ejr = p.orig_receipt_nr_ejr
                         AND p.tendertype_cd_ejr <> '11'
                       -- The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).
                         AND p.dat_formdate >= (SELECT MIN(d_min.dat_calendar) FROM P_LEW_MART_MSI.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 d_min)
                         AND p.dat_formdate <= (SELECT MAX(d_max.dat_calendar) FROM P_LEW_MART_MSI.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 d_max)
                   )
    QUALIFY void_line_nr_ejr > last_sale_line
) t2
/* Look for series (subsequent lines with same item_1) "Doppeltipper" */
LEFT OUTER JOIN
(   SELECT
     client_id
      ,store_id
      ,pos_terminal_id
      ,dat_formdate
      ,orig_receipt_nr_ejr
      ,item_id
      ,COUNT(*) nb_in_series
      ,AVG(is_rp) AS avg_rp
      ,AVG(is_manual) AS avg_manual
      ,STDDEV(qty_piece_ejr) stdev_qty_sold  -- when 0 : all quantities are equal
      ,STDDEV(qty_weight_ejr) stdev_wgt_sold -- when 0 : all weights are equal
      ,SUM(is_scanned) is_scanned
    FROM(
    SELECT
       rle.client_id
      ,rle.store_id
      ,pos_terminal_id
      ,dat_formdate
      ,orig_receipt_nr_ejr
      ,item_id
      ,CASE WHEN (LEAD(item_id) OVER (ORDER BY rle.client_id,rle.store_id,dat_formdate,orig_receipt_nr_ejr,rank_by_timestamp)=item_id )
               OR(LAG(item_id)  OVER (ORDER BY rle.client_id,rle.store_id,dat_formdate,orig_receipt_nr_ejr,rank_by_timestamp)=item_id )
			   THEN 1 ELSE 0 END AS series
       -- this indicates whether current record is a part of series (previous or next line has the same item_1)
      ,CASE WHEN item_entry_method_cd_ejr='RP' THEN 1 ELSE 0 END AS is_rp
      ,CASE WHEN item_entry_method_cd_ejr='KE' THEN 1 ELSE 0 END AS is_manual
      ,qty_piece_ejr
      ,qty_weight_ejr
     , CASE WHEN item_entry_method_cd_ejr='SC' THEN 1 ELSE 0 END AS is_scanned
	FROM (SELECT *, RANK() OVER ( PARTITION BY client_id,store_id,checker_id,dat_formdate,orig_receipt_nr_ejr 
	                              ORDER BY timestamp_begin_ejr,orig_receipt_serial_nr_ejr) AS rank_by_timestamp
          FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_receiptline_extract_1) rle
    INNER JOIN P_LEW_MART_MSI.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr
    ON rle.store_id = revstr.store_id
      AND rle.client_id = revstr.client_id
      AND rle.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
   WHERE transactiontype_id IN ('170', '101')
   -- only voided lines
   QUALIFY series=1
  -- select only series (at least 2 subsequent receipt lines with the same item_1)
   )
   GROUP BY client_id
      ,store_id
      ,pos_terminal_id
      ,dat_formdate
      ,orig_receipt_nr_ejr
      ,item_id
   HAVING stdev_qty_sold = 0 
   AND stdev_wgt_sold = 0
   AND avg_rp = 0
   AND avg_manual < 1
 )rls
ON rls.client_id = t2.client_id
  AND rls.store_id = t2.store_id
  AND rls.pos_terminal_id = t2.pos_terminal_id
  AND rls.dat_formdate =  t2.dat_formdate
  AND rls.orig_receipt_nr_ejr = t2.orig_receipt_nr_ejr
  AND rls.item_id = t2.item_id

/* Ermittlung der stornierten Artikel_1 im Folgebon */
LEFT OUTER JOIN
(
    SELECT
       rlx.client_id
      ,rlx.store_id
      ,rlx.pos_terminal_id
      ,rlx.time_receipt_ejr
      ,rlx.dat_formdate
      ,rlx.orig_receipt_nr_ejr
      ,rlx.item_id
      ,1 AS saled_item
      FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_receiptline_extract_1  rlx
      GROUP BY
       rlx.client_id
      ,rlx.store_id
      ,rlx.pos_terminal_id
      ,rlx.time_receipt_ejr
      ,rlx.dat_formdate
      ,rlx.orig_receipt_nr_ejr
      ,rlx.item_id
) rl
 ON rl.client_id = t2.client_id
 AND rl.store_id = t2.store_id
 AND rl.pos_terminal_id = t2.pos_terminal_id
 AND rl.dat_formdate =  t2.dat_formdate
 AND rl.orig_receipt_nr_ejr = t2.receipt_foll
 AND rl.item_id = t2.item_id
INNER JOIN  P_LEW_MART_MSI.v_ejr_lp_threshold_receipt_1 tr
ON tr.client_id = t2.client_id
WHERE t2.header_transactiontype_id = '100'
  AND ABS(t2.qty_piece_ejr) < 50
GROUP BY
  t2.client_id
  ,t2.store_id
  ,t2.pos_terminal_id
  ,t2.time_receipt_ejr
  ,t2.dat_formdate
  ,t2.orig_receipt_nr_ejr
HAVING is_sale_after_subtotal = 0
  AND    is_voided_value_aft_subtotal = 1
  AND    is_voided_item_innext = 0
  AND    is_voided_after_subtotal = 1
  AND (MAX(COALESCE(nb_in_series,0))<2 OR SUM(CASE WHEN t2.transactiontype_id IN ('171', '173') THEN 1 ELSE 0 END)>1)
  -- no Doppeltipper or more than 1 Storno
);