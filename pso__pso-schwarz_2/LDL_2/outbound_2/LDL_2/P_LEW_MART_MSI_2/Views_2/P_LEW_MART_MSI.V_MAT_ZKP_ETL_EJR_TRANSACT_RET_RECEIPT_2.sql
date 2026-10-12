-- 01.08.2012 Anpasung in Filterbeduienung weger "Alle Warengruppe"

-- Ausserdem: Wurde mal ein Tagesabschluss nicht getaetigt  ,sind die Kassierer angehalten  ,einen anderen ID-Bereich fuer den 2ten Tag_2 zu

-- Hinweis D.Gebel: Auswertungen basierend auf der checker_id sind fragwuerdig. Die checker_id ist nicht eindeutig einem Bediener zugeordnet.

-- verwenden. In solche einem Fall  ,verwendet der Bediener tatsaechlich 2 IDs.

-- Jeder Bediener hat zwar seine "Standard"-ID  ,jedoch ist es moeglich  ,das andere Kassierer die gleiche Bediener-Nummer verwenden.

CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_transact_ret_receipt_2 AS -- Alle
 -- Spirituosen

-- Waschmittel
 -- Kosmetik
 -- Baby
 -- Tabak
 -- NF

-- The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).

/* 3 */ /* 1 */ /* 3 */ /* 1 */ SELECT client_id,
 store_id,
 checker_id,
 dat_formdate,
 orig_receipt_nr_ejr,
 pos_terminal_id,
 time_receipt_ejr,
 MAX(receipt_check_b1) AS receipt_check_b1,
 MAX(receipt_check_b2) AS receipt_check_b2,
 MAX(receipt_check_b3) AS receipt_check_b3,
 MAX(receipt_check_b4) AS receipt_check_b4,
 MAX(receipt_check_b5) AS receipt_check_b5,
 MAX(receipt_check_b6) AS receipt_check_b6,
 MAX(receipt_check_b7) AS receipt_check_b7
FROM (SELECT tz.client_id,
   tz.store_id,
   tz.checker_id,
   tz.dat_formdate,
   tz.orig_receipt_nr_ejr,
   tz.pos_terminal_id,
   tz.time_receipt_ejr,
   1 AS receipt_check_b1,
    CASE
    WHEN tz.subitemgroup_id = 61
    THEN 1
    ELSE 0
    END AS receipt_check_b2,
    CASE
    WHEN tz.subitemgroup_id = 83
    THEN 1
    ELSE 0
    END AS receipt_check_b3,
    CASE
    WHEN tz.subitemgroup_id = 82
    THEN 1
    ELSE 0
    END AS receipt_check_b4,
    CASE
    WHEN tz.subitemgroup_id = 54
    THEN 1
    ELSE 0
    END AS receipt_check_b5,
    CASE
    WHEN tz.subitemgroup_id = 80
    THEN 1
    ELSE 0
    END AS receipt_check_b6,
    CASE
    WHEN tz.mainitemgroup_id = 10
    THEN 1
    ELSE 0
    END AS receipt_check_b7
  FROM (SELECT t8.client_id,
     t8.store_id,
     t8.checker_id,
     t8.dat_formdate,
     t8.orig_receipt_nr_ejr,
     t8.pos_terminal_id,
     t8.time_receipt_ejr,
     t8.cy_week,
     t8.item_id,
     t8.subitemgroup_id,
     t8.mainitemgroup_id,
     t8.cnt_orig_receipt_nr_ejr,
      CASE
      WHEN t8.cy_week = (MIN(t8.cy_week) OVER (PARTITION BY CAST(t8.client_id AS STRING), CAST(t8.store_id AS STRING), CAST(t8.checker_id AS STRING)
           ORDER BY t8.dat_formdate IS NULL, t8.dat_formdate, t8.cy_week IS NULL, t8.cy_week, t8.item_id IS NULL, t8.item_id
           ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING))
      THEN 0
      ELSE 1
      END AS change_fg
    FROM (SELECT tx.client_id,
       tx.store_id,
       tx.checker_id,
       tx.dat_formdate,
       tx.orig_receipt_nr_ejr,
       tx.pos_terminal_id,
       tx.time_receipt_ejr,
       tx.cy_week,
       tx.item_id,
       tx.subitemgroup_id,
       tx.mainitemgroup_id,
       tx.cnt_orig_receipt_nr_ejr,
       SUM(tx.cnt_orig_receipt_nr_ejr) OVER (PARTITION BY CAST(tx.client_id AS STRING), CAST(tx.store_id AS STRING), CAST(tx.checker_id AS STRING)
          , tx.item_id, CAST(tx.cy_week AS STRING) ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING) AS grp_sum_item_per_week,
       THRESHCUM.return_freq_same_item_in_1w
      FROM (SELECT T1.client_id,
         T1.store_id,
         T1.checker_id,
         T1.dat_formdate,
         T1.orig_receipt_nr_ejr,
         T1.pos_terminal_id,
         T1.time_receipt_ejr,
         T4.cy_week,
         T2.item_id,
         T2.subitemgroup_id,
         T2.mainitemgroup_id,
         COUNT(DISTINCT T1.orig_receipt_nr_ejr) AS cnt_orig_receipt_nr_ejr
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_2 AS T1_2
         INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 AS T2 ON T1.client_id = T2.client_id AND
               T1.store_id = T2.store_id AND T1.orig_receipt_nr_ejr = T2.orig_receipt_nr_ejr AND T1.pos_terminal_id = T2
             .pos_terminal_id AND T1.time_receipt_ejr = T2.time_receipt_ejr AND T1.dat_formdate = T2.dat_formdate
         INNER JOIN ldl_p_lew_mart_msi.v_cal_calendarday_2 AS T4 ON T1.dat_formdate = T4.dat_calendar
         INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_2 AS THRESH ON T1.client_id = THRESH.client_id
          -- CROSS JOIN to *load_store to get only the relevant stores   AND CROSS JOIN to *load_day for performance (optimizer will evaluate if dynamic partition elimination is used)

          
         INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS REVSTR ON T1.store_id = REVSTR.store_id
             AND T1.client_id = REVSTR.client_id AND T1.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
           
         INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS REVDAY ON T1.dat_formdate = REVDAY.dat_calendar
          
        WHERE T1.transactiontype_id = '150'
         AND T2.price_retail_ejr > THRESH.return_tot_val
         AND T1.dat_formdate >= (SELECT MIN(dat_calendar)
           FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS D_MIN)
         AND T1.dat_formdate <= (SELECT MAX(dat_calendar)
           FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS D_MAX)
         AND T2.subitemgroup_id NOT IN (100, 101, 102, 105, 106)
        GROUP BY T1.client_id,
         T1.store_id,
         T1.checker_id,
         T1.dat_formdate,
         T1.orig_receipt_nr_ejr,
         T1.pos_terminal_id,
         T1.time_receipt_ejr,
         T4.cy_week,
         T2.item_id,
         T2.subitemgroup_id,
         T2.mainitemgroup_id) AS tx
       INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_cumulation_2 AS THRESHCUM ON tx.client_id = THRESHCUM.client_id
         AND tx.store_id = THRESHCUM.store_id AND tx.checker_id = THRESHCUM.checker_id
      QUALIFY (SUM(tx.cnt_orig_receipt_nr_ejr) OVER (PARTITION BY CAST(tx.client_id AS STRING), CAST(tx.store_id AS STRING)
            , CAST(tx.checker_id AS STRING), tx.item_id, CAST(tx.cy_week AS STRING) ORDER BY 1 IS NULL, 1 RANGE BETWEEN
          UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) >= THRESHCUM.return_freq_same_item_in_1w) AS t8) AS tz
   INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_cumulation_2 AS THRESHCUM0 ON tz.client_id = THRESHCUM0.client_id AND
      tz.store_id = THRESHCUM0.store_id AND tz.checker_id = THRESHCUM0.checker_id
  QUALIFY (SUM(tz.change_fg) OVER (PARTITION BY CAST(tz.client_id AS STRING), CAST(tz.store_id AS STRING), CAST(tz.checker_id AS STRING)
        ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) >= THRESHCUM0.ret_threshold_qty_week_in_3m
    ) AS t
GROUP BY client_id,
 store_id,
 checker_id,
 dat_formdate,
 orig_receipt_nr_ejr,
 pos_terminal_id,
 time_receipt_ejr;