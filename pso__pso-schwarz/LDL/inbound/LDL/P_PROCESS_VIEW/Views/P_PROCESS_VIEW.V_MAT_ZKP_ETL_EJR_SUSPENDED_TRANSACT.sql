CREATE OR REPLACE VIEW P_PROCESS_VIEW.V_MAT_ZKP_ETL_EJR_SUSPENDED_TRANSACT
AS
   SELECT
       d.resumed_trans_store_id_ejr,
   d.resumed_trans_terminal_id_ejr,
   d.resumed_trans_date_ejr,
   d.resumed_trans_receipt_nr_ejr,
   d.resumed_trans_seqnr,
   d.store_id,
   d.client_id,
   d.pos_terminal_id,
   d.dat_formdate,
   d.orig_receipt_nr_ejr,
   d.checker_id,
   d.time_receipt_ejr,
   d.transactiontype_id,
   MAX(COALESCE(d.val_susp_retail_ejr, 0)) AS val_susp_retail_ejr,
   d.susp_next_transactiontype_id,
   MAX(COALESCE(d.val_susp_next_retail_ejr, 0)) AS val_susp_next_retail_ejr,
   MAX(COALESCE(d.cnt_s_all_salelines, 0)) AS cnt_s_all_salelines,
   MAX(COALESCE(d.cnt_s_all_voidedlines_in_res, 0)) AS cnt_s_all_voidedlines_in_res,
   MAX(COALESCE(d.is_s_lastline_sale, 0)) AS is_s_lastline_sale,
   MAX(COALESCE(d.cnt_s_voidedlines_beforlast, 0)) AS cnt_s_voidedlines_beforlast,
   MAX(COALESCE(d.cnt_s_all_lines, 0)) AS cnt_s_all_lines,
   MAX(COALESCE(d.cnt_r_all_salelines, 0)) AS cnt_r_all_salelines,
   MAX(COALESCE(d.cnt_r_all_voidedlines_in_res, 0)) AS cnt_r_all_voidedlines_in_res,
   MAX(COALESCE(d.is_r_lastline_sale, 0)) AS is_r_lastline_sale,
   MAX(COALESCE(d.cnt_r_voidedlines_beforlast, 0)) AS cnt_r_voidedlines_beforlast,
   MAX(COALESCE(d.cnt_r_all_lines, 0)) AS cnt_r_all_lines,
   MAX(COALESCE(d.val_r_voided, 0)) AS val_r_voided,
   MAX(COALESCE(d.val_s_voided, 0)) AS val_s_voided,
   MAX(COALESCE(d.is_voided_till_last_artikel, 0)) AS is_voided_till_last_artikel,
   MAX(COALESCE(d.is_new_item_in_resume, 0)) AS is_new_item_in_resume,
   MAX(COALESCE(d.is_suspend_gt_10, 0)) AS is_suspend_gt_10,
   MAX(COALESCE(d.is_next_tran_cond, 0)) AS is_next_tran_cond,
   MAX(COALESCE(d.is_resumed_aborted, 0)) AS is_resumed_aborted,
   MAX(COALESCE(d.is_voided_till_last_artikel_mc, 0)) AS is_voided_till_last_artikel_mc,
   MAX(COALESCE(d.is_new_item_in_resume_mc, 0)) AS is_new_item_in_resume_mc,
   MAX(COALESCE(d.is_open_suspended, 0)) AS is_open_suspended,
   MAX(COALESCE(d.is_next_low_tran, 0)) AS is_next_low_tran,
   MAX(COALESCE(d.is_next_low_tran_mc, 0)) AS is_next_low_tran_mc,
   MAX(COALESCE(d.is_next_abmeld_mc, 0)) AS is_next_abmeld_mc
   FROM (
   SELECT
     alls.resumed_trans_store_id_ejr,
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
   susp.val_susp_retail_ejr AS val_susp_retail_ejr,
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
   CASE WHEN s_res_out.cnt_r_all_voidedlines_in_res > susp.cnt_s_all_voidedlines_in_res   AND s_res_out.is_r_lastline_sale = 1   AND (s_res_out.val_r_voided - susp.val_s_voided) > tr.susp_voided_exp_last_void_val THEN 1 ELSE 0 END AS is_voided_till_last_artikel,
   CASE WHEN s_res_out.cnt_r_all_lines > susp.cnt_s_all_lines   AND s_res_out.is_r_lastline_sale = 1 THEN 1 ELSE 0 END AS is_new_item_in_resume,
   CASE WHEN val_susp_retail_ejr > tr.susp_tot_val THEN 1 ELSE 0 END AS is_suspend_gt_10,
   CASE WHEN (s_next.val_retail_ejr > 0   AND s_next.val_retail_ejr < tr.susp_subsequent_trans_low_val   AND s_next.transactiontype_id = '100'   AND s_next.cnt_sell_item = 1   AND s_next.cnt_all_deposit_back = 0   AND s_next.cnt_wo_deposit_voided_line = 0) OR s_next.transactiontype_id = '410' THEN 1 ELSE 0 END AS is_next_tran_cond,
   CASE WHEN s_res_out_abb.resumed_trans_store_id_ejr IS NOT NULL THEN 1 ELSE 0 END AS is_resumed_aborted,
   CASE WHEN s_res_out.cnt_r_all_voidedlines_in_res > susp.cnt_s_all_voidedlines_in_res   AND s_res_out.is_r_lastline_sale = 1   AND (s_res_out.val_r_voided - susp.val_s_voided) > tr.susp_voided_exp_last_void_val2 THEN 1 ELSE 0 END AS is_voided_till_last_artikel_mc,
   CASE WHEN s_res_out.cnt_r_all_lines > susp.cnt_s_all_lines   AND s_res_out.is_r_lastline_sale = 1 THEN 1 ELSE 0 END AS is_new_item_in_resume_mc,
   CASE WHEN s_res_out_abb.resumed_trans_store_id_ejr IS NULL AND s_res_out.resumed_trans_store_id_ejr IS NULL THEN 1 ELSE 0 END AS is_open_suspended,
   CASE WHEN (s_next.val_retail_ejr > 0   AND s_next.val_retail_ejr < tr.susp_subsequent_trans_low_val   AND s_next.transactiontype_id = '100'   AND s_next.cnt_sell_item = 1   AND s_next.cnt_all_deposit_back = 0   AND s_next.cnt_wo_deposit_voided_line = 0) THEN 1 ELSE 0 END AS is_next_low_tran,
   0 AS is_next_low_tran_mc,
   0 AS is_next_abmeld_mc
   FROM
   (
       SELECT
         tran.store_id,
   tran.client_id,
   tran.pos_terminal_id,
   tran.dat_formdate,
   tran.time_receipt_ejr,
   tran.orig_receipt_nr_ejr,
   tran.timezone_cd,
   tran.dat_dayend,
   tran.checker_id,
   tran.transactiontype_id,
   tran.val_retail_ejr,
   tran.store_id AS resumed_trans_store_id_ejr,
   tran.pos_terminal_id AS resumed_trans_terminal_id_ejr,
   tran.dat_formdate AS resumed_trans_date_ejr,
   tran.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr,
   1 AS resumed_trans_seqnr
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr tran
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
   ON tran.store_id = revstr.store_id
   AND tran.client_id = revstr.client_id
   AND tran.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
   ON tran.dat_formdate = revday.dat_calendar
   AND tran.transactiontype_id = '300'
 UNION ALL /* Aufruf Verkauf */
 SELECT
   tran.store_id,
   tran.client_id,
   tran.pos_terminal_id,
   tran.dat_formdate,
   tran.time_receipt_ejr,
   tran.orig_receipt_nr_ejr,
   tran.timezone_cd,
   tran.dat_dayend,
   tran.checker_id,
   tran.transactiontype_id,
   tran.val_retail_ejr,
   tran.resumed_trans_store_id_ejr,
   tran.resumed_trans_terminal_id_ejr,
   tran.resumed_trans_date_ejr,
   tran.resumed_trans_receipt_nr_ejr,
   3 AS resumed_trans_seqnr
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader tran
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
   ON tran.store_id = revstr.store_id
   AND tran.client_id = revstr.client_id
   AND tran.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
   ON tran.dat_formdate = revday.dat_calendar
   WHERE tran.resumed_trans_receipt_nr_ejr IS NOT NULL
   /* The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ). */
     AND tran.dat_formdate >= (SELECT Min(d_min.dat_calendar) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk d_min)
   AND tran.dat_formdate <= (SELECT Max(d_max.dat_calendar) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk d_max)

   UNION ALL /* Aufruf Bonabbruch  */
   SELECT
     tran.store_id,
   tran.client_id,
   tran.pos_terminal_id,
   tran.dat_formdate,
   tran.time_receipt_ejr,
   tran.orig_receipt_nr_ejr,
   tran.timezone_cd,
   tran.dat_dayend,
   tran.checker_id,
   tran.transactiontype_id,
   tran.val_retail_ejr,
   tran.resumed_trans_store_id_ejr,
   tran.resumed_trans_terminal_id_ejr,
   tran.resumed_trans_date_ejr,
   tran.resumed_trans_receipt_nr_ejr,
   3 AS resumed_trans_seqnr
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr tran
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
   ON tran.store_id = revstr.store_id
   AND tran.client_id = revstr.client_id
   AND tran.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
   ON tran.dat_formdate = revday.dat_calendar
   AND tran.transactiontype_id = '200'
   AND tran.resumed_trans_receipt_nr_ejr IS NOT NULL
 UNION ALL
 SELECT
   tran.store_id,
   tran.client_id,
   tran.pos_terminal_id,
   tran.dat_formdate,
   tran.time_receipt_ejr,
   tran.orig_receipt_nr_ejr,
   tran.timezone_cd,
   tran.dat_dayend,
   tran.checker_id,
   tran.transactiontype_id,
   tran.val_retail_ejr,
   tran.store_id AS resumed_trans_store_id_ejr,
   rueck.pos_terminal_id AS resumed_trans_terminal_id_ejr,
   rueck.dat_formdate AS resumed_trans_date_ejr,
   rueck.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr,
   2 AS resumed_trans_seqnr
       FROM p_lew_mart_msi.v_ejr_all_transact tran
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower rueck
   ON tran.store_id = rueck.store_id
   AND tran.client_id = rueck.client_id
   AND tran.pos_terminal_id = rueck.pos_terminal_id
   AND tran.orig_receipt_nr_ejr = rueck.next_orig_receipt_nr_ejr
   AND tran.time_receipt_ejr = rueck.next_time_receipt_ejr
   AND tran.dat_formdate = rueck.dat_formdate
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
   ON rueck.store_id = revstr.store_id
   AND rueck.client_id = revstr.client_id
   AND rueck.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
 WHERE rueck.transactiontype_id = '300'
) alls
   LEFT OUTER JOIN  /* RESUMING Details (Verkauf) */
   (
       SELECT
         s_res.resumed_trans_store_id_ejr,
   s_res.resumed_trans_terminal_id_ejr,
   s_res.resumed_trans_date_ejr,
   s_res.resumed_trans_receipt_nr_ejr,
   s_res.resumed_trans_seqnr,
   Sum(CASE WHEN r.transactiontype_id = '101' THEN 1 ELSE 0 END) AS cnt_r_all_salelines,
   Sum(CASE WHEN r.transactiontype_id = '170' THEN 1 ELSE 0 END) AS cnt_r_all_voidedlines_in_res,
   Sum(CASE WHEN r.xrownum = 1   AND r.transactiontype_id = '101' THEN 1 ELSE 0 END) AS is_r_lastline_sale,
   Sum(CASE WHEN r.xrownum = 1   AND r.transactiontype_id = '170' THEN 1 ELSE 0 END) AS is_r_lastline_void,
   Sum(CASE WHEN r.xrownum > 1   AND r.transactiontype_id = '170' THEN 1 ELSE 0 END) AS cnt_r_voidedlines_beforlast,
   Sum(CASE WHEN r.transactiontype_id = '101' OR r.transactiontype_id = '170' THEN 1 ELSE 0 END) AS cnt_r_all_lines,
   Sum(CASE WHEN r.transactiontype_id = '170' THEN r.val_retail_ejr ELSE 0 END) AS val_r_voided
       FROM
    (
           SELECT
             tran.store_id,
   tran.client_id,
   tran.pos_terminal_id,
   tran.dat_formdate,
   tran.time_receipt_ejr,
   tran.orig_receipt_nr_ejr,
   tran.timezone_cd,
   tran.dat_dayend,
   tran.checker_id,
   tran.transactiontype_id,
   tran.val_retail_ejr,
   tran.resumed_trans_store_id_ejr,
   tran.resumed_trans_terminal_id_ejr,
   tran.resumed_trans_date_ejr,
   tran.resumed_trans_receipt_nr_ejr,
   3 AS resumed_trans_seqnr
           FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader tran
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
   ON tran.store_id = revstr.store_id
   AND tran.client_id = revstr.client_id
   AND tran.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
   ON tran.dat_formdate = revday.dat_calendar
   WHERE tran.resumed_trans_receipt_nr_ejr IS NOT NULL
   /* The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).  */
     AND tran.dat_formdate >= (SELECT Min(d_min.dat_calendar) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk d_min)
   AND tran.dat_formdate <= (SELECT Max(d_max.dat_calendar) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk d_max)
   ) s_res /* Resume Transaction */
   INNER JOIN  /* p_msi_view.v_ejr_receiptline r */
   (
          SELECT
            Row_Number() Over ( PARTITION BY
                r.store_id
                ,r.client_id
                ,r.pos_terminal_id
                ,r.dat_formdate
                ,r.orig_receipt_nr_ejr
            ORDER BY
                r.orig_receipt_serial_nr_ejr DESC NULLS LAST) AS xrownum,
   r.store_id,
   r.client_id,
   r.pos_terminal_id,
   r.dat_formdate,
   r.time_receipt_ejr,
   r.orig_receipt_nr_ejr,
   r.transactiontype_id,
   r.val_retail_ejr
           FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract r
   WHERE r.parent_line_nr_ejr IS NULL
   /* Join to *load_store to get only the relevant stores   AND join to *load_day for performance (optimizer will evaluate if dynamic partition elimination is used)  */
     AND EXISTS (
                  SELECT 1 FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader rh
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
   ON rh.store_id = revstr.store_id
   AND rh.client_id = revstr.client_id
   AND rh.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
   ON rh.dat_formdate = revday.dat_calendar
   WHERE rh.store_id = r.store_id
     AND   rh.client_id = r.client_id
     AND   rh.pos_terminal_id = r.pos_terminal_id
     AND   rh.dat_formdate = r.dat_formdate
     AND   rh.time_receipt_ejr = r.time_receipt_ejr
     AND   rh.orig_receipt_nr_ejr = r.orig_receipt_nr_ejr
     AND   rh.resumed_trans_receipt_nr_ejr IS NOT NULL
   /* The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).  */
     AND rh.dat_formdate >= (SELECT Min(d_min.dat_calendar) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk d_min)
   AND rh.dat_formdate <= (SELECT Max(d_max.dat_calendar) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk d_max)
   )
) r
   ON s_res.store_id = r.store_id
   AND s_res.client_id = r.client_id
   AND s_res.pos_terminal_id = r.pos_terminal_id
   AND s_res.dat_formdate = r.dat_formdate
   AND s_res.time_receipt_ejr = r.time_receipt_ejr
   AND s_res.orig_receipt_nr_ejr = r.orig_receipt_nr_ejr
 GROUP BY
   s_res.resumed_trans_store_id_ejr
   ,s_res.resumed_trans_terminal_id_ejr
   ,s_res.resumed_trans_date_ejr
   ,s_res.resumed_trans_receipt_nr_ejr
   ,s_res.resumed_trans_seqnr
) s_res_out   /* r Resumedtransaction  */
   ON s_res_out.resumed_trans_store_id_ejr = alls.resumed_trans_store_id_ejr
   AND s_res_out.resumed_trans_terminal_id_ejr = alls.resumed_trans_terminal_id_ejr
   AND s_res_out.resumed_trans_date_ejr = alls.resumed_trans_date_ejr
   AND s_res_out.resumed_trans_receipt_nr_ejr = alls.resumed_trans_receipt_nr_ejr
   LEFT OUTER JOIN  /* RESUMING Details (Bonabbruch)  */
   (
         SELECT
             tran.store_id,
   tran.client_id,
   tran.pos_terminal_id,
   tran.dat_formdate,
   tran.time_receipt_ejr,
   tran.orig_receipt_nr_ejr,
   tran.timezone_cd,
   tran.dat_dayend,
   tran.checker_id,
   tran.transactiontype_id,
   tran.val_retail_ejr,
   tran.resumed_trans_store_id_ejr,
   tran.resumed_trans_terminal_id_ejr,
   tran.resumed_trans_date_ejr,
   tran.resumed_trans_receipt_nr_ejr,
   3 AS resumed_trans_seqnr
           FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr tran
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
   ON tran.store_id = revstr.store_id
   AND tran.client_id = revstr.client_id
   AND tran.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
   ON tran.dat_formdate = revday.dat_calendar
   WHERE tran.resumed_trans_receipt_nr_ejr IS NOT NULL
       AND tran.transactiontype_id = '200'
) s_res_out_abb
   ON s_res_out_abb.resumed_trans_store_id_ejr = alls.resumed_trans_store_id_ejr
   AND s_res_out_abb.resumed_trans_terminal_id_ejr = alls.resumed_trans_terminal_id_ejr
   AND s_res_out_abb.resumed_trans_date_ejr = alls.resumed_trans_date_ejr
   AND s_res_out_abb.resumed_trans_receipt_nr_ejr = alls.resumed_trans_receipt_nr_ejr
   LEFT OUTER JOIN /* FOLGEBON  */
   (
       SELECT
         tran.store_id,
   tran.client_id,
   tran.pos_terminal_id,
   tran.dat_formdate,
   tran.time_receipt_ejr,
   tran.orig_receipt_nr_ejr,
   tran.timezone_cd,
   tran.dat_dayend,
   tran.checker_id,
   tran.transactiontype_id,
   tran.val_retail_ejr,
   tran.store_id AS resumed_trans_store_id_ejr,
   rueck.pos_terminal_id AS resumed_trans_terminal_id_ejr,
   rueck.dat_formdate AS resumed_trans_date_ejr,
   rueck.orig_receipt_nr_ejr resumed_trans_receipt_nr_ejr,
   2 AS resumed_trans_seqnr,
   tran.cnt_sell_item,
   tran.cnt_all_deposit_back,
   tran.cnt_wo_deposit_voided_line
       FROM p_lew_mart_msi.v_ejr_all_transact tran
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower rueck
   ON tran.store_id = rueck.store_id
   AND tran.client_id = rueck.client_id
   AND tran.pos_terminal_id = rueck.pos_terminal_id
   AND tran.orig_receipt_nr_ejr = rueck.next_orig_receipt_nr_ejr
   AND tran.time_receipt_ejr = rueck.next_time_receipt_ejr
   AND tran.dat_formdate = rueck.dat_formdate
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
   ON rueck.store_id = revstr.store_id
   AND rueck.client_id = revstr.client_id
   AND rueck.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
 WHERE rueck.transactiontype_id = '300'
)  s_next  /* Next Receipt for Suspended Transaction  */
   ON s_next.resumed_trans_store_id_ejr =  alls.resumed_trans_store_id_ejr
   AND s_next.resumed_trans_terminal_id_ejr = alls.resumed_trans_terminal_id_ejr
   AND s_next.resumed_trans_date_ejr = alls.resumed_trans_date_ejr
   AND s_next.resumed_trans_receipt_nr_ejr = alls.resumed_trans_receipt_nr_ejr
   LEFT OUTER JOIN  /* Suspended Details  */
   (
       SELECT
         susp.resumed_trans_store_id_ejr,
   susp.resumed_trans_terminal_id_ejr,
   susp.resumed_trans_date_ejr,
   susp.resumed_trans_receipt_nr_ejr,
   susp.resumed_trans_seqnr,
   Max(susp.val_retail_ejr) AS val_susp_retail_ejr,
   Sum(CASE WHEN r.transactiontype_id = '201' THEN 1 ELSE 0 END) AS cnt_s_all_salelines,
   Sum(CASE WHEN r.transactiontype_id = '270' THEN 1 ELSE 0 END) AS cnt_s_all_voidedlines_in_res,
   Sum(CASE WHEN r.xrownum = 1   AND r.transactiontype_id = '201' THEN 1 ELSE 0 END) AS is_s_lastline_sale,
   Sum(CASE WHEN r.xrownum = 1   AND r.transactiontype_id = '270' THEN 1 ELSE 0 END) AS is_s_lastline_void,
   Sum(CASE WHEN r.xrownum > 1   AND r.transactiontype_id = '270' THEN 1 ELSE 0 END) AS cnt_s_voidedlines_beforlast,
   Sum(CASE WHEN r.transactiontype_id = '201' OR r.transactiontype_id = '270' THEN 1 ELSE 0 END) AS cnt_s_all_lines,
   Sum(CASE WHEN r.transactiontype_id = '270' THEN r.val_retail_ejr ELSE 0 END) AS val_s_voided
       FROM
    (
           SELECT
             tran.store_id,
   tran.client_id,
   tran.pos_terminal_id,
   tran.dat_formdate,
   tran.time_receipt_ejr,
   tran.orig_receipt_nr_ejr,
   tran.timezone_cd,
   tran.dat_dayend,
   tran.checker_id,
   tran.transactiontype_id,
   tran.val_retail_ejr,
   tran.store_id AS resumed_trans_store_id_ejr,
   tran.pos_terminal_id AS resumed_trans_terminal_id_ejr,
   tran.dat_formdate AS resumed_trans_date_ejr,
   tran.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr,
   1 AS resumed_trans_seqnr
           FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr tran
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
   ON tran.store_id = revstr.store_id
   AND tran.client_id = revstr.client_id
   AND tran.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
   ON tran.dat_formdate = revday.dat_calendar
   /* Exclude all lines that are TurnoverRelevant="false". These are indicated by the third digit of the header-transactiontype_id. */
   WHERE
   SUBSTRING(tran.transactiontype_id, 3, 1) <> '1'
   ) susp /* Resume Transaction  */
   INNER JOIN  /* p_msi_view.v_ejr_receiptline r */
   (
          SELECT
            Row_Number() Over (PARTITION BY
                r.store_id
                ,r.client_id
                ,r.pos_terminal_id
                ,r.dat_formdate
                ,r.orig_receipt_nr_ejr
            ORDER BY
                r.orig_receipt_serial_nr_ejr DESC NULLS LAST) AS xrownum,
   r.store_id,
   r.client_id,
   r.pos_terminal_id,
   r.dat_formdate,
   r.time_receipt_ejr,
   r.orig_receipt_nr_ejr,
   r.transactiontype_id,
   r.val_retail_ejr
           FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_ntr r
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
   ON r.store_id = revstr.store_id
   AND r.client_id = revstr.client_id
   AND r.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
   ON r.dat_formdate = revday.dat_calendar
   WHERE r.parent_line_nr_ejr IS NULL
) r
   ON susp.store_id = r.store_id
   AND susp.client_id = r.client_id
   AND susp.pos_terminal_id = r.pos_terminal_id
   AND susp.dat_formdate = r.dat_formdate
   AND susp.time_receipt_ejr = r.time_receipt_ejr
 WHERE susp.resumed_trans_seqnr = 1
 GROUP BY
   susp.resumed_trans_store_id_ejr
   ,susp.resumed_trans_terminal_id_ejr
   ,susp.resumed_trans_date_ejr
   ,susp.resumed_trans_receipt_nr_ejr
   ,susp.resumed_trans_seqnr
) susp
   ON susp.resumed_trans_store_id_ejr = alls.resumed_trans_store_id_ejr
   AND susp.resumed_trans_terminal_id_ejr = alls.resumed_trans_terminal_id_ejr
   AND susp.resumed_trans_date_ejr = alls.resumed_trans_date_ejr
   AND susp.resumed_trans_receipt_nr_ejr = alls.resumed_trans_receipt_nr_ejr
   INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt tr
   ON tr.client_id = alls.client_id
   UNION ALL
   /* New scenarios from BBT-398.
      Bonrueckstellung + Kleinstbon 
      Bonrueckstellung + Abmeldung  */
   SELECT
           sust.store_id                                                          AS resumed_trans_store_id_ejr,
   sust.pos_terminal_id                                                   AS resumed_trans_terminal_id_ejr,
   sust.dat_formdate                                                      AS resumed_trans_date_ejr,
   sust.orig_receipt_nr_ejr                                               AS resumed_trans_receipt_nr_ejr,
   ur.resumed_trans_seqnr                                                 AS resumed_trans_seqnr,
   sust.store_id                                                          AS store_id,
   sust.client_id                                                         AS client_id,
   sust.pos_terminal_id                                                   AS pos_terminal_id,
   sust.dat_formdate                                                      AS dat_formdate,
   CASE WHEN ur.resumed_trans_seqnr = 1 THEN sust.orig_receipt_nr_ejr
                WHEN ur.resumed_trans_seqnr = 2 THEN nxtt.orig_receipt_nr_ejr
                WHEN ur.resumed_trans_seqnr = 4 THEN anmd.orig_receipt_nr_ejr
            END                                                                   AS orig_receipt_nr_ejr,
   CASE WHEN ur.resumed_trans_seqnr = 1 THEN sust.checker_id
                WHEN ur.resumed_trans_seqnr = 2 THEN nxtt.checker_id
                WHEN ur.resumed_trans_seqnr = 4 THEN anmd.checker_id
            END                                                                   AS checker_id,
   CASE WHEN ur.resumed_trans_seqnr = 1 THEN sust.time_receipt_ejr
                WHEN ur.resumed_trans_seqnr = 2 THEN nxtt.time_receipt_ejr
                WHEN ur.resumed_trans_seqnr = 4 THEN anmd.time_receipt_ejr
            END                                                                   AS time_receipt_ejr,
   CASE WHEN ur.resumed_trans_seqnr = 1 THEN sust.transactiontype_id
                WHEN ur.resumed_trans_seqnr = 2 THEN nxtt.transactiontype_id
                WHEN ur.resumed_trans_seqnr = 4 THEN anmd.transactiontype_id
            END                                                                   AS transactiontype_id,
   0                                                                      AS val_susp_retail_ejr,
   nxtt.transactiontype_id                                                AS susp_next_transactiontype_id,
   nxtt.val_retail_ejr                                                    AS val_susp_next_retail_ejr,
   0                                                                      AS cnt_s_all_salelines,
   0                                                                      AS cnt_s_all_voidedlines_in_res,
   0                                                                      AS is_s_lastline_sale,
   0                                                                      AS cnt_s_voidedlines_beforlast,
   0                                                                      AS cnt_s_all_lines,
   0                                                                      AS cnt_r_all_salelines,
   0                                                                      AS cnt_r_all_voidedlines_in_res,
   0                                                                      AS is_r_lastline_sale,
   0                                                                      AS cnt_r_voidedlines_beforlast,
   0                                                                      AS cnt_r_all_lines,
   0                                                                      AS val_r_voided,
   0                                                                      AS val_s_voided,
   0                                                                      AS is_voided_till_last_artikel,
   0                                                                      AS is_new_item_in_resume,
   0                                                                      AS is_suspend_gt_10,
   0                                                                      AS is_next_tran_cond,
   0                                                                      AS is_resumed_aborted,
   0                                                                      AS is_voided_till_last_artikel_mc,
   0                                                                      AS is_new_item_in_resume_mc,
   1                                                                      AS is_open_suspended,
   0                                                                      AS is_next_low_tran,
   CASE WHEN nxtt.transactiontype_id = '410' THEN 0
                                                     ELSE 1
                 END                                                              AS is_next_low_tran_mc,
   CASE WHEN nxtt.transactiontype_id = '410' THEN 1
                                                     ELSE 0
                 END                                                              AS is_next_abmeld_mc
   FROM (
         SELECT  atf.client_id                                AS client_id                                   /* Suspended Transactions  */,
   atf.store_id                                 AS store_id,
   atf.pos_terminal_id                          AS pos_terminal_id,
   atf.dat_formdate                             AS dat_formdate,
   atf.orig_receipt_nr_ejr                      AS orig_receipt_nr_ejr
         FROM p_lew_mart_msi.v_ejr_all_transact_follower atf
   WHERE atf.dat_formdate BETWEEN (SELECT revstr1.dat_formdate_from FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr1
   WHERE revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id)
AND (SELECT revstr2.dat_formdate_until FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr2
   WHERE revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id)
AND atf.client_id   = (SELECT revstr3.client_id FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr3 WHERE revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id)
   AND atf.store_id    = (SELECT revstr4.store_id  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr4 WHERE revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id)
   AND atf.checker_id IS NOT NULL
   AND atf.transactiontype_id = '300'
   AND atf.val_retail_ejr <> 0
  MINUS
  SELECT                                                                                              /* Resumed Transactions  */
          atf.client_id                                AS client_id,
   atf.resumed_trans_store_id_ejr               AS store_id,
   atf.resumed_trans_terminal_id_ejr            AS pos_terminal_id,
   atf.resumed_trans_date_ejr                   AS dat_formdate,
   atf.resumed_trans_receipt_nr_ejr             AS orig_receipt_nr_ejr
         FROM p_lew_mart_msi.v_ejr_all_transact_follower atf
   WHERE atf.dat_formdate BETWEEN (SELECT revstr1.dat_formdate_from FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr1
   WHERE revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id)
AND (SELECT revstr2.dat_formdate_until FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr2
   WHERE revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id)
AND atf.client_id   = (SELECT revstr3.client_id FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr3 WHERE revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id)
   AND atf.store_id    = (SELECT revstr4.store_id  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr4 WHERE revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id)
   AND atf.checker_id IS NOT NULL
   AND atf.resumed_trans_receipt_nr_ejr IS NOT NULL
  ) osus                                                         /* Open, non resumed transactions */
   INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt tr                      /* Threshold values for client    */
   ON tr.client_id = osus.client_id
   INNER JOIN (                                                         /* Resumed Trans Sequence Numbers for output records */
   SELECT resumed_trans_seqnr FROM ( SELECT CAST(1 AS BYTEINT) AS "resumed_trans_seqnr" ) AS src
   UNION ALL
   SELECT resumed_trans_seqnr FROM ( SELECT CAST(2 AS BYTEINT) AS "resumed_trans_seqnr" ) AS src
   UNION ALL
   SELECT resumed_trans_seqnr FROM ( SELECT CAST(4 AS BYTEINT) AS "resumed_trans_seqnr" ) AS src
   ) ur
   ON 1 = 1
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower sust                   /* Suspended Transaction  */
   ON osus.client_id               = sust.client_id
   AND osus.store_id                = sust.store_id
   AND osus.pos_terminal_id         = sust.pos_terminal_id
   AND osus.dat_formdate            = sust.dat_formdate
   AND osus.orig_receipt_nr_ejr     = sust.orig_receipt_nr_ejr
   AND sust.checker_id IS NOT NULL
   AND sust.transactiontype_id = '300'
   AND    ((sust.next_transactiontype_id IN ('100','101','200','201') /* Only interested in Suspended Transactions that are followed by sales... */
            )
       OR
        (sust.next_transactiontype_id = '410'))                       /* ... or logoff.                                        */
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower nxtt                   /* Get the next transaction record (Sales or Logoff)*/
   ON osus.client_id                 = nxtt.client_id
   AND osus.store_id                  = nxtt.store_id
   AND osus.pos_terminal_id           = nxtt.pos_terminal_id
   AND sust.next_time_receipt_ejr     = nxtt.time_receipt_ejr
   AND osus.dat_formdate              = nxtt.dat_formdate
   AND sust.next_orig_receipt_nr_ejr  = nxtt.orig_receipt_nr_ejr
   AND sust.next_transactiontype_id   = nxtt.transactiontype_id
   AND nxtt.checker_id IS NOT NULL
   AND    ((nxtt.transactiontype_id IN ('100','101','200','201')
            AND nxtt.val_retail_ejr             < tr.susp_subseqent_trans_low_val_mc
            AND nxtt.cnt_sell_item              = 1
            AND nxtt.cnt_all_deposit_back       = 0
            AND nxtt.cnt_wo_deposit_voided_line = 0
            )
        OR
        (nxtt.transactiontype_id = '410'))
   LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact anmd
   ON osus.client_id                 = anmd.client_id
   AND osus.store_id                  = anmd.store_id
   AND osus.pos_terminal_id           = anmd.pos_terminal_id
   AND nxtt.next_time_receipt_ejr     = anmd.time_receipt_ejr
   AND osus.dat_formdate              = anmd.dat_formdate
   AND nxtt.next_orig_receipt_nr_ejr  = anmd.orig_receipt_nr_ejr
   AND nxtt.next_transactiontype_id   = anmd.transactiontype_id
   AND anmd.checker_id IS NOT NULL
   AND anmd.transactiontype_id = '415'

WHERE ur.resumed_trans_seqnr <> 4 OR anmd.client_id IS NOT NULL
) d
GROUP BY
    d.resumed_trans_store_id_ejr
   ,d.resumed_trans_terminal_id_ejr
   ,d.resumed_trans_date_ejr
   ,d.resumed_trans_receipt_nr_ejr
   ,d.resumed_trans_seqnr
   ,d.store_id
   ,d.client_id
   ,d.pos_terminal_id
   ,d.dat_formdate
   ,d.orig_receipt_nr_ejr
   ,d.checker_id
   ,d.time_receipt_ejr
   ,d.transactiontype_id
   ,d.susp_next_transactiontype_id
;