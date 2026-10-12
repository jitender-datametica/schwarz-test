/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_ejr_all_transact_prepare_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.10.2017    -                        Generiert aus Teradata
#  1.1  06.11.2017    Proch,Marika             Die View f_view.v_sys_revision_load_store_wrk_1 wurde ersetzt durch die Tabelle F_lew_mart_msi.t_msi_sys_revision_load_store_wrk_1
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205) scenario_id bytes 6 & 7 angepasst.
#  1.5  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) - scenario_id byte 15 angepasst
#  1.6  10.10.2023    Wandtke,Andrzej          AP0177990  - Byte 15: change from 2 to 1 in order not to lose receipts when matching scenarios
#  1.7  24.11.2023    Wandtke,Andrzej          INC7623719 - Byte 15: remove line WHEN x.transactiontype_id = '150' AND geldrueck.is_return_same_checker = 1 THEN '1'
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_all_transact_prepare_1 AS /* Byte 1   Grouping over Transaction type */
/* Byte 2 Flag für Storno (Nur für Verkaufsbon) */ /* Byte 3 */ /* Byte 4 */ /* Anmeldung */ /* Byte 5 */
/* Abmeldung */ /* Byte 6 */ /* Phase 2 */ /* Byte 7 */ /* Phase 2 */ /* Phase 2 */ /* Phase 2 */ /* Byte 8 */
/* Phase 2 */ /* Phase 2 */ /* Byte 9 */ /* Phase 2 */ /* Offene Bonrückstellung */ /* Byte 10 */ /* Phase 2 */
/* Byte 11 */ /* Bonrückstellung - Kleinstbon */ /* Bonabbruch - Kleinstbon */ /* Byte 12 */ /* Byte 13 */ /* Byte 14 */
/* Byte 15 */ /* EAN_1 */ /* Byte 16 */ SELECT X.store_id,
 X.client_id,
 X.pos_terminal_id,
 X.dat_formdate,
 X.time_receipt_ejr,
 X.orig_receipt_nr_ejr,
 X.timezone_cd,
 X.dat_dayend,
 X.checker_id,
 X.transactiontype_id,
 X.cnt_receiptline_ejr,
 X.cnt_selling_position_ejr,
 X.cnt_discount_ejr,
 X.cnt_deposit_ejr,
 X.cnt_return_ejr,
 X.cnt_void_ejr,
 X.cnt_ean_ejr,
 X.cnt_item_ejr,
 X.cnt_item_weight_ejr,
 X.cnt_mainitemgroup_ejr,
 X.qty_piece_ejr,
 X.val_retail_ejr,
 X.val_retail_pos_ejr,
 X.val_deposit_ejr,
 X.val_discount_ejr,
 X.val_discount_net_ejr,
 X.resumed_trans_store_id_ejr,
 X.resumed_trans_terminal_id_ejr,
 X.resumed_trans_date_ejr,
 X.resumed_trans_receipt_nr_ejr,
 X.dur_service_time_ejr,
 X.dur_pay_change_time_ejr,
 X.val_retail_net_ejr,
 X.timestamp_begin_ejr,
 X.timestamp_end_ejr,
 X.next_transactiontype_id,
 X.rank_login_nr,
 X.rank_logoff_nr,
 X.next_orig_receipt_nr_ejr,
 X.next_val_retail_ejr,
 X.prev_orig_receipt_nr_ejr,
 X.next_time_receipt_ejr,
 X.prev_time_receipt_ejr,
 X.cnt_all_deposit_back,
 X.cnt_ke_deposit_back,
 X.cnt_sc_deposit_back,
 X.val_all_deposit_back,
 X.val_all_deposit_back_net,
 X.val_ke_deposit_back,
 X.val_ke_deposit_back_net,
 X.val_sc_deposit_back,
 X.cnt_all_deposit_sell,
 X.cnt_ke_deposit_sell,
 X.cnt_sc_deposit_sell,
 X.val_all_deposit_sell,
 X.val_all_deposit_sell_net,
 X.val_ke_deposit_sell,
 X.val_sc_deposit_sell,
 X.amt_sell_item,
 X.cnt_sell_item,
 X.cnt_voided_line,
 X.amt_voided_item,
 X.val_voided_line,
 X.val_voided_line_net,
 X.val_all_voided_line_net,
 X.is_voided_gt_4,
 X.is_implausible_deposit,
 X.is_implausible_depositv1,
 X.is_implausible_depositv2,
 X.is_deposit_1itm,
 X.is_deposit_1itmv,
 X.is_deposit_1itmc,
 X.qty_return_ejr,
 X.turnover_relevant_fg,
                  CASE
                  WHEN X.transactiontype_id = '100'
                  THEN '1' /* Verkauf */
                  WHEN X.transactiontype_id IN ('410', '415')
                  THEN '2' /* An-/Abmeldung */
                  WHEN X.transactiontype_id = '150'
                  THEN '3' /* Geldrückgabe */
                  WHEN X.transactiontype_id = '200'
                  THEN '4' /* Bonrückstellung */
                  WHEN X.transactiontype_id = '300'
                  THEN '5' /* Bonabbruch */
                  WHEN X.transactiontype_id = '480'
                  THEN '6' /* Preisanzeige */
                  ELSE '7'
                  END || CASE
                  WHEN X.transactiontype_id = '100' AND X.cnt_voided_line > 0 OR X.transactiontype_id = '150' AND
                     geldrueck.is_return_not_authorised > 0
                  THEN '1'
                  ELSE '0'
                  END || CASE
                 WHEN X.transactiontype_id = '100' AND X.cnt_ke_deposit_back > 0
                 THEN '2'
                 WHEN X.transactiontype_id = '100' AND X.cnt_all_deposit_back > 0
                 THEN '1'
                 ELSE '0'
                 END || CASE
                WHEN X.transactiontype_id IN ('100', '150', '200') AND X.rank_terminal_login_nr < 21 OR X.transactiontype_id
                   = '415'
                THEN '1' /* Anmeldung */
                ELSE '0'
                END || CASE
               WHEN X.transactiontype_id IN ('100', '150', '200') AND X.rank_terminal_logoff_nr < 21 OR X.transactiontype_id
                  = '410'
               THEN '1' /* Abmeldung */
               ELSE '0'
               END || CASE
              WHEN X.transactiontype_id = '100' AND X.cnt_voided_line > 0 AND X.is_voided_gt10_fg >= 1 OR X.transactiontype_id
                   = '150' AND RETBON.receipt_check_b1 = 1 /* Geldrückgabe alle WG */ OR X.transactiontype_id = '300'
                    AND SUST.is_resumed_aborted = 1 AND SUST.is_suspend_gt_10 = 1 AND SUST.is_next_tran_cond = 1 AND
                  SUST.resumed_trans_seqnr = 1 AND SUST.same_checker_fg = 1
              THEN '1' /* Phase 2 */
              WHEN X.transactiontype_id = '300' AND SUST.is_resumed_aborted = 1 AND SUST.resumed_trans_seqnr = 1 AND
                SUST.same_checker_fg = 0
              THEN '2' /* Phase 2 */
              WHEN X.transactiontype_id = '480' AND (SP.is_kleinstbon = 1 OR SP.is_kleinstbon_man = 1)
              THEN '1'
              ELSE '0'
              END || CASE
             WHEN X.transactiontype_id = '100' AND X.cnt_voided_line > 0 AND X.is_voided_gt_4 >= 1 OR X.transactiontype_id
                  = '150' AND RETBON.receipt_check_b3 = 1 /* Geldrückgabe Waschmittel */ OR X.transactiontype_id = '300'
                     AND SUST.is_voided_till_last_artikel = 1 AND SUST.is_suspend_gt_10 = 1 AND SUST.is_next_tran_cond =
                  1 AND SUST.resumed_trans_seqnr = 1 AND SUST.same_checker_fg = 1
             THEN '1' /* Phase 2 */
             WHEN X.transactiontype_id = '300' AND SUST.is_voided_till_last_artikel_mc = 1 AND SUST.resumed_trans_seqnr
                = 1 AND SUST.same_checker_fg = 0
             THEN '2' /* Phase 2 */
             WHEN X.transactiontype_id = '480' AND (SP.is_abmeldung = 1 OR SP.is_abmeld_man = 1)
             THEN '1'
             ELSE '0'
             END || CASE
            WHEN X.transactiontype_id = '100' AND item_receipt.orig_receipt_nr_ejr IS NOT NULL OR X.transactiontype_id =
                '150' AND RETBON.receipt_check_b2 = 1 /* Geldrückgabe Spirituosen */ OR X.transactiontype_id = '300' AND
                   SUST.is_new_item_in_resume = 1 AND SUST.is_suspend_gt_10 = 1 AND SUST.is_next_tran_cond = 1 AND SUST
                .resumed_trans_seqnr = 1 AND SUST.same_checker_fg = 1
            THEN '1' /* Phase 2 */
            WHEN X.transactiontype_id = '300' AND SUST.is_new_item_in_resume_mc = 1 AND SUST.resumed_trans_seqnr = 1 AND
              SUST.same_checker_fg = 0
            THEN '2' /* Phase 2 */
            WHEN X.transactiontype_id = '480' AND SP.is_show_price_series = 1
            THEN '1'
            ELSE '0'
            END || CASE
           WHEN X.transactiontype_id = '100' AND X.is_lowval_fg = 1 OR X.transactiontype_id = '150' AND RETBON.receipt_check_b4
                = 1 /* Geldrückgabe Kosmetik */ OR X.transactiontype_id = '300' AND SUST.is_open_suspended = 1 AND SUST
              .resumed_trans_seqnr = 1
           THEN '1' /* Offene Bonrückstellung */
           ELSE '0'
           END || CASE
          WHEN X.transactiontype_id = '200' AND X.is_aborted_gt10_fg = 1 OR X.transactiontype_id = '150' AND RETBON.receipt_check_b5
               = 1 /* Geldrückgabe Baby */ OR X.transactiontype_id = '100' AND X.cnt_selling_position_ejr = 0 AND X.val_all_deposit_back
              <> 0
          THEN '1'
          ELSE '0'
          END || CASE
         WHEN X.transactiontype_id = '100' AND TS.is_sale_after_subtotal = 0 AND TS.is_voided_value_aft_subtotal = 1 AND
               TS.is_voided_item_innext = 0 AND TS.is_voided_after_subtotal = 1 OR X.transactiontype_id = '150' AND
              RETBON.receipt_check_b6 = 1 /* Geldrückgabe Tabakwaren */ OR X.transactiontype_id = '300' AND SUST.is_next_low_tran
               = 1 AND SUST.resumed_trans_seqnr = 1 OR X.transactiontype_id = '200' AND TABORT.is_lowval_fg = 1
         THEN '1' /* Bonabbruch - Kleinstbon */
         ELSE '0'
         END || CASE
        WHEN X.transactiontype_id = '150' AND RETBON.receipt_check_b7 = 1 /* Geldrückgabe -  NF */
        THEN '1'
        ELSE '0'
        END || CASE
       WHEN X.transactiontype_id = '100' AND X.is_deposit_1itm = 1 /* Is deposit_item */ OR X.transactiontype_id = '150'
           AND geldrueck.is_returned_wo_bon_per_day = 1 /* Geldrückgabe - Ohne Bon */
       THEN '1'
       WHEN X.transactiontype_id = '150' AND geldrueck.is_returned_gt_original = 1
         /* Geldrückgabe - mehrfach mit gleichem Originalbon */
       THEN '2'
       ELSE '0'
       END || CASE
      WHEN X.transactiontype_id = '100' AND X.is_implausible_depositv2 = 1 /* is_implausible_deposit   > 25 EUR */
      THEN '2' /* Phase 2 */
      WHEN X.transactiontype_id = '150' AND geldrueck_pr.is_return_price_gt_sale = 1
        /* Geldrückgabe - Rücknahmepreis höher Originalpreis */
      THEN '1'
      WHEN X.transactiontype_id = '150' AND geldrueck_pr.is_return_price_gt_wawi = 1
        /* Geldrückgabe - Rücknahmepreis größer höchster Wawi-Preis */
      THEN '2'
      ELSE '0'
      END || CASE
     WHEN X.transactiontype_id = '100' AND td.orig_receipt_nr_ejr IS NOT NULL OR X.transactiontype_id = '150' AND X.qty_ke_return_ejr
         > 0
     THEN '1'
     ELSE '0'
     END || CASE
    WHEN X.transactiontype_id = '150' AND geldrueck.cnt_return_same_receipt > 0
    THEN '1'
    ELSE '0'
    END || /* Bytes 17-20 */ '0000' AS scenario_id
FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS X
 INNER JOIN ldl_p_lew_mart_msi.t_msi_sys_revision_load_store_wrk_1 AS REVSTR ON X.store_id = REVSTR.st_loc_sid AND X.client_id
     = REVSTR.client_id AND X.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
 LEFT JOIN ldl_p_lew_mart_msi.v_ejr_void_transaction_1 AS TS ON X.client_id = TS.client_id AND X.store_id = TS.store_id
     AND X.pos_terminal_id = TS.pos_terminal_id AND X.time_receipt_ejr = TS.time_receipt_ejr AND X.dat_formdate = TS.dat_formdate
     AND X.orig_receipt_nr_ejr = TS.orig_receipt_nr_ejr
 LEFT JOIN (SELECT client_id,
   store_id,
   pos_terminal_id,
   time_receipt_ejr,
   dat_formdate,
   orig_receipt_nr_ejr
  FROM ldl_p_lew_mart_msi.v_ejr_transact_deposit_ean_1
  GROUP BY client_id,
   store_id,
   pos_terminal_id,
   time_receipt_ejr,
   dat_formdate,
   orig_receipt_nr_ejr) AS td ON X.client_id = td.client_id AND X.store_id = td.store_id AND X.pos_terminal_id = td.pos_terminal_id
       AND X.time_receipt_ejr = td.time_receipt_ejr AND X.dat_formdate = td.dat_formdate AND X.orig_receipt_nr_ejr = td
   .orig_receipt_nr_ejr
 LEFT JOIN ldl_p_lew_mart_msi.v_ejr_suspended_transact_1 AS SUST ON X.client_id = SUST.client_id AND X.store_id = SUST.store_id
         AND X.pos_terminal_id = SUST.pos_terminal_id AND X.time_receipt_ejr = SUST.time_receipt_ejr AND X.dat_formdate
     = SUST.dat_formdate AND X.orig_receipt_nr_ejr = SUST.orig_receipt_nr_ejr AND SUST.resumed_trans_seqnr = 1
 LEFT JOIN ldl_p_lew_mart_msi.v_ejr_transact_ret_receipt_1 AS RETBON ON X.client_id = RETBON.client_id AND X.store_id =
       RETBON.store_id AND X.pos_terminal_id = RETBON.pos_terminal_id AND X.time_receipt_ejr = RETBON.time_receipt_ejr
   AND X.dat_formdate = RETBON.dat_formdate AND X.orig_receipt_nr_ejr = RETBON.orig_receipt_nr_ejr
 LEFT JOIN (SELECT client_id,
   store_id,
   pos_terminal_id,
   time_receipt_ejr,
   dat_formdate,
   orig_receipt_nr_ejr,
   MAX(is_returned_wo_bon_per_day) AS is_returned_wo_bon_per_day,
   MAX(is_returned_gt_original) AS is_returned_gt_original,
   MAX(is_return_not_authorised) AS is_return_not_authorised,
   SUM(cnt_return_same_receipt) AS cnt_return_same_receipt,
   MAX(is_return_same_checker) AS is_return_same_checker
  FROM ldl_p_lew_mart_msi.v_ejr_return_transact_1
  GROUP BY client_id,
   store_id,
   pos_terminal_id,
   dat_formdate,
   time_receipt_ejr,
   orig_receipt_nr_ejr) AS geldrueck ON X.client_id = geldrueck.client_id AND X.store_id = geldrueck.store_id AND X.pos_terminal_id
       = geldrueck.pos_terminal_id AND X.time_receipt_ejr = geldrueck.time_receipt_ejr AND X.dat_formdate = geldrueck.dat_formdate
     AND X.orig_receipt_nr_ejr = geldrueck.orig_receipt_nr_ejr
 LEFT JOIN (SELECT client_id,
   store_id,
   pos_terminal_id,
   time_receipt_ejr,
   dat_formdate,
   orig_receipt_nr_ejr,
   MAX(is_return_price_gt_sale) AS is_return_price_gt_sale,
   MAX(is_return_price_gt_wawi) AS is_return_price_gt_wawi
  FROM ldl_p_lew_mart_msi.v_ejr_return_price_1
  GROUP BY client_id,
   store_id,
   pos_terminal_id,
   dat_formdate,
   time_receipt_ejr,
   orig_receipt_nr_ejr) AS geldrueck_pr ON X.client_id = geldrueck_pr.client_id AND X.store_id = geldrueck_pr.store_id
     AND X.pos_terminal_id = geldrueck_pr.pos_terminal_id AND X.time_receipt_ejr = geldrueck_pr.time_receipt_ejr AND X.dat_formdate
     = geldrueck_pr.dat_formdate AND X.orig_receipt_nr_ejr = geldrueck_pr.orig_receipt_nr_ejr
 LEFT JOIN ldl_p_lew_mart_msi.v_ejr_show_price_1 AS SP ON X.client_id = SP.client_id AND X.store_id = SP.store_id AND X.pos_terminal_id
       = SP.pos_terminal_id AND X.time_receipt_ejr = SP.time_receipt_ejr AND X.dat_formdate = SP.dat_formdate AND X.orig_receipt_nr_ejr
    = SP.orig_receipt_nr_ejr
 LEFT JOIN (SELECT client_id,
   store_id,
   pos_terminal_id,
   time_receipt_ejr,
   dat_formdate,
   orig_receipt_nr_ejr
  FROM ldl_p_lew_mart_msi.v_ejr_item_receipt_rel_1
  GROUP BY client_id,
   store_id,
   pos_terminal_id,
   time_receipt_ejr,
   dat_formdate,
   orig_receipt_nr_ejr) AS item_receipt ON X.client_id = item_receipt.client_id AND X.store_id = item_receipt.store_id
     AND X.pos_terminal_id = item_receipt.pos_terminal_id AND X.time_receipt_ejr = item_receipt.time_receipt_ejr AND X.dat_formdate
     = item_receipt.dat_formdate AND X.orig_receipt_nr_ejr = item_receipt.orig_receipt_nr_ejr
 LEFT JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS TABORT ON X.client_id = TABORT.client_id AND X.store_id =
          TABORT.store_id AND X.checker_id = TABORT.checker_id AND X.next_time_receipt_ejr = TABORT.time_receipt_ejr AND
       X.dat_formdate = TABORT.dat_formdate AND X.next_orig_receipt_nr_ejr = TABORT.orig_receipt_nr_ejr AND TABORT.transactiontype_id
      = '100' AND TABORT.is_lowval_fg = 1 AND TABORT.prev_transactiontype_id = '200' /* Bonabbruch Folgebon */;