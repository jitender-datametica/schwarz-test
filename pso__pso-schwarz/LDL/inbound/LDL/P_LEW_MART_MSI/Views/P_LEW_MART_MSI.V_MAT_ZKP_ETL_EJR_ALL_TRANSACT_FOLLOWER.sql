CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_ALL_TRANSACT_FOLLOWER
AS
SELECT
x.store_id,
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
MIN(x.transactiontype_id) OVER (PARTITION BY
      x.store_id
      ,x.client_id
      ,x.pos_terminal_id
      ,x.dat_formdate
      ,x.checker_id
  ORDER BY
      x.dat_dayend ASC
      ,x.time_receipt_ejr ASC
      ,x.pos_terminal_id ASC
      ,x.orig_receipt_nr_ejr ASC
      ,x.timestamp_begin_ejr ASC
  ROWS BETWEEN 1 FOLLOWING   AND 1  FOLLOWING) AS next_transactiontype_id,
ROW_NUMBER() OVER (PARTITION BY
      x.store_id
      ,x.client_id
      ,x.checker_id
      ,x.dat_formdate
  ORDER BY
      x.dat_dayend ASC
      ,x.time_receipt_ejr ASC
      ,x.pos_terminal_id ASC
      ,x.orig_receipt_nr_ejr ASC
      ,x.timestamp_begin_ejr ASC) AS rank_login_nr,
ROW_NUMBER() OVER (PARTITION BY
      x.store_id
      ,x.client_id
      ,x.checker_id
      ,x.dat_formdate
  ORDER BY
      x.dat_dayend DESC NULLS LAST
      ,x.time_receipt_ejr DESC NULLS LAST
      ,x.pos_terminal_id DESC NULLS LAST
      ,x.orig_receipt_nr_ejr DESC NULLS LAST
      ,x.timestamp_begin_ejr DESC NULLS LAST) AS rank_logoff_nr,
MIN(x.orig_receipt_nr_ejr) OVER (PARTITION BY
      x.store_id
      ,x.client_id
      ,x.pos_terminal_id
      ,x.dat_formdate
      ,x.checker_id
  ORDER BY
      x.dat_dayend ASC
      ,x.time_receipt_ejr ASC
      ,x.pos_terminal_id ASC
      ,x.orig_receipt_nr_ejr ASC
      ,x.timestamp_begin_ejr ASC
  ROWS BETWEEN 1 FOLLOWING   AND 1  FOLLOWING) AS next_orig_receipt_nr_ejr,
MIN(x.val_retail_ejr) OVER (PARTITION BY
      x.store_id
      ,x.client_id
      ,x.pos_terminal_id
      ,x.dat_formdate
      ,x.checker_id
  ORDER BY
      x.dat_dayend ASC
      ,x.time_receipt_ejr ASC
      ,x.pos_terminal_id ASC
      ,x.orig_receipt_nr_ejr ASC
      ,x.timestamp_begin_ejr ASC
  ROWS BETWEEN 1 FOLLOWING   AND 1  FOLLOWING) AS next_val_retail_ejr,
MIN(x.orig_receipt_nr_ejr) OVER (PARTITION BY
      x.store_id
      ,x.client_id
      ,x.pos_terminal_id
      ,x.dat_formdate
      ,x.checker_id
  ORDER BY
      x.dat_dayend ASC
      ,x.time_receipt_ejr ASC
      ,x.pos_terminal_id ASC
      ,x.orig_receipt_nr_ejr ASC
      ,x.timestamp_begin_ejr ASC
  ROWS BETWEEN 1 PRECEDING   AND 1  PRECEDING) AS prev_orig_receipt_nr_ejr,
MIN(x.time_receipt_ejr) OVER (PARTITION BY
      x.store_id
      ,x.client_id
      ,x.pos_terminal_id
      ,x.dat_formdate
      ,x.checker_id
  ORDER BY
      x.dat_dayend ASC
      ,x.time_receipt_ejr ASC
      ,x.pos_terminal_id ASC
      ,x.orig_receipt_nr_ejr ASC
      ,x.timestamp_begin_ejr ASC
  ROWS BETWEEN 1 FOLLOWING   AND 1  FOLLOWING) AS next_time_receipt_ejr,
MIN(x.time_receipt_ejr) OVER (PARTITION BY
      x.store_id
      ,x.client_id
      ,x.pos_terminal_id
      ,x.dat_formdate
      ,x.checker_id
  ORDER BY
      x.dat_dayend ASC
      ,x.time_receipt_ejr ASC
      ,x.pos_terminal_id ASC
      ,x.orig_receipt_nr_ejr ASC
      ,x.timestamp_begin_ejr ASC
  ROWS BETWEEN 1 PRECEDING   AND 1  PRECEDING) AS prev_time_receipt_ejr,
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
CASE WHEN (y.cnt_sell_item + y.cnt_wo_deposit_voided_line) = 1   AND x.val_retail_ejr <= tr.deposit_1itm_receipt_val   AND ((y.cnt_wo_deposit_voided_line = 1   AND ABS(y.val_all_voided_line) <= tr.deposit_1itm_item_val) OR (y.cnt_sell_item = 1   AND y.val_sell_item <= tr.deposit_1itm_item_val)) THEN 1 ELSE 0 END AS is_deposit_1itm,
CASE WHEN (y.cnt_sell_item + y.cnt_wo_deposit_voided_line) = 1   AND (ABS(y.val_all_deposit_back) >= tr.deposit_amt_plus_empty_ret) THEN 1 ELSE 0 END AS is_deposit_1itmv,
CASE WHEN (y.cnt_sell_item + y.cnt_wo_deposit_voided_line) = 1   AND (y.cnt_all_deposit_back >= tr.deposit_1itm_plus_empty_ret) THEN 1 ELSE 0 END AS is_deposit_1itmc,
y.qty_return_ejr,
ROW_NUMBER() OVER (PARTITION BY
      x.store_id
      ,x.client_id
      ,x.checker_id
      ,x.dat_formdate
      ,x.pos_terminal_id
  ORDER BY
      x.dat_dayend ASC
      ,x.time_receipt_ejr ASC
      ,x.pos_terminal_id ASC
      ,x.orig_receipt_nr_ejr ASC) AS rank_terminal_login_nr,
ROW_NUMBER() OVER (PARTITION BY
      x.store_id
      ,x.client_id
      ,x.checker_id
      ,x.dat_formdate
      ,x.pos_terminal_id
  ORDER BY
      x.dat_dayend DESC NULLS LAST
      ,x.time_receipt_ejr DESC NULLS LAST
      ,x.pos_terminal_id DESC NULLS LAST
      ,x.orig_receipt_nr_ejr DESC NULLS LAST) AS rank_terminal_logoff_nr,
x.turnover_relevant_fg,
(CASE WHEN x.transactiontype_id = '200'   AND x.val_retail_ejr > tm.msusp_aborted_receipt_val THEN 1 ELSE 0 END) AS is_aborted_gt10_fg,
(CASE WHEN ABS(y.val_voided_line) > tm.mreceipt_void_val THEN 1 ELSE 0 END) AS is_voided_gt10_fg,
(CASE WHEN x.val_retail_ejr < tm.mothers_low_receipt_val   AND y.cnt_sell_item =1   AND y.cnt_all_deposit_back = 0   AND y.cnt_wo_deposit_voided_line = 0 THEN 1 ELSE 0 END) AS is_lowval_fg,
cal.cy_week,
cal.cy_month,
x.authority_id,
y.qty_ke_return_ejr,
y.qty_sc_return_ejr,
y.val_ke_return_ejr,
y.val_sc_return_ejr,
MIN(x.transactiontype_id) OVER (PARTITION BY
      x.store_id
      ,x.client_id
      ,x.pos_terminal_id
      ,x.dat_formdate
      ,x.checker_id
  ORDER BY
      x.dat_dayend ASC
      ,x.time_receipt_ejr ASC
      ,x.pos_terminal_id ASC
      ,x.orig_receipt_nr_ejr ASC
      ,x.timestamp_begin_ejr ASC
  ROWS BETWEEN 1 PRECEDING   AND 1 PRECEDING) AS prev_transactiontype_id
FROM
(SELECT
tr.store_id,
tr.client_id,
tr.pos_terminal_id,
tr.dat_formdate,
tr.time_receipt_ejr,
tr.orig_receipt_nr_ejr,
tr.timezone_cd,
tr.dat_dayend,
tr.checker_id,
tr.transactiontype_id,
tr.cnt_receiptline_ejr,
tr.cnt_selling_position_ejr,
tr.cnt_discount_ejr,
tr.cnt_deposit_ejr,
tr.cnt_return_ejr,
tr.cnt_void_ejr,
tr.cnt_ean_ejr,
tr.cnt_item_ejr,
tr.cnt_item_weight_ejr,
tr.cnt_mainitemgroup_ejr,
tr.qty_piece_ejr,
tr.val_retail_ejr AS val_retail_ejr,
tr.val_retail_pos_ejr AS val_retail_pos_ejr,
tr.val_deposit_ejr AS val_deposit_ejr,
tr.val_discount_ejr AS val_discount_ejr,
tr.val_discount_net_ejr AS val_discount_net_ejr,
tr.resumed_trans_store_id_ejr,
tr.resumed_trans_terminal_id_ejr,
tr.resumed_trans_date_ejr,
tr.resumed_trans_receipt_nr_ejr,
tr.dur_service_time_ejr,
tr.dur_pay_change_time_ejr,
tr.val_retail_net_ejr,
tr.timestamp_begin_ejr,
tr.timestamp_end_ejr,
CAST(1 AS BYTEINT) AS turnover_relevant_fg,
CASE WHEN tr.transactiontype_id = '150' THEN COALESCE(tr.authority_id, st.authority_id)
          ELSE tr.authority_id
      END                                                       AS authority_id
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader tr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON tr.store_id = revstr.store_id
AND tr.client_id = revstr.client_id
AND tr.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
ON tr.dat_formdate = revday.dat_calendar
LEFT OUTER JOIN (SELECT
sub.client_id,
sub.store_id,
sub.dat_formdate,
sub.pos_terminal_id,
sub.orig_receipt_nr_ejr,
MAX(sub.authority_id)               AS authority_id
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_subtotal sub
WHERE sub.dat_formdate BETWEEN (SELECT
min(revstr1.dat_formdate_from)
FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr1
WHERE revstr1.client_id = sub.client_id
  AND revstr1.store_id  = sub.store_id)
AND (SELECT
max(revstr2.dat_formdate_until)
FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr2
WHERE revstr2.client_id = sub.client_id
  AND revstr2.store_id  = sub.store_id)
AND sub.client_id   = (SELECT
min(revstr3.client_id)
FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr3
WHERE revstr3.client_id = sub.client_id
  AND revstr3.store_id  = sub.store_id)
AND sub.store_id    = (SELECT
min(revstr4.store_id)
FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr4
WHERE revstr4.client_id = sub.client_id
  AND revstr4.store_id  = sub.store_id)
AND sub.authority_id IS NOT NULL
GROUP BY sub.client_id, sub.store_id, sub.dat_formdate, sub.pos_terminal_id, sub.orig_receipt_nr_ejr
) st
ON tr.client_id            = st.client_id
AND tr.store_id             = st.store_id
AND tr.dat_formdate         = st.dat_formdate
AND tr.pos_terminal_id      = st.pos_terminal_id
AND tr.orig_receipt_nr_ejr  = st.orig_receipt_nr_ejr

/* The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).  */
WHERE tr.dat_formdate >= (SELECT
MIN(d_min.dat_calendar)
FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk d_min)
AND tr.dat_formdate <= (SELECT
MAX(d_max.dat_calendar)
FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk d_max)

UNION ALL
SELECT
ntr.store_id,
ntr.client_id,
ntr.pos_terminal_id,
ntr.dat_formdate,
ntr.time_receipt_ejr,
ntr.orig_receipt_nr_ejr,
ntr.timezone_cd,
ntr.dat_dayend,
ntr.checker_id,
ntr.transactiontype_id,
ntr.cnt_receiptline_ejr,
ntr.cnt_selling_position_ejr,
ntr.cnt_discount_ejr,
ntr.cnt_deposit_ejr,
ntr.cnt_return_ejr,
ntr.cnt_void_ejr,
ntr.cnt_ean_ejr,
ntr.cnt_item_ejr,
ntr.cnt_item_weight_ejr,
ntr.cnt_mainitemgroup_ejr,
ntr.qty_piece_ejr,
ntr.val_retail_ejr,
ntr.val_retail_pos_ejr,
ntr.val_deposit_ejr,
ntr.val_discount_ejr,
ntr.val_discount_net_ejr,
ntr.resumed_trans_store_id_ejr,
ntr.resumed_trans_terminal_id_ejr,
ntr.resumed_trans_date_ejr,
ntr.resumed_trans_receipt_nr_ejr,
ntr.dur_service_time_ejr,
ntr.dur_pay_change_time_ejr,
ntr.val_retail_net_ejr,
ntr.timestamp_begin_ejr,
ntr.timestamp_end_ejr,
0 AS turnover_relevant_fg,
ntr.authority_id
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr ntr

INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON ntr.store_id = revstr.store_id
AND ntr.client_id = revstr.client_id
AND ntr.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until

INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
ON ntr.dat_formdate = revday.dat_calendar

/* Exclude all lines that are TurnoverRelevant="false". These are indicated by the third digit of the header-transactiontype_id.  */
WHERE
SUBSTRING(ntr.transactiontype_id, 3, 1) <> '1'

UNION ALL
SELECT
ctr.store_id,
ctr.client_id,
ctr.pos_terminal_id,
ctr.dat_formdate,
ctr.time_receipt_ejr,
ctr.orig_receipt_nr_ejr,
ctr.timezone_cd,
ctr.dat_dayend,
ctr.checker_id,
ctr.transactiontype_id,
NULL  /* cnt_receiptline_ejr                      */,
NULL  /* cnt_selling_position_ejr                 */,
NULL  /* cnt_discount_ejr                         */,
NULL  /* cnt_deposit_ejr                          */,
NULL  /* cnt_return_ejr                           */,
NULL  /* cnt_void_ejr                             */,
NULL  /* cnt_ean_ejr                              */,
NULL  /* cnt_item_ejr                             */,
NULL  /* cnt_item_weight_ejr                      */,
NULL  /* cnt_mainitemgroup_ejr                    */,
NULL  /* qty_piece_ejr                            */,
0     /* val_retail_ejr                           */,
NULL  /* val_retail_pos_ejr                       */,
NULL  /* val_deposit_ejr                          */,
NULL  /* val_discount_ejr                         */,
NULL  /* val_discount_net_ejr                     */,
NULL  /* resumed_trans_store_id_ejr               */,
NULL  /* resumed_trans_terminal_id_ejr            */,
NULL  /* resumed_trans_date_ejr                   */,
NULL  /* resumed_trans_receipt_nr_ejr             */,
NULL  /* dur_service_time_ejr                     */,
NULL  /* dur_pay_change_time_ejr                  */,
NULL  /* val_retail_net_ejr                       */,
ctr.timestamp_begin_ejr,
ctr.timestamp_end_ejr,
0 AS turnover_relevant_fg,
ctr.authority_id
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_cntr_transact ctr

INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON ctr.store_id = revstr.store_id
AND ctr.client_id = revstr.client_id
AND ctr.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until

INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
ON ctr.dat_formdate = revday.dat_calendar

UNION ALL
SELECT
prc.store_id,
prc.client_id,
prc.pos_terminal_id,
prc.dat_formdate,
prc.time_receipt_ejr,
prc.orig_receipt_nr_ejr,
prc.timezone_cd,
prc.dat_dayend,
prc.checker_id,
prc.transactiontype_id,
NULL  /* cnt_receiptline_ejr                               */,
NULL  /* cnt_selling_position_ejr                          */,
NULL  /* cnt_discount_ejr                                  */,
NULL  /* cnt_deposit_ejr                                   */,
NULL  /* cnt_return_ejr                                    */,
NULL  /* cnt_void_ejr                                      */,
NULL  /* cnt_ean_ejr                                       */,
NULL  /* cnt_item_ejr                                      */,
NULL  /* cnt_item_weight_ejr                               */,
NULL  /* cnt_mainitemgroup_ejr                             */,
NULL  /* qty_piece_ejr                                     */,
COALESCE(prc.price_retail_ejr  ,0) AS val_retail_ejr,
NULL  /* val_retail_pos_ejr                                */,
NULL  /* val_deposit_ejr                                   */,
NULL  /* val_discount_ejr                                  */,
NULL  /* val_discount_net_ejr                              */,
NULL  /* resumed_trans_store_id_ejr                        */,
NULL  /* resumed_trans_terminal_id_ejr                     */,
NULL  /* resumed_trans_date_ejr                            */,
NULL  /* resumed_trans_receipt_nr_ejr                      */,
NULL  /* dur_service_time_ejr                              */,
NULL  /* dur_pay_change_time_ejr                           */,
NULL  /* val_retail_net_ejr                                */,
prc.timestamp_begin_ejr,
prc.timestamp_end_ejr,
0 AS turnover_relevant_fg,
prc.authority_id
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_price_info prc

INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON prc.store_id = revstr.store_id
AND prc.client_id = revstr.client_id
AND prc.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until

INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
ON prc.dat_formdate = revday.dat_calendar

/* Gruppierung wg. Irland Fall 27.07.2018 (doppelte Preisabfrage innerhalb einer Sekunde)  */
GROUP BY 1,2,3,4,5,6,7,8,9,10,22,34,35,37
) x
LEFT OUTER JOIN
(SELECT
rh.store_id,
rh.client_id,
rh.pos_terminal_id,
rh.dat_formdate,
rh.orig_receipt_nr_ejr,
rh.time_receipt_ejr,
Sum(CASE WHEN  rl.transactiontype_id IN ('120'  ,'122'  ,'220'  ,'222') THEN 1 ELSE 0 END) AS cnt_all_deposit_back,
Sum(CASE WHEN (rl.transactiontype_id IN ('120'  ,'122'  ,'220'  ,'222'))   AND (rl.item_entry_method_cd_ejr IN ('KE','DV')   AND LENGTH(rl.barcode) < 19)  THEN 1 ELSE 0 END) AS cnt_ke_deposit_back,
Sum(CASE WHEN (rl.transactiontype_id IN ('120'  ,'122'  ,'220'  ,'222'))   AND (rl.item_entry_method_cd_ejr = 'SC' OR LENGTH(rl.barcode) >= 19) THEN 1 ELSE 0 END) AS cnt_sc_deposit_back,
Sum(CASE WHEN  rl.transactiontype_id IN ('120'  ,'122'  ,'220'  ,'222') THEN rl.val_retail_ejr ELSE 0 END) AS val_all_deposit_back,
Sum(CASE WHEN  rl.transactiontype_id IN ('120'  ,'122'  ,'220'  ,'222') THEN rl.val_retail_ejr - rl.val_vat_ejr ELSE 0 END) AS val_all_deposit_back_net,
Sum(CASE WHEN (rl.transactiontype_id IN ('120'  ,'122'  ,'220'  ,'222'))   AND (rl.item_entry_method_cd_ejr IN ('KE','DV')   AND LENGTH(rl.barcode) < 19)  THEN rl.val_retail_ejr ELSE 0 END) AS val_ke_deposit_back,
Sum(CASE WHEN (rl.transactiontype_id IN ('120'  ,'122'  ,'220'  ,'222'))   AND (rl.item_entry_method_cd_ejr IN ('KE','DV')   AND LENGTH(rl.barcode) < 19)  THEN rl.val_retail_ejr - rl.val_vat_ejr ELSE 0 END) AS val_ke_deposit_back_net,
Sum(CASE WHEN (rl.transactiontype_id IN ('120'  ,'122'  ,'220'  ,'222'))   AND (rl.item_entry_method_cd_ejr = 'SC' OR LENGTH(rl.barcode) >= 19) THEN rl.val_retail_ejr ELSE 0 END) AS val_sc_deposit_back,
Sum(CASE WHEN  rl.transactiontype_id IN ('121'  ,'123'  ,'221'  ,'223') THEN 1 ELSE 0 END) AS cnt_all_deposit_sell,
Sum(CASE WHEN (rl.transactiontype_id IN ('121'  ,'123'  ,'221'  ,'223'))   AND rl.item_entry_method_cd_ejr IN ('KE','DV') THEN 1 ELSE 0 END) AS cnt_ke_deposit_sell,
Sum(CASE WHEN (rl.transactiontype_id IN ('121'  ,'123'  ,'221'  ,'223'))   AND rl.item_entry_method_cd_ejr = 'SC' THEN 1 ELSE 0 END) AS cnt_sc_deposit_sell,
Sum(CASE WHEN  rl.transactiontype_id IN ('121'  ,'123'  ,'221'  ,'223') THEN rl.val_retail_ejr ELSE 0 END) AS val_all_deposit_sell,
Sum(CASE WHEN  rl.transactiontype_id IN ('121'  ,'123'  ,'221'  ,'223') THEN rl.val_retail_ejr - rl.val_vat_ejr ELSE 0 END) AS val_all_deposit_sell_net,
Sum(CASE WHEN (rl.transactiontype_id IN ('121'  ,'123'  ,'221'  ,'223'))   AND rl.item_entry_method_cd_ejr IN ('KE','DV') THEN rl.val_retail_ejr ELSE 0 END) AS val_ke_deposit_sell,
Sum(CASE WHEN (rl.transactiontype_id IN ('121'  ,'123'  ,'221'  ,'223'))   AND rl.item_entry_method_cd_ejr = 'SC' THEN rl.val_retail_ejr ELSE 0 END) AS val_sc_deposit_sell,
Sum(CASE WHEN  rl.transactiontype_id IN ('101'  ,'102','201','202') THEN (CASE WHEN Coalesce(rl.qty_piece_ejr,0) = 0   AND Coalesce(rl.qty_weight_ejr,0) <> 0 THEN 1 ELSE rl.qty_piece_ejr END) ELSE 0 END) AS amt_sell_item,
Sum(CASE WHEN  rl.transactiontype_id IN ('101'  ,'102','201','202') THEN 1 ELSE 0 END) AS cnt_sell_item,
Sum(CASE WHEN  rl.transactiontype_id IN ('101'  ,'102','201','202') THEN rl.val_retail_ejr ELSE 0 END) AS val_sell_item,
Sum(CASE WHEN  rl.transactiontype_id IN ('101'  ,'102','201','202') THEN rl.price_retail_ejr ELSE 0 END) AS val_price_item,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0   AND rl.val_retail_ejr > 0 THEN rl.price_retail_ejr ELSE 0 END) AS val_void_price_item,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0 THEN 1 ELSE 0 END) AS cnt_all_voided_line,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0   AND rl.val_retail_ejr > 0 THEN 1 ELSE 0 END) AS cnt_wo_deposit_voided_line,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0   AND (rl.mainitemgroup_id <> 1   AND rl.subitemgroup_id <> 74) THEN 1 ELSE 0 END) AS cnt_voided_line,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0 THEN rl.qty_piece_ejr ELSE 0 END) AS amt_all_voided_item,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0   AND (rl.mainitemgroup_id <> 1   AND rl.subitemgroup_id <> 74) THEN rl.qty_piece_ejr ELSE 0 END) AS amt_voided_item,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0 THEN rl.val_retail_ejr ELSE 0 END) AS val_all_voided_line,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0 THEN rl.val_retail_ejr - rl.val_vat_ejr ELSE 0 END) AS val_all_voided_line_net,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0   AND rl.val_retail_ejr < 0 THEN rl.val_retail_ejr ELSE 0 END) AS val_wo_deposit_voided_line,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0   AND (rl.mainitemgroup_id <> 1   AND rl.subitemgroup_id <> 74) THEN rl.val_retail_ejr ELSE 0 END) AS val_voided_line,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0   AND (rl.mainitemgroup_id <> 1   AND rl.subitemgroup_id <> 74) THEN rl.val_retail_ejr - rl.val_vat_ejr ELSE 0 END) AS val_voided_line_net,
Sum(CASE WHEN  rh.transactiontype_id = '100'   AND rl.voided_by_line_nr_ejr > 0   AND (rl.mainitemgroup_id <> 1   AND rl.subitemgroup_id <> 74   AND rl.price_retail_ejr > tm.mvoid_item_val) THEN 1 ELSE 0 END) AS is_voided_gt_4,
MAX(CASE WHEN (rl.transactiontype_id IN ('120'  ,'122'))   AND (rl.item_entry_method_cd_ejr = 'SC' OR LENGTH(rl.barcode) >= 19)   AND ((rl.val_retail_ejr * -1.0) > tr.deposit_scanned_value OR (MOD((rl.val_retail_ejr * -1.0 * 100.0), (CASE WHEN tr.deposit_scanned_qty_integer = 0 THEN null ELSE tr.deposit_scanned_qty_integer END * 100.0))) <> 0.0) THEN 1 ELSE 0 END) AS is_implausible_deposit,
MAX(CASE WHEN (rl.transactiontype_id IN ('120'  ,'122'))   AND (rl.item_entry_method_cd_ejr = 'SC' OR LENGTH(rl.barcode) >= 19)   AND ((MOD((rl.val_retail_ejr * -1.0 * 100.0), (CASE WHEN tr.deposit_scanned_qty_integer = 0 THEN null ELSE tr.deposit_scanned_qty_integer END * 100.0))) <> 0.0) THEN 1 ELSE 0 END) AS is_implausible_depositv1,
MAX(CASE WHEN (rl.transactiontype_id IN ('120'  ,'122'))   AND (rl.item_entry_method_cd_ejr = 'SC' OR LENGTH(rl.barcode) >= 19)   AND ((rl.val_retail_ejr * -1.0) > tr.deposit_scanned_value )   AND ((MOD((rl.val_retail_ejr * -1.0 * 100.0), (CASE WHEN tr.deposit_scanned_qty_integer = 0 THEN null ELSE tr.deposit_scanned_qty_integer END * 100.0))) = 0.0) THEN 1 ELSE 0 END) AS is_implausible_depositv2,
Sum(CASE WHEN (rl.transactiontype_id IN ('120'  ,'122'))   AND (rl.item_entry_method_cd_ejr = 'SC' OR LENGTH(rl.barcode) >= 19)   AND ((MOD((rl.val_retail_ejr * -1.0 * 100.0), (CASE WHEN tr.deposit_scanned_qty_integer = 0 THEN null ELSE tr.deposit_scanned_qty_integer END * 100.0))) <> 0.0) THEN rl.val_retail_ejr * -1 ELSE 0 END) AS implausible_depositv1_val,
Sum(CASE WHEN (rl.transactiontype_id IN ('120'  ,'122'))   AND (rl.item_entry_method_cd_ejr = 'SC' OR LENGTH(rl.barcode) >= 19)   AND ((rl.val_retail_ejr * -1.0) > tr.deposit_scanned_value )   AND ((MOD((rl.val_retail_ejr * -1.0 * 100.0), (CASE WHEN tr.deposit_scanned_qty_integer = 0 THEN null ELSE tr.deposit_scanned_qty_integer END * 100.0))) = 0.0) THEN rl.val_retail_ejr * -1 ELSE 0 END) AS implausible_depositv2_val,
Sum(CASE WHEN  rl.transactiontype_id IN ('141'  ,'241'  ,'142'  ,'242'  ,'143'  ,'243'  ,'120'  ,'220'  ,'122'  ,'222') THEN ABS(rl.qty_piece_ejr) ELSE 0 END) AS qty_return_ejr,
Sum(CASE WHEN  rl.transactiontype_id IN ('141'  ,'241'  ,'142'  ,'242'  ,'143'  ,'243'  ,'120'  ,'220'  ,'122'  ,'222')   AND rl.item_entry_method_cd_ejr IN ('KE','DV') THEN ABS(rl.qty_piece_ejr) ELSE 0 END) AS qty_ke_return_ejr,
Sum(CASE WHEN  rl.transactiontype_id IN ('141'  ,'241'  ,'142'  ,'242'  ,'143'  ,'243'  ,'120'  ,'220'  ,'122'  ,'222')   AND rl.item_entry_method_cd_ejr = 'SC'         THEN ABS(rl.qty_piece_ejr) ELSE 0 END) AS qty_sc_return_ejr,
Sum(CASE WHEN  rl.transactiontype_id IN ('141'  ,'241'  ,'142'  ,'242'  ,'143'  ,'243'  ,'120'  ,'220'  ,'122'  ,'222')   AND rl.item_entry_method_cd_ejr IN ('KE','DV') THEN rl.val_retail_ejr ELSE 0 END) AS val_ke_return_ejr,
Sum(CASE WHEN  rl.transactiontype_id IN ('141'  ,'241'  ,'142'  ,'242'  ,'143'  ,'243'  ,'120'  ,'220'  ,'122'  ,'222')   AND rl.item_entry_method_cd_ejr = 'SC'         THEN rl.val_retail_ejr ELSE 0 END) AS val_sc_return_ejr
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader rh

INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract rl
ON rh.client_id = rl.client_id
AND rh.store_id = rl.store_id
AND rh.pos_terminal_id = rl.pos_terminal_id
AND rh.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
AND rh.dat_formdate = rl.dat_formdate

INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt tr
ON rl.client_id = tr.client_id

INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_threshold_manual tm
ON rl.client_id = tm.client_id
AND CURRENT_DATE BETWEEN tm.dat_rec_start   AND tm.dat_rec_end
AND   tm.approval_fg = 1

/* Join to *load_store to get only the relevant stores   AND join to *load_day for performance (optimizer will evaluate if dynamic partition elimination is used)
*/
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON rh.store_id = revstr.store_id
AND rh.client_id = revstr.client_id
AND rh.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until

INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday
ON rh.dat_formdate = revday.dat_calendar
WHERE (   rl.transactiontype_id IN ('120','121','122','123','101','102'
                                ,'201','202','220','221','222','223'
                                ,'141','241','142','242','143','243')
    OR rl.voided_by_line_nr_ejr > 0)
/* The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).
*/
AND rh.dat_formdate >= (SELECT
MIN(d_min.dat_calendar)
FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk d_min)
AND rh.dat_formdate <= (SELECT
MAX(d_max.dat_calendar)
FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk d_max)

GROUP BY
   rh.client_id
  ,rh.store_id
  ,rh.pos_terminal_id
  ,rh.dat_formdate
  ,rh.orig_receipt_nr_ejr
  ,rh.time_receipt_ejr
)  y
 ON y.client_id = x.client_id
AND y.store_id = x.store_id
AND y.pos_terminal_id = x.pos_terminal_id
AND y.dat_formdate = x.dat_formdate
AND y.orig_receipt_nr_ejr = x.orig_receipt_nr_ejr
AND y.time_receipt_ejr = x.time_receipt_ejr

INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt tr
ON x.client_id = tr.client_id

INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_threshold_manual tm
ON x.client_id = tm.client_id
AND CURRENT_DATE BETWEEN tm.dat_rec_start   AND tm.dat_rec_end
AND   tm.approval_fg = 1

INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_cal_calendarday cal
ON x.dat_formdate = cal.dat_calendar
;



