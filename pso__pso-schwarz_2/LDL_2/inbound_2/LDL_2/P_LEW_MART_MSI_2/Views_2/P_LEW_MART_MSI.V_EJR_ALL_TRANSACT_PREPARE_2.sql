/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_ejr_all_transact_prepare_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.10.2017    -                        Generiert aus Teradata
#  1.1  06.11.2017    Proch,Marika             Die View f_view.v_sys_revision_load_store_wrk_2 wurde ersetzt durch die Tabelle F_lew_mart_msi.t_msi_sys_revision_load_store_wrk_2
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205) scenario_id bytes 6 & 7 angepasst.
#  1.5  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) - scenario_id byte 15 angepasst
#  1.6  10.10.2023    Wandtke,Andrzej          AP0177990  - Byte 15: change from 2 to 1 in order not to lose receipts when matching scenarios
#  1.7  24.11.2023    Wandtke,Andrzej          INC7623719 - Byte 15: remove line WHEN x.transactiontype_id = '150' AND geldrueck.is_return_same_checker = 1 THEN '1'
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_ALL_TRANSACT_PREPARE_2 AS
      SELECT	
      x.store_id
	 ,x.client_id
	 ,x.pos_terminal_id
	 ,x.dat_formdate
	 ,x.time_receipt_ejr
	 ,x.orig_receipt_nr_ejr
	 ,x.timezone_cd
	 ,x.dat_dayend
	 ,x.checker_id
	 ,x.transactiontype_id
	 ,x.cnt_receiptline_ejr
	 ,x.cnt_selling_position_ejr
	 ,x.cnt_discount_ejr
	 ,x.cnt_deposit_ejr
	 ,x.cnt_return_ejr
	 ,x.cnt_void_ejr
	 ,x.cnt_ean_ejr
	 ,x.cnt_item_ejr
	 ,x.cnt_item_weight_ejr
	 ,x.cnt_mainitemgroup_ejr
	 ,x.qty_piece_ejr
	 ,x.val_retail_ejr
	 ,x.val_retail_pos_ejr
	 ,x.val_deposit_ejr
	 ,x.val_discount_ejr
	 ,x.val_discount_net_ejr
	 ,x.resumed_trans_store_id_ejr
	 ,x.resumed_trans_terminal_id_ejr
	 ,x.resumed_trans_date_ejr
	 ,x.resumed_trans_receipt_nr_ejr
	 ,x.dur_service_time_ejr
	 ,x.dur_pay_change_time_ejr
	 ,x.val_retail_net_ejr
	 ,x.timestamp_begin_ejr
	 ,x.timestamp_end_ejr
	 ,x.next_transactiontype_id
	 ,x.rank_login_nr
	 ,x.rank_logoff_nr
	 ,x.next_orig_receipt_nr_ejr
	 ,x.next_val_retail_ejr
	 ,x.prev_orig_receipt_nr_ejr
	 ,x.next_time_receipt_ejr
	 ,x.prev_time_receipt_ejr
	 ,x.cnt_all_deposit_back
	 ,x.cnt_ke_deposit_back
	 ,x.cnt_sc_deposit_back
	 ,x.val_all_deposit_back
	 ,x.val_all_deposit_back_net
	 ,x.val_ke_deposit_back
	 ,x.val_ke_deposit_back_net
	 ,x.val_sc_deposit_back
	 ,x.cnt_all_deposit_sell
	 ,x.cnt_ke_deposit_sell
	 ,x.cnt_sc_deposit_sell
	 ,x.val_all_deposit_sell
	 ,x.val_all_deposit_sell_net
	 ,x.val_ke_deposit_sell
	 ,x.val_sc_deposit_sell
	 ,x.amt_sell_item
	 ,x.cnt_sell_item
	 ,x.cnt_voided_line
	 ,x.amt_voided_item
	 ,x.val_voided_line
	 ,x.val_voided_line_net
	 ,x.val_all_voided_line_net
	 ,x.is_voided_gt_4
	 ,x.is_implausible_deposit
	 ,x.is_implausible_depositv1
	 ,x.is_implausible_depositv2
	 ,x.is_deposit_1itm
	 ,x.is_deposit_1itmv
	 ,x.is_deposit_1itmc
	 ,x.qty_return_ejr
	 ,x.turnover_relevant_fg
	 ,CASE /* Byte 1   Grouping over Transaction type   */	
            WHEN x.transactiontype_id = '100'           THEN '1'  /* Verkauf             */	
            WHEN x.transactiontype_id IN ('410', '415') THEN '2'  /* An-/Abmeldung       */	
            WHEN x.transactiontype_id = '150'           THEN '3'  /* Geldrückgabe        */	
            WHEN x.transactiontype_id = '200'           THEN '4'  /* Bonrückstellung     */	
            WHEN x.transactiontype_id = '300'           THEN '5'  /* Bonabbruch          */	
            WHEN x.transactiontype_id = '480'           THEN '6'  /* Preisanzeige        */	
            ELSE '7'	
        END ||	
	
       CASE /* Byte 2 Flag für Storno (Nur für Verkaufsbon)  */	
            WHEN x.transactiontype_id = '100' AND x.cnt_voided_line                  > 0 THEN '1'	
            WHEN x.transactiontype_id = '150' AND geldrueck.is_return_not_authorised > 0 THEN '1'	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 3  */	
            WHEN x.transactiontype_id = '100' AND x.cnt_ke_deposit_back  > 0 THEN '2'	
            WHEN x.transactiontype_id = '100' AND x.cnt_all_deposit_back > 0 THEN '1'	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 4 */	
            WHEN x.transactiontype_id IN ('100', '150', '200') AND x.rank_terminal_login_nr < 21 THEN '1'	
            WHEN x.transactiontype_id = '415'                                                    THEN '1'  /* Anmeldung */	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 5 */	
            WHEN x.transactiontype_id IN ('100', '150', '200') AND x.rank_terminal_logoff_nr < 21 THEN '1'	
            WHEN x.transactiontype_id = '410'                                                     THEN '1'  /* Abmeldung */	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 6  */	
            WHEN x.transactiontype_id = '100' AND x.cnt_voided_line       > 0 AND x.is_voided_gt10_fg >= 1                                                                                                  THEN '1' /* Phase 2 */	
            WHEN x.transactiontype_id = '150' AND retbon.receipt_check_b1 = 1   /*  Geldrückgabe alle WG */                                                                                                 THEN '1'	
            WHEN x.transactiontype_id = '300' AND sust.is_resumed_aborted = 1 AND sust.is_suspend_gt_10 = 1    AND sust.is_next_tran_cond = 1 AND sust.resumed_trans_seqnr = 1 AND sust.same_checker_fg = 1 THEN '1' /* Phase 2 */	
            WHEN x.transactiontype_id = '300' AND sust.is_resumed_aborted = 1 AND sust.resumed_trans_seqnr = 1 AND sust.same_checker_fg   = 0                                                               THEN '2' /* Phase 2 */	
            WHEN x.transactiontype_id = '480' AND ( sp.is_kleinstbon      = 1 OR sp.is_kleinstbon_man = 1)                                                                                                  THEN '1'	
            ELSE '0'	
        END ||	
	
       CASE /*  Byte 7 */	
            WHEN x.transactiontype_id = '100' AND x.cnt_voided_line                        > 0 AND x.is_voided_gt_4        >= 1                                                                                              THEN '1' /* Phase 2 */	
            WHEN x.transactiontype_id = '150' AND retbon.receipt_check_b3                  = 1   /*  Geldrückgabe Waschmittel*/                                                                                              THEN '1'	
            WHEN x.transactiontype_id = '300' AND sust.is_voided_till_last_artikel         = 1 AND sust.is_suspend_gt_10    = 1 AND sust.is_next_tran_cond = 1 AND sust.resumed_trans_seqnr = 1 AND sust.same_checker_fg = 1 THEN '1' /* Phase 2 */	
            WHEN x.transactiontype_id = '300' AND sust.is_voided_till_last_artikel_mc      = 1 AND sust.resumed_trans_seqnr = 1 AND sust.same_checker_fg   = 0                                                               THEN '2' /* Phase 2 */	
            WHEN x.transactiontype_id = '480' AND (sp.is_abmeldung = 1 OR sp.is_abmeld_man = 1)                                                                                                                              THEN '1'	
            ELSE '0'	
        END ||	
	
       CASE /*  Byte 8  */	
            WHEN x.transactiontype_id = '100' AND item_receipt.orig_receipt_nr_ejr IS NOT NULL                                                                                                                       THEN '1'	
            WHEN x.transactiontype_id = '150' AND retbon.receipt_check_b2          = 1   /*  Geldrückgabe Spirituosen*/                                                                                              THEN '1'	
            WHEN x.transactiontype_id = '300' AND sust.is_new_item_in_resume       = 1 AND sust.is_suspend_gt_10    = 1 AND sust.is_next_tran_cond = 1 AND sust.resumed_trans_seqnr = 1 AND sust.same_checker_fg = 1 THEN '1'  /* Phase 2 */	
            WHEN x.transactiontype_id = '300' AND sust.is_new_item_in_resume_mc    = 1 AND sust.resumed_trans_seqnr = 1 AND sust.same_checker_fg   = 0                                                               THEN '2'  /* Phase 2 */	
            WHEN x.transactiontype_id = '480' AND sp.is_show_price_series          = 1                                                                                                                               THEN '1'	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 9  */	
            WHEN x.transactiontype_id = '100' AND x.is_lowval_fg          = 1                                  THEN '1'  /* Phase 2 */	
            WHEN x.transactiontype_id = '150' AND retbon.receipt_check_b4 = 1   /*  Geldrückgabe Kosmetik*/    THEN '1'	
            WHEN x.transactiontype_id = '300' AND sust.is_open_suspended  = 1 AND sust.resumed_trans_seqnr = 1 THEN '1'  /*  Offene Bonrückstellung */	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 10  */	
            WHEN x.transactiontype_id = '200' AND x.is_aborted_gt10_fg       = 1                                 THEN '1' /* Phase 2 */	
            WHEN x.transactiontype_id = '150' AND retbon.receipt_check_b5    = 1   /*  Geldrückgabe Baby*/       THEN '1'	
            WHEN x.transactiontype_id = '100' AND x.cnt_selling_position_ejr = 0 AND x.val_all_deposit_back <> 0 THEN '1'	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 11  */	
            WHEN x.transactiontype_id = '100'	
                AND (ts.is_sale_after_subtotal = 0 AND ts.is_voided_value_aft_subtotal = 1	
                AND  ts.is_voided_item_innext  = 0 AND ts.is_voided_after_subtotal     = 1	
               )                                                                                                THEN '1'	
            WHEN x.transactiontype_id = '150' AND retbon.receipt_check_b6 = 1   /*  Geldrückgabe Tabakwaren */  THEN '1'	
            WHEN x.transactiontype_id = '300' AND sust.is_next_low_tran   = 1 AND sust.resumed_trans_seqnr = 1  THEN '1'   /* Bonrückstellung - Kleinstbon */	
            WHEN x.transactiontype_id = '200' AND tabort.is_lowval_fg     = 1                                   THEN '1'   /* Bonabbruch - Kleinstbon      */	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 12 */	
            WHEN x.transactiontype_id = '150' AND retbon.receipt_check_b7 = 1   /*  Geldrückgabe -  NF*/ THEN '1'	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 13  */	
            WHEN x.transactiontype_id = '100' AND x.is_deposit_1itm                    = 1 /*  Is deposit_item */                                  THEN '1'	
            WHEN x.transactiontype_id = '150' AND geldrueck.is_returned_wo_bon_per_day = 1 /*  Geldrückgabe - Ohne Bon */                          THEN '1'	
            WHEN x.transactiontype_id = '150' AND geldrueck.is_returned_gt_original    = 1 /*  Geldrückgabe - mehrfach mit gleichem Originalbon */ THEN '2'	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 14  */	
            WHEN x.transactiontype_id = '100' AND x.is_implausible_depositv2           = 1  /*  is_implausible_deposit   > 25 EUR*/                         THEN '2'  /* Phase 2 */	
            WHEN x.transactiontype_id = '150' AND geldrueck_pr.is_return_price_gt_sale = 1  /*  Geldrückgabe - Rücknahmepreis höher Originalpreis */        THEN '1'	
            WHEN x.transactiontype_id = '150' AND geldrueck_pr.is_return_price_gt_wawi = 1  /*  Geldrückgabe - Rücknahmepreis größer höchster Wawi-Preis */ THEN '2'	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 15  */	
            WHEN x.transactiontype_id = '100' AND td.orig_receipt_nr_ejr IS NOT NULL /*  EAN_2 */  THEN '1'	
            WHEN x.transactiontype_id = '150' AND x.qty_ke_return_ejr    > 0                     THEN '1'	
            ELSE '0'	
        END ||	
	
       CASE /* Byte 16  */	
            WHEN x.transactiontype_id = '150' AND geldrueck.cnt_return_same_receipt > 0 THEN '1'	
            ELSE '0'	
        END ||	
     /* Bytes 17-20 */	
       '0000' AS scenario_id	
      FROM p_lew_mart_msi.v_ejr_all_transact_follower_2 AS x	
      INNER JOIN p_lew_mart_msi.t_msi_sys_revision_load_store_wrk_2 AS revstr	
      ON  x.store_id           = revstr.st_loc_sid	
      AND x.client_id           = revstr.client_id	
      AND x.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until	
      LEFT OUTER JOIN p_lew_mart_msi.v_ejr_void_transaction_2 AS ts	
      ON  x.client_id          = ts.client_id	
      AND x.store_id            = ts.store_id	
      AND x.pos_terminal_id     = ts.pos_terminal_id	
      AND x.time_receipt_ejr    = ts.time_receipt_ejr	
      AND x.dat_formdate        = ts.dat_formdate	
      AND x.orig_receipt_nr_ejr = ts.orig_receipt_nr_ejr	
      LEFT OUTER JOIN (	
      SELECT	
       client_id
       ,store_id
       ,pos_terminal_id
       ,time_receipt_ejr
       ,dat_formdate
       ,orig_receipt_nr_ejr	
                        FROM p_lew_mart_msi.v_ejr_transact_deposit_ean_2	
                        GROUP BY	
                                   client_id	
                                  , store_id	
                                  , pos_terminal_id	
                                  , time_receipt_ejr	
                                  , dat_formdate	
                                  , orig_receipt_nr_ejr	
                        ) AS td	
      ON  x.client_id          = td.client_id	
      AND x.store_id            = td.store_id	
      AND x.pos_terminal_id     = td.pos_terminal_id	
      AND x.time_receipt_ejr    = td.time_receipt_ejr	
      AND x.dat_formdate        = td.dat_formdate	
      AND x.orig_receipt_nr_ejr = td.orig_receipt_nr_ejr	
      LEFT OUTER JOIN p_lew_mart_msi.v_ejr_suspended_transact_2 AS sust	
      ON x.client_id           = sust.client_id	
      AND x.store_id            = sust.store_id	
      AND x.pos_terminal_id     = sust.pos_terminal_id	
      AND x.time_receipt_ejr    = sust.time_receipt_ejr	
      AND x.dat_formdate        = sust.dat_formdate	
      AND x.orig_receipt_nr_ejr = sust.orig_receipt_nr_ejr	
      AND sust.resumed_trans_seqnr = 1	
      LEFT OUTER JOIN p_lew_mart_msi.v_ejr_transact_ret_receipt_2 AS retbon	
      ON x.client_id           = retbon.client_id	
      AND x.store_id            = retbon.store_id	
      AND x.pos_terminal_id     = retbon.pos_terminal_id	
      AND x.time_receipt_ejr    = retbon.time_receipt_ejr	
      AND x.dat_formdate        = retbon.dat_formdate	
      AND x.orig_receipt_nr_ejr = retbon.orig_receipt_nr_ejr	
      LEFT OUTER JOIN (	
      SELECT	
       client_id
	  ,store_id
	  ,pos_terminal_id
	  ,time_receipt_ejr
	  ,dat_formdate
	  ,orig_receipt_nr_ejr
	  ,MAX(is_returned_wo_bon_per_day) AS is_returned_wo_bon_per_day
	  ,MAX(is_returned_gt_original)    AS is_returned_gt_original
	  ,MAX(is_return_not_authorised)   AS is_return_not_authorised
	  ,SUM(cnt_return_same_receipt)    AS cnt_return_same_receipt
	  ,MAX(is_return_same_checker)     AS is_return_same_checker	
                       FROM p_lew_mart_msi.v_ejr_return_transact_2	
                      GROUP BY	
                                  client_id	
                                , store_id	
                                , pos_terminal_id	
                                , time_receipt_ejr	
                                , dat_formdate	
                                , orig_receipt_nr_ejr	
                       ) AS geldrueck	
      ON x.client_id           = geldrueck.client_id	
      AND x.store_id            = geldrueck.store_id	
      AND x.pos_terminal_id     = geldrueck.pos_terminal_id	
      AND x.time_receipt_ejr    = geldrueck.time_receipt_ejr	
      AND x.dat_formdate        = geldrueck.dat_formdate	
      AND x.orig_receipt_nr_ejr = geldrueck.orig_receipt_nr_ejr	
      LEFT OUTER JOIN (	
      SELECT	
       client_id
	  ,store_id
	  ,pos_terminal_id
	  ,time_receipt_ejr
	  ,dat_formdate
	  ,orig_receipt_nr_ejr
	  ,MAX(is_return_price_gt_sale) AS is_return_price_gt_sale
	  ,MAX(is_return_price_gt_wawi) AS is_return_price_gt_wawi	
                       FROM p_lew_mart_msi.v_ejr_return_price_2	
                      GROUP BY	
                                  client_id	
                                , store_id	
                                , pos_terminal_id	
                                , time_receipt_ejr	
                                , dat_formdate	
                                , orig_receipt_nr_ejr	
                  ) AS geldrueck_pr	
      ON  x.client_id            = geldrueck_pr.client_id	
      AND x.store_id             = geldrueck_pr.store_id	
      AND x.pos_terminal_id      = geldrueck_pr.pos_terminal_id	
      AND x.time_receipt_ejr     = geldrueck_pr.time_receipt_ejr	
      AND x.dat_formdate         = geldrueck_pr.dat_formdate	
      AND x.orig_receipt_nr_ejr  = geldrueck_pr.orig_receipt_nr_ejr	
      LEFT OUTER JOIN p_lew_mart_msi.v_ejr_show_price_2 sp	
      ON  x.client_id           = sp.client_id	
      AND x.store_id             = sp.store_id	
      AND x.pos_terminal_id      = sp.pos_terminal_id	
      AND x.time_receipt_ejr     = sp.time_receipt_ejr	
      AND x.dat_formdate         = sp.dat_formdate	
      AND x.orig_receipt_nr_ejr  = sp.orig_receipt_nr_ejr	
      LEFT OUTER JOIN (	
      SELECT	
       client_id
	  ,store_id
	  ,pos_terminal_id
	  ,time_receipt_ejr
	  ,dat_formdate
	  ,orig_receipt_nr_ejr	
                      FROM p_lew_mart_msi.v_ejr_item_receipt_rel_2	
                     GROUP BY	
                               client_id	
                              , store_id	
                              , pos_terminal_id	
                              , time_receipt_ejr	
                              , dat_formdate	
                              , orig_receipt_nr_ejr	
                      ) AS item_receipt	
      ON x.client_id           = item_receipt.client_id	
      AND x.store_id            = item_receipt.store_id	
      AND x.pos_terminal_id     = item_receipt.pos_terminal_id	
      AND x.time_receipt_ejr    = item_receipt.time_receipt_ejr	
      AND x.dat_formdate        = item_receipt.dat_formdate	
      AND x.orig_receipt_nr_ejr = item_receipt.orig_receipt_nr_ejr	
      LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_2 AS tabort /* Bonabbruch Folgebon  */	
      ON x.client_id                    = tabort.client_id	
      AND x.store_id                     = tabort.store_id	
      AND x.checker_id                   = tabort.checker_id	
      AND x.next_time_receipt_ejr        = tabort.time_receipt_ejr	
      AND x.dat_formdate                 = tabort.dat_formdate	
      AND x.next_orig_receipt_nr_ejr     = tabort.orig_receipt_nr_ejr	
      AND tabort.transactiontype_id      = '100'	
      AND tabort.is_lowval_fg            = 1	
      AND tabort.prev_transactiontype_id = '200'	
;