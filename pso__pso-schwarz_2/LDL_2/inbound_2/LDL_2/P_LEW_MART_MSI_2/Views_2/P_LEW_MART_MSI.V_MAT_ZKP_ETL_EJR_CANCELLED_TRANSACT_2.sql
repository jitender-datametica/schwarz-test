/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_CANCELLED_TRANSACT_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.04.2024    Kowalik,Aleksander       Initial
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_CANCELLED_TRANSACT_2(
	RESUMED_TRANS_STORE_ID_EJR
	,RESUMED_TRANS_TERMINAL_ID_EJR
	,RESUMED_TRANS_DATE_EJR
	,RESUMED_TRANS_RECEIPT_NR_EJR
	,RESUMED_TRANS_SEQNR
	,STORE_ID
	,CLIENT_ID
	,POS_TERMINAL_ID
	,DAT_FORMDATE
	,ORIG_RECEIPT_NR_EJR
	,CHECKER_ID
	,TIME_RECEIPT_EJR
	,TRANSACTIONTYPE_ID
	,VAL_SUSP_RETAIL_EJR
	,SUSP_NEXT_TRANSACTIONTYPE_ID
	,VAL_SUSP_NEXT_RETAIL_EJR
	,IS_RESUMED_CANCELLED
	,IS_NEXT_LOW_TRAN_CANCELLED
	,IS_NEXT_ABMELD_CANCELLED
 ) AS
   SELECT
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
   ,MAX(COALESCE(d.val_susp_retail_ejr, 0)) AS val_susp_retail_ejr
   ,d.susp_next_transactiontype_id
   ,MAX(COALESCE(d.val_susp_next_retail_ejr, 0)) AS val_susp_next_retail_ejr
   ,MAX(COALESCE(d.is_resumed_cancelled, 0)) AS is_resumed_cancelled
   ,MAX(COALESCE(d.is_next_low_tran_cancelled, 0)) AS is_next_low_tran_cancelled
   ,MAX(COALESCE(d.is_next_abmeld_cancelled, 0)) AS is_next_abmeld_cancelled
   FROM (
		SELECT
    alls.resumed_trans_store_id_ejr
   ,alls.resumed_trans_terminal_id_ejr
   ,alls.resumed_trans_date_ejr
   ,alls.resumed_trans_receipt_nr_ejr
   ,alls.resumed_trans_seqnr
   ,alls.store_id
   ,alls.client_id
   ,alls.pos_terminal_id
   ,alls.dat_formdate
   ,alls.orig_receipt_nr_ejr
   ,alls.checker_id
   ,alls.time_receipt_ejr
   ,alls.transactiontype_id
   ,0 AS val_susp_retail_ejr
   ,s_next.transactiontype_id AS susp_next_transactiontype_id
   ,s_next.val_retail_ejr AS val_susp_next_retail_ejr
   ,CASE WHEN s_res_out_abb.resumed_trans_store_id_ejr IS NOT NULL THEN 1 ELSE 0 END AS is_resumed_cancelled
   ,0 AS is_next_low_tran_cancelled
   ,0 AS is_next_abmeld_cancelled
   FROM
   (
       SELECT /* Aufruf Verkauf */
    tran.store_id
   ,tran.client_id
   ,tran.pos_terminal_id
   ,tran.dat_formdate
   ,tran.time_receipt_ejr
   ,tran.orig_receipt_nr_ejr
   ,tran.timezone_cd
   ,tran.dat_dayend
   ,tran.checker_id
   ,tran.transactiontype_id
   ,tran.val_retail_ejr
   ,tran.resumed_trans_store_id_ejr
   ,tran.resumed_trans_terminal_id_ejr
   ,tran.resumed_trans_date_ejr
   ,tran.resumed_trans_receipt_nr_ejr
   ,3 AS resumed_trans_seqnr
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_2 tran
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr
   ON tran.store_id = revstr.store_id
   AND tran.client_id = revstr.client_id
   AND tran.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 revday
   ON tran.dat_formdate = revday.dat_calendar
   WHERE tran.resumed_trans_receipt_nr_ejr IS NOT NULL
   /* The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ). */
   AND tran.dat_formdate >= (SELECT MIN(d_min.dat_calendar) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 d_min)
   AND tran.dat_formdate <= (SELECT MAX(d_max.dat_calendar) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 d_max)

   UNION ALL /* Aufruf Bonabbruch  */
   
   SELECT
    tran.store_id
   ,tran.client_id
   ,tran.pos_terminal_id
   ,tran.dat_formdate
   ,tran.time_receipt_ejr
   ,tran.orig_receipt_nr_ejr
   ,tran.timezone_cd
   ,tran.dat_dayend
   ,tran.checker_id
   ,tran.transactiontype_id
   ,tran.val_retail_ejr
   ,tran.resumed_trans_store_id_ejr
   ,tran.resumed_trans_terminal_id_ejr
   ,tran.resumed_trans_date_ejr
   ,tran.resumed_trans_receipt_nr_ejr
   ,3 AS resumed_trans_seqnr
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr_2 tran
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr
   ON tran.store_id = revstr.store_id
   AND tran.client_id = revstr.client_id
   AND tran.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 revday
   ON tran.dat_formdate = revday.dat_calendar
   AND tran.transactiontype_id = '200'
   AND tran.resumed_trans_receipt_nr_ejr IS NOT NULL
 
 UNION ALL
 
 SELECT
    next_op.store_id
   ,next_op.client_id
   ,next_op.pos_terminal_id
   ,next_op.dat_formdate
   ,next_op.time_receipt_ejr
   ,next_op.orig_receipt_nr_ejr
   ,next_op.timezone_cd
   ,next_op.dat_dayend
   ,next_op.checker_id
   ,next_op.transactiontype_id
   ,next_op.val_retail_ejr
   ,next_op.store_id AS resumed_trans_store_id_ejr
   ,tran.pos_terminal_id AS resumed_trans_terminal_id_ejr
   ,tran.dat_formdate AS resumed_trans_date_ejr
   ,tran.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr
   ,2 AS resumed_trans_seqnr
       FROM
        p_lew_mart_msi.v_ejr_all_transact_2 tran
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_2 next_op
   ON tran.store_id = next_op.store_id
   AND tran.client_id = next_op.client_id
   AND tran.pos_terminal_id = next_op.pos_terminal_id
   AND next_op.orig_receipt_nr_ejr =
   (SELECT MIN (tr_next.orig_receipt_nr_ejr)
   FROM p_lew_mart_msi.v_ejr_all_transact_follower_2 tr_next -- follower of current receipt
   WHERE tran.client_id = tr_next.client_id
  AND tran.store_id = tr_next.store_id
  AND tran.pos_terminal_id = tr_next.pos_terminal_id
  AND tran.dat_formdate = tr_next.dat_formdate
  AND tran.checker_id = tr_next.checker_id
  AND tr_next.orig_receipt_nr_ejr > tran.orig_receipt_nr_ejr
      AND tr_next.transactiontype_id NOT IN (400, 405, 420, 425, 430, 480))
   AND tran.dat_formdate = next_op.dat_formdate
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr
   ON tran.store_id = revstr.store_id
   AND tran.client_id = revstr.client_id
   AND tran.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
 WHERE tran.transactiontype_id = '200'
) alls
 LEFT OUTER JOIN  /* RESUMING Details (Bonabbruch)  */
   (
    SELECT
    tran.store_id
   ,tran.client_id
   ,tran.pos_terminal_id
   ,tran.dat_formdate
   ,tran.time_receipt_ejr
   ,tran.orig_receipt_nr_ejr
   ,tran.timezone_cd
   ,tran.dat_dayend
   ,tran.checker_id
   ,tran.transactiontype_id
   ,tran.val_retail_ejr
   ,tran.resumed_trans_store_id_ejr
   ,tran.resumed_trans_terminal_id_ejr
   ,tran.resumed_trans_date_ejr
   ,tran.resumed_trans_receipt_nr_ejr
   ,3 AS resumed_trans_seqnr
           FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr_2 tran
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr
   ON tran.store_id = revstr.store_id
   AND tran.client_id = revstr.client_id
   AND tran.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 revday
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
    next_op.store_id
   ,next_op.client_id
   ,next_op.pos_terminal_id
   ,next_op.dat_formdate
   ,next_op.time_receipt_ejr
   ,next_op.orig_receipt_nr_ejr
   ,next_op.timezone_cd
   ,next_op.dat_dayend
   ,next_op.checker_id
   ,next_op.transactiontype_id
   ,next_op.val_retail_ejr
   ,next_op.store_id AS resumed_trans_store_id_ejr
   ,tran.pos_terminal_id AS resumed_trans_terminal_id_ejr
   ,tran.dat_formdate AS resumed_trans_date_ejr
   ,tran.orig_receipt_nr_ejr resumed_trans_receipt_nr_ejr
   ,2 AS resumed_trans_seqnr
   ,next_op.cnt_sell_item
   ,next_op.cnt_all_deposit_back
   ,next_op.cnt_wo_deposit_voided_line
   FROM p_lew_mart_msi.v_ejr_all_transact_2 tran
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_2 next_op
   ON tran.store_id = next_op.store_id
   AND tran.client_id = next_op.client_id
   AND tran.pos_terminal_id = next_op.pos_terminal_id
   AND tran.dat_formdate = next_op.dat_formdate
   AND next_op.orig_receipt_nr_ejr =
   (SELECT MIN (tr_next.orig_receipt_nr_ejr)
    FROM p_lew_mart_msi.v_ejr_all_transact_follower_2 tr_next -- follower of current receipt
    WHERE tran.client_id = tr_next.client_id
    AND tran.store_id = tr_next.store_id
    AND tran.pos_terminal_id = tr_next.pos_terminal_id
    AND tran.dat_formdate = tr_next.dat_formdate
    AND tran.checker_id = tr_next.checker_id
    AND tr_next.orig_receipt_nr_ejr > tran.orig_receipt_nr_ejr
    AND tr_next.transactiontype_id NOT IN (400, 405, 420, 425, 430, 480))
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr
   ON tran.store_id = revstr.store_id
   AND tran.client_id = revstr.client_id
   AND tran.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
 WHERE tran.transactiontype_id = '200'
)  s_next  /* Next Receipt for Suspended Transaction  */
   ON s_next.resumed_trans_store_id_ejr =  alls.resumed_trans_store_id_ejr
   AND s_next.resumed_trans_terminal_id_ejr = alls.resumed_trans_terminal_id_ejr
   AND s_next.resumed_trans_date_ejr = alls.resumed_trans_date_ejr
   AND s_next.resumed_trans_receipt_nr_ejr = alls.resumed_trans_receipt_nr_ejr	
  
UNION ALL
/* New scenarios from BBT-6852.
      Bonabbruch + Kleinstbon
      Bonabbruch + Abmeldung  */
	  
 SELECT
    abrt.store_id                                                          AS resumed_trans_store_id_ejr
   ,abrt.pos_terminal_id                                                   AS resumed_trans_terminal_id_ejr
   ,abrt.dat_formdate                                                      AS resumed_trans_date_ejr
   ,abrt.orig_receipt_nr_ejr                                               AS resumed_trans_receipt_nr_ejr
   ,ur.resumed_trans_seqnr                                                 AS resumed_trans_seqnr
   ,abrt.store_id                                                          AS store_id
   ,abrt.client_id                                                         AS client_id
   ,abrt.pos_terminal_id                                                   AS pos_terminal_id
   ,abrt.dat_formdate                                                      AS dat_formdate
   ,CASE WHEN ur.resumed_trans_seqnr = 1 THEN abrt.orig_receipt_nr_ejr
                WHEN ur.resumed_trans_seqnr = 2 THEN nxtt.orig_receipt_nr_ejr
                WHEN ur.resumed_trans_seqnr = 4 THEN anmd.orig_receipt_nr_ejr
            END                                                                   AS orig_receipt_nr_ejr
   ,CASE WHEN ur.resumed_trans_seqnr = 1 THEN abrt.checker_id
                WHEN ur.resumed_trans_seqnr = 2 THEN nxtt.checker_id
                WHEN ur.resumed_trans_seqnr = 4 THEN anmd.checker_id
            END                                                                   AS checker_id
   ,CASE WHEN ur.resumed_trans_seqnr = 1 THEN abrt.time_receipt_ejr
                WHEN ur.resumed_trans_seqnr = 2 THEN nxtt.time_receipt_ejr
                WHEN ur.resumed_trans_seqnr = 4 THEN anmd.time_receipt_ejr
            END                                                                   AS time_receipt_ejr
   ,CASE WHEN ur.resumed_trans_seqnr = 1 THEN abrt.transactiontype_id
                WHEN ur.resumed_trans_seqnr = 2 THEN nxtt.transactiontype_id
                WHEN ur.resumed_trans_seqnr = 4 THEN anmd.transactiontype_id
            END                                                                   AS transactiontype_id
   ,0                                                                      AS val_susp_retail_ejr
   ,nxtt.transactiontype_id                                                AS susp_next_transactiontype_id
   ,nxtt.val_retail_ejr                                                    AS val_susp_next_retail_ejr
   ,1                                                                      AS is_resumed_cancelled
   ,CASE WHEN nxtt.transactiontype_id = '410' THEN 0
                                                     ELSE 1
                 END                                                              AS is_next_low_tran_cancelled
   ,CASE WHEN nxtt.transactiontype_id = '410' THEN 1
                                                     ELSE 0
                 END                                                              AS is_next_abmeld_cancelled
   FROM (
    SELECT  atf.client_id                                AS client_id  /* Cancelled Transactions  */
   ,atf.store_id                                 AS store_id
   ,atf.pos_terminal_id                          AS pos_terminal_id
   ,atf.dat_formdate                             AS dat_formdate
   ,atf.orig_receipt_nr_ejr                      AS orig_receipt_nr_ejr
   FROM p_lew_mart_msi.v_ejr_all_transact_follower_2 atf
   INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_2 tr                      /* Threshold values for client    */
   ON tr.client_id = atf.client_id
   WHERE atf.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr1
   WHERE revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id)
   AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr2
   WHERE revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id)
   AND atf.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr3 WHERE revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id)
   AND atf.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr4 WHERE revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id)
   AND atf.checker_id IS NOT NULL
   AND atf.transactiontype_id = '200'
   AND atf.val_retail_ejr <> 0
   AND atf.val_retail_ejr >= tr.susp_aborted_tot_val
  MINUS
  SELECT
    atf.client_id                                AS client_id /* Resumed Transactions  */
   ,atf.resumed_trans_store_id_ejr               AS store_id
   ,atf.resumed_trans_terminal_id_ejr            AS pos_terminal_id
   ,atf.resumed_trans_date_ejr                   AS dat_formdate
   ,atf.resumed_trans_receipt_nr_ejr             AS orig_receipt_nr_ejr
   FROM p_lew_mart_msi.v_ejr_all_transact_follower_2 atf
   WHERE atf.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr1
    WHERE revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id)
   AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr2
   WHERE revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id)
   AND atf.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr3 WHERE revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id)
   AND atf.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr4 WHERE revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id)
   AND atf.checker_id IS NOT NULL
   AND atf.resumed_trans_receipt_nr_ejr IS NOT NULL
  ) osus                                                         /* Open, non-resumed transactions */
   INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_2 tr                      /* Threshold values for client    */
   ON tr.client_id = osus.client_id
   INNER JOIN (                               /* Resumed Trans Sequence Numbers for output records */
   SELECT resumed_trans_seqnr FROM ( SELECT CAST(1 AS BYTEINT) AS "resumed_trans_seqnr" ) AS src
   UNION ALL
   SELECT resumed_trans_seqnr FROM ( SELECT CAST(2 AS BYTEINT) AS "resumed_trans_seqnr" ) AS src
   UNION ALL
   SELECT resumed_trans_seqnr FROM ( SELECT CAST(4 AS BYTEINT) AS "resumed_trans_seqnr" ) AS src
   ) ur
   ON 1 = 1
   INNER JOIN
    (SELECT tr_foll.* ,(SELECT MIN(tr_next.orig_receipt_nr_ejr)
     FROM p_lew_mart_msi.v_ejr_all_transact_follower_2 tr_next -- follower of current receipt
     WHERE tr_foll.client_id = tr_next.client_id
     AND tr_foll.store_id = tr_next.store_id
     AND tr_foll.pos_terminal_id = tr_next.pos_terminal_id
     AND tr_foll.dat_formdate = tr_next.dat_formdate
     AND tr_foll.checker_id = tr_next.checker_id
     AND tr_next.orig_receipt_nr_ejr > tr_foll.orig_receipt_nr_ejr
     AND tr_next.transactiontype_id NOT IN (400, 405, 420, 425, 430, 480)) receipt_foll
     FROM p_lew_mart_msi.v_ejr_all_transact_follower_2 tr_foll) abrt                  /* Cancelled Transaction  */
   ON osus.client_id               = abrt.client_id
   AND osus.store_id                = abrt.store_id
   AND osus.pos_terminal_id         = abrt.pos_terminal_id
   AND osus.dat_formdate            = abrt.dat_formdate
   AND osus.orig_receipt_nr_ejr     = abrt.orig_receipt_nr_ejr
   AND abrt.checker_id IS NOT NULL
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_2 nxtt                   /* Get the next transaction record (Sales_2 or Logoff)*/
   ON osus.client_id                 = nxtt.client_id
   AND osus.store_id                  = nxtt.store_id
   AND osus.pos_terminal_id           = nxtt.pos_terminal_id
   AND osus.dat_formdate              = nxtt.dat_formdate
   AND nxtt.orig_receipt_nr_ejr = receipt_foll
   AND nxtt.checker_id IS NOT NULL
   AND    ((nxtt.transactiontype_id IN ('100','101','200','201') /* Only interested in Cancelled Transactions that are followed by sales... */
            AND nxtt.val_retail_ejr < tr.susp_aborted_subsequent_trans_low_val
			AND nxtt.cnt_sell_item + nxtt.cnt_all_deposit_back = 1 -- There has to be exactly one item_2, either sale or deposit collection
            AND nxtt.cnt_wo_deposit_voided_line = 0
            )
        OR
        (nxtt.transactiontype_id = '410'))  /* ... or logoff.                                        */
   LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_2 anmd
   ON osus.client_id                 = anmd.client_id
   AND osus.store_id                  = anmd.store_id
   AND osus.pos_terminal_id           = anmd.pos_terminal_id
   AND nxtt.next_time_receipt_ejr     = anmd.time_receipt_ejr
   AND osus.dat_formdate              = anmd.dat_formdate
   AND nxtt.next_orig_receipt_nr_ejr  = anmd.orig_receipt_nr_ejr
   AND nxtt.next_transactiontype_id   = anmd.transactiontype_id
   AND anmd.checker_id IS NOT NULL
   AND anmd.transactiontype_id = '415'
WHERE (ur.resumed_trans_seqnr <> 4 OR anmd.client_id IS NOT NULL)  
   
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