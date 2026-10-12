/*
#
# @ LIDL Stiftung & Co. KG - DWH / MIS
#
# Interface: DDL for P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_SUSPENDED_TRANSACT_2
#
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  21.10.2019    Morris, Michael          20191021_2259_ZKP_BBT_272_398 (Jira: LEAD-7462): New Attributes is_next_low_tran_mc & is_next_abmeld_mc.
#  1.3  07.11.2019    Morris, Michael          20191030_2273_ZKP_SG_57_58_ID (Jira: LEAD-7462): Added GROUP BY to view to inhibit duplicates.
#  1.4  21.11.2023    Wandtke,Andrzej          AP0150752 - skip transactions 400, 405, 420, 425, 430, 480 while looking for the next receipt.
#  1.5  06.02.2024    Wandtke,Andrzej          INC7923180 Changes in part "Bonrueckstellung + Kleinstbon / Bonrueckstellung + Abmeldung": replace condition nxtt.cnt_sell_item = 1 AND nxtt.cnt_all_deposit_back = 0 by nxtt.cnt_sell_item = 1 + nxtt.cnt_all_deposit_back = 1
#
*/
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_suspended_transact_2 (
  resumed_trans_store_id_ejr,
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
  val_susp_retail_ejr,
  susp_next_transactiontype_id,
  val_susp_next_retail_ejr,
  cnt_s_all_salelines,
  cnt_s_all_voidedlines_in_res,
  is_s_lastline_sale,
  cnt_s_voidedlines_beforlast,
  cnt_s_all_lines,
  cnt_r_all_salelines,
  cnt_r_all_voidedlines_in_res,
  is_r_lastline_sale,
  cnt_r_voidedlines_beforlast,
  cnt_r_all_lines,
  val_r_voided,
  val_s_voided,
  is_voided_till_last_artikel,
  is_new_item_in_resume,
  is_suspend_gt_10,
  is_next_tran_cond,
  is_resumed_aborted,
  is_voided_till_last_artikel_mc,
  is_new_item_in_resume_mc,
  is_open_suspended,
  is_next_low_tran,
  is_next_low_tran_mc,
  is_next_abmeld_mc
) AS
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
  MAX(coalesce(d.val_susp_retail_ejr, 0)) AS val_susp_retail_ejr,
  d.susp_next_transactiontype_id,
  MAX(coalesce(d.val_susp_next_retail_ejr, 0)) AS val_susp_next_retail_ejr,
  MAX(coalesce(d.cnt_s_all_salelines, 0)) AS cnt_s_all_salelines,
  MAX(coalesce(d.cnt_s_all_voidedlines_in_res, 0)) AS cnt_s_all_voidedlines_in_res,
  MAX(coalesce(d.is_s_lastline_sale, 0)) AS is_s_lastline_sale,
  MAX(coalesce(d.cnt_s_voidedlines_beforlast, 0)) AS cnt_s_voidedlines_beforlast,
  MAX(coalesce(d.cnt_s_all_lines, 0)) AS cnt_s_all_lines,
  MAX(coalesce(d.cnt_r_all_salelines, 0)) AS cnt_r_all_salelines,
  MAX(coalesce(d.cnt_r_all_voidedlines_in_res, 0)) AS cnt_r_all_voidedlines_in_res,
  MAX(coalesce(d.is_r_lastline_sale, 0)) AS is_r_lastline_sale,
  MAX(coalesce(d.cnt_r_voidedlines_beforlast, 0)) AS cnt_r_voidedlines_beforlast,
  MAX(coalesce(d.cnt_r_all_lines, 0)) AS cnt_r_all_lines,
  MAX(coalesce(d.val_r_voided, 0)) AS val_r_voided,
  MAX(coalesce(d.val_s_voided, 0)) AS val_s_voided,
  MAX(coalesce(d.is_voided_till_last_artikel, 0)) AS is_voided_till_last_artikel,
  MAX(coalesce(d.is_new_item_in_resume, 0)) AS is_new_item_in_resume,
  MAX(coalesce(d.is_suspend_gt_10, 0)) AS is_suspend_gt_10,
  MAX(coalesce(d.is_next_tran_cond, 0)) AS is_next_tran_cond,
  MAX(coalesce(d.is_resumed_aborted, 0)) AS is_resumed_aborted,
  MAX(coalesce(d.is_voided_till_last_artikel_mc, 0)) AS is_voided_till_last_artikel_mc,
  MAX(coalesce(d.is_new_item_in_resume_mc, 0)) AS is_new_item_in_resume_mc,
  MAX(coalesce(d.is_open_suspended, 0)) AS is_open_suspended,
  MAX(coalesce(d.is_next_low_tran, 0)) AS is_next_low_tran,
  MAX(coalesce(d.is_next_low_tran_mc, 0)) AS is_next_low_tran_mc,
  MAX(coalesce(d.is_next_abmeld_mc, 0)) AS is_next_abmeld_mc
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
    CASE
      WHEN s_res_out.cnt_r_all_voidedlines_in_res > susp.cnt_s_all_voidedlines_in_res
      AND s_res_out.is_r_lastline_sale = 1
      AND s_res_out.val_r_voided - susp.val_s_voided > tr.susp_voided_exp_last_void_val
      THEN 1
      ELSE 0
    END AS is_voided_till_last_artikel,
    CASE
      WHEN s_res_out.cnt_r_all_lines > susp.cnt_s_all_lines
      AND s_res_out.is_r_lastline_sale = 1
      THEN 1
      ELSE 0
    END AS is_new_item_in_resume,
    CASE
      WHEN susp.val_susp_retail_ejr > tr.susp_tot_val
      THEN 1
      ELSE 0
    END AS is_suspend_gt_10,
    CASE
      WHEN s_next.val_retail_ejr > 0
      AND s_next.val_retail_ejr < tr.susp_subsequent_trans_low_val
      AND s_next.transactiontype_id = '100'
      AND s_next.cnt_sell_item = 1
      AND s_next.cnt_all_deposit_back = 0
      AND s_next.cnt_wo_deposit_voided_line = 0
      OR s_next.transactiontype_id = '410'
      THEN 1
      ELSE 0
    END AS is_next_tran_cond,
    CASE
      WHEN NOT s_res_out_abb.resumed_trans_store_id_ejr IS NULL
      THEN 1
      ELSE 0
    END AS is_resumed_aborted,
    CASE
      WHEN s_res_out.cnt_r_all_voidedlines_in_res > susp.cnt_s_all_voidedlines_in_res
      AND s_res_out.is_r_lastline_sale = 1
      AND s_res_out.val_r_voided - susp.val_s_voided > tr.susp_voided_exp_last_void_val2
      THEN 1
      ELSE 0
    END AS is_voided_till_last_artikel_mc,
    CASE
      WHEN s_res_out.cnt_r_all_lines > susp.cnt_s_all_lines
      AND s_res_out.is_r_lastline_sale = 1
      THEN 1
      ELSE 0
    END AS is_new_item_in_resume_mc,
    CASE
      WHEN s_res_out_abb.resumed_trans_store_id_ejr IS NULL
      AND s_res_out.resumed_trans_store_id_ejr IS NULL
      THEN 1
      ELSE 0
    END AS is_open_suspended,
    CASE
      WHEN s_next.val_retail_ejr > 0
      AND s_next.val_retail_ejr < tr.susp_subsequent_trans_low_val
      AND s_next.transactiontype_id = '100'
      AND s_next.cnt_sell_item = 1
      AND s_next.cnt_all_deposit_back = 0
      AND s_next.cnt_wo_deposit_voided_line = 0
      THEN 1
      ELSE 0
    END AS is_next_low_tran,
    0 AS is_next_low_tran_mc,
    0 AS is_next_abmeld_mc
  FROM (
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
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr_2 AS tran
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr
      ON tran.store_id = revstr.store_id
      AND tran.client_id = revstr.client_id
      AND tran.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS revday
      ON tran.dat_formdate = revday.dat_calendar AND tran.transactiontype_id = '300'
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
      tran.resumed_trans_store_id_ejr,
      tran.resumed_trans_terminal_id_ejr,
      tran.resumed_trans_date_ejr,
      tran.resumed_trans_receipt_nr_ejr,
      CAST('3' AS NUMERIC) AS resumed_trans_seqnr
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_2 AS tran
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr
      ON tran.store_id = revstr.store_id
      AND tran.client_id = revstr.client_id
      AND tran.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS revday
      ON tran.dat_formdate = revday.dat_calendar
    WHERE
      NOT tran.resumed_trans_receipt_nr_ejr IS NULL
      AND tran.dat_formdate >= (
        SELECT
          MIN(d_min.dat_calendar)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS d_min
      )
      AND tran.dat_formdate <= (
        SELECT
          MAX(d_max.dat_calendar)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS d_max
      )
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
      tran.resumed_trans_store_id_ejr,
      tran.resumed_trans_terminal_id_ejr,
      tran.resumed_trans_date_ejr,
      tran.resumed_trans_receipt_nr_ejr,
      CAST('3' AS NUMERIC) AS resumed_trans_seqnr
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr_2 AS tran
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr
      ON tran.store_id = revstr.store_id
      AND tran.client_id = revstr.client_id
      AND tran.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS revday
      ON tran.dat_formdate = revday.dat_calendar
      AND tran.transactiontype_id = '200'
      AND NOT tran.resumed_trans_receipt_nr_ejr IS NULL
    UNION ALL
    SELECT
      next_op.store_id,
      next_op.client_id,
      next_op.pos_terminal_id,
      next_op.dat_formdate,
      next_op.time_receipt_ejr,
      next_op.orig_receipt_nr_ejr,
      next_op.timezone_cd,
      next_op.dat_dayend,
      next_op.checker_id,
      next_op.transactiontype_id,
      next_op.val_retail_ejr,
      next_op.store_id AS resumed_trans_store_id_ejr,
      tran.pos_terminal_id AS resumed_trans_terminal_id_ejr,
      tran.dat_formdate AS resumed_trans_date_ejr,
      tran.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr,
      CAST('2' AS NUMERIC) AS resumed_trans_seqnr
    FROM ldl_p_lew_mart_msi.v_ejr_all_transact_2 AS tran
    LEFT OUTER JOIN (
      SELECT DISTINCT
        tr_next.client_id AS cw_0,
        tr_next.store_id AS cw_1,
        tr_next.pos_terminal_id AS cw_2,
        tr_next.dat_formdate AS cw_3,
        tr_next.checker_id AS cw_4,
        MIN(tr_next.orig_receipt_nr_ejr) AS orig_receipt_nr_ejr
      FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_2 AS tr_next
      INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_2 AS tran_0
        ON tran_0.client_id = tr_next.client_id
        AND tran_0.store_id = tr_next.store_id
        AND tran_0.pos_terminal_id = tr_next.pos_terminal_id
        AND tran_0.dat_formdate = tr_next.dat_formdate
        AND tran_0.checker_id = tr_next.checker_id
      WHERE
        tr_next.orig_receipt_nr_ejr > tran_0.orig_receipt_nr_ejr
        AND NOT tr_next.transactiontype_id IN (
          '400',
          '405',
          '420',
          '425',
          '430',
          '480'
        )
      GROUP BY
        1,
        2,
        3,
        4,
        5
    ) AS ex0
      ON tran.client_id = ex0.cw_0
      AND tran.store_id = ex0.cw_1
      AND tran.pos_terminal_id = ex0.cw_2
      AND tran.dat_formdate = ex0.cw_3
      AND tran.checker_id = ex0.cw_4
    INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower_2 AS next_op
      ON tran.store_id = next_op.store_id
      AND tran.client_id = next_op.client_id
      AND tran.pos_terminal_id = next_op.pos_terminal_id
      AND next_op.orig_receipt_nr_ejr = ex0.orig_receipt_nr_ejr
      AND tran.dat_formdate = next_op.dat_formdate
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr
      ON tran.store_id = revstr.store_id
      AND tran.client_id = revstr.client_id
      AND tran.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    WHERE
      tran.transactiontype_id = '300'
  ) AS alls
  LEFT OUTER JOIN (
    SELECT
      s_res.resumed_trans_store_id_ejr,
      s_res.resumed_trans_terminal_id_ejr,
      s_res.resumed_trans_date_ejr,
      s_res.resumed_trans_receipt_nr_ejr,
      s_res.resumed_trans_seqnr,
      sum(
        CASE
          WHEN r.transactiontype_id = '101'
          THEN 1
          ELSE 0
        END
      ) AS cnt_r_all_salelines,
      sum(
        CASE
          WHEN r.transactiontype_id = '170'
          THEN 1
          ELSE 0
        END
      ) AS cnt_r_all_voidedlines_in_res,
      sum(
        CASE
          WHEN r.xrownum = 1 AND r.transactiontype_id = '101'
          THEN 1
          ELSE 0
        END
      ) AS is_r_lastline_sale,
      sum(
        CASE
          WHEN r.xrownum = 1 AND r.transactiontype_id = '170'
          THEN 1
          ELSE 0
        END
      ) AS is_r_lastline_void,
      sum(
        CASE
          WHEN r.xrownum > 1 AND r.transactiontype_id = '170'
          THEN 1
          ELSE 0
        END
      ) AS cnt_r_voidedlines_beforlast,
      sum(
        CASE
          WHEN r.transactiontype_id = '101' OR r.transactiontype_id = '170'
          THEN 1
          ELSE 0
        END
      ) AS cnt_r_all_lines,
      sum(
        CASE
          WHEN r.transactiontype_id = '170'
          THEN r.val_retail_ejr
          ELSE 0
        END
      ) AS val_r_voided
    FROM (
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
        CAST('3' AS NUMERIC) AS resumed_trans_seqnr
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_2 AS tran
      INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr
        ON tran.store_id = revstr.store_id
        AND tran.client_id = revstr.client_id
        AND tran.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
      INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS revday
        ON tran.dat_formdate = revday.dat_calendar
      WHERE
        NOT tran.resumed_trans_receipt_nr_ejr IS NULL
        AND tran.dat_formdate >= (
          SELECT
            MIN(d_min.dat_calendar)
          FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS d_min
        )
        AND tran.dat_formdate <= (
          SELECT
            MAX(d_max.dat_calendar)
          FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS d_max
        )
    ) AS s_res
    INNER JOIN (
      SELECT
        row_number() OVER (
          PARTITION BY r_0.store_id, r_0.client_id, r_0.pos_terminal_id, r_0.dat_formdate, r_0.orig_receipt_nr_ejr
          ORDER BY r_0.orig_receipt_serial_nr_ejr DESC
        ) AS xrownum,
        r_0.store_id,
        r_0.client_id,
        r_0.pos_terminal_id,
        r_0.dat_formdate,
        r_0.time_receipt_ejr,
        r_0.orig_receipt_nr_ejr,
        r_0.transactiontype_id,
        r_0.val_retail_ejr
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 AS r_0
      WHERE
        r_0.parent_line_nr_ejr IS NULL
        AND EXISTS(
          SELECT
            1
          FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_2 AS rh
          INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr
            ON rh.store_id = revstr.store_id
            AND rh.client_id = revstr.client_id
            AND rh.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
          INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS revday
            ON rh.dat_formdate = revday.dat_calendar
          WHERE
            rh.store_id = r_0.store_id
            AND rh.client_id = r_0.client_id
            AND rh.pos_terminal_id = r_0.pos_terminal_id
            AND rh.dat_formdate = r_0.dat_formdate
            AND rh.time_receipt_ejr = r_0.time_receipt_ejr
            AND rh.orig_receipt_nr_ejr = r_0.orig_receipt_nr_ejr
            AND NOT rh.resumed_trans_receipt_nr_ejr IS NULL
            AND rh.dat_formdate >= (
              SELECT
                MIN(d_min.dat_calendar)
              FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS d_min
            )
            AND rh.dat_formdate <= (
              SELECT
                MAX(d_max.dat_calendar)
              FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS d_max
            )
        )
    ) AS r
      ON s_res.store_id = r.store_id
      AND s_res.client_id = r.client_id
      AND s_res.pos_terminal_id = r.pos_terminal_id
      AND s_res.dat_formdate = r.dat_formdate
      AND s_res.time_receipt_ejr = r.time_receipt_ejr
      AND s_res.orig_receipt_nr_ejr = r.orig_receipt_nr_ejr
    GROUP BY
      1,
      2,
      3,
      4,
      5
  ) AS s_res_out
    ON s_res_out.resumed_trans_store_id_ejr = alls.resumed_trans_store_id_ejr
    AND s_res_out.resumed_trans_terminal_id_ejr = alls.resumed_trans_terminal_id_ejr
    AND s_res_out.resumed_trans_date_ejr = alls.resumed_trans_date_ejr
    AND s_res_out.resumed_trans_receipt_nr_ejr = alls.resumed_trans_receipt_nr_ejr
  LEFT OUTER JOIN (
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
      CAST('3' AS NUMERIC) AS resumed_trans_seqnr
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr_2 AS tran
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr
      ON tran.store_id = revstr.store_id
      AND tran.client_id = revstr.client_id
      AND tran.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS revday
      ON tran.dat_formdate = revday.dat_calendar
    WHERE
      NOT tran.resumed_trans_receipt_nr_ejr IS NULL AND tran.transactiontype_id = '200'
  ) AS s_res_out_abb
    ON s_res_out_abb.resumed_trans_store_id_ejr = alls.resumed_trans_store_id_ejr
    AND s_res_out_abb.resumed_trans_terminal_id_ejr = alls.resumed_trans_terminal_id_ejr
    AND s_res_out_abb.resumed_trans_date_ejr = alls.resumed_trans_date_ejr
    AND s_res_out_abb.resumed_trans_receipt_nr_ejr = alls.resumed_trans_receipt_nr_ejr
  LEFT OUTER JOIN (
    SELECT
      next_op.store_id,
      next_op.client_id,
      next_op.pos_terminal_id,
      next_op.dat_formdate,
      next_op.time_receipt_ejr,
      next_op.orig_receipt_nr_ejr,
      next_op.timezone_cd,
      next_op.dat_dayend,
      next_op.checker_id,
      next_op.transactiontype_id,
      next_op.val_retail_ejr,
      next_op.store_id AS resumed_trans_store_id_ejr,
      tran.pos_terminal_id AS resumed_trans_terminal_id_ejr,
      tran.dat_formdate AS resumed_trans_date_ejr,
      tran.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr,
      CAST('2' AS NUMERIC) AS resumed_trans_seqnr,
      next_op.cnt_sell_item,
      next_op.cnt_all_deposit_back,
      next_op.cnt_wo_deposit_voided_line
    FROM ldl_p_lew_mart_msi.v_ejr_all_transact_2 AS tran
    LEFT OUTER JOIN (
      SELECT DISTINCT
        tr_next.client_id AS cw_0,
        tr_next.store_id AS cw_1,
        tr_next.pos_terminal_id AS cw_2,
        tr_next.dat_formdate AS cw_3,
        tr_next.checker_id AS cw_4,
        MIN(tr_next.orig_receipt_nr_ejr) AS orig_receipt_nr_ejr
      FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_2 AS tr_next
      INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_2 AS tran_0
        ON tran_0.client_id = tr_next.client_id
        AND tran_0.store_id = tr_next.store_id
        AND tran_0.pos_terminal_id = tr_next.pos_terminal_id
        AND tran_0.dat_formdate = tr_next.dat_formdate
        AND tran_0.checker_id = tr_next.checker_id
      WHERE
        tr_next.orig_receipt_nr_ejr > tran_0.orig_receipt_nr_ejr
        AND NOT tr_next.transactiontype_id IN (
          '400' ,
          '405' ,
          '420' ,
          '425' ,
          '430' ,
          '480' 
        )
      GROUP BY
        1,
        2,
        3,
        4,
        5
    ) AS ex1
      ON tran.client_id = ex1.cw_0
      AND tran.store_id = ex1.cw_1
      AND tran.pos_terminal_id = ex1.cw_2
      AND tran.dat_formdate = ex1.cw_3
      AND tran.checker_id = ex1.cw_4
    INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower_2 AS next_op
      ON tran.store_id = next_op.store_id
      AND tran.client_id = next_op.client_id
      AND tran.pos_terminal_id = next_op.pos_terminal_id
      AND tran.dat_formdate = next_op.dat_formdate
      AND next_op.orig_receipt_nr_ejr = ex1.orig_receipt_nr_ejr
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr
      ON tran.store_id = revstr.store_id
      AND tran.client_id = revstr.client_id
      AND tran.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    WHERE
      tran.transactiontype_id = '300'
  ) AS s_next
    ON s_next.resumed_trans_store_id_ejr = alls.resumed_trans_store_id_ejr
    AND s_next.resumed_trans_terminal_id_ejr = alls.resumed_trans_terminal_id_ejr
    AND s_next.resumed_trans_date_ejr = alls.resumed_trans_date_ejr
    AND s_next.resumed_trans_receipt_nr_ejr = alls.resumed_trans_receipt_nr_ejr
  LEFT OUTER JOIN (
    SELECT
      susp_0.resumed_trans_store_id_ejr,
      susp_0.resumed_trans_terminal_id_ejr,
      susp_0.resumed_trans_date_ejr,
      susp_0.resumed_trans_receipt_nr_ejr,
      susp_0.resumed_trans_seqnr,
      MAX(susp_0.val_retail_ejr) AS val_susp_retail_ejr,
      sum(
        CASE
          WHEN r.transactiontype_id = '201'
          THEN 1
          ELSE 0
        END
      ) AS cnt_s_all_salelines,
      sum(
        CASE
          WHEN r.transactiontype_id = '270'
          THEN 1
          ELSE 0
        END
      ) AS cnt_s_all_voidedlines_in_res,
      sum(
        CASE
          WHEN r.xrownum = 1 AND r.transactiontype_id = '201'
          THEN 1
          ELSE 0
        END
      ) AS is_s_lastline_sale,
      sum(
        CASE
          WHEN r.xrownum = 1 AND r.transactiontype_id = '270'
          THEN 1
          ELSE 0
        END
      ) AS is_s_lastline_void,
      sum(
        CASE
          WHEN r.xrownum > 1 AND r.transactiontype_id = '270'
          THEN 1
          ELSE 0
        END
      ) AS cnt_s_voidedlines_beforlast,
      sum(
        CASE
          WHEN r.transactiontype_id = '201' OR r.transactiontype_id = '270'
          THEN 1
          ELSE 0
        END
      ) AS cnt_s_all_lines,
      sum(
        CASE
          WHEN r.transactiontype_id = '270'
          THEN r.val_retail_ejr
          ELSE 0
        END
      ) AS val_s_voided
    FROM (
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
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_ntr_2 AS tran
      INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr
        ON tran.store_id = revstr.store_id
        AND tran.client_id = revstr.client_id
        AND tran.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
      INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS revday
        ON tran.dat_formdate = revday.dat_calendar
      WHERE
        substr(tran.transactiontype_id, 3, 1) <> '1'
    ) AS susp_0
    INNER JOIN (
      SELECT
        row_number() OVER (
          PARTITION BY r_0.store_id, r_0.client_id, r_0.pos_terminal_id, r_0.dat_formdate, r_0.orig_receipt_nr_ejr
          ORDER BY r_0.orig_receipt_serial_nr_ejr DESC
        ) AS xrownum,
        r_0.store_id,
        r_0.client_id,
        r_0.pos_terminal_id,
        r_0.dat_formdate,
        r_0.time_receipt_ejr,
        r_0.orig_receipt_nr_ejr,
        r_0.transactiontype_id,
        r_0.val_retail_ejr
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_ntr_2 AS r_0
      INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr
        ON r_0.store_id = revstr.store_id
        AND r_0.client_id = revstr.client_id
        AND r_0.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
      INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS revday
        ON r_0.dat_formdate = revday.dat_calendar
      WHERE
        r_0.parent_line_nr_ejr IS NULL
    ) AS r
      ON susp_0.store_id = r.store_id
      AND susp_0.client_id = r.client_id
      AND susp_0.pos_terminal_id = r.pos_terminal_id
      AND susp_0.dat_formdate = r.dat_formdate
      AND susp_0.time_receipt_ejr = r.time_receipt_ejr
    WHERE
      susp_0.resumed_trans_seqnr = 1
    GROUP BY
      1,
      2,
      3,
      4,
      5
  ) AS susp
    ON susp.resumed_trans_store_id_ejr = alls.resumed_trans_store_id_ejr
    AND susp.resumed_trans_terminal_id_ejr = alls.resumed_trans_terminal_id_ejr
    AND susp.resumed_trans_date_ejr = alls.resumed_trans_date_ejr
    AND susp.resumed_trans_receipt_nr_ejr = alls.resumed_trans_receipt_nr_ejr
  INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_2 AS tr
    ON tr.client_id = alls.client_id
  UNION ALL
  SELECT
    sust.store_id AS resumed_trans_store_id_ejr, /* New scenarios from BBT-398.
                Bonrueckstellung + Kleinstbon
                Bonrueckstellung + Abmeldung  */
    sust.pos_terminal_id AS resumed_trans_terminal_id_ejr,
    sust.dat_formdate AS resumed_trans_date_ejr,
    sust.orig_receipt_nr_ejr AS resumed_trans_receipt_nr_ejr,
    ur.resumed_trans_seqnr AS resumed_trans_seqnr,
    sust.store_id AS store_id,
    sust.client_id AS client_id,
    sust.pos_terminal_id AS pos_terminal_id,
    sust.dat_formdate AS dat_formdate,
    CASE ur.resumed_trans_seqnr
      WHEN 1
      THEN sust.orig_receipt_nr_ejr
      WHEN CAST('2' AS NUMERIC)
      THEN nxtt.orig_receipt_nr_ejr
      WHEN CAST('4' AS NUMERIC)
      THEN anmd.orig_receipt_nr_ejr
    END AS orig_receipt_nr_ejr,
    CASE ur.resumed_trans_seqnr
      WHEN 1
      THEN sust.checker_id
      WHEN CAST('2' AS NUMERIC)
      THEN nxtt.checker_id
      WHEN CAST('4' AS NUMERIC)
      THEN anmd.checker_id
    END AS checker_id,
    CASE ur.resumed_trans_seqnr
      WHEN 1
      THEN sust.time_receipt_ejr
      WHEN CAST('2' AS NUMERIC)
      THEN nxtt.time_receipt_ejr
      WHEN CAST('4' AS NUMERIC)
      THEN anmd.time_receipt_ejr
    END AS time_receipt_ejr,
    CASE ur.resumed_trans_seqnr
      WHEN 1
      THEN sust.transactiontype_id
      WHEN CAST('2' AS NUMERIC)
      THEN nxtt.transactiontype_id
      WHEN CAST('4' AS NUMERIC)
      THEN anmd.transactiontype_id
    END AS transactiontype_id,
    0 AS val_susp_retail_ejr,
    nxtt.transactiontype_id AS susp_next_transactiontype_id,
    nxtt.val_retail_ejr AS val_susp_next_retail_ejr,
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
      WHEN nxtt.transactiontype_id = '410'
      THEN 0
      ELSE 1
    END AS is_next_low_tran_mc,
    CASE
      WHEN nxtt.transactiontype_id = '410'
      THEN 1
      ELSE 0
    END AS is_next_abmeld_mc
  FROM (
    SELECT
      atf.client_id AS client_id,
      atf.store_id AS store_id,
      atf.pos_terminal_id AS pos_terminal_id,
      atf.dat_formdate AS dat_formdate,
      atf.orig_receipt_nr_ejr AS orig_receipt_nr_ejr
    FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_2 AS atf
    WHERE
      atf.dat_formdate BETWEEN (
        SELECT
          MAX(revstr1.dat_formdate_from)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr1
        WHERE
          revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id
      ) AND (
        SELECT
          MAX(revstr2.dat_formdate_until)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr2
        WHERE
          revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id
      )
      AND atf.client_id = (
        SELECT
          MAX(revstr3.client_id)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr3
        WHERE
          revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id
      )
      AND atf.store_id = (
        SELECT
          MAX(revstr4.store_id)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr4
        WHERE
          revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id
      )
      AND NOT atf.checker_id IS NULL
      AND atf.transactiontype_id = '300'
      AND atf.val_retail_ejr <> 0
    EXCEPT DISTINCT
    SELECT
      atf.client_id AS client_id,
      atf.resumed_trans_store_id_ejr AS store_id,
      atf.resumed_trans_terminal_id_ejr AS pos_terminal_id,
      atf.resumed_trans_date_ejr AS dat_formdate,
      atf.resumed_trans_receipt_nr_ejr AS orig_receipt_nr_ejr
    FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_2 AS atf
    WHERE
      atf.dat_formdate BETWEEN (
        SELECT
          MAX(revstr1.dat_formdate_from)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr1
        WHERE
          revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id
      ) AND (
        SELECT
          MAX(revstr2.dat_formdate_until)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr2
        WHERE
          revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id
      )
      AND atf.client_id = (
        SELECT
          MAX(revstr3.client_id)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr3
        WHERE
          revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id
      )
      AND atf.store_id = (
        SELECT
          MAX(revstr4.store_id)
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS revstr4
        WHERE
          revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id
      )
      AND NOT atf.checker_id IS NULL
      AND NOT atf.resumed_trans_receipt_nr_ejr IS NULL
  ) AS osus
  INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_2 AS tr
    ON tr.client_id = osus.client_id
  INNER JOIN (
    SELECT
      src.resumed_trans_seqnr
    FROM (
      SELECT
        round(1, 0) AS resumed_trans_seqnr
    ) AS src
    UNION ALL
    SELECT
      src.resumed_trans_seqnr
    FROM (
      SELECT
        round(CAST('2' AS NUMERIC), 0) AS resumed_trans_seqnr
    ) AS src
    UNION ALL
    SELECT
      src.resumed_trans_seqnr
    FROM (
      SELECT
        round(CAST('4' AS NUMERIC), 0) AS resumed_trans_seqnr
    ) AS src
  ) AS ur
    ON 1 = 1
  INNER JOIN (
    SELECT
      tr_foll.*,
      (
        SELECT
          MIN(tr_next.orig_receipt_nr_ejr)
        FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_2 AS tr_next
        WHERE
          tr_foll.client_id = tr_next.client_id
          AND tr_foll.store_id = tr_next.store_id
          AND tr_foll.pos_terminal_id = tr_next.pos_terminal_id
          AND tr_foll.dat_formdate = tr_next.dat_formdate
          AND tr_foll.checker_id = tr_next.checker_id
          AND tr_next.orig_receipt_nr_ejr > tr_foll.orig_receipt_nr_ejr
          AND NOT tr_next.transactiontype_id IN (
            '400' ,
            '405' ,
            '420' ,
            '425' ,
            '430' ,
            '480' 
          )
      ) AS receipt_foll
    FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_2 AS tr_foll
  ) AS sust
    ON osus.client_id = sust.client_id
    AND osus.store_id = sust.store_id
    AND osus.pos_terminal_id = sust.pos_terminal_id
    AND osus.dat_formdate = sust.dat_formdate
    AND osus.orig_receipt_nr_ejr = sust.orig_receipt_nr_ejr
    AND NOT sust.checker_id IS NULL
  INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower_2 AS nxtt
    ON osus.client_id = nxtt.client_id
    AND osus.store_id = nxtt.store_id
    AND osus.pos_terminal_id = nxtt.pos_terminal_id
    AND osus.dat_formdate = nxtt.dat_formdate
    AND nxtt.orig_receipt_nr_ejr = sust.receipt_foll
    AND NOT nxtt.checker_id IS NULL
    AND (
      nxtt.transactiontype_id IN ('100', '101', '200', '201')
      AND nxtt.val_retail_ejr < tr.susp_subseqent_trans_low_val_mc
      AND nxtt.cnt_sell_item + nxtt.cnt_all_deposit_back = 1
      AND nxtt.cnt_wo_deposit_voided_line = 0
      OR nxtt.transactiontype_id = '410'
    )
  LEFT OUTER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_2 AS anmd
    ON osus.client_id = anmd.client_id
    AND osus.store_id = anmd.store_id
    AND osus.pos_terminal_id = anmd.pos_terminal_id
    AND nxtt.next_time_receipt_ejr = anmd.time_receipt_ejr
    AND osus.dat_formdate = anmd.dat_formdate
    AND nxtt.next_orig_receipt_nr_ejr = anmd.orig_receipt_nr_ejr
    AND nxtt.next_transactiontype_id = anmd.transactiontype_id
    AND NOT anmd.checker_id IS NULL
    AND anmd.transactiontype_id = '415'
  WHERE
    ur.resumed_trans_seqnr <> CAST('4' AS NUMERIC) OR NOT anmd.client_id IS NULL
) AS d
GROUP BY
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  15;