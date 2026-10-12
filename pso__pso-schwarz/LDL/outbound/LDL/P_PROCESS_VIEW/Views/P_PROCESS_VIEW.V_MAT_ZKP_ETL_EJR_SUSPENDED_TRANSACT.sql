CREATE OR REPLACE VIEW ldl_p_process_view.v_mat_zkp_etl_ejr_suspended_transact AS /* Aufruf Verkauf */
/* The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ). */
/* Aufruf Bonabbruch */ /* RESUMING Details (Verkauf) */
/* The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ). */
/* Resume Transaction */ /* p_msi_view.v_ejr_receiptline r */
/* CROSS JOIN to *load_store to get only the relevant stores   AND CROSS JOIN to *load_day for performance (optimizer will evaluate if dynamic partition elimination is used) */
/* The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ). */
/* r Resumedtransaction */ /* RESUMING Details (Bonabbruch) */ /* FOLGEBON */
/* Next Receipt for Suspended Transaction */ /* Suspended Details */ /* Resume Transaction */
/* p_msi_view.v_ejr_receiptline r */
/* New scenarios from BBT-398.
      Bonrueckstellung + Kleinstbon 
      Bonrueckstellung + Abmeldung */
/* Suspended Transactions */ /* Open, non resumed transactions */ /* Threshold values for client */
/* Resumed Trans Sequence Numbers for output records */ /* Suspended Transaction */ /* ... or logoff. */
/* Get the next transaction record (Sales or Logoff) */ SELECT resumed_trans_store_id_ejr,
 resumed_trans_terminal_id_ejr,
 resumed_trans_date_ejr,
 resumed_trans_receipt_nr_ejr,
 resumed_trans_seqnr,
 store_id,
 client_id,
 pos_terminal_id,
 dat_formdate,
 orig_receipt_nr_ejr,
 checker_id,
 time_receipt_ejr,
 transactiontype_id,
 MAX(COALESCE(val_susp_retail_ejr, 0)) AS val_susp_retail_ejr,
 susp_next_transactiontype_id,
 MAX(COALESCE(val_susp_next_retail_ejr, 0)) AS val_susp_next_retail_ejr,
 MAX(COALESCE(cnt_s_all_salelines, 0)) AS cnt_s_all_salelines,
 MAX(COALESCE(cnt_s_all_voidedlines_in_res, 0)) AS cnt_s_all_voidedlines_in_res,
 MAX(COALESCE(is_s_lastline_sale, 0)) AS is_s_lastline_sale,
 MAX(COALESCE(cnt_s_voidedlines_beforlast, 0)) AS cnt_s_voidedlines_beforlast,
 MAX(COALESCE(cnt_s_all_lines, 0)) AS cnt_s_all_lines,
 MAX(COALESCE(cnt_r_all_salelines, 0)) AS cnt_r_all_salelines,
 MAX(COALESCE(cnt_r_all_voidedlines_in_res, 0)) AS cnt_r_all_voidedlines_in_res,
 MAX(COALESCE(is_r_lastline_sale, 0)) AS is_r_lastline_sale,
 MAX(COALESCE(cnt_r_voidedlines_beforlast, 0)) AS cnt_r_voidedlines_beforlast,
 MAX(COALESCE(cnt_r_all_lines, 0)) AS cnt_r_all_lines,
 MAX(COALESCE(val_r_voided, 0)) AS val_r_voided,
 MAX(COALESCE(val_s_voided, 0)) AS val_s_voided,
 MAX(is_voided_till_last_artikel) AS is_voided_till_last_artikel,
 MAX(is_new_item_in_resume) AS is_new_item_in_resume,
 MAX(is_suspend_gt_10) AS is_suspend_gt_10,
 MAX(is_next_tran_cond) AS is_next_tran_cond,
 MAX(is_resumed_aborted) AS is_resumed_aborted,
 MAX(is_voided_till_last_artikel_mc) AS is_voided_till_last_artikel_mc,
 MAX(is_new_item_in_resume_mc) AS is_new_item_in_resume_mc,
 MAX(is_open_suspended) AS is_open_suspended,
 MAX(is_next_low_tran) AS is_next_low_tran,
 MAX(is_next_low_tran_mc) AS is_next_low_tran_mc,
 MAX(is_next_abmeld_mc) AS is_next_abmeld_mc
FROM (SELECT alls.resumed_trans_store_id_ejr,
    alls.resumed_trans_terminal_id_ejr,
    alls.resumed_trans_date_ejr,
    alls.resumed_trans_receipt_nr_ejr,
    alls.resumed_trans_seqnr,
    alls.store_id,
    alls.client_id,
    alls.pos_terminal_id,
    alls.dat_formdate,
    alls.orig_receipt_nr_ejr,
    alls.checker_id,
    alls.time_receipt_ejr,
    alls.transactiontype_id,
    susp.val_susp_retail_ejr,
    s_next.transactiontype_id AS susp_next_transactiontype_id,
    s_next.val_retail_ejr AS val_susp_next_retail_ejr,
    susp.cnt_s_all_salelines,
    susp.cnt_s_all_voidedlines_in_res,
    susp.is_s_lastline_sale,
    susp.cnt_s_voidedlines_beforlast,
    susp.cnt_s_all_lines,
    s_res_out.cnt_r_all_salelines,
    s_res_out.cnt_r_all_voidedlines_in_res,
    s_res_out.is_r_lastline_sale,
    s_res_out.cnt_r_voidedlines_beforlast,
    s_res_out.cnt_r_all_lines,
    s_res_out.val_r_voided,
    susp.val_s_voided,
     CASE
     WHEN s_res_out.cnt_r_all_voidedlines_in_res > susp.cnt_s_all_voidedlines_in_res AND s_res_out.is_r_lastline_sale =
        1 AND s_res_out.val_r_voided - susp.val_s_voided > TR.susp_voided_exp_last_void_val
     THEN 1
     ELSE 0
     END AS is_voided_till_last_artikel,
     CASE
     WHEN s_res_out.cnt_r_all_lines > susp.cnt_s_all_lines AND s_res_out.is_r_lastline_sale = 1
     THEN 1
     ELSE 0
     END AS is_new_item_in_resume,
     CASE
     WHEN susp.val_susp_retail_ejr > TR.susp_tot_val
     THEN 1
     ELSE 0
     END AS is_suspend_gt_10,
     CASE
     WHEN s_next.val_retail_ejr > 0 AND s_next.val_retail_ejr < TR.susp_subsequent_trans_low_val AND s_next.transactiontype_id
            = '100' AND s_next.cnt_sell_item = 1 AND s_next.cnt_all_deposit_back = 0 AND s_next.cnt_wo_deposit_voided_line
         = 0 OR s_next.transactiontype_id = '410'
     THEN 1
     ELSE 0
     END AS is_next_tran_cond,
     CASE
     WHEN s_res_out_abb.resumed_trans_store_id_ejr IS NOT NULL
     THEN 1
     ELSE 0
     END AS is_resumed_aborted,
     CASE
     WHEN s_res_out.cnt_r_all_voidedlines_in_res > susp.cnt_s_all_voidedlines_in_res AND s_res_out.is_r_lastline_sale =
        1 AND s_res_out.val_r_voided - susp.val_s_voided > TR.susp_voided_exp_last_void_val2
     THEN 1
     ELSE 0
     END AS is_voided_till_last_artikel_mc,
     CASE
     WHEN s_res_out.cnt_r_all_lines > susp.cnt_s_all_lines AND s_res_out.is_r_lastline_sale = 1
     THEN 1
     ELSE 0
     END AS is_new_item_in_resume_mc,
     CASE
     WHEN s_res_out_abb.resumed_trans_store_id_ejr IS NULL AND s_res_out.resumed_trans_store_id_ejr IS NULL
     THEN 1
     ELSE 0
     END AS is_open_suspended,
     CASE
     WHEN s_next.val_retail_ejr > 0 AND s_next.val_retail_ejr < TR.susp_subsequent_trans_low_val AND s_next.transactiontype_id
           = '100' AND s_next.cnt_sell_item = 1 AND s_next.cnt_all_deposit_back = 0 AND s_next.cnt_wo_deposit_voided_line
        = 0
     THEN 1
     ELSE 0
     END AS is_next_low_tran,
    0 AS is_next_low_tran_mc,
    0 AS is_next_abmeld_mc
   FROM (SELECT TRAN.store_id,
       TRAN.client_id,
       TRAN.pos_terminal_id,
       TRAN.dat_formdate,
       TRAN.time_receipt_ejr,
       TRAN.orig_receipt_nr_ejr,
       TRAN.timezone_cd,
       TRAN.dat_dayend,
       TRAN.checker_id,
       TRAN.transactiontype_id,
       TRAN.val_retail_ejr,
       TRAN.store_id AS resumed_trans_store_id_ejr,
       TRAN.pos_terminal_id AS resumed_trans_terminal_id_ejr,
       TRAN.dat_formdate AS resumed_trans_date_ejr,
       TRAN.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr,
       1 AS resumed_trans_seqnr
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr AS TRAN
       INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR ON TRAN.store_id = REVSTR.store_id
           AND TRAN.client_id = REVSTR.client_id AND TRAN.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
         
       INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS REVDAY ON TRAN.dat_formdate = REVDAY.dat_calendar
          AND TRAN.transactiontype_id = '300'
      UNION ALL
      SELECT TRAN.store_id,
       TRAN.client_id,
       TRAN.pos_terminal_id,
       TRAN.dat_formdate,
       TRAN.time_receipt_ejr,
       TRAN.orig_receipt_nr_ejr,
       TRAN.timezone_cd,
       TRAN.dat_dayend,
       TRAN.checker_id,
       TRAN.transactiontype_id,
       TRAN.val_retail_ejr,
       TRAN.resumed_trans_store_id_ejr,
       TRAN.resumed_trans_terminal_id_ejr,
       TRAN.resumed_trans_date_ejr,
       TRAN.resumed_trans_receipt_nr_ejr,
       3 AS resumed_trans_seqnr
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader AS TRAN
       INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR ON TRAN.store_id = REVSTR.store_id
           AND TRAN.client_id = REVSTR.client_id AND TRAN.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
         
       INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS REVDAY ON TRAN.dat_formdate = REVDAY.dat_calendar
        
      WHERE TRAN.resumed_trans_receipt_nr_ejr IS NOT NULL
       AND TRAN.dat_formdate >= (SELECT MIN(dat_calendar)
         FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS D_MIN)
       AND TRAN.dat_formdate <= (SELECT MAX(dat_calendar)
         FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS D_MAX)
      UNION ALL
      SELECT TRAN.store_id,
       TRAN.client_id,
       TRAN.pos_terminal_id,
       TRAN.dat_formdate,
       TRAN.time_receipt_ejr,
       TRAN.orig_receipt_nr_ejr,
       TRAN.timezone_cd,
       TRAN.dat_dayend,
       TRAN.checker_id,
       TRAN.transactiontype_id,
       TRAN.val_retail_ejr,
       TRAN.resumed_trans_store_id_ejr,
       TRAN.resumed_trans_terminal_id_ejr,
       TRAN.resumed_trans_date_ejr,
       TRAN.resumed_trans_receipt_nr_ejr,
       3 AS resumed_trans_seqnr
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr AS TRAN
       INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR ON TRAN.store_id = REVSTR.store_id
           AND TRAN.client_id = REVSTR.client_id AND TRAN.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
         
       INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS REVDAY ON TRAN.dat_formdate = REVDAY.dat_calendar
           AND TRAN.transactiontype_id = '200' AND TRAN.resumed_trans_receipt_nr_ejr IS NOT NULL
      UNION ALL
      SELECT TRAN.store_id,
       TRAN.client_id,
       TRAN.pos_terminal_id,
       TRAN.dat_formdate,
       TRAN.time_receipt_ejr,
       TRAN.orig_receipt_nr_ejr,
       TRAN.timezone_cd,
       TRAN.dat_dayend,
       TRAN.checker_id,
       TRAN.transactiontype_id,
       TRAN.val_retail_ejr,
       TRAN.store_id AS resumed_trans_store_id_ejr,
       RUECK.pos_terminal_id AS resumed_trans_terminal_id_ejr,
       RUECK.dat_formdate AS resumed_trans_date_ejr,
       RUECK.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr,
       2 AS resumed_trans_seqnr
      FROM ldl_p_lew_mart_msi.v_ejr_all_transact AS TRAN
       INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower AS RUECK ON TRAN.store_id = RUECK.store_id AND TRAN.client_id
              = RUECK.client_id AND TRAN.pos_terminal_id = RUECK.pos_terminal_id AND TRAN.orig_receipt_nr_ejr = RUECK.next_orig_receipt_nr_ejr
            AND TRAN.time_receipt_ejr = RUECK.next_time_receipt_ejr AND TRAN.dat_formdate = RUECK.dat_formdate
       INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR ON RUECK.store_id = REVSTR.store_id
           AND RUECK.client_id = REVSTR.client_id AND RUECK.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
         
      WHERE RUECK.transactiontype_id = '300') AS alls
    LEFT JOIN (SELECT s_res.resumed_trans_store_id_ejr,
      s_res.resumed_trans_terminal_id_ejr,
      s_res.resumed_trans_date_ejr,
      s_res.resumed_trans_receipt_nr_ejr,
      s_res.resumed_trans_seqnr,
      SUM(CASE
        WHEN r.transactiontype_id = '101'
        THEN 1
        ELSE 0
        END) AS cnt_r_all_salelines,
      SUM(CASE
        WHEN r.transactiontype_id = '170'
        THEN 1
        ELSE 0
        END) AS cnt_r_all_voidedlines_in_res,
      SUM(CASE
        WHEN r.xrownum = 1 AND r.transactiontype_id = '101'
        THEN 1
        ELSE 0
        END) AS is_r_lastline_sale,
      SUM(CASE
        WHEN r.xrownum = 1 AND r.transactiontype_id = '170'
        THEN 1
        ELSE 0
        END) AS is_r_lastline_void,
      SUM(CASE
        WHEN r.xrownum > 1 AND r.transactiontype_id = '170'
        THEN 1
        ELSE 0
        END) AS cnt_r_voidedlines_beforlast,
      SUM(CASE
        WHEN r.transactiontype_id = '101' OR r.transactiontype_id = '170'
        THEN 1
        ELSE 0
        END) AS cnt_r_all_lines,
      SUM(CASE
        WHEN r.transactiontype_id = '170'
        THEN r.val_retail_ejr
        ELSE 0
        END) AS val_r_voided
     FROM (SELECT TRAN0.store_id,
        TRAN0.client_id,
        TRAN0.pos_terminal_id,
        TRAN0.dat_formdate,
        TRAN0.time_receipt_ejr,
        TRAN0.orig_receipt_nr_ejr,
        TRAN0.timezone_cd,
        TRAN0.dat_dayend,
        TRAN0.checker_id,
        TRAN0.transactiontype_id,
        TRAN0.val_retail_ejr,
        TRAN0.resumed_trans_store_id_ejr,
        TRAN0.resumed_trans_terminal_id_ejr,
        TRAN0.resumed_trans_date_ejr,
        TRAN0.resumed_trans_receipt_nr_ejr,
        3 AS resumed_trans_seqnr
       FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader AS TRAN0
        INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR0 ON TRAN0.store_id = REVSTR0
           .store_id AND TRAN0.client_id = REVSTR0.client_id AND TRAN0.dat_formdate BETWEEN REVSTR0.dat_formdate_from
          AND REVSTR0.dat_formdate_until
        INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS REVDAY ON TRAN0.dat_formdate = REVDAY
         .dat_calendar
       WHERE TRAN0.resumed_trans_receipt_nr_ejr IS NOT NULL
        AND TRAN0.dat_formdate >= (SELECT MIN(dat_calendar)
          FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS D_MIN)
        AND TRAN0.dat_formdate <= (SELECT MAX(dat_calendar)
          FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS D_MAX)) AS s_res
      INNER JOIN (SELECT ROW_NUMBER() OVER (PARTITION BY store_id, client_id, pos_terminal_id, dat_formdate,
           orig_receipt_nr_ejr ORDER BY orig_receipt_serial_nr_ejr IS NULL, orig_receipt_serial_nr_ejr) AS xrownum,
        store_id,
        client_id,
        pos_terminal_id,
        dat_formdate,
        time_receipt_ejr,
        orig_receipt_nr_ejr,
        transactiontype_id,
        val_retail_ejr
       FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract AS R
       WHERE parent_line_nr_ejr IS NULL
        AND EXISTS (SELECT 1
         FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader AS RH
          INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR1 ON RH.store_id = REVSTR1.store_id
              AND RH.client_id = REVSTR1.client_id AND RH.dat_formdate BETWEEN REVSTR1.dat_formdate_from AND REVSTR1.dat_formdate_until
            
          INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS REVDAY0 ON RH.dat_formdate = REVDAY0
           .dat_calendar
          INNER JOIN (SELECT MIN(dat_calendar) AS a622787332
           FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS D_MIN) AS t13 ON TRUE
          INNER JOIN (SELECT MAX(dat_calendar) AS a2100252426
           FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS D_MAX) AS t15 ON TRUE
         WHERE RH.store_id = R.store_id
          AND RH.client_id = R.client_id
          AND RH.pos_terminal_id = R.pos_terminal_id
          AND RH.dat_formdate = R.dat_formdate
          AND RH.time_receipt_ejr = R.time_receipt_ejr
          AND RH.orig_receipt_nr_ejr = R.orig_receipt_nr_ejr
          AND RH.dat_formdate >= t13.a622787332
          AND RH.dat_formdate <= t15.a2100252426
          AND RH.resumed_trans_receipt_nr_ejr IS NOT NULL)) AS r ON s_res.store_id = r.store_id AND s_res.client_id = r
            .client_id AND s_res.pos_terminal_id = r.pos_terminal_id AND s_res.dat_formdate = r.dat_formdate AND s_res.time_receipt_ejr
          = r.time_receipt_ejr AND s_res.orig_receipt_nr_ejr = r.orig_receipt_nr_ejr
     GROUP BY s_res.resumed_trans_store_id_ejr,
      s_res.resumed_trans_terminal_id_ejr,
      s_res.resumed_trans_date_ejr,
      s_res.resumed_trans_receipt_nr_ejr,
      s_res.resumed_trans_seqnr) AS s_res_out ON alls.resumed_trans_store_id_ejr = s_res_out.resumed_trans_store_id_ejr
       AND alls.resumed_trans_terminal_id_ejr = s_res_out.resumed_trans_terminal_id_ejr AND alls.resumed_trans_date_ejr
       = s_res_out.resumed_trans_date_ejr AND alls.resumed_trans_receipt_nr_ejr = s_res_out.resumed_trans_receipt_nr_ejr
      
    LEFT JOIN (SELECT TRAN1.store_id,
      TRAN1.client_id,
      TRAN1.pos_terminal_id,
      TRAN1.dat_formdate,
      TRAN1.time_receipt_ejr,
      TRAN1.orig_receipt_nr_ejr,
      TRAN1.timezone_cd,
      TRAN1.dat_dayend,
      TRAN1.checker_id,
      TRAN1.transactiontype_id,
      TRAN1.val_retail_ejr,
      TRAN1.resumed_trans_store_id_ejr,
      TRAN1.resumed_trans_terminal_id_ejr,
      TRAN1.resumed_trans_date_ejr,
      TRAN1.resumed_trans_receipt_nr_ejr,
      3 AS resumed_trans_seqnr
     FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr AS TRAN1
      INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR2 ON TRAN1.store_id = REVSTR2.store_id
          AND TRAN1.client_id = REVSTR2.client_id AND TRAN1.dat_formdate BETWEEN REVSTR2.dat_formdate_from AND REVSTR2.dat_formdate_until
        
      INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS REVDAY1 ON TRAN1.dat_formdate = REVDAY1
       .dat_calendar
     WHERE TRAN1.resumed_trans_receipt_nr_ejr IS NOT NULL
      AND TRAN1.transactiontype_id = '200') AS s_res_out_abb ON alls.resumed_trans_store_id_ejr = s_res_out_abb.resumed_trans_store_id_ejr
         AND alls.resumed_trans_terminal_id_ejr = s_res_out_abb.resumed_trans_terminal_id_ejr AND alls.resumed_trans_date_ejr
        = s_res_out_abb.resumed_trans_date_ejr AND alls.resumed_trans_receipt_nr_ejr = s_res_out_abb.resumed_trans_receipt_nr_ejr
      
    LEFT JOIN (SELECT TRAN2.store_id,
      TRAN2.client_id,
      TRAN2.pos_terminal_id,
      TRAN2.dat_formdate,
      TRAN2.time_receipt_ejr,
      TRAN2.orig_receipt_nr_ejr,
      TRAN2.timezone_cd,
      TRAN2.dat_dayend,
      TRAN2.checker_id,
      TRAN2.transactiontype_id,
      TRAN2.val_retail_ejr,
      TRAN2.store_id AS resumed_trans_store_id_ejr,
      RUECK0.pos_terminal_id AS resumed_trans_terminal_id_ejr,
      RUECK0.dat_formdate AS resumed_trans_date_ejr,
      RUECK0.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr,
      2 AS resumed_trans_seqnr,
      TRAN2.cnt_sell_item,
      TRAN2.cnt_all_deposit_back,
      TRAN2.cnt_wo_deposit_voided_line
     FROM ldl_p_lew_mart_msi.v_ejr_all_transact AS TRAN2
      INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower AS RUECK0 ON TRAN2.store_id = RUECK0.store_id AND TRAN2
            .client_id = RUECK0.client_id AND TRAN2.pos_terminal_id = RUECK0.pos_terminal_id AND TRAN2.orig_receipt_nr_ejr
           = RUECK0.next_orig_receipt_nr_ejr AND TRAN2.time_receipt_ejr = RUECK0.next_time_receipt_ejr AND TRAN2.dat_formdate
         = RUECK0.dat_formdate
      INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR3 ON RUECK0.store_id = REVSTR3.store_id
          AND RUECK0.client_id = REVSTR3.client_id AND RUECK0.dat_formdate BETWEEN REVSTR3.dat_formdate_from AND REVSTR3
        .dat_formdate_until
     WHERE RUECK0.transactiontype_id = '300') AS s_next ON alls.resumed_trans_store_id_ejr = s_next.resumed_trans_store_id_ejr
         AND alls.resumed_trans_terminal_id_ejr = s_next.resumed_trans_terminal_id_ejr AND alls.resumed_trans_date_ejr =
       s_next.resumed_trans_date_ejr AND alls.resumed_trans_receipt_nr_ejr = s_next.resumed_trans_receipt_nr_ejr
    LEFT JOIN (SELECT susp.resumed_trans_store_id_ejr,
      susp.resumed_trans_terminal_id_ejr,
      susp.resumed_trans_date_ejr,
      susp.resumed_trans_receipt_nr_ejr,
      susp.resumed_trans_seqnr,
      MAX(susp.val_retail_ejr) AS val_susp_retail_ejr,
      SUM(CASE
        WHEN r.transactiontype_id = '201'
        THEN 1
        ELSE 0
        END) AS cnt_s_all_salelines,
      SUM(CASE
        WHEN r.transactiontype_id = '270'
        THEN 1
        ELSE 0
        END) AS cnt_s_all_voidedlines_in_res,
      SUM(CASE
        WHEN r.xrownum = 1 AND r.transactiontype_id = '201'
        THEN 1
        ELSE 0
        END) AS is_s_lastline_sale,
      SUM(CASE
        WHEN r.xrownum = 1 AND r.transactiontype_id = '270'
        THEN 1
        ELSE 0
        END) AS is_s_lastline_void,
      SUM(CASE
        WHEN r.xrownum > 1 AND r.transactiontype_id = '270'
        THEN 1
        ELSE 0
        END) AS cnt_s_voidedlines_beforlast,
      SUM(CASE
        WHEN r.transactiontype_id = '201' OR r.transactiontype_id = '270'
        THEN 1
        ELSE 0
        END) AS cnt_s_all_lines,
      SUM(CASE
        WHEN r.transactiontype_id = '270'
        THEN r.val_retail_ejr
        ELSE 0
        END) AS val_s_voided
     FROM (SELECT TRAN3.store_id,
        TRAN3.client_id,
        TRAN3.pos_terminal_id,
        TRAN3.dat_formdate,
        TRAN3.time_receipt_ejr,
        TRAN3.orig_receipt_nr_ejr,
        TRAN3.timezone_cd,
        TRAN3.dat_dayend,
        TRAN3.checker_id,
        TRAN3.transactiontype_id,
        TRAN3.val_retail_ejr,
        TRAN3.store_id AS resumed_trans_store_id_ejr,
        TRAN3.pos_terminal_id AS resumed_trans_terminal_id_ejr,
        TRAN3.dat_formdate AS resumed_trans_date_ejr,
        TRAN3.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr,
        1 AS resumed_trans_seqnr
       FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr AS TRAN3
        INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR4 ON TRAN3.store_id = REVSTR4
           .store_id AND TRAN3.client_id = REVSTR4.client_id AND TRAN3.dat_formdate BETWEEN REVSTR4.dat_formdate_from
          AND REVSTR4.dat_formdate_until
        INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS REVDAY2 ON TRAN3.dat_formdate =
         REVDAY2.dat_calendar
         /* Exclude all lines that are TurnoverRelevant="false". These are indicated by the third digit of the header-transactiontype_id. */
         
       WHERE SUBSTR(TRAN3.transactiontype_id, 3, 1) <> '1') AS susp
      INNER JOIN (SELECT ROW_NUMBER() OVER (PARTITION BY CAST(R0.store_id AS STRING), CAST(R0.client_id AS STRING), CAST(R0.pos_terminal_id AS STRING)
           , R0.dat_formdate, CAST(R0.orig_receipt_nr_ejr AS STRING) ORDER BY R0.orig_receipt_serial_nr_ejr IS NULL, R0
           .orig_receipt_serial_nr_ejr) AS xrownum,
        R0.store_id,
        R0.client_id,
        R0.pos_terminal_id,
        R0.dat_formdate,
        R0.time_receipt_ejr,
        R0.orig_receipt_nr_ejr,
        R0.transactiontype_id,
        R0.val_retail_ejr
       FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_ntr AS R0
        INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR5 ON R0.store_id = REVSTR5.store_id
            AND R0.client_id = REVSTR5.client_id AND R0.dat_formdate BETWEEN REVSTR5.dat_formdate_from AND REVSTR5.dat_formdate_until
          
        INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS REVDAY3 ON R0.dat_formdate = REVDAY3.dat_calendar
         
       WHERE R0.parent_line_nr_ejr IS NULL) AS r ON susp.store_id = r.store_id AND susp.client_id = r.client_id AND susp
          .pos_terminal_id = r.pos_terminal_id AND susp.dat_formdate = r.dat_formdate AND susp.time_receipt_ejr = r.time_receipt_ejr
        
     WHERE susp.resumed_trans_seqnr = 1
     GROUP BY susp.resumed_trans_store_id_ejr,
      susp.resumed_trans_terminal_id_ejr,
      susp.resumed_trans_date_ejr,
      susp.resumed_trans_receipt_nr_ejr,
      susp.resumed_trans_seqnr) AS susp ON alls.resumed_trans_store_id_ejr = susp.resumed_trans_store_id_ejr AND alls.resumed_trans_terminal_id_ejr
         = susp.resumed_trans_terminal_id_ejr AND alls.resumed_trans_date_ejr = susp.resumed_trans_date_ejr AND alls.resumed_trans_receipt_nr_ejr
       = susp.resumed_trans_receipt_nr_ejr
    INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt AS TR ON alls.client_id = TR.client_id
   UNION ALL
   SELECT SUST.store_id AS resumed_trans_store_id_ejr,
    SUST.pos_terminal_id AS resumed_trans_terminal_id_ejr,
    SUST.dat_formdate AS resumed_trans_date_ejr,
    SUST.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr,
    ur.resumed_trans_seqnr,
    SUST.store_id,
    SUST.client_id,
    SUST.pos_terminal_id,
    SUST.dat_formdate,
     CASE
     WHEN ur.resumed_trans_seqnr = 1
     THEN SUST.orig_receipt_nr_ejr
     WHEN ur.resumed_trans_seqnr = 2
     THEN NXTT.orig_receipt_nr_ejr
     WHEN ur.resumed_trans_seqnr = 4
     THEN ANMD.orig_receipt_nr_ejr
     ELSE NULL
     END AS orig_receipt_nr_ejr,
     CASE
     WHEN ur.resumed_trans_seqnr = 1
     THEN SUST.checker_id
     WHEN ur.resumed_trans_seqnr = 2
     THEN NXTT.checker_id
     WHEN ur.resumed_trans_seqnr = 4
     THEN ANMD.checker_id
     ELSE NULL
     END AS checker_id,
     CASE
     WHEN ur.resumed_trans_seqnr = 1
     THEN SUST.time_receipt_ejr
     WHEN ur.resumed_trans_seqnr = 2
     THEN NXTT.time_receipt_ejr
     WHEN ur.resumed_trans_seqnr = 4
     THEN ANMD.time_receipt_ejr
     ELSE NULL
     END AS time_receipt_ejr,
     CASE
     WHEN ur.resumed_trans_seqnr = 1
     THEN SUST.transactiontype_id
     WHEN ur.resumed_trans_seqnr = 2
     THEN NXTT.transactiontype_id
     WHEN ur.resumed_trans_seqnr = 4
     THEN ANMD.transactiontype_id
     ELSE NULL
     END AS transactiontype_id,
    0 AS val_susp_retail_ejr,
    NXTT.transactiontype_id AS susp_next_transactiontype_id,
    NXTT.val_retail_ejr AS val_susp_next_retail_ejr,
    0 AS cnt_s_all_salelines,
    0 AS cnt_s_all_voidedlines_in_res,
    0 AS is_s_lastline_sale,
    0 AS cnt_s_voidedlines_beforlast,
    0 AS cnt_s_all_lines,
    0 AS cnt_r_all_salelines,
    0 AS cnt_r_all_voidedlines_in_res,
    0 AS is_r_lastline_sale,
    0 AS cnt_r_voidedlines_beforlast,
    0 AS cnt_r_all_lines,
    0 AS val_r_voided,
    0 AS val_s_voided,
    0 AS is_voided_till_last_artikel,
    0 AS is_new_item_in_resume,
    0 AS is_suspend_gt_10,
    0 AS is_next_tran_cond,
    0 AS is_resumed_aborted,
    0 AS is_voided_till_last_artikel_mc,
    0 AS is_new_item_in_resume_mc,
    1 AS is_open_suspended,
    0 AS is_next_low_tran,
     CASE
     WHEN NXTT.transactiontype_id = '410'
     THEN 0
     ELSE 1
     END AS is_next_low_tran_mc,
     CASE
     WHEN NXTT.transactiontype_id = '410'
     THEN 1
     ELSE 0
     END AS is_next_abmeld_mc
   FROM (SELECT client_id,
       store_id,
       pos_terminal_id,
       dat_formdate,
       orig_receipt_nr_ejr
      FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower AS ATF
      WHERE dat_formdate BETWEEN (SELECT dat_formdate_from
         FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR1
         WHERE client_id = ATF.client_id
          AND store_id = ATF.store_id) AND (SELECT dat_formdate_until
         FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR2
         WHERE client_id = ATF.client_id
          AND store_id = ATF.store_id)
       AND client_id = (SELECT client_id
         FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR3
         WHERE client_id = ATF.client_id
          AND store_id = ATF.store_id)
       AND store_id = (SELECT store_id
         FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR4
         WHERE client_id = ATF.client_id
          AND store_id = ATF.store_id)
       AND transactiontype_id = '300'
       AND val_retail_ejr <> 0
       AND checker_id IS NOT NULL
      EXCEPT DISTINCT
      SELECT /* Resumed Transactions */ client_id,
       resumed_trans_store_id_ejr AS store_id,
       resumed_trans_terminal_id_ejr AS pos_terminal_id,
       resumed_trans_date_ejr AS dat_formdate,
       resumed_trans_receipt_nr_ejr AS orig_receipt_nr_ejr
      FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower AS ATF
      WHERE dat_formdate BETWEEN (SELECT dat_formdate_from
         FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR1
         WHERE client_id = ATF.client_id
          AND store_id = ATF.store_id) AND (SELECT dat_formdate_until
         FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR2
         WHERE client_id = ATF.client_id
          AND store_id = ATF.store_id)
       AND client_id = (SELECT client_id
         FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR3
         WHERE client_id = ATF.client_id
          AND store_id = ATF.store_id)
       AND store_id = (SELECT store_id
         FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR4
         WHERE client_id = ATF.client_id
          AND store_id = ATF.store_id)
       AND checker_id IS NOT NULL
       AND resumed_trans_receipt_nr_ejr IS NOT NULL) AS t55
    INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt AS TR ON t55.client_id = TR.client_id
    INNER JOIN (SELECT 1 AS resumed_trans_seqnr
      UNION ALL
      SELECT 2 AS resumed_trans_seqnr
      UNION ALL
      SELECT 4 AS resumed_trans_seqnr) AS ur ON TRUE
    INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower AS SUST ON t55.client_id = SUST.client_id AND t55.store_id
             = SUST.store_id AND t55.pos_terminal_id = SUST.pos_terminal_id AND t55.dat_formdate = SUST.dat_formdate AND
         t55.orig_receipt_nr_ejr = SUST.orig_receipt_nr_ejr AND SUST.transactiontype_id = '300' AND (SUST.next_transactiontype_id
          IN ('100', '101', '200', '201') /* Only interested in Suspended Transactions that are followed by sales... */
        OR SUST.next_transactiontype_id = '410') AND SUST.checker_id IS NOT NULL
    INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower AS NXTT ON t55.client_id = NXTT.client_id AND t55.store_id
              = NXTT.store_id AND t55.pos_terminal_id = NXTT.pos_terminal_id AND SUST.next_time_receipt_ejr = NXTT.time_receipt_ejr
            AND t55.dat_formdate = NXTT.dat_formdate AND SUST.next_orig_receipt_nr_ejr = NXTT.orig_receipt_nr_ejr AND
        SUST.next_transactiontype_id = NXTT.transactiontype_id AND (NXTT.transactiontype_id IN ('100', '101', '200',
              '201') AND TR.susp_subseqent_trans_low_val_mc > NXTT.val_retail_ejr AND NXTT.cnt_sell_item = 1 AND NXTT.cnt_all_deposit_back
            = 0 AND NXTT.cnt_wo_deposit_voided_line = 0 OR NXTT.transactiontype_id = '410') AND NXTT.checker_id
     IS NOT NULL
    LEFT JOIN ldl_p_lew_mart_msi.v_ejr_all_transact AS ANMD ON t55.client_id = ANMD.client_id AND t55.store_id = ANMD.store_id
              AND t55.pos_terminal_id = ANMD.pos_terminal_id AND NXTT.next_time_receipt_ejr = ANMD.time_receipt_ejr AND
          t55.dat_formdate = ANMD.dat_formdate AND NXTT.next_orig_receipt_nr_ejr = ANMD.orig_receipt_nr_ejr AND NXTT.next_transactiontype_id
         = ANMD.transactiontype_id AND ANMD.transactiontype_id = '415' AND ANMD.checker_id IS NOT NULL
   WHERE ur.resumed_trans_seqnr <> 4
    OR ANMD.client_id IS NOT NULL) AS d
GROUP BY resumed_trans_store_id_ejr,
 resumed_trans_terminal_id_ejr,
 resumed_trans_date_ejr,
 resumed_trans_receipt_nr_ejr,
 resumed_trans_seqnr,
 store_id,
 client_id,
 pos_terminal_id,
 dat_formdate,
 orig_receipt_nr_ejr,
 checker_id,
 time_receipt_ejr,
 transactiontype_id,
 susp_next_transactiontype_id;
