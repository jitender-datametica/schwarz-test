/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_VOID_TRANSACTION_ADV
#----------------------------------------------------------------------------
# History:
#  1.0  11.01.2024    Szewczyk,Milosz          AP0182639 : Creating a separate view for voided lines without last position filter (QUALIFY void_line_nr_ejr > last_sale_line) - based on P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_VOID_TRANSACTION
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_VOID_TRANSACTION_ADV(
	CLIENT_ID
	,STORE_ID
	,POS_TERMINAL_ID
	,TIME_RECEIPT_EJR
	,DAT_FORMDATE
	,ORIG_RECEIPT_NR_EJR
	,WH_ID
	,CHECKER_ID
	,IS_VOIDED_AFTER_SUBTOTAL
	,CNT_VOID_AFTER_SUBTOTAL
	,IS_VOIDED_ITEM_INNEXT
	,TOTAL_VALUE_VOID
	,IS_PAY_EXACT
	,IS_SUBTOTAL_BEF_STORNO
	,IS_VOID_NOT_AUTHORISED
	,IS_HIGHEST_VAL
	,IS_ALK_TAB
	,IS_VOIDED_VALUE_AFT_SUBTOTAL_2
	,IS_1_ITM_2
	,IS_OUTSIDE_HOURS
	,IS_MAN_DISCOUNT
	,CNT_VOID_EJR
	,IS_MAN_DISCOUNT_ITEM
) AS
(
SELECT
   t2.client_id
  ,t2.store_id
  ,t2.pos_terminal_id
  ,t2.time_receipt_ejr
  ,t2.dat_formdate
  ,t2.orig_receipt_nr_ejr
  ,MAX(t2.wh_id) AS wh_id
  ,MAX(t2.checker_id) AS checker_id
  /* Storni nicht Obst und Gemuese und Bake-Off | removed COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line AND from CASE statement: */
  ,MAX(CASE WHEN t2.transactiontype_id IN ('170','172') AND t2.subitemgroup_id <> 74 AND t2.mainitemgroup_id <> 1 THEN 1 ELSE 0 END) AS is_voided_after_subtotal
  /* Part of Filial metric / Anz Bons mit Stornovorgang / Anzahl Storni nach Zwichensumme | removed COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line AND from CASE statement: */
  ,SUM(CASE WHEN t2.transactiontype_id IN ('170','172') AND (t2.subitemgroup_id = 74 OR t2.mainitemgroup_id = 1) THEN 1 ELSE 0 END) AS cnt_void_after_subtotal
  /* Storn Artikel auf Folgebon | removed COALESCE(t2.void_line_nr_ejr,0) > t2.last_sale_line AND from CASE statement: */
  ,SUM(CASE WHEN t2.transactiontype_id IN ('170','172') THEN COALESCE(rl.saled_item,0) ELSE 0 END) AS is_voided_item_innext
  /* Gesamtwert Storno: */
  ,MAX(t2.val_all_voided_line) AS total_value_void
  /* Bon glatt Bezahlt: */
  ,MAX(CASE WHEN (val_total_retail_ejr > 0 AND chg_aft_pay < 0) OR (val_total_retail_ejr < 0 AND chg_aft_pay > 0) THEN 1 ELSE 0 END) AS is_pay_exact
  /* Zwischensumme vor Storno: */
  ,MAX(CASE WHEN t2.last_subtot_bef_void < t2.timestamp_begin_ejr THEN 1 ELSE 0 END) AS is_subtotal_bef_storno
  /* Storno nicht authorisierungspflichtig: */
  ,CASE WHEN AVG(CASE WHEN t2.authority_id IS NULL THEN 1 ELSE 0 END) = 1 THEN 1 ELSE 0 END AS is_void_not_authorised
  /* Storno hoechster Einzelwert: */
  ,MAX(CASE WHEN t2.highest_val_void = t2.highest_val THEN 1 ELSE 0 END) AS is_highest_val
  /* Storno Tabak/ Alkohol: */
  ,MAX(CASE WHEN t2.subitemgroup_id IN (60,61,63,80) AND t2.transactiontype_id IN ('170','172') THEN 1 ELSE 0 END) AS is_alk_tab
  /* Gesamtsumme der stornierten Artikel > X LW new: */
  ,CASE WHEN SUM(CASE WHEN t2.subitemgroup_id <> 74   AND t2.mainitemgroup_id <> 1 THEN ABS(t2.val_retail_ejr) ELSE 0 END) > MAX(tr.void_tot_val_cnt) THEN 1 ELSE 0 END AS is_voided_value_aft_subtotal_2
  /* Bonsumme<X LW + 1 Artikel new: */
  ,MAX(CASE WHEN t2.cnt_sale_aft_void = 1 AND t2.val_total_retail_ejr < tr.void_1itm_receipt_val_2 THEN 1 ELSE 0 END) AS is_1_itm_2
  /* Bons außerhalb der Öffnungszeit: */
  ,MAX(CASE WHEN (t2.time_receipt_ejr <=
								(CASE
                                WHEN date_part(dayofweek,t2.dat_formdate)=1 THEN lh1.mon_closing_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=2 THEN lh1.tue_closing_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=3 THEN lh1.wed_closing_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=4 THEN lh1.thu_closing_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=5 THEN lh1.fri_closing_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=6 THEN lh1.sat_closing_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=7 THEN lh1.sun_closing_tm
                                END)
							AND t2.time_receipt_ejr >= (CASE
                                WHEN date_part(dayofweek,t2.dat_formdate)=1 THEN lh1.mon_opening_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=2 THEN lh1.tue_opening_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=3 THEN lh1.wed_opening_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=4 THEN lh1.thu_opening_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=5 THEN lh1.fri_opening_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=6 THEN lh1.sat_opening_tm
                                WHEN date_part(dayofweek,t2.dat_formdate)=7 THEN lh1.sun_opening_tm
                               END)
							) THEN 0 ELSE 1 END) AS is_outside_hours
  /* Bons mit manuellem Rabatt: */
  ,MAX(CASE WHEN (t2.transactiontype_id IN (401,402,441,442,470,502,570,472,482,572,580,582) -- only discounts
	      AND NOT ((t2.BARCODE LIKE '55%' OR t2.BARCODE LIKE '56%') AND LENGTH(t2.BARCODE) BETWEEN 15 AND 17) -- exclude scanned discounts
	      AND ABS(t2.val_discount_ejr) > 0.01) THEN 1 ELSE 0 END) AS is_man_discount
  /* Anzahl Stornozeilen */
  ,MAX(t2.cnt_void_ejr) AS cnt_void
  /* Stornierter Artikel mit manuellem Rabatt verkauft*/
  ,MAX(CASE WHEN rl3.is_man_discount_item = 1 THEN 1 ELSE 0 END) AS is_man_discount_item
FROM
(
    SELECT
       x.client_id
      ,x.orig_receipt_serial_nr_ejr
      ,x.store_id
      ,x.pos_terminal_id
      ,x.dat_formdate
      ,x.time_receipt_ejr
      ,x.orig_receipt_nr_ejr
      ,x.dat_dayend
      ,x.checker_id
      ,x.transactiontype_id
      ,x.item_id
      ,x.mainitemgroup_id
      ,x.subitemgroup_id
      ,x.val_retail_ejr
      ,x.parent_line_nr_ejr
      ,x.voided_by_line_nr_ejr
      ,x.barcode
      ,x.val_discount_ejr
	    ,y.val_all_voided_line
      ,y.cnt_void_ejr
      ,tr.void_itm_cnt
      ,y.next_orig_receipt_nr_ejr
      ,y.next_time_receipt_ejr
      ,y.transactiontype_id AS header_transactiontype_id
      ,revstr.wh_id
      ,y.val_retail_ejr AS val_total_retail_ejr
      ,(SELECT COALESCE(MAX(CASE WHEN p.cnt_payment_ejr = 0 THEN orig_receipt_serial_nr_ejr ELSE 0 END),0) - COALESCE(MAX(CASE WHEN p.cnt_payment_ejr = 1 THEN orig_receipt_serial_nr_ejr ELSE 0 END),0)
      -- Difference between last position of change and last payment position.
        FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_payment_extract p
        WHERE y.store_id = p.store_id
        AND y.client_id = p.client_id
        AND y.pos_terminal_id = p.pos_terminal_id
        AND y.dat_formdate = p.dat_formdate
        AND y.time_receipt_ejr = p.time_receipt_ejr
        AND y.orig_receipt_nr_ejr = p.orig_receipt_nr_ejr) AS chg_aft_pay
      ,x.authority_id
      ,MAX(CASE WHEN x.transactiontype_id IN ('101','102','120','122','170') THEN x.val_retail_ejr ELSE 0 END ) OVER (PARTITION BY
           x.client_id
          ,x.store_id
          ,x.pos_terminal_id
          ,x.time_receipt_ejr
          ,x.dat_formdate
          ,x.orig_receipt_nr_ejr) AS highest_val
      ,MAX(CASE WHEN x.transactiontype_id IN ('170') THEN x.val_retail_ejr ELSE 0 END ) OVER (PARTITION BY
           x.client_id
          ,x.store_id
          ,x.pos_terminal_id
          ,x.time_receipt_ejr
          ,x.dat_formdate
          ,x.orig_receipt_nr_ejr) AS highest_val_void
	    ,(SELECT MAX(s.timestamp_begin_ejr) -- Timestamp of the last subtotal before Storno
	      FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_subtotal_extract s
        WHERE y.store_id = s.store_id
        AND y.client_id = s.client_id
        AND y.pos_terminal_id = s.pos_terminal_id
        AND y.dat_formdate = s.dat_formdate
        AND y.time_receipt_ejr = s.time_receipt_ejr
        AND y.orig_receipt_nr_ejr = s.orig_receipt_nr_ejr
	      AND s.timestamp_begin_ejr < CASE WHEN x.transactiontype_id IN ('171','173') THEN x.timestamp_begin_ejr ELSE NULL END  -- last part is void_line_nr_ejr (SF does not accept use of alias in a subquery)
	    ) AS last_subtot_bef_void
     ,SUM(CASE WHEN x.transactiontype_id IN ('101','102','120','122') AND x.orig_receipt_serial_nr_ejr > COALESCE(x.parent_line_nr_ejr,0) THEN 1 ELSE 0 END ) OVER (PARTITION BY
           x.client_id
          ,x.store_id
          ,x.pos_terminal_id
          ,x.time_receipt_ejr
          ,x.dat_formdate
          ,x.orig_receipt_nr_ejr) AS cnt_sale_aft_void
     ,x.qty_piece_ejr
     ,x.timestamp_begin_ejr
     ,y.cnt_voided_line
     ,y.receipt_foll
	FROM (SELECT * ,RANK() OVER ( PARTITION BY client_id,store_id,checker_id,dat_formdate,orig_receipt_nr_ejr 
	                              ORDER BY timestamp_begin_ejr,orig_receipt_serial_nr_ejr) AS rank_by_timestamp
          FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_receiptline_extract) x
  INNER JOIN (
    SELECT tr_foll.* 
    ,(SELECT MIN (tr_next.orig_receipt_nr_ejr)
      FROM p_lew_mart_msi.v_ejr_all_transact_follower tr_next -- follower of current receipt
      WHERE tr_foll.client_id = tr_next.client_id
      AND tr_foll.store_id = tr_next.store_id
      AND tr_foll.pos_terminal_id = tr_next.pos_terminal_id
      AND tr_foll.dat_formdate = tr_next.dat_formdate
      AND tr_foll.checker_id = tr_next.checker_id
      AND tr_next.orig_receipt_nr_ejr > tr_foll.orig_receipt_nr_ejr
      AND tr_next.transactiontype_id NOT IN (400,405,420,425,430,480)) receipt_foll
    FROM P_LEW_MART_MSI.v_ejr_all_transact_follower tr_foll) y
    ON y.store_id = x.store_id
      AND y.client_id = x.client_id
      AND y.pos_terminal_id = x.pos_terminal_id
      AND y.dat_formdate = x.dat_formdate
      AND y.time_receipt_ejr = x.time_receipt_ejr
      AND y.orig_receipt_nr_ejr = x.orig_receipt_nr_ejr    
	  -- Join to *load_store to get only the relevant stores
    INNER JOIN P_LEW_MART_MSI.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
    ON y.store_id = revstr.store_id
      AND y.client_id = revstr.client_id
      AND y.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
	  INNER JOIN  P_LEW_MART_MSI.v_ejr_lp_threshold_receipt tr
		ON tr.client_id = y.client_id
    WHERE y.transactiontype_id = '100'
      AND y.cnt_void_ejr >= tr.void_itm_cnt
	    AND y.val_retail_ejr <> 0
	    AND (100*y.val_all_voided_line)/y.val_retail_ejr >= tr.void_tot_itm_in_receipt
      AND y.val_all_voided_line >= tr.void_tot_val_cnt
) t2
/* Look for series (subsequent lines with same item) "Doppeltipper" */
LEFT OUTER JOIN
(   SELECT
     client_id
      ,store_id
      ,pos_terminal_id
      ,dat_formdate
      ,orig_receipt_nr_ejr
      ,item_id
      ,COUNT(*) nb_in_series
      ,AVG(is_rp) AS avg_rp
      ,AVG(is_manual) AS avg_manual
      ,STDDEV(qty_piece_ejr) stdev_qty_sold  -- when 0 : all quantities are equal
      ,STDDEV(qty_weight_ejr) stdev_wgt_sold -- when 0 : all weights are equal
      ,SUM(is_scanned) is_scanned
    FROM(
    SELECT
       rle.client_id
      ,rle.store_id
      ,pos_terminal_id
      ,dat_formdate
      ,orig_receipt_nr_ejr
      ,item_id
      ,CASE WHEN (LEAD(item_id) OVER (ORDER BY rle.client_id,rle.store_id,dat_formdate,orig_receipt_nr_ejr,rank_by_timestamp)=item_id )
               OR(LAG(item_id)  OVER (ORDER BY rle.client_id,rle.store_id,dat_formdate,orig_receipt_nr_ejr,rank_by_timestamp)=item_id )
			   THEN 1 ELSE 0 END AS series
       -- this indicates whether current record is a part of series (previous or next line has the same item)
      ,CASE WHEN item_entry_method_cd_ejr='RP' THEN 1 ELSE 0 END AS is_rp
      ,CASE WHEN item_entry_method_cd_ejr='KE' THEN 1 ELSE 0 END AS is_manual
      ,qty_piece_ejr
      ,qty_weight_ejr
      ,CASE WHEN item_entry_method_cd_ejr='SC' THEN 1 ELSE 0 END AS is_scanned
	  FROM (SELECT * ,RANK() OVER ( PARTITION BY client_id,store_id,checker_id,dat_formdate,orig_receipt_nr_ejr 
	                              ORDER BY timestamp_begin_ejr,orig_receipt_serial_nr_ejr) AS rank_by_timestamp
          FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_receiptline_extract) rle
    INNER JOIN P_LEW_MART_MSI.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
    ON rle.store_id = revstr.store_id
      AND rle.client_id = revstr.client_id
      AND rle.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    WHERE transactiontype_id IN ('170','101')
   -- only voided lines
   QUALIFY series=1
  -- select only series (at least 2 subsequent receipt lines with the same item)
   )
   GROUP BY client_id
      ,store_id
      ,pos_terminal_id
      ,dat_formdate
      ,orig_receipt_nr_ejr
      ,item_id
   HAVING stdev_qty_sold = 0 
   AND stdev_wgt_sold = 0
   AND avg_rp = 0
   AND avg_manual < 1
 )rls
ON rls.client_id = t2.client_id
  AND rls.store_id = t2.store_id
  AND rls.pos_terminal_id = t2.pos_terminal_id
  AND rls.dat_formdate =  t2.dat_formdate
  AND rls.orig_receipt_nr_ejr = t2.orig_receipt_nr_ejr
  AND rls.item_id = t2.item_id

/* Ermittlung der stornierten Artikel im Folgebon */
LEFT OUTER JOIN
(
    SELECT
       rlx.client_id
      ,rlx.store_id
      ,rlx.pos_terminal_id
      ,rlx.time_receipt_ejr
      ,rlx.dat_formdate
      ,rlx.orig_receipt_nr_ejr
      ,rlx.item_id
      ,1 AS saled_item
      FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_receiptline_extract  rlx
      GROUP BY
       rlx.client_id
      ,rlx.store_id
      ,rlx.pos_terminal_id
      ,rlx.time_receipt_ejr
      ,rlx.dat_formdate
      ,rlx.orig_receipt_nr_ejr
      ,rlx.item_id
) rl
 ON rl.client_id = t2.client_id
 AND rl.store_id = t2.store_id
 AND rl.pos_terminal_id = t2.pos_terminal_id
 AND rl.dat_formdate =  t2.dat_formdate
 AND rl.orig_receipt_nr_ejr = t2.receipt_foll
 AND rl.item_id = t2.item_id
INNER JOIN  P_LEW_MART_MSI.v_ejr_lp_threshold_receipt tr
ON tr.client_id = t2.client_id

/* Bons außerhalb der Öffnungszeit */
LEFT OUTER JOIN p_lew_core_ac.v_location_hist lh1
ON t2.store_id = lh1.loc_sid
	AND t2.dat_formdate <= lh1.dwh_valid_to
    AND t2.dat_formdate >= lh1.dwh_valid_from
	
/* Stornierter Artikel wird nicht auf demselben Bon mit manuellem Rabatt verkauft */
LEFT OUTER JOIN
	(SELECT rl1.client_id
	,rl1.store_id
	,rl1.pos_terminal_id
	,rl1.dat_formdate
	,rl1.item_id
	,rl1.orig_receipt_nr_ejr
	,1 AS is_man_discount_item
	FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract rl1
	INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk ls
	ON ls.client_id                                 = rl1.client_id
		AND rl1.store_id                              = ls.store_id
	WHERE rl1.transactiontype_id IN (401,402,441,442,470,502,570,472,482,572,580,582) -- only discounts
	AND NOT ((rl1.BARCODE LIKE '55%' OR rl1.BARCODE LIKE '56%') AND LENGTH(rl1.BARCODE) BETWEEN 15 AND 17) -- exclude scanned discounts
	AND ABS(rl1.val_discount_ejr) > 0.01
	)AS rl3
ON t2.client_id                                   = rl3.client_id
  AND t2.store_id                                 = rl3.store_id
  AND t2.pos_terminal_id                          = rl3.pos_terminal_id
  AND t2.dat_formdate							                = rl3.dat_formdate
  AND t2.item_id                    			        = rl3.item_id
  AND t2.orig_receipt_nr_ejr                      = rl3.orig_receipt_nr_ejr
  AND t2.cnt_void_ejr							  > 0

WHERE t2.header_transactiontype_id = '100'
GROUP BY
  t2.client_id
  ,t2.store_id
  ,t2.pos_terminal_id
  ,t2.time_receipt_ejr
  ,t2.dat_formdate
  ,t2.orig_receipt_nr_ejr
HAVING   is_voided_value_aft_subtotal_2 = 1
  AND    is_voided_item_innext <> cnt_void
  AND    cnt_void_after_subtotal <> cnt_void
  AND    MAX(t2.cnt_void_ejr) - SUM(CASE WHEN t2.transactiontype_id IN (170,172) AND rls.stdev_qty_sold = 0 AND rls.stdev_wgt_sold = 0 AND rls.avg_rp = 0 AND rls.avg_manual < 1 AND rls.nb_in_series > 1 THEN 1 ELSE 0 END) - SUM(CASE WHEN t2.transactiontype_id IN ('171','173') AND t2.qty_piece_ejr < -50 THEN 1 ELSE 0 END) >= MAX(t2.void_itm_cnt) 
  -- no Doppeltipper or more than 50 articles.
);