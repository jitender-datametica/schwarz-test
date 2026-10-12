CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_all_transact_follower_1 AS /* cnt_receiptline_ejr */
/* cnt_selling_position_ejr */ /* cnt_discount_ejr */ /* cnt_deposit_ejr */ /* cnt_return_ejr */ /* cnt_void_ejr */
/* cnt_ean_ejr */ /* cnt_item_ejr */ /* cnt_item_weight_ejr */ /* cnt_mainitemgroup_ejr */ /* qty_piece_ejr */
/* val_retail_pos_ejr */ /* val_deposit_ejr */ /* val_discount_ejr */ /* val_discount_net_ejr */
/* resumed_trans_store_id_ejr */ /* resumed_trans_terminal_id_ejr */ /* resumed_trans_date_ejr */
/* resumed_trans_receipt_nr_ejr */ /* dur_service_time_ejr */ /* dur_pay_change_time_ejr */ /* val_retail_net_ejr */
/* cnt_receiptline_ejr */ /* cnt_selling_position_ejr */ /* cnt_discount_ejr */ /* cnt_deposit_ejr */
/* cnt_return_ejr */ /* cnt_void_ejr */ /* cnt_ean_ejr */ /* cnt_item_ejr */ /* cnt_item_weight_ejr */
/* cnt_mainitemgroup_ejr */ /* qty_piece_ejr */ /* val_retail_pos_ejr */ /* val_deposit_ejr */ /* val_discount_ejr */
/* val_discount_net_ejr */ /* resumed_trans_store_id_ejr */ /* resumed_trans_terminal_id_ejr */
/* resumed_trans_date_ejr */ /* resumed_trans_receipt_nr_ejr */ /* dur_service_time_ejr */ /* dur_pay_change_time_ejr */
/* val_retail_net_ejr */
/* The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ). */
SELECT x.store_id,
 x.client_id,
 x.pos_terminal_id,
 x.dat_formdate,
 x.time_receipt_ejr,
 x.orig_receipt_nr_ejr,
 x.timezone_cd,
 x.dat_dayend,
 x.checker_id,
 x.transactiontype_id,
 x.cnt_receiptline_ejr,
 x.cnt_selling_position_ejr,
 x.cnt_discount_ejr,
 x.cnt_deposit_ejr,
 x.cnt_return_ejr,
 x.cnt_void_ejr,
 x.cnt_ean_ejr,
 x.cnt_item_ejr,
 x.cnt_item_weight_ejr,
 x.cnt_mainitemgroup_ejr,
 x.qty_piece_ejr,
 x.val_retail_ejr,
 x.val_retail_pos_ejr,
 x.val_deposit_ejr,
 x.val_discount_ejr,
 x.val_discount_net_ejr,
 x.resumed_trans_store_id_ejr,
 x.resumed_trans_terminal_id_ejr,
 x.resumed_trans_date_ejr,
 x.resumed_trans_receipt_nr_ejr,
 x.dur_service_time_ejr,
 x.dur_pay_change_time_ejr,
 x.val_retail_net_ejr,
 x.timestamp_begin_ejr,
 x.timestamp_end_ejr,
 MIN(x.transactiontype_id) OVER (PARTITION BY CAST(x.store_id AS STRING), CAST(x.client_id AS STRING), CAST(x.pos_terminal_id AS STRING)
    , x.dat_formdate, CAST(x.checker_id AS STRING) ORDER BY x.dat_dayend IS NULL, x.dat_dayend, x.time_receipt_ejr
    IS NULL, x.time_receipt_ejr, x.pos_terminal_id IS NULL, x.pos_terminal_id, x.orig_receipt_nr_ejr IS NULL, x.orig_receipt_nr_ejr
    , x.timestamp_begin_ejr IS NULL, x.timestamp_begin_ejr ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS
 next_transactiontype_id,
 ROW_NUMBER() OVER (PARTITION BY CAST(x.store_id AS STRING), CAST(x.client_id AS STRING), CAST(x.checker_id AS STRING),
    x.dat_formdate ORDER BY x.dat_dayend IS NULL, x.dat_dayend, x.time_receipt_ejr IS NULL, x.time_receipt_ejr, x.pos_terminal_id
    IS NULL, x.pos_terminal_id, x.orig_receipt_nr_ejr IS NULL, x.orig_receipt_nr_ejr, x.timestamp_begin_ejr IS NULL, x.timestamp_begin_ejr
    ) AS rank_login_nr,
 ROW_NUMBER() OVER (PARTITION BY CAST(x.store_id AS STRING), CAST(x.client_id AS STRING), CAST(x.checker_id AS STRING),
    x.dat_formdate ORDER BY x.dat_dayend IS NULL, x.dat_dayend, x.time_receipt_ejr IS NULL, x.time_receipt_ejr, x.pos_terminal_id
    IS NULL, x.pos_terminal_id, x.orig_receipt_nr_ejr IS NULL, x.orig_receipt_nr_ejr, x.timestamp_begin_ejr IS NULL, x.timestamp_begin_ejr
    ) AS rank_logoff_nr,
 MIN(x.orig_receipt_nr_ejr) OVER (PARTITION BY CAST(x.store_id AS STRING), CAST(x.client_id AS STRING), CAST(x.pos_terminal_id AS STRING)
    , x.dat_formdate, CAST(x.checker_id AS STRING) ORDER BY x.dat_dayend IS NULL, x.dat_dayend, x.time_receipt_ejr
    IS NULL, x.time_receipt_ejr, x.pos_terminal_id IS NULL, x.pos_terminal_id, x.orig_receipt_nr_ejr IS NULL, x.orig_receipt_nr_ejr
    , x.timestamp_begin_ejr IS NULL, x.timestamp_begin_ejr ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS
 next_orig_receipt_nr_ejr,
 MIN(x.val_retail_ejr) OVER (PARTITION BY CAST(x.store_id AS STRING), CAST(x.client_id AS STRING), CAST(x.pos_terminal_id AS STRING)
    , x.dat_formdate, CAST(x.checker_id AS STRING) ORDER BY x.dat_dayend IS NULL, x.dat_dayend, x.time_receipt_ejr
    IS NULL, x.time_receipt_ejr, x.pos_terminal_id IS NULL, x.pos_terminal_id, x.orig_receipt_nr_ejr IS NULL, x.orig_receipt_nr_ejr
    , x.timestamp_begin_ejr IS NULL, x.timestamp_begin_ejr ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS
 next_val_retail_ejr,
 MIN(x.orig_receipt_nr_ejr) OVER (PARTITION BY CAST(x.store_id AS STRING), CAST(x.client_id AS STRING), CAST(x.pos_terminal_id AS STRING)
    , x.dat_formdate, CAST(x.checker_id AS STRING) ORDER BY x.dat_dayend IS NULL, x.dat_dayend, x.time_receipt_ejr
    IS NULL, x.time_receipt_ejr, x.pos_terminal_id IS NULL, x.pos_terminal_id, x.orig_receipt_nr_ejr IS NULL, x.orig_receipt_nr_ejr
    , x.timestamp_begin_ejr IS NULL, x.timestamp_begin_ejr ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS
 prev_orig_receipt_nr_ejr,
 MIN(x.time_receipt_ejr) OVER (PARTITION BY CAST(x.store_id AS STRING), CAST(x.client_id AS STRING), CAST(x.pos_terminal_id AS STRING)
    , x.dat_formdate, CAST(x.checker_id AS STRING) ORDER BY x.dat_dayend IS NULL, x.dat_dayend, x.time_receipt_ejr
    IS NULL, x.time_receipt_ejr, x.pos_terminal_id IS NULL, x.pos_terminal_id, x.orig_receipt_nr_ejr IS NULL, x.orig_receipt_nr_ejr
    , x.timestamp_begin_ejr IS NULL, x.timestamp_begin_ejr ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS
 next_time_receipt_ejr,
 MIN(x.time_receipt_ejr) OVER (PARTITION BY CAST(x.store_id AS STRING), CAST(x.client_id AS STRING), CAST(x.pos_terminal_id AS STRING)
    , x.dat_formdate, CAST(x.checker_id AS STRING) ORDER BY x.dat_dayend IS NULL, x.dat_dayend, x.time_receipt_ejr
    IS NULL, x.time_receipt_ejr, x.pos_terminal_id IS NULL, x.pos_terminal_id, x.orig_receipt_nr_ejr IS NULL, x.orig_receipt_nr_ejr
    , x.timestamp_begin_ejr IS NULL, x.timestamp_begin_ejr ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS
 prev_time_receipt_ejr,
 y.cnt_all_deposit_back,
 y.cnt_ke_deposit_back,
 y.cnt_sc_deposit_back,
 y.val_all_deposit_back,
 y.val_all_deposit_back_net,
 y.val_ke_deposit_back,
 y.val_ke_deposit_back_net,
 y.val_sc_deposit_back,
 y.cnt_all_deposit_sell,
 y.cnt_ke_deposit_sell,
 y.cnt_sc_deposit_sell,
 y.val_all_deposit_sell,
 y.val_all_deposit_sell_net,
 y.val_ke_deposit_sell,
 y.val_sc_deposit_sell,
 y.cnt_wo_deposit_voided_line,
 y.amt_sell_item,
 y.cnt_sell_item,
 y.val_sell_item,
 y.cnt_voided_line,
 y.cnt_all_voided_line,
 y.amt_voided_item,
 y.amt_all_voided_item,
 y.val_voided_line,
 y.val_voided_line_net,
 y.val_all_voided_line,
 y.val_all_voided_line_net,
 y.is_voided_gt_4,
 y.is_implausible_deposit,
 y.is_implausible_depositv1,
 y.is_implausible_depositv2,
 y.implausible_depositv1_val,
 y.implausible_depositv2_val,
  CASE
  WHEN y.cnt_sell_item + y.cnt_wo_deposit_voided_line = 1 AND x.val_retail_ejr <= TR0.deposit_1itm_receipt_val AND (y.cnt_wo_deposit_voided_line
        = 1 AND ABS(y.val_all_voided_line) <= TR0.deposit_1itm_item_val OR y.cnt_sell_item = 1 AND y.val_sell_item <=
       TR0.deposit_1itm_item_val)
  THEN 1
  ELSE 0
  END AS is_deposit_1itm,
  CASE
  WHEN y.cnt_sell_item + y.cnt_wo_deposit_voided_line = 1 AND ABS(y.val_all_deposit_back) >= TR0.deposit_amt_plus_empty_ret
    
  THEN 1
  ELSE 0
  END AS is_deposit_1itmv,
  CASE
  WHEN y.cnt_sell_item + y.cnt_wo_deposit_voided_line = 1 AND y.cnt_all_deposit_back >= TR0.deposit_1itm_plus_empty_ret
  THEN 1
  ELSE 0
  END AS is_deposit_1itmc,
 y.qty_return_ejr,
 ROW_NUMBER() OVER (PARTITION BY CAST(x.store_id AS STRING), CAST(x.client_id AS STRING), CAST(x.checker_id AS STRING),
    x.dat_formdate, CAST(x.pos_terminal_id AS STRING) ORDER BY x.dat_dayend IS NULL, x.dat_dayend, x.time_receipt_ejr
    IS NULL, x.time_receipt_ejr, x.pos_terminal_id IS NULL, x.pos_terminal_id, x.orig_receipt_nr_ejr IS NULL, x.orig_receipt_nr_ejr
    ) AS rank_terminal_login_nr,
 ROW_NUMBER() OVER (PARTITION BY CAST(x.store_id AS STRING), CAST(x.client_id AS STRING), CAST(x.checker_id AS STRING),
    x.dat_formdate, CAST(x.pos_terminal_id AS STRING) ORDER BY x.dat_dayend IS NULL, x.dat_dayend, x.time_receipt_ejr
    IS NULL, x.time_receipt_ejr, x.pos_terminal_id IS NULL, x.pos_terminal_id, x.orig_receipt_nr_ejr IS NULL, x.orig_receipt_nr_ejr
    ) AS rank_terminal_logoff_nr,
 x.turnover_relevant_fg,
  CASE
  WHEN x.transactiontype_id = '200' AND x.val_retail_ejr > TM0.msusp_aborted_receipt_val
  THEN 1
  ELSE 0
  END AS is_aborted_gt10_fg,
  CASE
  WHEN ABS(y.val_voided_line) > TM0.mreceipt_void_val
  THEN 1
  ELSE 0
  END AS is_voided_gt10_fg,
  CASE
  WHEN x.val_retail_ejr < TM0.mothers_low_receipt_val AND y.cnt_sell_item = 1 AND y.cnt_all_deposit_back = 0 AND y.cnt_wo_deposit_voided_line
     = 0
  THEN 1
  ELSE 0
  END AS is_lowval_fg,
 CAL.cy_week,
 CAL.cy_month,
 x.authority_id,
 y.qty_ke_return_ejr,
 y.qty_sc_return_ejr,
 y.val_ke_return_ejr,
 y.val_sc_return_ejr,
 MIN(x.transactiontype_id) OVER (PARTITION BY CAST(x.store_id AS STRING), CAST(x.client_id AS STRING), CAST(x.pos_terminal_id AS STRING)
    , x.dat_formdate, CAST(x.checker_id AS STRING) ORDER BY x.dat_dayend IS NULL, x.dat_dayend, x.time_receipt_ejr
    IS NULL, x.time_receipt_ejr, x.pos_terminal_id IS NULL, x.pos_terminal_id, x.orig_receipt_nr_ejr IS NULL, x.orig_receipt_nr_ejr
    , x.timestamp_begin_ejr IS NULL, x.timestamp_begin_ejr ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS
 prev_transactiontype_id
FROM (SELECT TR.store_id,
    TR.client_id,
    TR.pos_terminal_id,
    TR.dat_formdate,
    TR.time_receipt_ejr,
    TR.orig_receipt_nr_ejr,
    TR.timezone_cd,
    TR.dat_dayend,
    TR.checker_id,
    TR.transactiontype_id,
    TR.cnt_receiptline_ejr,
    TR.cnt_selling_position_ejr,
    TR.cnt_discount_ejr,
    TR.cnt_deposit_ejr,
    TR.cnt_return_ejr,
    TR.cnt_void_ejr,
    TR.cnt_ean_ejr,
    TR.cnt_item_ejr,
    TR.cnt_item_weight_ejr,
    TR.cnt_mainitemgroup_ejr,
    TR.qty_piece_ejr,
    TR.val_retail_ejr,
    TR.val_retail_pos_ejr,
    TR.val_deposit_ejr,
    TR.val_discount_ejr,
    TR.val_discount_net_ejr,
    TR.resumed_trans_store_id_ejr,
    TR.resumed_trans_terminal_id_ejr,
    TR.resumed_trans_date_ejr,
    TR.resumed_trans_receipt_nr_ejr,
    TR.dur_service_time_ejr,
    TR.dur_pay_change_time_ejr,
    TR.val_retail_net_ejr,
    TR.timestamp_begin_ejr,
    TR.timestamp_end_ejr,
    1 AS turnover_relevant_fg,
     CASE
     WHEN TR.transactiontype_id = '150'
     THEN COALESCE(TR.authority_id, t9.authority_id)
     ELSE TR.authority_id
     END AS authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_1 AS TR
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON TR.store_id = REVSTR.store_id
      AND TR.client_id = REVSTR.client_id AND TR.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
      
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 AS REVDAY ON TR.dat_formdate = REVDAY.dat_calendar
     
    LEFT JOIN (SELECT client_id,
      store_id,
      dat_formdate,
      pos_terminal_id,
      orig_receipt_nr_ejr,
      MAX(authority_id) AS authority_id
     FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_subtotal_1 AS SUB
     WHERE dat_formdate BETWEEN (SELECT MIN(dat_formdate_from)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR1
        WHERE client_id = SUB.client_id
         AND store_id = SUB.store_id) AND (SELECT MAX(dat_formdate_until)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR2
        WHERE client_id = SUB.client_id
         AND store_id = SUB.store_id)
      AND client_id = (SELECT MIN(client_id)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR3
        WHERE client_id = SUB.client_id
         AND store_id = SUB.store_id)
      AND store_id = (SELECT MIN(store_id)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR4
        WHERE client_id = SUB.client_id
         AND store_id = SUB.store_id)
      AND authority_id IS NOT NULL
     GROUP BY client_id,
      store_id,
      pos_terminal_id,
      dat_formdate,
      orig_receipt_nr_ejr) AS t9 ON TR.client_id = t9.client_id AND TR.store_id = t9.store_id AND TR.dat_formdate = t9.dat_formdate
         AND TR.pos_terminal_id = t9.pos_terminal_id AND TR.orig_receipt_nr_ejr = t9.orig_receipt_nr_ejr
      /* The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ). */
      
   WHERE TR.dat_formdate >= (SELECT MIN(dat_calendar)
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 AS D_MIN)
    AND TR.dat_formdate <= (SELECT MAX(dat_calendar)
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 AS D_MAX)
   UNION ALL
   SELECT NTR.store_id,
    NTR.client_id,
    NTR.pos_terminal_id,
    NTR.dat_formdate,
    NTR.time_receipt_ejr,
    NTR.orig_receipt_nr_ejr,
    NTR.timezone_cd,
    NTR.dat_dayend,
    NTR.checker_id,
    NTR.transactiontype_id,
    NTR.cnt_receiptline_ejr,
    NTR.cnt_selling_position_ejr,
    NTR.cnt_discount_ejr,
    NTR.cnt_deposit_ejr,
    NTR.cnt_return_ejr,
    NTR.cnt_void_ejr,
    NTR.cnt_ean_ejr,
    NTR.cnt_item_ejr,
    NTR.cnt_item_weight_ejr,
    NTR.cnt_mainitemgroup_ejr,
    NTR.qty_piece_ejr,
    NTR.val_retail_ejr,
    NTR.val_retail_pos_ejr,
    NTR.val_deposit_ejr,
    NTR.val_discount_ejr,
    NTR.val_discount_net_ejr,
    NTR.resumed_trans_store_id_ejr,
    NTR.resumed_trans_terminal_id_ejr,
    NTR.resumed_trans_date_ejr,
    NTR.resumed_trans_receipt_nr_ejr,
    NTR.dur_service_time_ejr,
    NTR.dur_pay_change_time_ejr,
    NTR.val_retail_net_ejr,
    NTR.timestamp_begin_ejr,
    NTR.timestamp_end_ejr,
    0 AS turnover_relevant_fg,
    NTR.authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr_1 AS NTR
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON NTR.store_id = REVSTR.store_id
        AND NTR.client_id = REVSTR.client_id AND NTR.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
      
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 AS REVDAY ON NTR.dat_formdate = REVDAY.dat_calendar
     /* Exclude all lines that are TurnoverRelevant="false". These are indicated by the third digit of the header-transactiontype_id. */
     
   WHERE SUBSTR(NTR.transactiontype_id, 3, 1) <> '1'
   UNION ALL
   SELECT CTR.store_id,
    CTR.client_id,
    CTR.pos_terminal_id,
    CTR.dat_formdate,
    CTR.time_receipt_ejr,
    CTR.orig_receipt_nr_ejr,
    CTR.timezone_cd,
    CTR.dat_dayend,
    CTR.checker_id,
    CTR.transactiontype_id,
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS NUMERIC),
    0 /* val_retail_ejr */,
    CAST(NULL AS NUMERIC),
    CAST(NULL AS NUMERIC),
    CAST(NULL AS NUMERIC),
    CAST(NULL AS NUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS DATE),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS NUMERIC),
    CTR.timestamp_begin_ejr,
    CTR.timestamp_end_ejr,
    0 AS turnover_relevant_fg,
    CTR.authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_cntr_transact_1 AS CTR
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON CTR.store_id = REVSTR.store_id
        AND CTR.client_id = REVSTR.client_id AND CTR.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
      
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 AS REVDAY ON CTR.dat_formdate = REVDAY.dat_calendar
     
   UNION ALL
   SELECT PRC.store_id,
    PRC.client_id,
    PRC.pos_terminal_id,
    PRC.dat_formdate,
    PRC.time_receipt_ejr,
    PRC.orig_receipt_nr_ejr,
    PRC.timezone_cd,
    PRC.dat_dayend,
    PRC.checker_id,
    PRC.transactiontype_id,
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS NUMERIC),
    COALESCE(PRC.price_retail_ejr, 0) AS val_retail_ejr,
    CAST(NULL AS NUMERIC),
    CAST(NULL AS NUMERIC),
    CAST(NULL AS NUMERIC),
    CAST(NULL AS NUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS DATE),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS BIGNUMERIC),
    CAST(NULL AS NUMERIC),
    PRC.timestamp_begin_ejr,
    PRC.timestamp_end_ejr,
    0 AS turnover_relevant_fg,
    PRC.authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_price_info_1 AS PRC
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON PRC.store_id = REVSTR.store_id
        AND PRC.client_id = REVSTR.client_id AND PRC.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
      
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 AS REVDAY ON PRC.dat_formdate = REVDAY.dat_calendar
     /* Gruppierung wg. Irland Fall 27.07.2018 (doppelte Preisabfrage innerhalb einer Sekunde) */
   GROUP BY PRC.store_id,
    PRC.client_id,
    PRC.pos_terminal_id,
    PRC.dat_formdate,
    PRC.time_receipt_ejr,
    PRC.orig_receipt_nr_ejr,
    PRC.timezone_cd,
    PRC.dat_dayend,
    PRC.checker_id,
    PRC.transactiontype_id,
    val_retail_ejr,
    PRC.timestamp_begin_ejr,
    PRC.timestamp_end_ejr,
    PRC.authority_id) AS x
 LEFT JOIN (SELECT RH.store_id,
   RH.client_id,
   RH.pos_terminal_id,
   RH.dat_formdate,
   RH.orig_receipt_nr_ejr,
   RH.time_receipt_ejr,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('120', '122', '220', '222')
     THEN 1
     ELSE 0
     END) AS cnt_all_deposit_back,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('120', '122', '220', '222') AND RL.item_entry_method_cd_ejr IN ('KE', 'DV') AND
       LENGTH(RL.barcode) < 19
     THEN 1
     ELSE 0
     END) AS cnt_ke_deposit_back,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('120', '122', '220', '222') AND (RL.item_entry_method_cd_ejr = 'SC' OR LENGTH(RL.barcode
          ) >= 19)
     THEN 1
     ELSE 0
     END) AS cnt_sc_deposit_back,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('120', '122', '220', '222')
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_all_deposit_back,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('120', '122', '220', '222')
     THEN RL.val_retail_ejr - RL.val_vat_ejr
     ELSE 0
     END) AS val_all_deposit_back_net,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('120', '122', '220', '222') AND RL.item_entry_method_cd_ejr IN ('KE', 'DV') AND
       LENGTH(RL.barcode) < 19
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_ke_deposit_back,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('120', '122', '220', '222') AND RL.item_entry_method_cd_ejr IN ('KE', 'DV') AND
       LENGTH(RL.barcode) < 19
     THEN RL.val_retail_ejr - RL.val_vat_ejr
     ELSE 0
     END) AS val_ke_deposit_back_net,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('120', '122', '220', '222') AND (RL.item_entry_method_cd_ejr = 'SC' OR LENGTH(RL.barcode
          ) >= 19)
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_sc_deposit_back,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('121', '123', '221', '223')
     THEN 1
     ELSE 0
     END) AS cnt_all_deposit_sell,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('121', '123', '221', '223') AND RL.item_entry_method_cd_ejr IN ('KE', 'DV')
     THEN 1
     ELSE 0
     END) AS cnt_ke_deposit_sell,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('121', '123', '221', '223') AND RL.item_entry_method_cd_ejr = 'SC'
     THEN 1
     ELSE 0
     END) AS cnt_sc_deposit_sell,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('121', '123', '221', '223')
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_all_deposit_sell,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('121', '123', '221', '223')
     THEN RL.val_retail_ejr - RL.val_vat_ejr
     ELSE 0
     END) AS val_all_deposit_sell_net,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('121', '123', '221', '223') AND RL.item_entry_method_cd_ejr IN ('KE', 'DV')
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_ke_deposit_sell,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('121', '123', '221', '223') AND RL.item_entry_method_cd_ejr = 'SC'
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_sc_deposit_sell,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('101', '102', '201', '202')
     THEN CASE
      WHEN COALESCE(RL.qty_piece_ejr, 0) = 0 AND COALESCE(RL.qty_weight_ejr, 0) <> 0
      THEN 1
      ELSE RL.qty_piece_ejr
      END
     ELSE 0
     END) AS amt_sell_item,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('101', '102', '201', '202')
     THEN 1
     ELSE 0
     END) AS cnt_sell_item,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('101', '102', '201', '202')
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_sell_item,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('101', '102', '201', '202')
     THEN RL.price_retail_ejr
     ELSE 0
     END) AS val_price_item,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0 AND RL.val_retail_ejr > 0
     THEN RL.price_retail_ejr
     ELSE 0
     END) AS val_void_price_item,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0
     THEN 1
     ELSE 0
     END) AS cnt_all_voided_line,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0 AND RL.val_retail_ejr > 0
     THEN 1
     ELSE 0
     END) AS cnt_wo_deposit_voided_line,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0 AND RL.mainitemgroup_id <> 1 AND RL.subitemgroup_id
        <> 74
     THEN 1
     ELSE 0
     END) AS cnt_voided_line,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0
     THEN RL.qty_piece_ejr
     ELSE 0
     END) AS amt_all_voided_item,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0 AND RL.mainitemgroup_id <> 1 AND RL.subitemgroup_id
        <> 74
     THEN RL.qty_piece_ejr
     ELSE 0
     END) AS amt_voided_item,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_all_voided_line,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0
     THEN RL.val_retail_ejr - RL.val_vat_ejr
     ELSE 0
     END) AS val_all_voided_line_net,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0 AND RL.val_retail_ejr < 0
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_wo_deposit_voided_line,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0 AND RL.mainitemgroup_id <> 1 AND RL.subitemgroup_id
        <> 74
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_voided_line,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0 AND RL.mainitemgroup_id <> 1 AND RL.subitemgroup_id
        <> 74
     THEN RL.val_retail_ejr - RL.val_vat_ejr
     ELSE 0
     END) AS val_voided_line_net,
   SUM(CASE
     WHEN RH.transactiontype_id = '100' AND RL.voided_by_line_nr_ejr > 0 AND RL.mainitemgroup_id <> 1 AND RL.subitemgroup_id
         <> 74 AND RL.price_retail_ejr > TM.mvoid_item_val
     THEN 1
     ELSE 0
     END) AS is_voided_gt_4,
   MAX(CASE
     WHEN RL.transactiontype_id IN ('120', '122') AND (RL.item_entry_method_cd_ejr = 'SC' OR LENGTH(RL.barcode) >= 19)
      AND (RL.val_retail_ejr * - 1.0 > TR.deposit_scanned_value OR MOD(RL.val_retail_ejr * - 1.0 * 100.0, CASE
            WHEN TR.deposit_scanned_qty_integer = 0
            THEN NULL
            ELSE TR.deposit_scanned_qty_integer
            END * 100.0) <> 0.0)
     THEN 1
     ELSE 0
     END) AS is_implausible_deposit,
   MAX(CASE
     WHEN RL.transactiontype_id IN ('120', '122') AND (RL.item_entry_method_cd_ejr = 'SC' OR LENGTH(RL.barcode) >= 19)
      AND MOD(RL.val_retail_ejr * - 1.0 * 100.0, CASE
          WHEN TR.deposit_scanned_qty_integer = 0
          THEN NULL
          ELSE TR.deposit_scanned_qty_integer
          END * 100.0) <> 0.0
     THEN 1
     ELSE 0
     END) AS is_implausible_depositv1,
   MAX(CASE
     WHEN RL.transactiontype_id IN ('120', '122') AND (RL.item_entry_method_cd_ejr = 'SC' OR LENGTH(RL.barcode) >= 19)
       AND RL.val_retail_ejr * - 1.0 > TR.deposit_scanned_value AND MOD(RL.val_retail_ejr * - 1.0 * 100.0, CASE
          WHEN TR.deposit_scanned_qty_integer = 0
          THEN NULL
          ELSE TR.deposit_scanned_qty_integer
          END * 100.0) = 0.0
     THEN 1
     ELSE 0
     END) AS is_implausible_depositv2,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('120', '122') AND (RL.item_entry_method_cd_ejr = 'SC' OR LENGTH(RL.barcode) >= 19)
      AND MOD(RL.val_retail_ejr * - 1.0 * 100.0, CASE
          WHEN TR.deposit_scanned_qty_integer = 0
          THEN NULL
          ELSE TR.deposit_scanned_qty_integer
          END * 100.0) <> 0.0
     THEN RL.val_retail_ejr * - 1
     ELSE 0
     END) AS implausible_depositv1_val,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('120', '122') AND (RL.item_entry_method_cd_ejr = 'SC' OR LENGTH(RL.barcode) >= 19)
       AND RL.val_retail_ejr * - 1.0 > TR.deposit_scanned_value AND MOD(RL.val_retail_ejr * - 1.0 * 100.0, CASE
          WHEN TR.deposit_scanned_qty_integer = 0
          THEN NULL
          ELSE TR.deposit_scanned_qty_integer
          END * 100.0) = 0.0
     THEN RL.val_retail_ejr * - 1
     ELSE 0
     END) AS implausible_depositv2_val,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('141', '241', '142', '242', '143', '243', '120', '220', '122', '222')
     THEN ABS(RL.qty_piece_ejr)
     ELSE 0
     END) AS qty_return_ejr,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('141', '241', '142', '242', '143', '243', '120', '220', '122', '222') AND RL.item_entry_method_cd_ejr
        IN ('KE', 'DV')
     THEN ABS(RL.qty_piece_ejr)
     ELSE 0
     END) AS qty_ke_return_ejr,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('141', '241', '142', '242', '143', '243', '120', '220', '122', '222') AND RL.item_entry_method_cd_ejr
        = 'SC'
     THEN ABS(RL.qty_piece_ejr)
     ELSE 0
     END) AS qty_sc_return_ejr,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('141', '241', '142', '242', '143', '243', '120', '220', '122', '222') AND RL.item_entry_method_cd_ejr
        IN ('KE', 'DV')
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_ke_return_ejr,
   SUM(CASE
     WHEN RL.transactiontype_id IN ('141', '241', '142', '242', '143', '243', '120', '220', '122', '222') AND RL.item_entry_method_cd_ejr
        = 'SC'
     THEN RL.val_retail_ejr
     ELSE 0
     END) AS val_sc_return_ejr
  FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_1 AS RH
   INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS RL ON RH.client_id = RL.client_id AND RH.store_id
         = RL.store_id AND RH.pos_terminal_id = RL.pos_terminal_id AND RH.orig_receipt_nr_ejr = RL.orig_receipt_nr_ejr
    AND RH.dat_formdate = RL.dat_formdate
   INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS TR ON RL.client_id = TR.client_id
   INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_threshold_manual_1 AS TM ON RL.client_id = TM.client_id AND
      CURRENT_DATE BETWEEN TM.dat_rec_start AND TM.dat_rec_end AND TM.approval_fg = 1
     /* CROSS JOIN to *load_store to get only the relevant stores   AND CROSS JOIN to *load_day for performance (optimizer will evaluate if dynamic partition elimination is used) */
     
   INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR0 ON RH.store_id = REVSTR0.store_id
       AND RH.client_id = REVSTR0.client_id AND RH.dat_formdate BETWEEN REVSTR0.dat_formdate_from AND REVSTR0.dat_formdate_until
     
   INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 AS REVDAY0 ON RH.dat_formdate = REVDAY0.dat_calendar
    
  WHERE (RL.transactiontype_id IN ('120', '121', '122', '123', '101', '102', '201', '202', '220', '221', '222', '223',
       '141', '241', '142', '242', '143', '243') OR RL.voided_by_line_nr_ejr > 0)
   AND RH.dat_formdate >= (SELECT MIN(dat_calendar)
     FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 AS D_MIN)
   AND RH.dat_formdate <= (SELECT MAX(dat_calendar)
     FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 AS D_MAX)
  GROUP BY RH.client_id,
   RH.store_id,
   RH.pos_terminal_id,
   RH.dat_formdate,
   RH.orig_receipt_nr_ejr,
   RH.time_receipt_ejr) AS y ON x.client_id = y.client_id AND x.store_id = y.store_id AND x.pos_terminal_id = y.pos_terminal_id
       AND x.dat_formdate = y.dat_formdate AND x.orig_receipt_nr_ejr = y.orig_receipt_nr_ejr AND x.time_receipt_ejr = y
   .time_receipt_ejr
 INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS TR0 ON x.client_id = TR0.client_id
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_threshold_manual_1 AS TM0 ON x.client_id = TM0.client_id AND
    CURRENT_DATE BETWEEN TM0.dat_rec_start AND TM0.dat_rec_end AND TM0.approval_fg = 1
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_cal_calendarday_1 AS CAL ON x.dat_formdate = CAL.dat_calendar;