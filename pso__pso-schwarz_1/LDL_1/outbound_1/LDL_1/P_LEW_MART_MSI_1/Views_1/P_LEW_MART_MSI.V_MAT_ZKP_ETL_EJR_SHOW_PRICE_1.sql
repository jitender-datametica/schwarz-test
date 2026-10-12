/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_mat_zkp_etl_ejr_show_price_1
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  02.07.2018    Wandtke,Andrzej          20180419_1646_ZKP_Creation_Threshold_Team1 Add condition on price_subseq_trans_low_val2
#  1.3  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Felder is_kleinstbon_man & is_abmeld_man
#  1.4  26.01.2022    Wandtke, Andrzej         AP0085915_ZKP_SHOW_PRICE scenario 49: Changes in 1st part: look for next receipt by skipping transactions of types 400, 405, 420, 425, 430
#                                                     do not select a record if item_1 is present on next or previous receipt 
#                                                     add all the show price operations that took place immediately before the current operation (series)
#                                                     add column pr_show_orig_receipt_nr_ejr: receipt number of show price operation. For price series it marks end of series, otherwise equal to orig_receipt_nr_ejr
#  1.5  21.04.2022    Wandtke, Andrzej         AP0085915_ZKP_SHOW_PRICE Changes in 1st part: separate QUALIFY conditions on price_ssq_qty_trans_past_3m and on cnt_on_prev + cnt_on_next
#  1.6  05.02.2024    Wandtke, Andrzej         INC7923180 Changes in 1st part: replace condition a11f.cnt_sell_item = 1 AND a11f.cnt_all_deposit_back = 0 by a11f.cnt_sell_item + a11f.cnt_all_deposit_back = 1

#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_show_price_1 AS -- follower of current receipt

-- details of show price operation
 /* The second part of the UNION processes the show_price_series */
/* CROSS JOIN to *load_store to get only the relevant stores */
/* THRESHOLD for receipt sum of transactions:
 The following condition determines the receipts total that has to be exceeded in order to be processed.
 The sum has to consider ALL price info transactions in the sequence. E.g. if there are 4 price info transactions in a sequence with each 1 EUR as val_retail_ejr  ,the sum is 4 EUR. This 4 EUR has to exceed the threshold. */
/* Required for BBT-1566 - Manual Scenario for Show Price followed by Kleinstbon or Abmeldung */ SELECT
 orig_receipt_nr_ejr,
 MAX(pr_show_orig_receipt_nr_ejr) AS pr_show_orig_receipt_nr_ejr,
 store_id,
 dat_formdate,
 pos_terminal_id,
 client_id,
 time_receipt_ejr,
 checker_id,
 next_val_retail_ejr,
 val_retail_ejr,
 MAX(next_orig_receipt_nr_ejr) AS next_orig_receipt_nr_ejr,
 next_time_receipt_ejr,
 transactiontype_id,
 next_transactiontype_id,
 rank_login_nr,
 MAX(is_kleinstbon) AS is_kleinstbon,
 MAX(is_abmeldung) AS is_abmeldung,
 MAX(is_show_price_series) AS is_show_price_series,
 MAX(cnt_same_transactiontype) AS cnt_same_transactiontype,
 MAX(is_kleinstbon_man) AS is_kleinstbon_man,
 MAX(is_abmeld_man) AS is_abmeld_man
FROM (SELECT all_ops_final.orig_receipt_nr_ejr,
    all_ops_final.pr_show_orig_receipt_nr_ejr,
    all_ops_final.store_id,
    all_ops_final.dat_formdate,
    all_ops_final.pos_terminal_id,
    all_ops_final.client_id,
    all_ops_final.time_receipt_ejr,
    all_ops_final.checker_id,
    all_ops_final.next_val_retail_ejr,
    all_ops_final.val_retail_ejr,
    all_ops_final.next_orig_receipt_nr_ejr,
    all_ops_final.next_time_receipt_ejr,
    all_ops_final.transactiontype_id,
    all_ops_final.next_transactiontype_id,
    all_ops_final.rank_login_nr,
    all_ops_final.is_kleinstbon,
    all_ops_final.is_abmeldung,
    0 AS is_show_price_series,
    0 AS cnt_same_transactiontype,
    0 AS is_kleinstbon_man,
    0 AS is_abmeld_man
   FROM (SELECT all_ops.orig_receipt_nr_ejr,
      all_ops.pr_show_orig_receipt_nr_ejr,
      all_ops.store_id,
      all_ops.dat_formdate,
      all_ops.pos_terminal_id,
      all_ops.client_id,
      all_ops.time_receipt_ejr,
      all_ops.checker_id,
      all_ops.next_val_retail_ejr,
      all_ops.val_retail_ejr,
      all_ops.next_orig_receipt_nr_ejr,
      all_ops.next_time_receipt_ejr,
      all_ops.transactiontype_id,
      all_ops.next_transactiontype_id,
      all_ops.rank_login_nr,
      all_ops.is_kleinstbon,
      all_ops.is_abmeldung,
       (SELECT COUNT(*)
       FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS PREV_REC
       WHERE all_ops.store_id = store_id
        AND all_ops.client_id = client_id
        AND all_ops.pos_terminal_id = pos_terminal_id
        AND all_ops.checker_id = checker_id
        AND all_ops.dat_formdate = dat_formdate
        AND all_ops.prev_orig_receipt_nr_ejr = orig_receipt_nr_ejr
        AND PR_INF.item_id = item_id) AS cnt_on_prev,
       (SELECT COUNT(*)
       FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS NEXT_REC
       WHERE all_ops.store_id = store_id
        AND all_ops.client_id = client_id
        AND all_ops.pos_terminal_id = pos_terminal_id
        AND all_ops.checker_id = checker_id
        AND all_ops.dat_formdate = dat_formdate
        AND all_ops.next_orig_receipt_nr_ejr = orig_receipt_nr_ejr
        AND PR_INF.item_id = item_id) AS cnt_on_next
     FROM (SELECT t10.orig_receipt_nr_ejr,
        t10.pr_show_orig_receipt_nr_ejr,
        t10.store_id,
        t10.dat_formdate,
        t10.pos_terminal_id,
        t10.client_id,
        t10.time_receipt_ejr,
        t10.checker_id,
        t10.next_val_retail_ejr,
        t10.val_retail_ejr,
        t10.next_orig_receipt_nr_ejr,
        t10.next_time_receipt_ejr,
        t10.transactiontype_id,
        t10.next_transactiontype_id,
        t10.rank_login_nr,
        t10.is_kleinstbon,
        t10.is_abmeldung,
        t10.prev_orig_receipt_nr_ejr
       FROM (SELECT PR_SERIES.orig_receipt_nr_ejr,
          pr_show.orig_receipt_nr_ejr AS pr_show_orig_receipt_nr_ejr,
          PR_SERIES.store_id,
          PR_SERIES.dat_formdate,
          PR_SERIES.pos_terminal_id,
          PR_SERIES.client_id,
          PR_SERIES.time_receipt_ejr,
          PR_SERIES.checker_id,
          PR_SERIES.next_val_retail_ejr,
          PR_SERIES.val_retail_ejr,
          pr_show.next_orig_receipt_nr_ejr,
          PR_SERIES.next_time_receipt_ejr,
          PR_SERIES.transactiontype_id,
          PR_SERIES.next_transactiontype_id,
          PR_SERIES.rank_login_nr -- Mark series by '2', show price operations by '1'
,
           CASE
           WHEN PR_SERIES.orig_receipt_nr_ejr = pr_show.orig_receipt_nr_ejr
           THEN pr_show.is_kleinstbon
           ELSE pr_show.is_kleinstbon * 2
           END AS is_kleinstbon,
           CASE
           WHEN PR_SERIES.orig_receipt_nr_ejr = pr_show.orig_receipt_nr_ejr
           THEN pr_show.is_abmeldung
           ELSE pr_show.is_abmeldung * 2
           END AS is_abmeldung,
           (SELECT MAX(orig_receipt_nr_ejr) AS prev_orig_receipt_nr_ejr
           FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS TR_PREV
           WHERE PR_SERIES.client_id = client_id
            AND PR_SERIES.store_id = store_id
            AND PR_SERIES.pos_terminal_id = pos_terminal_id
            AND PR_SERIES.dat_formdate = dat_formdate
            AND PR_SERIES.checker_id = checker_id
            AND PR_SERIES.orig_receipt_nr_ejr > orig_receipt_nr_ejr
            AND transactiontype_id NOT IN ('400', '405', '420', '425', '430', '480')) AS prev_orig_receipt_nr_ejr,
          pr_show.orig_receipt_nr_ejr AS orig_receipt_nr_ejr0,
          pr_show.client_id AS client_id0,
          pr_show.store_id AS store_id0,
          pr_show.checker_id AS checker_id0,
          pr_show.dat_formdate AS dat_formdate0
         FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS PR_SERIES
          INNER JOIN (SELECT a11.orig_receipt_nr_ejr,
            a11.store_id,
            a11.dat_formdate,
            a11.pos_terminal_id,
            a11.client_id,
            a11.time_receipt_ejr,
            a11.checker_id,
            a11.next_val_retail_ejr,
            a11.val_retail_ejr,
            A11F.orig_receipt_nr_ejr AS next_orig_receipt_nr_ejr,
            a11.next_time_receipt_ejr,
            a11.transactiontype_id,
            a11.next_transactiontype_id,
            a11.rank_login_nr,
             CASE
             WHEN A11F.transactiontype_id = '100'
             THEN 1
             ELSE 0
             END AS is_kleinstbon,
             CASE
             WHEN A11F.transactiontype_id = '410'
             THEN 1
             ELSE 0
             END AS is_abmeldung
           FROM (SELECT store_id,
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
                AND transactiontype_id NOT IN ('400', '405', '420', '425', '430')) AS receipt_foll
             FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS TR_FOLL) AS a11
            INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS A12 ON a11.client_id = A12.client_id
             -- next receipt

            INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS A11F ON a11.client_id = A11F.client_id AND a11
                 .store_id = A11F.store_id AND a11.pos_terminal_id = A11F.pos_terminal_id AND a11.receipt_foll = A11F.orig_receipt_nr_ejr
                AND a11.dat_formdate = A11F.dat_formdate /* CROSS JOIN to *load_store to get only the relevant stores */
              
            INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON a11.store_id = REVSTR
               .store_id AND a11.client_id = REVSTR.client_id AND a11.dat_formdate BETWEEN REVSTR.dat_formdate_from AND
              REVSTR.dat_formdate_until
           WHERE a11.transactiontype_id = '480'
            AND (A11F.transactiontype_id = '100' AND A11F.val_retail_ejr < A12.price_subseq_trans_low_val AND A11F.cnt_sell_item
                   + A11F.cnt_all_deposit_back = 1
                 -- There has to be exactly one item_1, either sale or deposit collection
 AND A11F.cnt_wo_deposit_voided_line
                 = 0 OR A11F.transactiontype_id = '410')
            AND a11.val_retail_ejr > COALESCE(A12.price_subseq_trans_low_val2, 0)) AS pr_show ON PR_SERIES.client_id =
               pr_show.client_id AND PR_SERIES.store_id = pr_show.store_id AND PR_SERIES.checker_id = pr_show.checker_id
               AND PR_SERIES.dat_formdate = pr_show.dat_formdate AND PR_SERIES.orig_receipt_nr_ejr <= pr_show.orig_receipt_nr_ejr
            
          INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR0 ON PR_SERIES.store_id =
             REVSTR0.store_id AND PR_SERIES.client_id = REVSTR0.client_id AND PR_SERIES.dat_formdate BETWEEN REVSTR0.dat_formdate_from
            AND REVSTR0.dat_formdate_until
         WHERE PR_SERIES.transactiontype_id = '480'
           -- this condition will only restrict selection to show prices that are part of a series. The assumption here is that all the receipt numbers of a series are incremented by 1.

           -- QUALIFY series_diff < series_position

         QUALIFY orig_receipt_nr_ejr0 - PR_SERIES.orig_receipt_nr_ejr < (ROW_NUMBER() OVER (PARTITION BY client_id0,
               store_id0, checker_id0, dat_formdate0, orig_receipt_nr_ejr0 ORDER BY PR_SERIES.orig_receipt_nr_ejr
               IS NULL DESC, PR_SERIES.orig_receipt_nr_ejr DESC))) AS t10) AS all_ops
      INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_price_info_extract_1 AS PR_INF ON all_ops.client_id = PR_INF.client_id
            AND all_ops.store_id = PR_INF.store_id AND all_ops.pos_terminal_id = PR_INF.pos_terminal_id AND all_ops.orig_receipt_nr_ejr
          = PR_INF.orig_receipt_nr_ejr AND all_ops.dat_formdate = PR_INF.dat_formdate
     QUALIFY (SUM(cnt_on_prev + cnt_on_next) OVER (PARTITION BY all_ops.client_id, all_ops.store_id, all_ops.checker_id
           , all_ops.pos_terminal_id, all_ops.dat_formdate, all_ops.pr_show_orig_receipt_nr_ejr RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0 -- item_1 is not on next receipt and not on previous receipt
)
    AS all_ops_final
    INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_cumulation_1 AS A14 ON all_ops_final.store_id = A14.store_id AND
       all_ops_final.client_id = A14.client_id AND all_ops_final.checker_id = A14.checker_id -- Anzahl Preisanzeigen

   QUALIFY (SUM(1) OVER (PARTITION BY all_ops_final.client_id, all_ops_final.store_id, all_ops_final.checker_id
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) >= A14.price_ssq_qty_trans_past_3m
      -- Anzahl Vorgangen
 AND (SUM(CASE
         WHEN all_ops_final.is_kleinstbon = 1 OR all_ops_final.is_abmeldung = 1
         THEN 1
         ELSE 0
         END) OVER (PARTITION BY all_ops_final.client_id, all_ops_final.store_id, all_ops_final.checker_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) >= A14.price_ssq_qty_trans_randm_1w
   UNION ALL
   SELECT tr2.orig_receipt_nr_ejr,
    CAST(NULL AS INTEGER),
    tr2.store_id,
    tr2.dat_formdate,
    tr2.pos_terminal_id,
    tr2.client_id,
    tr2.time_receipt_ejr,
    tr2.checker_id,
    tr2.next_val_retail_ejr,
    tr2.val_retail_ejr,
    tr2.next_orig_receipt_nr_ejr,
    tr2.next_time_receipt_ejr,
    tr2.transactiontype_id,
    tr2.next_transactiontype_id,
    tr2.rank_login_nr,
    0 AS is_kleinstbon,
    0 AS is_abmeldung,
    1 AS is_show_price_series,
    COUNT(1) OVER (PARTITION BY tr2.store_id, tr2.client_id, tr2.checker_id, tr2.dat_formdate, tr2.csum_transactiontype_change
       ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_same_transactiontype,
    0 AS is_kleinstbon_man,
    0 AS is_abmeld_man
   FROM (SELECT TR1.orig_receipt_nr_ejr,
      TR1.store_id,
      TR1.dat_formdate,
      TR1.pos_terminal_id,
      TR1.client_id,
      TR1.time_receipt_ejr,
      TR1.checker_id,
      TR1.next_val_retail_ejr,
      TR1.val_retail_ejr,
      TR1.next_orig_receipt_nr_ejr,
      TR1.next_time_receipt_ejr,
      TR1.transactiontype_id,
      TR1.next_transactiontype_id,
      TR1.rank_login_nr,
       CASE
       WHEN TR1.transactiontype_id <> COALESCE(TR1.prev_transactiontype_id, 'XXX_1')
       THEN 1
       ELSE 0
       END AS transactiontype_change_fg,
      SUM(CASE
        WHEN TR1.transactiontype_id <> COALESCE(TR1.prev_transactiontype_id, 'XXX_1')
        THEN 1
        ELSE 0
        END) OVER (PARTITION BY TR1.store_id, TR1.client_id, TR1.checker_id, TR1.dat_formdate ORDER BY TR1.rank_login_nr
         IS NULL, TR1.rank_login_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS csum_transactiontype_change
     FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS TR1
      INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON TR1.store_id = REVSTR.store_id
          AND TR1.client_id = REVSTR.client_id AND TR1.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
        ) AS tr2
    INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS TH_R ON tr2.client_id = TH_R.client_id
   WHERE tr2.transactiontype_id = '480'
   QUALIFY tr2.transactiontype_change_fg = 1
       /* THRESHOLD for number of receipts:
 The following condition determines  ,how many price info transactions have to be in the sequence to be processed.
 If the threshold is NULL we use 2 instead  ,because a "series" is defined out of at least 2 occurrences in a line. */
        AND (COUNT(1) OVER (PARTITION BY tr2.store_id, tr2.client_id, tr2.checker_id, tr2.dat_formdate, tr2.csum_transactiontype_change
           ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) >= COALESCE(TH_R.price_series_receipt_cnt
        , 2) AND (SUM(tr2.val_retail_ejr) OVER (PARTITION BY tr2.store_id, tr2.client_id, tr2.checker_id, tr2.dat_formdate
          , tr2.csum_transactiontype_change ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING)) > COALESCE(TH_R.price_series_receipt_total_val, 2)
   UNION ALL
   SELECT A11.orig_receipt_nr_ejr,
    CAST(NULL AS INTEGER),
    A11.store_id,
    A11.dat_formdate,
    A11.pos_terminal_id,
    A11.client_id,
    A11.time_receipt_ejr,
    A11.checker_id,
    A11.next_val_retail_ejr,
    A11.val_retail_ejr,
    A11.next_orig_receipt_nr_ejr,
    A11.next_time_receipt_ejr,
    A11.transactiontype_id,
    A11.next_transactiontype_id,
    A11.rank_login_nr,
    0 AS is_kleinstbon,
    0 AS is_abmeldung,
    0 AS is_show_price_series,
    0 AS cnt_same_transactiontype,
     CASE
     WHEN A11.next_transactiontype_id = '100' AND A11.next_val_retail_ejr < TM.mshow_price_low_nxt_receipt_val
     THEN 1
     ELSE 0
     END AS is_kleinstbon_man,
     CASE
     WHEN A11.next_transactiontype_id = '410'
     THEN 1
     ELSE 0
     END AS is_abmeld_man
   FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS A11
    INNER JOIN ldl_p_lew_mart_msi.v_cal_calendarday_1 AS A13 ON A11.dat_formdate = A13.dat_calendar
    INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS A11F ON A11.client_id = A11F.client_id AND A11.store_id
           = A11F.store_id AND A11.pos_terminal_id = A11F.pos_terminal_id AND A11.next_orig_receipt_nr_ejr = A11F.orig_receipt_nr_ejr
         AND A11.next_time_receipt_ejr = A11F.time_receipt_ejr AND A11.dat_formdate = A11F.dat_formdate
      /* CROSS JOIN to *load_store to get only the relevant stores */
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON A11.store_id = REVSTR.store_id
        AND A11.client_id = REVSTR.client_id AND A11.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
      /* New CROSS JOIN to manual thresholds */
    INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_manual_1 AS TM ON A11.client_id = TM.client_id AND A11.store_id = TM
       .store_id AND A11.checker_id = TM.checker_id
   WHERE A11.transactiontype_id = '480'
    AND (A11.next_transactiontype_id = '100' AND A11.next_val_retail_ejr < TM.mshow_price_low_nxt_receipt_val AND A11F.cnt_sell_item
           = 1 AND A11F.cnt_all_deposit_back = 0 AND A11F.cnt_wo_deposit_voided_line = 0 OR A11.next_transactiontype_id
       = '410')) AS t_uni
GROUP BY orig_receipt_nr_ejr,
 store_id,
 dat_formdate,
 pos_terminal_id,
 client_id,
 time_receipt_ejr,
 checker_id,
 val_retail_ejr,
 next_val_retail_ejr,
 next_time_receipt_ejr,
 transactiontype_id,
 next_transactiontype_id,
 rank_login_nr;