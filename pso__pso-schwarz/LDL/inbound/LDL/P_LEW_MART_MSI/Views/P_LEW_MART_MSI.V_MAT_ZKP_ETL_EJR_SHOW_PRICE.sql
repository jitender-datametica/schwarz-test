/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_mat_zkp_etl_ejr_show_price
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  02.07.2018    Wandtke,Andrzej          20180419_1646_ZKP_Creation_Threshold_Team1 Add condition on price_subseq_trans_low_val2
#  1.3  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Felder is_kleinstbon_man & is_abmeld_man
#  1.4  26.01.2022    Wandtke, Andrzej         AP0085915_ZKP_SHOW_PRICE scenario 49: Changes in 1st part: look for next receipt by skipping transactions of types 400, 405, 420, 425, 430
#                                                     do not select a record if item is present on next or previous receipt 
#                                                     add all the show price operations that took place immediately before the current operation (series)
#                                                     add column pr_show_orig_receipt_nr_ejr: receipt number of show price operation. For price series it marks end of series, otherwise equal to orig_receipt_nr_ejr
#  1.5  21.04.2022    Wandtke, Andrzej         AP0085915_ZKP_SHOW_PRICE Changes in 1st part: separate QUALIFY conditions on price_ssq_qty_trans_past_3m and on cnt_on_prev + cnt_on_next
#  1.6  05.02.2024    Wandtke, Andrzej         INC7923180 Changes in 1st part: replace condition a11f.cnt_sell_item = 1 AND a11f.cnt_all_deposit_back = 0 by a11f.cnt_sell_item + a11f.cnt_all_deposit_back = 1

#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_SHOW_PRICE
AS
SELECT
 t_uni.orig_receipt_nr_ejr
,MAX(t_uni.pr_show_orig_receipt_nr_ejr) AS pr_show_orig_receipt_nr_ejr
,t_uni.store_id
,t_uni.dat_formdate
,t_uni.pos_terminal_id
,t_uni.client_id
,t_uni.time_receipt_ejr
,t_uni.checker_id
,t_uni.next_val_retail_ejr
,t_uni.val_retail_ejr
,MAX(t_uni.next_orig_receipt_nr_ejr) AS next_orig_receipt_nr_ejr
,t_uni.next_time_receipt_ejr
,t_uni.transactiontype_id
,t_uni.next_transactiontype_id
,t_uni.rank_login_nr
,MAX(t_uni.is_kleinstbon)            AS is_kleinstbon
,MAX(t_uni.is_abmeldung)             AS is_abmeldung
,MAX(t_uni.is_show_price_series)     AS is_show_price_series
,MAX(t_uni.cnt_same_transactiontype) AS cnt_same_transactiontype
,MAX(t_uni.is_kleinstbon_man)        AS is_kleinstbon_man
,MAX(t_uni.is_abmeld_man)            AS is_abmeld_man
FROM
(
SELECT
 orig_receipt_nr_ejr
,pr_show_orig_receipt_nr_ejr
,all_ops_final.store_id
,dat_formdate
,pos_terminal_id
,all_ops_final.client_id
,time_receipt_ejr
,all_ops_final.checker_id
,next_val_retail_ejr
,val_retail_ejr
,next_orig_receipt_nr_ejr
,next_time_receipt_ejr
,transactiontype_id
,next_transactiontype_id
,rank_login_nr
,is_kleinstbon
,is_abmeldung
,CAST(0 AS INTEGER) AS is_show_price_series
,CAST(0 AS INTEGER) AS cnt_same_transactiontype
,CAST(0 AS BYTEINT) AS is_kleinstbon_man
,CAST(0 AS BYTEINT) AS is_abmeld_man
FROM
(
SELECT
 all_ops.orig_receipt_nr_ejr
,all_ops.pr_show_orig_receipt_nr_ejr
,all_ops.store_id
,all_ops.dat_formdate
,all_ops.pos_terminal_id
,all_ops.client_id
,all_ops.time_receipt_ejr
,all_ops.checker_id
,all_ops.next_val_retail_ejr
,all_ops.val_retail_ejr
,all_ops.next_orig_receipt_nr_ejr
,all_ops.next_time_receipt_ejr
,all_ops.transactiontype_id
,all_ops.next_transactiontype_id
,all_ops.rank_login_nr
,all_ops.is_kleinstbon
,all_ops.is_abmeldung
,(SELECT COUNT(*)
  FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_receiptline_extract prev_rec
  WHERE all_ops.store_id = prev_rec.store_id
  AND all_ops.client_id = prev_rec.client_id
  AND all_ops.pos_terminal_id = prev_rec.pos_terminal_id
  AND all_ops.checker_id = prev_rec.checker_id
  AND all_ops.dat_formdate = prev_rec.dat_formdate
  AND prev_orig_receipt_nr_ejr = prev_rec.orig_receipt_nr_ejr
  AND pr_inf.item_id = prev_rec.item_id
 ) cnt_on_prev
,(SELECT COUNT(*)
  FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_receiptline_extract next_rec
  WHERE all_ops.store_id = next_rec.store_id
  AND all_ops.client_id = next_rec.client_id
  AND all_ops.pos_terminal_id = next_rec.pos_terminal_id
  AND all_ops.checker_id = next_rec.checker_id
  AND all_ops.dat_formdate = next_rec.dat_formdate
  AND next_orig_receipt_nr_ejr = next_rec.orig_receipt_nr_ejr
  AND pr_inf.item_id = next_rec.item_id
 ) cnt_on_next
FROM
(SELECT
 pr_series.orig_receipt_nr_ejr 
,pr_show.orig_receipt_nr_ejr pr_show_orig_receipt_nr_ejr
,pr_series.store_id
,pr_series.dat_formdate
,pr_series.pos_terminal_id
,pr_series.client_id
,pr_series.time_receipt_ejr
,pr_series.checker_id
,pr_series.next_val_retail_ejr
,pr_series.val_retail_ejr
,pr_show.next_orig_receipt_nr_ejr
,pr_series.next_time_receipt_ejr
,pr_series.transactiontype_id
,pr_series.next_transactiontype_id
,pr_series.rank_login_nr
-- Mark series by '2', show price operations by '1'
,CASE WHEN pr_series.orig_receipt_nr_ejr=pr_show.orig_receipt_nr_ejr THEN pr_show.is_kleinstbon ELSE pr_show.is_kleinstbon*2 END is_kleinstbon
,CASE WHEN pr_series.orig_receipt_nr_ejr=pr_show.orig_receipt_nr_ejr THEN pr_show.is_abmeldung ELSE pr_show.is_abmeldung*2 END is_abmeldung
,(SELECT MAX(orig_receipt_nr_ejr) prev_orig_receipt_nr_ejr
   FROM p_lew_mart_msi.v_ejr_all_transact_follower tr_prev
  WHERE pr_series.client_id = tr_prev.client_id
  AND pr_series.store_id = tr_prev.store_id
  AND pr_series.pos_terminal_id = tr_prev.pos_terminal_id
  AND pr_series.dat_formdate = tr_prev.dat_formdate
  AND pr_series.checker_id = tr_prev.checker_id
  AND pr_series.orig_receipt_nr_ejr > tr_prev.orig_receipt_nr_ejr
  AND transactiontype_id NOT IN('400', '405', '420', '425', '430', '480')
) AS prev_orig_receipt_nr_ejr

FROM p_lew_mart_msi.v_ejr_all_transact_follower pr_series
INNER JOIN
(
  SELECT
   a11.orig_receipt_nr_ejr
  ,a11.store_id
  ,a11.dat_formdate
  ,a11.pos_terminal_id
  ,a11.client_id
  ,a11.time_receipt_ejr
  ,a11.checker_id
  ,a11.next_val_retail_ejr
  ,a11.val_retail_ejr
  ,a11f.orig_receipt_nr_ejr next_orig_receipt_nr_ejr
  ,a11.next_time_receipt_ejr
  ,a11.transactiontype_id
  ,a11.next_transactiontype_id
  ,a11.rank_login_nr
  ,CASE WHEN a11f.transactiontype_id = '100' THEN 1 ELSE 0 END AS is_kleinstbon
  ,CASE WHEN a11f.transactiontype_id = '410' THEN 1 ELSE 0 END AS is_abmeldung
  FROM
  (SELECT tr_foll.*
   ,(SELECT MIN (tr_next.orig_receipt_nr_ejr)
     FROM p_lew_mart_msi.v_ejr_all_transact_follower tr_next -- follower of current receipt
     WHERE tr_foll.client_id = tr_next.client_id
    AND tr_foll.store_id = tr_next.store_id
    AND tr_foll.pos_terminal_id = tr_next.pos_terminal_id
    AND tr_foll.dat_formdate = tr_next.dat_formdate
    AND tr_foll.checker_id = tr_next.checker_id
    AND tr_next.orig_receipt_nr_ejr > tr_foll.orig_receipt_nr_ejr
    AND tr_next.transactiontype_id NOT IN('400', '405', '420', '425', '430')) receipt_foll
   FROM p_lew_mart_msi.v_ejr_all_transact_follower tr_foll) AS a11
  INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt a12
  ON a11.client_id = a12.client_id
  
  -- next receipt
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower a11f
   ON a11.client_id = a11f.client_id
   AND a11.store_id = a11f.store_id
   AND a11.pos_terminal_id = a11f.pos_terminal_id
   AND a11.receipt_foll = a11f.orig_receipt_nr_ejr
   AND a11.dat_formdate = a11f.dat_formdate

  /* Join to *load_store to get only the relevant stores  */
  INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
  ON a11.store_id = revstr.store_id
    AND a11.client_id = revstr.client_id
    AND a11.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
  WHERE a11.transactiontype_id = '480'
    AND  ( (     a11f.transactiontype_id = '100'
             AND a11f.val_retail_ejr < a12.price_subseq_trans_low_val
             AND a11f.cnt_sell_item + a11f.cnt_all_deposit_back = 1 -- There has to be exactly one item, either sale or deposit collection
             AND a11f.cnt_wo_deposit_voided_line = 0)
       OR (     a11f.transactiontype_id = '410')
     )
   AND a11.val_retail_ejr > COALESCE(a12.price_subseq_trans_low_val2,0)
) pr_show
ON pr_series.client_id = pr_show.client_id
  AND pr_series.store_id = pr_show.store_id
  AND pr_series.checker_id = pr_show.checker_id
  AND pr_series.dat_formdate = pr_show.dat_formdate
  AND pr_series.orig_receipt_nr_ejr <= pr_show.orig_receipt_nr_ejr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON pr_series.store_id = revstr.store_id
  AND pr_series.client_id = revstr.client_id
  AND pr_series.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
 
WHERE pr_series.transactiontype_id = '480'
-- this condition will only restrict selection to show prices that are part of a series. The assumption here is that all the receipt numbers of a series are incremented by 1.
--QUALIFY series_diff < series_position
QUALIFY pr_show.orig_receipt_nr_ejr-pr_series.orig_receipt_nr_ejr < ROW_NUMBER() OVER (PARTITION BY pr_show.client_id, pr_show.store_id, pr_show.checker_id, pr_show.dat_formdate, pr_show.orig_receipt_nr_ejr ORDER BY pr_series.orig_receipt_nr_ejr DESC)

) all_ops

-- details of show price operation
INNER JOIN p_lew_mart_msi.V_MAT0_ZKP_ETL_EJR_PRICE_INFO_EXTRACT pr_inf
ON all_ops.client_id = pr_inf.client_id
  AND all_ops.store_id = pr_inf.store_id
  AND all_ops.pos_terminal_id = pr_inf.pos_terminal_id
  AND all_ops.orig_receipt_nr_ejr = pr_inf.orig_receipt_nr_ejr
  AND all_ops.dat_formdate = pr_inf.dat_formdate

QUALIFY SUM(cnt_on_prev + cnt_on_next) OVER (PARTITION BY all_ops.client_id, all_ops.store_id, all_ops.checker_id, all_ops.pos_terminal_id, all_ops.dat_formdate, all_ops.pr_show_orig_receipt_nr_ejr) = 0
-- item is not on next receipt and not on previous receipt
) all_ops_final
 INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_cumulation a14
 ON all_ops_final.store_id = a14.store_id
  AND all_ops_final.client_id = a14.client_id
  AND all_ops_final.checker_id = a14.checker_id

-- Anzahl Preisanzeigen
QUALIFY SUM(1) OVER (PARTITION BY all_ops_final.client_id, all_ops_final.store_id, all_ops_final.checker_id) >= a14.price_ssq_qty_trans_past_3m
-- Anzahl Vorgangen
AND   SUM(CASE WHEN is_kleinstbon=1 OR is_abmeldung=1 THEN 1 ELSE 0 END) OVER (PARTITION BY all_ops_final.client_id, all_ops_final.store_id, all_ops_final.checker_id ) >= a14.price_ssq_qty_trans_randm_1w
UNION ALL
/* The second part of the UNION processes the show_price_series  */
SELECT
 tr2.orig_receipt_nr_ejr
,NULL
,tr2.store_id
,tr2.dat_formdate
,tr2.pos_terminal_id
,tr2.client_id
,tr2.time_receipt_ejr
,tr2.checker_id
,tr2.next_val_retail_ejr
,tr2.val_retail_ejr
,tr2.next_orig_receipt_nr_ejr
,tr2.next_time_receipt_ejr
,tr2.transactiontype_id
,tr2.next_transactiontype_id
,tr2.rank_login_nr
,0 AS is_kleinstbon
,0 AS is_abmeldung
,1 AS is_show_price_series
,COUNT(1) Over (PARTITION BY tr2.store_id  ,tr2.client_id  ,tr2.checker_id  ,tr2.dat_formdate  ,tr2.csum_transactiontype_change ORDER BY 1 ROWS BETWEEN UNBOUNDED PRECEDING   AND UNBOUNDED FOLLOWING) AS cnt_same_transactiontype
,0 AS is_kleinstbon_man
,0 AS is_abmeld_man
FROM
(SELECT
 tr1.orig_receipt_nr_ejr
,tr1.store_id
,tr1.dat_formdate
,tr1.pos_terminal_id
,tr1.client_id
,tr1.time_receipt_ejr
,tr1.checker_id
,tr1.next_val_retail_ejr
,tr1.val_retail_ejr
,tr1.next_orig_receipt_nr_ejr
,tr1.next_time_receipt_ejr
,tr1.transactiontype_id
,tr1.next_transactiontype_id
,tr1.rank_login_nr
,CASE WHEN tr1.transactiontype_id <> COALESCE(tr1.prev_transactiontype_id  ,'XXX') THEN 1 ELSE 0 END AS transactiontype_change_fg
,SUM(transactiontype_change_fg) OVER (PARTITION BY tr1.store_id  ,tr1.client_id  ,tr1.checker_id  ,tr1.dat_formdate ORDER BY tr1.rank_login_nr ROWS UNBOUNDED PRECEDING) AS csum_transactiontype_change
FROM p_lew_mart_msi.v_ejr_all_transact_follower tr1
/* Join to *load_store to get only the relevant stores  */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON tr1.store_id = revstr.store_id
AND tr1.client_id = revstr.client_id
AND tr1.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
) tr2
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt th_r
ON th_r.client_id = tr2.client_id

WHERE tr2.transactiontype_id = '480'
QUALIFY tr2.transactiontype_change_fg = 1
/* THRESHOLD for number of receipts:
 The following condition determines  ,how many price info transactions have to be in the sequence to be processed.
 If the threshold is NULL we use 2 instead  ,because a "series" is defined out of at least 2 occurrences in a line.  */
AND   cnt_same_transactiontype >= COALESCE(th_r.price_series_receipt_cnt  ,2)

/* THRESHOLD for receipt sum of transactions:
 The following condition determines the receipts total that has to be exceeded in order to be processed.
 The sum has to consider ALL price info transactions in the sequence. E.g. if there are 4 price info transactions in a sequence with each 1 EUR as val_retail_ejr  ,the sum is 4 EUR. This 4 EUR has to exceed the threshold.  */
AND SUM(tr2.val_retail_ejr) OVER (PARTITION BY tr2.store_id  ,tr2.client_id  ,tr2.checker_id  ,tr2.dat_formdate  ,tr2.csum_transactiontype_change ORDER BY 1 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) > COALESCE(th_r.price_series_receipt_total_val  ,2)
UNION ALL
/* Required for BBT-1566 - Manual Scenario for Show Price followed by Kleinstbon or Abmeldung */
SELECT
 a11.orig_receipt_nr_ejr
,NULL
,a11.store_id
,a11.dat_formdate
,a11.pos_terminal_id
,a11.client_id
,a11.time_receipt_ejr
,a11.checker_id
,a11.next_val_retail_ejr
,a11.val_retail_ejr
,a11.next_orig_receipt_nr_ejr
,a11.next_time_receipt_ejr
,a11.transactiontype_id
,a11.next_transactiontype_id
,a11.rank_login_nr
,CAST(0 AS BYTEINT) AS is_kleinstbon
,CAST(0 AS BYTEINT) AS is_abmeldung
,CAST(0 AS INTEGER) AS is_show_price_series
,CAST(0 AS INTEGER) AS cnt_same_transactiontype
,CASE WHEN a11.next_transactiontype_id = '100'
         AND a11.next_val_retail_ejr < tm.mshow_price_low_nxt_receipt_val THEN 1 ELSE 0 END AS is_kleinstbon_man
,CASE WHEN a11.next_transactiontype_id = '410' THEN 1 ELSE 0 END AS is_abmeld_man
FROM p_lew_mart_msi.v_ejr_all_transact_follower a11
INNER JOIN p_lew_mart_msi.v_cal_calendarday a13
ON a11.dat_formdate = a13.dat_calendar
INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower a11f
ON a11.client_id = a11f.client_id
AND a11.store_id = a11f.store_id
AND a11.pos_terminal_id = a11f.pos_terminal_id
AND a11.next_orig_receipt_nr_ejr = a11f.orig_receipt_nr_ejr
AND a11.next_time_receipt_ejr = a11f.time_receipt_ejr
AND a11.dat_formdate = a11f.dat_formdate
/* Join to *load_store to get only the relevant stores  */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON a11.store_id  = revstr.store_id
AND a11.client_id = revstr.client_id
AND a11.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
/* New Join to manual thresholds */
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_manual tm
ON a11.client_id  = tm.client_id
AND a11.store_id   = tm.store_id
AND a11.checker_id = tm.checker_id
WHERE a11.transactiontype_id = '480'
    AND ((a11.next_transactiontype_id = '100'
         AND a11.next_val_retail_ejr < tm.mshow_price_low_nxt_receipt_val
         AND a11f.cnt_sell_item = 1   AND a11f.cnt_all_deposit_back = 0
         AND a11f.cnt_wo_deposit_voided_line = 0
        )
          OR (a11.next_transactiontype_id = '410'))

) t_uni
GROUP BY
  t_uni.orig_receipt_nr_ejr
 ,t_uni.store_id
 ,t_uni.dat_formdate
 ,t_uni.pos_terminal_id
 ,t_uni.client_id
 ,t_uni.time_receipt_ejr
 ,t_uni.checker_id
 ,t_uni.val_retail_ejr
 ,t_uni.next_val_retail_ejr
 ,t_uni.next_time_receipt_ejr
 ,t_uni.transactiontype_id
 ,t_uni.next_transactiontype_id
 ,t_uni.rank_login_nr
;

