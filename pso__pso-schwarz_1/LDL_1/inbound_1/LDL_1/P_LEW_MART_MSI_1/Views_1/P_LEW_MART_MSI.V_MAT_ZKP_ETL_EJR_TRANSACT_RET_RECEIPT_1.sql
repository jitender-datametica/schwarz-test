CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_TRANSACT_RET_RECEIPT_1
AS

-- Hinweis D.Gebel: Auswertungen basierend auf der checker_id sind fragwuerdig. Die checker_id ist nicht eindeutig einem Bediener zugeordnet.
--                  Jeder Bediener hat zwar seine "Standard"-ID  ,jedoch ist es moeglich  ,das andere Kassierer die gleiche Bediener-Nummer verwenden.
--                  Ausserdem: Wurde mal ein Tagesabschluss nicht getaetigt  ,sind die Kassierer angehalten  ,einen anderen ID-Bereich fuer den 2ten Tag_1 zu
--                  verwenden. In solche einem Fall  ,verwendet der Bediener tatsaechlich 2 IDs.
 --   01.08.2012 Anpasung in Filterbeduienung weger "Alle Warengruppe"
SELECT
t.client_id,
t.store_id,
t.checker_id,
t.dat_formdate,
t.orig_receipt_nr_ejr,
t.pos_terminal_id,
t.time_receipt_ejr,
Max(t.receipt_check_b1) AS receipt_check_b1,
Max(t.receipt_check_b2) AS receipt_check_b2,
Max(t.receipt_check_b3) AS receipt_check_b3,
Max(t.receipt_check_b4) AS receipt_check_b4,
Max(t.receipt_check_b5) AS receipt_check_b5,
Max(t.receipt_check_b6) AS receipt_check_b6,
Max(t.receipt_check_b7) AS receipt_check_b7
FROM
(SELECT
tz.client_id,
tz.store_id,
tz.checker_id,
tz.dat_formdate,
tz.orig_receipt_nr_ejr,
tz.pos_terminal_id,
tz.time_receipt_ejr,
1 AS receipt_check_b1  --  Alle
,
CASE WHEN tz.subitemgroup_id = 61 THEN 1 ELSE 0 END AS receipt_check_b2 --  Spirituosen
,
CASE WHEN tz.subitemgroup_id = 83 THEN 1 ELSE 0 END AS receipt_check_b3 --  Waschmittel
,
CASE WHEN tz.subitemgroup_id = 82 THEN 1 ELSE 0 END AS receipt_check_b4 --  Kosmetik
,
CASE WHEN tz.subitemgroup_id = 54 THEN 1 ELSE 0 END AS receipt_check_b5 --  Baby
,
CASE WHEN tz.subitemgroup_id = 80 THEN 1 ELSE 0 END AS receipt_check_b6 --  Tabak
,
CASE WHEN tz.mainitemgroup_id = 10 THEN 1 ELSE 0 END AS receipt_check_b7 --  NF

FROM
(SELECT
ty.client_id,
ty.store_id,
ty.checker_id,
ty.dat_formdate,
ty.orig_receipt_nr_ejr,
ty.pos_terminal_id,
ty.time_receipt_ejr,
ty.cy_week,
ty.item_id,
ty.subitemgroup_id,
ty.mainitemgroup_id,
ty.cnt_orig_receipt_nr_ejr,
CASE WHEN ty.cy_week = Min(ty.cy_week) Over(PARTITION BY ty.client_id  ,ty.store_id  ,ty.checker_id
                                                      ORDER BY ty.dat_formdate  ,ty.cy_week  ,ty.item_id
                                                      ROWS BETWEEN 1 Preceding   AND 1 Preceding)
               THEN 0
               ELSE 1
               END AS change_fg
FROM
(SELECT
tx.client_id,
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
Sum(tx.cnt_orig_receipt_nr_ejr) Over (PARTITION BY tx.client_id  ,tx.store_id  ,tx.checker_id  ,tx.item_id  ,tx.cy_week ORDER BY 1 ROWS BETWEEN Unbounded Preceding   AND Unbounded Following) grp_sum_item_per_week
FROM
(SELECT
t1.client_id,
t1.store_id,
t1.checker_id,
t1.dat_formdate,
t1.orig_receipt_nr_ejr,
t1.pos_terminal_id,
t1.time_receipt_ejr,
t4.cy_week,
t2.item_id,
t2.subitemgroup_id,
t2.mainitemgroup_id,
Count(DISTINCT t1.orig_receipt_nr_ejr) AS cnt_orig_receipt_nr_ejr
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_1 t1_1
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 t2
ON   t1.client_id = t2.client_id
  AND   t1.store_id = t2.store_id
  AND   t1.orig_receipt_nr_ejr = t2.orig_receipt_nr_ejr
  AND   t1.pos_terminal_id = t2.pos_terminal_id
  AND   t1.time_receipt_ejr = t2.time_receipt_ejr
  AND   t1.dat_formdate =  t2.dat_formdate
INNER JOIN p_lew_mart_msi.v_cal_calendarday_1 t4
ON   t1.dat_formdate = t4.dat_calendar
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 thresh
ON t1.client_id = thresh.client_id
-- Join to *load_store to get only the relevant stores   AND join to *load_day for performance (optimizer will evaluate if dynamic partition elimination is used)
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr
ON t1.store_id = revstr.store_id
  AND t1.client_id = revstr.client_id
  AND t1.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 revday
ON t1.dat_formdate = revday.dat_calendar
WHERE t1.transactiontype_id = '150'
  AND (t2.price_retail_ejr > thresh.return_tot_val   AND t2.subitemgroup_id NOT IN (100  ,101  ,102  ,105  ,106))
-- The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).
  AND t1.dat_formdate >= (SELECT
Min(d_min.dat_calendar)
FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 d_min)
AND t1.dat_formdate <= (SELECT
Max(d_max.dat_calendar)
FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 d_max)
GROUP BY
  t1.client_id
 ,t1.store_id
 ,t1.checker_id
 ,t1.dat_formdate
 ,t1.orig_receipt_nr_ejr
 ,t1.pos_terminal_id
 ,t1.time_receipt_ejr
 ,t4.cy_week
 ,t2.item_id
 ,t2.subitemgroup_id
 ,t2.mainitemgroup_id
) tx
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_cumulation_1 threshcum
ON tx.client_id = threshcum.client_id
  AND tx.store_id = threshcum.store_id
  AND tx.checker_id = threshcum.checker_id
QUALIFY grp_sum_item_per_week >= threshcum.return_freq_same_item_in_1w
) ty
) tz
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_cumulation_1 threshcum
ON tz.client_id = threshcum.client_id
  AND tz.store_id = threshcum.store_id
  AND tz.checker_id = threshcum.checker_id
QUALIFY Sum(tz.change_fg) Over (PARTITION BY tz.client_id  ,tz.store_id  ,tz.checker_id ORDER BY 1 ROWS BETWEEN Unbounded Preceding   AND Unbounded Following) >= threshcum.ret_threshold_qty_week_in_3m /*3*/ /*1*/ /*3*/ /*1*/
) t
GROUP BY
  t.client_id
  ,t.store_id
  ,t.checker_id
  ,t.dat_formdate
  ,t.orig_receipt_nr_ejr
  ,t.pos_terminal_id
  ,t.time_receipt_ejr
;


