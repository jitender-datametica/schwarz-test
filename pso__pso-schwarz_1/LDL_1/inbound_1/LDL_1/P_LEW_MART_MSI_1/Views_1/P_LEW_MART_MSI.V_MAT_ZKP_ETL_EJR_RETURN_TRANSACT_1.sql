/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_mat_zkp_etl_ejr_return_transact_1
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding.Michael           Initial
#  1.1  17.01.2018    Wieber.Harald            Release 2.2
#  1.2  31.01.2018    Wieber,Harald            Release 2.3
#  1.3  2018-03-16    Luca Mancini             20180319_1619_ejr_return_views_DWH_Support
#                                              New condition added in the subquery of #X_LEW_MART_MSI#.v_mat0_zkp_etl_ejr_receiptline_extract_1 rlv  -- Receiptline Verkauf
#  1.4  19.06.2018    Wandtke,Andrzej          20180419_1646_ZKP_Creation_Threshold_Team1 Add condition on return_not_authorised_val2
#  1.5  12.07.2018    Wandtke,Andrzej          20180711_1760_Add_New_Column_Rep1 Add column return_seq
#  1.6  23.05.2019    Morris, Michael          20190516_2087_ZKP_MFRB, removed line 419 to allow comparison between store_id's
#  1.7  03.07.2019    Morris, Michael          20190703_2143_ZKP_MFRGB Add new column val_return_same_receipt
#  1.8  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) - New column is_return_same_checker + logic for BBT-1649
#  1.9  07.02.2020    Morris, Michael          20200207_2376_ZKP_rtn_trns_32_45 (REP1-13043) - Corrections to: Ist der Rueckgabe-Artikel_1 auf dem Originalbon
#  1.10 20.03.2020    Rekovsky, Marvin         20200319_2433_ZKP_return_transact_price_ret_ejr (REP1-13604) - Switched val_retail_ejr for price_retail_ejr in line 102                                                                                             + die Anzahl Rueckgaben ist groesser als die Anzahl Verkaeufe
#  2.1  26.05.2020    Wandtke,Andrzej          20200526_2482_ZKP_Einzelbedienerbericht: Add columns is_return_not_dv, is_return_dv, is_return_orig_same_checker, is_return_orig_same_checker_day, is_return_no_orig_receipt
#  2.2  16.06.2020    Wandtke,Andrzej          20200526_2482_ZKP_Einzelbedienerbericht: Parts is_return_not_dv, is_return_dv: remove JOIN to Verkaufsbon
#  2.3  19.06.2020    Wandtke,Andrzej          20200618_2503_ZKP_EB_Correction: Parts is_return_not_dv, is_return_dv: add condition s_pos_terminal_id_ejr < 32767 : do not extract lines with incorrect original terminal id
#  2.4  15.09.2020    Wandtke,Andrzej          20200915_2587_ZKP_CORR_RECEIPT: Parts is_return_not_dv, is_return_dv: Apply COALESCE function so that receipts with empty source terminal number are loaded
#                                              Part is_return_no_orig_receipt: Shift INNER JOIN to NOT EXISTS clause as to enable extracting receipts with incorrect source store and register id as Ohne Originalbon
#  2.5  13.05.2021    Wandtke,Andrzej          AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: Add column is_return_sc
#  2.6  24.08.2021    Wandtke,Andrzej          AP0091650_ZKP_BTEQ - Tech tests of BTEQ : use NULL instead of '' in fields s_orig_receipt_nr_ejr, s_pos_terminal_id_ejr (1st SQL), remove CAST in CAST(rl.original_pos_terminal_id_ejr AS VARCHAR(4)) (is_return_no_orig_receipt)
#  2.7  27.06.2022    Wandtke,Andrzej          BS0011299_ZKP_CLEAN Add TRY_CAST in order to convert safely the terminal number to numerical values
#  2.8  15.12.2022    Wandtke,Andrzej          INC5590629 - Remove condition COALESCE(TRY_CAST(s_pos_terminal_id_ejr AS INTEGER), 0) < 32767
#  2.9  20.03.2023    Wandtke,Andrzej          AP0152808 : Add column is_return_no_orig_receipt_man
#  3.0  13.04.2023    Wandtke,Andrzej          AP0170366 : Add columns is_return_many_itm, is_return_same_itm_nb and section for scenario "Returns of many items with an original receipt"
#  3.1  05.06.2023    Wandtke,Andrzej          AP0169375 : Changes in scenarios "Originalbon gleicher Bediener", "Geldrückgabe nicht autorisierungspflichtig", "Manual returns with no original receipt": skip some transaction types when looking for next receipt (Folgebon), add new selection criteria
#  3.2  28.08.2023    Kowalik,Aleksander       AP0177990 : Changes in scenario "Geldrückgabe - Originalbon gleicher Bediener (manuell) BBT-1649" - ignore "KE" data input type + added statement for: gleicher Bediener/gleicher Tag_1 +not DV +manual only
#  3.3  15.09.2023    Kowalik,Aleksander       INC7050449 : Changes in scenario "Geldrückgabe ohne Originalbon (manuell)" - changed threshold application level from single line to whole receipt (AP0152808: Manual returns with no original receipt)
#  3.4  21.11.2023    Wandtke,Andrzej          INC7172504 : Changes in scenarios "Returns of many items with an original receipt" (Geldruckgabe mehrerer Artikel_1), Geldruckgaben ohne Originalbon (manuell), Geldruckgabe nicht autorisierungspflichtig, Geldruckgabe – Originalbon gleicher Tag_1 - gleicher Bediener
#                                              -substract count of deposits from count of returns : rh_gr_cnt_return_ejr-rh_gr_cnt_deposit_ejr
#  3.5  11.04.2024    Wandtke,Andrzej          AP0198055 : Changes in scenarios Geldruckgaben ohne Originalbon (manuell), Geldruckgabe nicht autorisierungspflichtig, Geldruckgabe – Originalbon gleicher Tag_1 - gleicher Bediener: 
#                                              - add 150 to exclusion list while looking for Folgebon
#                                              - filter out return transactions with Folgebon with 1 item_1 and the same sold quantity (except quantity 1)
#  3.6  03.06.2024    Roszczyk,Kamil           AP0198073 : BBT-6847, Changes in scenarios "Geldrückgabe - Originalbon gleicher Bediener (manuell)", "Geldrückgabe nicht autorisierungspflichtig", "Geldrückgaben ohne Originalbon (manuell)", "Geldrückgabe mehrerer Artikel_1 eines Originalbons"
#                                              - filter out return transactions where the return follower is a normal receipt with an exactly same amount paid in cash as in the return
#  3.7  06.05.2024    Szewczyk,Milosz          Added Doppeltipper clause to 'nicht authorisierungspflichtig' and 'originalbon gleicher bediener (manuell)'
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_RETURN_TRANSACT_1
AS
/* Pruefung: Ist der Rueckgabe-Artikel_1 auf dem Originalbon (als der Artikel_1 verkauft wurde)? */
SELECT
 rh_gr.client_id                                         AS client_id
,rh_gr.store_id                                          AS store_id
,rh_gr.pos_terminal_id                                   AS  pos_terminal_id
,rh_gr.dat_formdate                                      AS dat_formdate
,rh_gr.time_receipt_ejr                                  AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                               AS orig_receipt_nr_ejr
,rh_gr.checker_id                                        AS checker_id
,CAST(0 AS SMALLINT)                                     AS s_client_id_ejr
,'-1'                              AS s_orig_store_nr_ejr
,CAST(NULL AS DATE)                                      AS s_dat_formdate_ejr
,NULL                                AS s_orig_receipt_nr_ejr
,NULL                                AS s_pos_terminal_id_ejr
,rl.item_id                                              AS item_id
,CAST(0 AS INTEGER)                                      AS cnt_return_item
,rh_gr.dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(1 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,CAST(0 AS SMALLINT)                                     AS return_seq
,CAST(0 AS DECIMAL(18,4))                                AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr           /* Geldrueckgaben       */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl          /* Geldrueckgabe Zeilen */
ON rh_gr.client_id                  = rl.client_id
  AND rh_gr.store_id                = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
  AND rh_gr.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr   /* Pruefung der Filiale  ,ob fuer Beladung relevant */
ON rh_gr.client_id                  = st_pr.client_id
  AND rh_gr.store_id                = st_pr.store_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st      /* Ermittlung der store_id fuer Verkaufsbon */
ON rl.client_id                     = st.client_id
  AND rl.original_orig_store_nr_ejr = st.orig_store_nr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_vb     /* Verkaufsbon */
ON rh_vb.client_id                  = rl.client_id
  AND rh_vb.store_id                = st.store_id
  AND rh_vb.orig_receipt_nr_ejr     = rl.original_orig_receipt_nr_ejr
  AND rh_vb.pos_terminal_id         = rl.original_pos_terminal_id_ejr
  AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 tr
ON tr.client_id = rh_gr.client_id
WHERE rh_gr.transactiontype_id = '150'                                         /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
  AND rh_vb.transactiontype_id = '100'
  AND rl.transactiontype_id BETWEEN '140'   AND '149'                          /* Filter Geldrueckgaben-Zeilen */
  AND NOT EXISTS
(SELECT
1
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rlv        /* Receiptline Verkauf */
WHERE  rh_vb.client_id             = rlv.client_id
     AND rh_vb.store_id            = rlv.store_id
     AND rh_vb.orig_receipt_nr_ejr = rlv.orig_receipt_nr_ejr
     AND rh_vb.pos_terminal_id     = rlv.pos_terminal_id
     AND rh_vb.dat_formdate        = rlv.dat_formdate
     AND rl.item_id                = rlv.item_id
     AND rlv.transactiontype_id BETWEEN '101' AND '102'               /* Verkaufszeilen */ /* Verkaufszeilen */
)
AND rl.price_retail_ejr > tr.return_tot_val

UNION ALL

/* Pruefung: Der Rueckgabe-Artikel_1 ist auf dem Originalbon ,aber die Anzahl Rueckgaben ist groesser als die Anzahl Verkaeufe. */
SELECT
 returnx.client_id
,returnx.store_id
,returnx.pos_terminal_id
,returnx.dat_formdate
,returnx.time_receipt_ejr
,returnx.orig_receipt_nr_ejr
,returnx.checker_id
,returnx.s_client_id_ejr
,returnx.s_orig_store_nr_ejr
,returnx.s_dat_formdate_ejr
,returnx.s_orig_receipt_nr_ejr
,returnx.s_pos_terminal_id_ejr
,returnx.item_id
,returnx.cnt_return_item
,returnx.dat_last_returndate
,salex.cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(1 AS INTEGER)                                      AS is_returned_gt_original
,CASE WHEN     returnx.dat_formdate = returnx.dat_last_returndate
             AND returnx.time_receipt_ejr = returnx.last_time_receipt_ejr THEN CAST(1 AS INTEGER)
ELSE 0 END                                         AS cnt_returned_gt_original
,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,CAST(0 AS SMALLINT)                                     AS return_seq
,CAST(0 AS DECIMAL(18,4))                                AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM
(SELECT DISTINCT
 x1.client_id
,x1.store_id
,x1.pos_terminal_id
,x1.dat_formdate
,x1.time_receipt_ejr
,x1.orig_receipt_nr_ejr
,x1.checker_id
,x1.s_client_id_ejr
,x1.s_orig_store_nr_ejr
,x1.s_dat_formdate_ejr
,x1.s_orig_receipt_nr_ejr
,x1.s_pos_terminal_id_ejr
,x1.item_id
,SUM(ABS(x1.cnt_return_item)) OVER (PARTITION BY
                      x1.s_client_id_ejr
                      ,x1.s_orig_store_nr_ejr
                      ,x1.s_dat_formdate_ejr
                      ,x1.s_orig_receipt_nr_ejr
                      ,x1.s_pos_terminal_id_ejr
                      ,x1.client_id
                      ,x1.store_id
                      ,x1.checker_id
                      ,x1.item_id)                         AS cnt_return_item
,MAX(x1.time_receipt_ejr) OVER (PARTITION BY
                      x1.s_client_id_ejr
                      ,x1.s_orig_store_nr_ejr
                      ,x1.s_dat_formdate_ejr
                      ,x1.s_orig_receipt_nr_ejr
                      ,x1.s_pos_terminal_id_ejr
                      ,x1.client_id
                      ,x1.store_id
                      ,x1.checker_id
                      ,x1.item_id)                         AS last_time_receipt_ejr
,MAX(x1.dat_formdate) OVER (PARTITION BY
                      x1.s_client_id_ejr
                      ,x1.s_orig_store_nr_ejr
                      ,x1.s_dat_formdate_ejr
                      ,x1.s_orig_receipt_nr_ejr
                      ,x1.s_pos_terminal_id_ejr
                      ,x1.client_id
                      ,x1.store_id
                      ,x1.checker_id
                      ,x1.item_id)                         AS dat_last_returndate
FROM
(SELECT DISTINCT
 temp.client_id
,temp.store_id
,temp.pos_terminal_id
,temp.dat_formdate
,temp.time_receipt_ejr
,temp.orig_receipt_nr_ejr
,temp.checker_id
,temp.s_client_id_ejr
,temp.s_orig_store_nr_ejr
,temp.s_dat_formdate_ejr
,temp.s_orig_receipt_nr_ejr
,temp.s_pos_terminal_id_ejr
,temp.item_id
,temp.r_orig_receipt_serial_nr_ejr
,temp.cnt_return_item
FROM
(SELECT
 rh_gr.client_id                             AS client_id
,rh_gr.store_id                              AS store_id
,rh_gr.pos_terminal_id                       AS pos_terminal_id
,rh_gr.dat_formdate                          AS dat_formdate
,rh_gr.time_receipt_ejr                      AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                   AS orig_receipt_nr_ejr
,rh_gr.checker_id                            AS checker_id
,rl.client_id                                AS s_client_id_ejr
,rl.original_orig_store_nr_ejr               AS s_orig_store_nr_ejr
,rl.original_dat_formdate_ejr                AS s_dat_formdate_ejr
,rl.original_orig_receipt_nr_ejr             AS s_orig_receipt_nr_ejr
,rl.original_pos_terminal_id_ejr             AS s_pos_terminal_id_ejr
,rl.item_id
,rl.orig_receipt_serial_nr_ejr               AS r_orig_receipt_serial_nr_ejr
,rl.qty_piece_ejr                            AS cnt_return_item
,rlv.qty_piece_ejr                           AS cnt_sale_item
,rlv.orig_receipt_serial_nr_ejr              AS s_orig_receipt_serial_nr_ejr
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr   /* Geldrueckgaben        */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl  /* Geldrueckgaben-Zeilen */
ON rh_gr.client_id               = rl.client_id
AND rh_gr.store_id                = rl.store_id
AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
AND rh_gr.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr /* Pruefung der Filiale  ,ob fuer Beladung relevant */
ON rh_gr.client_id               = st_pr.client_id
AND rh_gr.store_id                = st_pr.store_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1  st   /* Ermittlung der store_id fuer Verkaufsbon */
ON rl.client_id                  = st.client_id
AND rl.original_orig_store_nr_ejr = st.orig_store_nr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_vb   /* Verkaufsbon */
ON rh_vb.client_id                                 = rl.client_id
AND rh_vb.store_id                                  = st.store_id
AND rh_vb.orig_receipt_nr_ejr = rl.original_orig_receipt_nr_ejr
AND rh_vb.pos_terminal_id     = rl.original_pos_terminal_id_ejr
AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rlv       /* Receiptline Verkauf */
ON rh_vb.client_id                                 = rlv.client_id
AND rh_vb.store_id                                  = rlv.store_id
AND rh_vb.orig_receipt_nr_ejr                       = rlv.orig_receipt_nr_ejr
AND rh_vb.pos_terminal_id                           = rlv.pos_terminal_id
AND rh_vb.dat_formdate                              = rlv.dat_formdate
AND rl.item_id                                      = rlv.item_id
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 tr
ON tr.client_id                                    =   rh_gr.client_id
WHERE rh_gr.transactiontype_id                        = '150'                /* Filter Geldrueckgaben (Header-transactiontype_id = '150') */
AND ABS(rh_gr.val_retail_ejr)                       > tr.return_tot_val
AND rh_vb.transactiontype_id                        = '100'                /* Filter Verkaufsbon           */
AND rl.transactiontype_id  BETWEEN '140'   AND '149'                       /* Filter Geldrueckgaben-Zeilen */
AND rlv.transactiontype_id BETWEEN '101'   AND '102'                       /* Nur Verkaufszeilen           */ /* Nur Verkaufszeilen           */
) temp
) x1
) returnx
INNER JOIN
(SELECT DISTINCT
 x2.s_client_id_ejr
,x2.s_orig_store_nr_ejr
,x2.s_dat_formdate_ejr
,x2.s_orig_receipt_nr_ejr
,x2.s_pos_terminal_id_ejr
,x2.item_id
,SUM((x2.cnt_sale_item)) OVER (PARTITION BY
                      x2.s_client_id_ejr
                      ,x2.s_orig_store_nr_ejr
                      ,x2.s_dat_formdate_ejr
                      ,x2.s_orig_receipt_nr_ejr
                      ,x2.s_pos_terminal_id_ejr
                      ,x2.client_id
                      ,x2.store_id
                      ,x2.checker_id
                      ,x2.item_id)                         AS cnt_sale_item
FROM
(SELECT DISTINCT
 temp.s_client_id_ejr
,temp.s_orig_store_nr_ejr
,temp.s_dat_formdate_ejr
,temp.s_orig_receipt_nr_ejr
,temp.s_pos_terminal_id_ejr
,temp.client_id
,temp.store_id
,temp.checker_id
,temp.item_id
,temp.s_orig_receipt_serial_nr_ejr
,temp.cnt_sale_item
FROM
(SELECT
 rh_gr.client_id                             AS client_id
,rh_gr.store_id                              AS store_id
,rh_gr.pos_terminal_id                       AS pos_terminal_id
,rh_gr.dat_formdate                          AS dat_formdate
,rh_gr.time_receipt_ejr                      AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                   AS orig_receipt_nr_ejr
,rh_gr.checker_id                            AS checker_id
,rl.client_id                                AS s_client_id_ejr
,rl.original_orig_store_nr_ejr               AS s_orig_store_nr_ejr
,rl.original_dat_formdate_ejr                AS s_dat_formdate_ejr
,rl.original_orig_receipt_nr_ejr             AS s_orig_receipt_nr_ejr
,rl.original_pos_terminal_id_ejr             AS s_pos_terminal_id_ejr
,rl.item_id
,rl.orig_receipt_serial_nr_ejr               AS r_orig_receipt_serial_nr_ejr
,rl.qty_piece_ejr                            AS cnt_return_item
,rlv.qty_piece_ejr                           AS cnt_sale_item
,rlv.orig_receipt_serial_nr_ejr              AS s_orig_receipt_serial_nr_ejr
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr         /* Geldrueckgaben */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl        /* Geldrueckgaben-Zeilen */
ON rh_gr.client_id                                 = rl.client_id
AND rh_gr.store_id                                  = rl.store_id
AND rh_gr.orig_receipt_nr_ejr                       = rl.orig_receipt_nr_ejr
AND rh_gr.pos_terminal_id                           = rl.pos_terminal_id
AND rh_gr.time_receipt_ejr                          = rl.time_receipt_ejr
AND rh_gr.dat_formdate                              = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr /* Pruefung der Filiale  ,ob fuer Beladung relevant */
ON rh_gr.client_id                                 = st_pr.client_id
AND rh_gr.store_id                                  = st_pr.store_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1  st   /* Ermittlung der store_id fuer Verkaufsbon */
ON rl.client_id                                    = st.client_id
AND rl.original_orig_store_nr_ejr                   = st.orig_store_nr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_vb   /* Verkaufsbon */
ON rh_vb.client_id                                 = rl.client_id
AND rh_vb.store_id                                  = st.store_id
AND rh_vb.orig_receipt_nr_ejr  = rl.original_orig_receipt_nr_ejr
AND rh_vb.pos_terminal_id      = rl.original_pos_terminal_id_ejr
AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rlv       /* Receiptline Verkauf */
ON rh_vb.client_id                                 = rlv.client_id
AND rh_vb.store_id                                  = rlv.store_id
AND rh_vb.orig_receipt_nr_ejr                       = rlv.orig_receipt_nr_ejr
AND rh_vb.pos_terminal_id                           = rlv.pos_terminal_id
AND rh_vb.dat_formdate                              = rlv.dat_formdate
AND rl.item_id                                      = rlv.item_id
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 tr
ON tr.client_id                                    =   rh_gr.client_id
WHERE rh_gr.transactiontype_id                        = '150'                /* Filter Geldrueckgaben (Header-transactiontype_id = '150') */
AND ABS(rh_gr.val_retail_ejr)                       > tr.return_tot_val
AND rh_vb.transactiontype_id                        = '100'                /* Filter Verkaufsbon */
AND rl.transactiontype_id BETWEEN '140'    AND '149'                       /* Filter Geldrueckgaben-Zeilen */
AND rlv.transactiontype_id BETWEEN '101'   AND '102'                       /* Nur Verkaufszeilen           */ /* Nur Verkaufszeilen           */
) temp
) x2
) salex
ON returnx.s_client_id_ejr       = salex.s_client_id_ejr
AND returnx.s_orig_store_nr_ejr   = salex.s_orig_store_nr_ejr
AND returnx.s_dat_formdate_ejr    = salex.s_dat_formdate_ejr
AND returnx.s_orig_receipt_nr_ejr = salex.s_orig_receipt_nr_ejr
AND returnx.s_pos_terminal_id_ejr = salex.s_pos_terminal_id_ejr
AND returnx.item_id               = salex.item_id
WHERE COALESCE(ABS(salex.cnt_sale_item), 0)           > 0
AND COALESCE(ABS(salex.cnt_sale_item), 0)           < returnx.cnt_return_item
UNION ALL
/* Mehrfach GeldrÃ¼ckgabe mit orginalbon */
SELECT
 rets.client_id
,rets.store_id
,rets.pos_terminal_id
,rets.dat_formdate
,rets.time_receipt_ejr
,rets.orig_receipt_nr_ejr
,rets.checker_id
,rets.s_client_id_ejr
,rets.s_orig_store_nr_ejr
,rets.s_dat_formdate_ejr
,CAST(rets.s_orig_receipt_nr_ejr AS VARCHAR(100))        AS s_orig_receipt_nr_ejr
,CAST(rets.s_pos_terminal_id_ejr AS VARCHAR(100))        AS s_pos_terminal_id_ejr
,CAST(-1 AS INTEGER)                                     AS item_id
,CAST(0 AS INTEGER)                                      AS cnt_return_item
,rets.dat_formdate                                       AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,CAST(SUM(rets.cnt_return_same_receipt) OVER (
                    PARTITION BY
                      rets.s_client_id_ejr
                      ,rets.s_orig_store_nr_ejr
                      ,rets.s_dat_formdate_ejr
                      ,rets.s_orig_receipt_nr_ejr
                      ,rets.s_pos_terminal_id_ejr
                ) AS DECIMAL(18,4))                        AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,CAST(RANK() OVER (PARTITION BY
                      rets.client_id
                     ,rets.s_orig_store_nr_ejr
                     ,rets.s_dat_formdate_ejr
                     ,rets.s_orig_receipt_nr_ejr
                     ,rets.s_pos_terminal_id_ejr
     ORDER BY   rets.dat_formdate
              , rets.time_receipt_ejr) AS SMALLINT)        AS return_seq
,rets.r_val_retail_ejr                                   AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM
(SELECT DISTINCT
 rh_gr.client_id                                     AS client_id
,rh_gr.store_id                                      AS store_id
,rh_gr.pos_terminal_id                               AS pos_terminal_id
,rh_gr.dat_formdate                                  AS dat_formdate
,rh_gr.time_receipt_ejr                              AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                           AS orig_receipt_nr_ejr
,rh_gr.checker_id                                    AS checker_id
,rh_vb.client_id                                     AS s_client_id_ejr
,rl.original_orig_store_nr_ejr                       AS s_orig_store_nr_ejr
,rh_vb.dat_formdate                                  AS s_dat_formdate_ejr
,rh_vb.orig_receipt_nr_ejr                           AS s_orig_receipt_nr_ejr
,rh_vb.pos_terminal_id                               AS s_pos_terminal_id_ejr
,SUM(ABS(rl.val_retail_ejr)) OVER (
          PARTITION BY
             rh_gr.client_id
            ,rh_gr.store_id
            ,rh_gr.dat_formdate
            ,rh_gr.orig_receipt_nr_ejr
            ,rh_gr.pos_terminal_id
            ,rh_gr.time_receipt_ejr
      )                                                    AS r_val_retail_ejr
,CAST(1 AS DECIMAL(18,4))                            AS cnt_return_same_receipt
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_gr              /* Geldrueckgaben  */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS rl             /* Geldrueckgaben Zeilen */
ON rh_gr.client_id                                 = rl.client_id
AND rh_gr.store_id                                  = rl.store_id
AND rh_gr.orig_receipt_nr_ejr                       = rl.orig_receipt_nr_ejr
AND rh_gr.pos_terminal_id                           = rl.pos_terminal_id
AND rh_gr.time_receipt_ejr                          = rl.time_receipt_ejr
AND rh_gr.dat_formdate                              = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st_pr      /* Pruefung der Filiale  ,ob fuer Beladung relevant */
ON rh_gr.client_id                                 = st_pr.client_id
AND rh_gr.store_id                                  = st_pr.store_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st         /* Ermittlung der store_id fuer Verkaufsbon */
ON rl.client_id                                    = st.client_id
AND rl.original_orig_store_nr_ejr                   = st.orig_store_nr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb        /* Verkaufsbon */
ON rh_vb.client_id                                 = rl.client_id
AND rh_vb.store_id                                  = st.store_id
AND rh_vb.orig_receipt_nr_ejr = rl.original_orig_receipt_nr_ejr
AND rh_vb.pos_terminal_id     = rl.original_pos_terminal_id_ejr
AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS tr
ON tr.client_id                                    = rh_gr.client_id
WHERE rh_gr.transactiontype_id                        = '150'                        /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
AND rh_vb.transactiontype_id                        = '100'
AND rl.transactiontype_id BETWEEN '140'   AND '149'                                /* Filter Geldrueckgaben-Zeilen */ /* Filter Geldrueckgaben-Zeilen */
) AS rets
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS tr
ON tr.client_id = rets.client_id
QUALIFY SUM(rets.cnt_return_same_receipt) OVER (
PARTITION BY
  rets.s_client_id_ejr
  ,rets.s_orig_store_nr_ejr
  ,rets.s_dat_formdate_ejr
  ,rets.s_orig_receipt_nr_ejr
  ,rets.s_pos_terminal_id_ejr
) >= tr.return_same_receipt_qty
AND MAX(rets.r_val_retail_ejr) OVER (
PARTITION BY
  rets.s_client_id_ejr
  ,rets.s_orig_store_nr_ejr
  ,rets.s_dat_formdate_ejr
  ,rets.s_orig_receipt_nr_ejr
  ,rets.s_pos_terminal_id_ejr
) >= tr.return_same_receipt_val
UNION ALL
/* Geldruckgabe nicht autorisierungspflichtig */
SELECT
 rh_gr_client_id
,rh_gr_store_id
,rh_gr_pos_terminal_id
,rh_gr_dat_formdate
,time_receipt_ejr
,rh_gr_orig_receipt_nr_ejr
,checker_id
,s_client_id_ejr
,s_orig_store_nr_ejr
,s_dat_formdate_ejr
,CAST(s_orig_receipt_nr_ejr AS VARCHAR(100))             AS s_orig_receipt_nr_ejr
,CAST(s_pos_terminal_id_ejr AS VARCHAR(100))             AS s_pos_terminal_id_ejr
,CAST(-1 AS INTEGER)                                     AS item_id
,(SELECT COUNT(item_id)
  FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub -- items of current receipt
  WHERE rh_gr_client_id          = rl_sub.client_id
  AND rh_gr_store_id                = rl_sub.store_id
  AND rh_gr_orig_receipt_nr_ejr  = rl_sub.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = rl_sub.pos_terminal_id
  AND rh_gr_dat_formdate            = rl_sub.dat_formdate
  AND rl_sub.transactiontype_id BETWEEN '140' AND '149'
  AND CONTAINS(items_foll_rec, rl_sub.item_id)
) AS cnt_return_item
,rh_gr_dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
,CAST(1 AS BYTEINT)                                      AS is_return_not_authorised
,0                                                       AS return_seq
,CAST(0 AS BYTEINT)                                      AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM( 
SELECT DISTINCT
 rets.rh_gr_client_id
,rets.rh_gr_store_id
,rets.rh_gr_pos_terminal_id
,rets.rh_gr_dat_formdate
,rets.time_receipt_ejr
,rets.rh_gr_orig_receipt_nr_ejr
,rets.checker_id
,rets.s_client_id_ejr
,rets.s_orig_store_nr_ejr
,rets.s_dat_formdate_ejr
,rets.s_orig_receipt_nr_ejr        AS s_orig_receipt_nr_ejr
,rets.s_pos_terminal_id_ejr        AS s_pos_terminal_id_ejr
,rets.rh_gr_dat_formdate                                 AS dat_last_returndate
,CAST(RANK() OVER (PARTITION BY
                      rets.rh_gr_client_id
                     ,rets.s_orig_store_nr_ejr
                     ,rets.s_dat_formdate_ejr
                     ,rets.s_orig_receipt_nr_ejr
                     ,rets.s_pos_terminal_id_ejr
                     ,rets.checker_id
     ORDER BY   rets.rh_gr_dat_formdate
              , rets.time_receipt_ejr) AS SMALLINT)      AS return_seq
,rets.r_val_retail_ejr           
,(SELECT LISTAGG(DISTINCT rl_sub.item_id, ' ')
  FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub -- items of following receipt
  WHERE rh_gr_client_id          = rl_sub.client_id
  AND rh_gr_store_id                = rl_sub.store_id
  AND receipt_foll  = rl_sub.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = rl_sub.pos_terminal_id
  AND rh_gr_dat_formdate            = rl_sub.dat_formdate) items_foll_rec
,rh_gr_cnt_return_ejr
,rh_gr_cnt_deposit_ejr
,tr_next.cnt_sell_item AS tr_next_cnt_sell_item
,tr_next.qty_piece_ejr AS tr_next_qty_piece_ejr
,rh_gr_qty_return_ejr AS rh_gr_qty_return_ejr
,rl_qty_weight_ejr AS rl_qty_weight_ejr
,rl_weight_item_fg AS rl_weight_item_fg
FROM
(SELECT DISTINCT
 rh_gr.client_id                                     AS rh_gr_client_id
,rh_gr.store_id                                      AS rh_gr_store_id
,rh_gr.pos_terminal_id                               AS rh_gr_pos_terminal_id
,rh_gr.dat_formdate                                  AS rh_gr_dat_formdate
,rh_gr.time_receipt_ejr                              AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                           AS rh_gr_orig_receipt_nr_ejr
,rh_gr.checker_id                                    AS checker_id
,rh_vb.client_id                                     AS s_client_id_ejr
,rl.original_orig_store_nr_ejr                       AS s_orig_store_nr_ejr
,rh_vb.dat_formdate                                  AS s_dat_formdate_ejr
,rh_vb.orig_receipt_nr_ejr                           AS s_orig_receipt_nr_ejr
,rh_vb.pos_terminal_id                               AS s_pos_terminal_id_ejr
,SUM(ABS(rl.val_retail_ejr)) OVER (
          PARTITION BY
             rh_gr.client_id
            ,rh_gr.store_id
            ,rh_gr.dat_formdate
            ,rh_gr.orig_receipt_nr_ejr
            ,rh_gr.pos_terminal_id
            ,rh_gr.time_receipt_ejr
           )                                        AS r_val_retail_ejr
,(SELECT MIN (tr_next.orig_receipt_nr_ejr)
  FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- follower of current receipt
  WHERE rh_gr.client_id = tr_next.client_id
  AND rh_gr.store_id = tr_next.store_id
  AND rh_gr.pos_terminal_id = tr_next.pos_terminal_id
  AND rh_gr.dat_formdate = tr_next.dat_formdate
  AND rh_gr.checker_id = tr_next.checker_id
  AND tr_next.orig_receipt_nr_ejr > rh_gr.orig_receipt_nr_ejr
  AND tr_next.transactiontype_id NOT IN (150, 400, 405, 420, 425, 430, 480)) receipt_foll
,rl.original_orig_receipt_nr_ejr rl_original_orig_receipt_nr_ejr
,rl.original_pos_terminal_id_ejr rl_original_pos_terminal_id_ejr
,rl.original_dat_formdate_ejr rl_original_dat_formdate_ejr
,rl.original_orig_store_nr_ejr rl_original_orig_store_nr_ejr
,rl.qty_weight_ejr rl_qty_weight_ejr
,rl.weight_item_fg rl_weight_item_fg
,(SELECT MIN (tr_next.orig_receipt_nr_ejr)
  FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- follower of original receipt
  WHERE rl.client_id = tr_next.client_id
  AND st.store_id = tr_next.store_id
  AND rl.original_pos_terminal_id_ejr  = tr_next.pos_terminal_id
  AND rl.original_dat_formdate_ejr = tr_next.dat_formdate
  AND tr_next.orig_receipt_nr_ejr > rl.original_orig_receipt_nr_ejr
  AND tr_next.transactiontype_id NOT IN (150, 400, 405, 420, 425, 430, 480)) orig_receipt_foll
,st.store_id st_orig_store_id
,rh_gr.val_retail_ejr rh_gr_val_retail_ejr
,rh_gr.cnt_return_ejr rh_gr_cnt_return_ejr
,rh_gr.cnt_deposit_ejr rh_gr_cnt_deposit_ejr
,rh_gr.qty_return_ejr rh_gr_qty_return_ejr
					  
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_gr                        /* Geldrueckgaben */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS rl                       /* Geldrueckgaben Zeilen */
ON rh_gr.client_id                                 = rl.client_id
AND rh_gr.store_id                                  = rl.store_id
AND rh_gr.orig_receipt_nr_ejr                       = rl.orig_receipt_nr_ejr
AND rh_gr.pos_terminal_id                           = rl.pos_terminal_id
AND rh_gr.time_receipt_ejr                          = rl.time_receipt_ejr
AND rh_gr.dat_formdate                              = rl.dat_formdate
AND rl.authority_id                                   IS NULL
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st_pr   /* Pruefung der Filiale  ,ob fuer Beladung relevant */
ON rh_gr.client_id                                 = st_pr.client_id
AND rh_gr.store_id                                  = st_pr.store_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st          /* Ermittlung der store_id fuer Verkaufsbon */
ON rl.client_id                                    = st.client_id
AND rl.original_orig_store_nr_ejr                   = st.orig_store_nr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb                  /* Verkaufsbon */
ON rh_vb.client_id                                 = rl.client_id
AND rh_vb.store_id                                  = st.store_id
AND rh_vb.orig_receipt_nr_ejr                       = rl.original_orig_receipt_nr_ejr
AND rh_vb.pos_terminal_id                           = rl.original_pos_terminal_id_ejr
AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
LEFT OUTER JOIN /* Doppeltipper */
(SELECT
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
      ,1 AS is_doppeltipper
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
       -- this indicates whether current record is a part of series (previous or next line has the same item_1)
      ,CASE WHEN item_entry_method_cd_ejr='RP' THEN 1 ELSE 0 END AS is_rp
      ,CASE WHEN item_entry_method_cd_ejr='KE' THEN 1 ELSE 0 END AS is_manual
      ,qty_piece_ejr
      ,qty_weight_ejr
      ,CASE WHEN item_entry_method_cd_ejr='SC' THEN 1 ELSE 0 END AS is_scanned
	  FROM (SELECT * ,RANK() OVER ( PARTITION BY client_id,store_id,checker_id,dat_formdate,orig_receipt_nr_ejr 
	                              ORDER BY timestamp_begin_ejr,orig_receipt_serial_nr_ejr) AS rank_by_timestamp
          FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_receiptline_extract_1) rle
    INNER JOIN P_LEW_MART_MSI.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr
    ON rle.store_id = revstr.store_id
      AND rle.client_id = revstr.client_id
      AND rle.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    WHERE transactiontype_id BETWEEN '140' AND '149'
        OR transactiontype_id = '101'
   -- only return lines
   QUALIFY series=1
  -- select only series (at least 2 subsequent receipt lines with the same item_1)
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
) AS dopp
ON dopp.client_id                                 = rh_vb.client_id
AND dopp.store_id                                  = rh_vb.store_id
AND dopp.orig_receipt_nr_ejr                       = rh_vb.orig_receipt_nr_ejr
AND dopp.pos_terminal_id                           = rh_vb.pos_terminal_id
AND dopp.dat_formdate                              = rh_vb.dat_formdate
AND dopp.item_id									= rl.item_id
/* Doppeltipper END */
WHERE rh_gr.transactiontype_id                        = '150'         /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
AND rh_vb.transactiontype_id                        = '100'
AND rl.transactiontype_id BETWEEN '140' AND '149'               /* Filter Geldrueckgaben-Zeilen */ 
AND (COALESCE(dopp.is_doppeltipper,0) = 0 OR rh_gr.cnt_return_ejr > 1) /*Filter doppeltippers out */
) AS rets
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS tr
ON tr.client_id             = rets.rh_gr_client_id
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- next receipt
  ON rh_gr_client_id                = tr_next.client_id
  AND rh_gr_store_id                = tr_next.store_id
  AND receipt_foll                  = tr_next.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = tr_next.pos_terminal_id
  AND rh_gr_dat_formdate            = tr_next.dat_formdate
INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_orig_next -- next receipt after original receipt
  ON s_client_id_ejr                  = tr_orig_next.client_id
  AND st_orig_store_id                = tr_orig_next.store_id
  AND orig_receipt_foll               = tr_orig_next.orig_receipt_nr_ejr
  AND s_pos_terminal_id_ejr           = tr_orig_next.pos_terminal_id
  AND s_dat_formdate_ejr              = tr_orig_next.dat_formdate
LEFT OUTER JOIN													/* Join to the header and receipt line views with a filter which, apart from standard return lines, includes also returned deposits (transactiontype_id = 120) that take part in Bonsumme calculations - BBT-6847 */
	(
		SELECT
			rl.store_id
			, rl.client_id
			, rl.pos_terminal_id
			, rl.dat_formdate
			, rl.orig_receipt_nr_ejr
			, SUM(COALESCE(rl.val_retail_ejr, 0)) AS total_value
		FROM
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr
		INNER JOIN
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
				ON rh_gr.client_id = rl.client_id
				AND rh_gr.store_id = rl.store_id
				AND rh_gr.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
				AND rh_gr.pos_terminal_id = rl.pos_terminal_id
				AND rh_gr.time_receipt_ejr = rl.time_receipt_ejr
				AND rh_gr.dat_formdate = rl.dat_formdate
		WHERE
			(rl.transactiontype_id BETWEEN 140 AND 149
			OR rl.transactiontype_id = 120)
			AND rh_gr.transactiontype_id = 150
		GROUP BY
			rl.store_id
			, rl.client_id
			, rl.pos_terminal_id
			, rl.dat_formdate
			, rl.orig_receipt_nr_ejr
	) tval
		ON rets.rh_gr_client_id = tval.client_id
		AND rets.rh_gr_store_id = tval.store_id
		AND rets.rh_gr_orig_receipt_nr_ejr = tval.orig_receipt_nr_ejr
		AND rets.rh_gr_pos_terminal_id = tval.pos_terminal_id
		AND rets.rh_gr_dat_formdate = tval.dat_formdate
LEFT OUTER JOIN													/* Join to the payment type table to fetch cash payments and merge with the return receipt's follower - BBT-6847 */
	(
		SELECT
			store_id
			, client_id
			, pos_terminal_id
			, dat_formdate
			, time_receipt_ejr
			, orig_receipt_nr_ejr
			, val_retail_payment_ejr
		FROM
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_1
		WHERE
			tendertype_cd_ejr = 11
			AND cnt_payment_ejr = 1
		QUALIFY
			ROW_NUMBER() OVER(PARTITION BY store_id, client_id, pos_terminal_id, dat_formdate, time_receipt_ejr, orig_receipt_nr_ejr ORDER BY orig_receipt_serial_nr_ejr) = 1
	) pmt
  ON tr_next.store_id = pmt.store_id
  AND tr_next.client_id = pmt.client_id
  AND tr_next.pos_terminal_id = pmt.pos_terminal_id
  AND tr_next.dat_formdate = pmt.dat_formdate
  AND tr_next.time_receipt_ejr = pmt.time_receipt_ejr
  AND tr_next.orig_receipt_nr_ejr = pmt.orig_receipt_nr_ejr
  WHERE ABS(rh_gr_val_retail_ejr) <> tr_next.val_retail_ejr
  -- Wert der Geldrückgabe (Bonsumme) ist nicht gleich wie die Bonsumme des Folgebons nach der Geldrückgabe
  AND ABS(rh_gr_val_retail_ejr) <> tr_orig_next.val_retail_ejr
  -- Wert der Geldrückgabe (Bonsumme) ist nicht gleich wie die Bonsumme des Folgebons nach dem dazugehörigen Originalbon
  AND
  (
  /* Below:
    Both thresholds filled -> give values BETWEN AND  */
  (rets.r_val_retail_ejr <= tr.return_not_authorised_val AND rets.r_val_retail_ejr > tr.return_not_authorised_val2)
  OR
  /* Below:
    One threshold filled */
  (rets.r_val_retail_ejr <= COALESCE(tr.return_not_authorised_val, 99999999999999) AND rets.r_val_retail_ejr > tr.return_not_authorised_val2)
  OR
  /* Below:
    One threshold filled */
  (rets.r_val_retail_ejr <= tr.return_not_authorised_val AND rets.r_val_retail_ejr > COALESCE(tr.return_not_authorised_val2,0))
  /* Both thresholds are null: no clause is true so give no results */
  )
  /* Filter out rows where the return amount is the same as the amount paid in cash in the next receipt - BBT-6847 */
  AND COALESCE(pmt.val_retail_payment_ejr, 0) <> ABS(tval.total_value)
)


  WHERE cnt_return_item < rh_gr_cnt_return_ejr-rh_gr_cnt_deposit_ejr
  -- Count of cases that item_1 sales_1 on next receipt has to be lower than total number of position on return 
  -- (Alle Rückgabeartikel sind nicht auf dem Folgebon nach der Geldrückgabe) 
  AND (NVL(tr_next_cnt_sell_item,0) > 1
       OR rh_gr_cnt_return_ejr - rh_gr_cnt_deposit_ejr > 1 
       OR NVL(tr_next_qty_piece_ejr,0) <> ABS(CASE WHEN rl_weight_item_fg=1 THEN rl_qty_weight_ejr ELSE rh_gr_qty_return_ejr END)
       OR (NVL(tr_next_qty_piece_ejr,0) = 1 AND ABS(CASE WHEN rl_weight_item_fg=1 THEN rl_qty_weight_ejr ELSE rh_gr_qty_return_ejr END) = 1))
-- Exclude returns with Folgebon with the same sold quantity (except quantity 1)
UNION ALL
/* GelrÃ¼ckgaben - Originalbon gleicher Bediener (manuell) BBT-1649 */
SELECT
 rh_gr_client_id
,rh_gr_store_id
,rh_gr_pos_terminal_id
,rh_gr_dat_formdate
,time_receipt_ejr
,rh_gr_orig_receipt_nr_ejr
,checker_id
,s_client_id_ejr
,s_orig_store_nr_ejr
,s_dat_formdate_ejr
,CAST(s_orig_receipt_nr_ejr AS VARCHAR(100))        AS s_orig_receipt_nr_ejr
,CAST(s_pos_terminal_id_ejr AS VARCHAR(100))        AS s_pos_terminal_id_ejr
,CAST(-1 AS INTEGER)                                AS item_id
,(SELECT COUNT(item_id)
  FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub -- items of current receipt
  WHERE rh_gr_client_id          = rl_sub.client_id
  AND rh_gr_store_id                = rl_sub.store_id
  AND rh_gr_orig_receipt_nr_ejr  = rl_sub.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = rl_sub.pos_terminal_id
  AND rh_gr_dat_formdate            = rl_sub.dat_formdate
  AND rl_sub.transactiontype_id BETWEEN '140' AND '149'
  AND CONTAINS(items_foll_rec, rl_sub.item_id)
) cnt_return_item
,rh_gr_dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,cnt_return_same_receipt                                 AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,return_seq                                              AS return_seq
,r_val_retail_ejr                                        AS val_return_same_receipt
,CAST(1 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM( 
SELECT DISTINCT
 rets.rh_gr_client_id
,rets.rh_gr_store_id
,rets.rh_gr_pos_terminal_id
,rets.rh_gr_dat_formdate
,rets.time_receipt_ejr
,rets.rh_gr_orig_receipt_nr_ejr
,rets.checker_id
,rets.s_client_id_ejr
,rets.s_orig_store_nr_ejr
,rets.s_dat_formdate_ejr
,rets.s_orig_receipt_nr_ejr        AS s_orig_receipt_nr_ejr
,rets.s_pos_terminal_id_ejr        AS s_pos_terminal_id_ejr
,rets.rh_gr_dat_formdate                                 AS dat_last_returndate
,CAST(SUM(rets.cnt_return_same_receipt) OVER (
                    PARTITION BY
                      rets.s_client_id_ejr
                      ,rets.s_orig_store_nr_ejr
                      ,rets.s_dat_formdate_ejr
                      ,rets.s_orig_receipt_nr_ejr
                      ,rets.s_pos_terminal_id_ejr
                ) AS DECIMAL(18,4))                      AS cnt_return_same_receipt
,CAST(RANK() OVER (PARTITION BY
                      rets.rh_gr_client_id
                     ,rets.s_orig_store_nr_ejr
                     ,rets.s_dat_formdate_ejr
                     ,rets.s_orig_receipt_nr_ejr
                     ,rets.s_pos_terminal_id_ejr
                     ,rets.checker_id
     ORDER BY   rets.rh_gr_dat_formdate
              , rets.time_receipt_ejr) AS SMALLINT)      AS return_seq
,rets.r_val_retail_ejr           
, (SELECT LISTAGG(DISTINCT rl_sub.item_id, ' ')
  FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub -- items of following receipt
  WHERE rh_gr_client_id          = rl_sub.client_id
  AND rh_gr_store_id                = rl_sub.store_id
  AND receipt_foll  = rl_sub.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = rl_sub.pos_terminal_id
  AND rh_gr_dat_formdate            = rl_sub.dat_formdate) items_foll_rec
,rh_gr_cnt_return_ejr
,rh_gr_cnt_deposit_ejr
,tr_next.cnt_sell_item AS tr_next_cnt_sell_item
,tr_next.qty_piece_ejr AS tr_next_qty_piece_ejr
,rh_gr_qty_return_ejr AS rh_gr_qty_return_ejr
,rl_qty_weight_ejr AS rl_qty_weight_ejr
,rl_weight_item_fg AS rl_weight_item_fg
FROM
(SELECT DISTINCT
 rh_gr.client_id                                     AS rh_gr_client_id
,rh_gr.store_id                                      AS rh_gr_store_id
,rh_gr.pos_terminal_id                               AS rh_gr_pos_terminal_id
,rh_gr.dat_formdate                                  AS rh_gr_dat_formdate
,rh_gr.time_receipt_ejr                              AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                           AS rh_gr_orig_receipt_nr_ejr
,rh_gr.checker_id                                    AS checker_id
,rh_vb.client_id                                     AS s_client_id_ejr
,rl.original_orig_store_nr_ejr                       AS s_orig_store_nr_ejr
,rh_vb.dat_formdate                                  AS s_dat_formdate_ejr
,rh_vb.orig_receipt_nr_ejr                           AS s_orig_receipt_nr_ejr
,rh_vb.pos_terminal_id                               AS s_pos_terminal_id_ejr
,SUM(ABS(rl.val_retail_ejr)) OVER (
          PARTITION BY
             rh_gr.client_id
           ,rh_gr.store_id
            ,rh_gr.dat_formdate
            ,rh_gr.orig_receipt_nr_ejr
            ,rh_gr.pos_terminal_id
            ,rh_gr.time_receipt_ejr
           )                                               AS r_val_retail_ejr
,COUNT(rh_gr.checker_id) OVER (
           PARTITION BY
             rh_gr.client_id
            ,rh_gr.store_id
            ,rh_gr.dat_formdate
            ,rh_gr.orig_receipt_nr_ejr
            ,rh_gr.pos_terminal_id
            ,rh_gr.time_receipt_ejr
           )                                               AS cnt_return_same_receipt
,(SELECT MIN (tr_next.orig_receipt_nr_ejr)
  FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- follower of current receipt
  WHERE rh_gr.client_id = tr_next.client_id
  AND rh_gr.store_id = tr_next.store_id
  AND rh_gr.pos_terminal_id = tr_next.pos_terminal_id
  AND rh_gr.dat_formdate = tr_next.dat_formdate
  AND rh_gr.checker_id = tr_next.checker_id
  AND tr_next.orig_receipt_nr_ejr > rh_gr.orig_receipt_nr_ejr
  AND tr_next.transactiontype_id NOT IN (150, 400, 405, 420, 425, 430, 480)) receipt_foll
,rl.original_orig_receipt_nr_ejr rl_original_orig_receipt_nr_ejr
,rl.original_pos_terminal_id_ejr rl_original_pos_terminal_id_ejr
,rl.original_dat_formdate_ejr rl_original_dat_formdate_ejr
,rl.original_orig_store_nr_ejr rl_original_orig_store_nr_ejr
,rl.qty_weight_ejr rl_qty_weight_ejr
,rl.weight_item_fg rl_weight_item_fg
,(SELECT MIN (tr_next.orig_receipt_nr_ejr)
  FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- follower of original receipt
  WHERE rl.client_id = tr_next.client_id
  AND st.store_id = tr_next.store_id
  AND rl.original_pos_terminal_id_ejr  = tr_next.pos_terminal_id
  AND rl.original_dat_formdate_ejr = tr_next.dat_formdate
  AND tr_next.orig_receipt_nr_ejr > rl.original_orig_receipt_nr_ejr
  AND tr_next.transactiontype_id NOT IN (150, 400, 405, 420, 425, 430, 480)) orig_receipt_foll
,st.store_id st_orig_store_id
,rh_gr.val_retail_ejr rh_gr_val_retail_ejr
,rh_gr.cnt_return_ejr rh_gr_cnt_return_ejr
,rh_gr.cnt_deposit_ejr rh_gr_cnt_deposit_ejr
,rh_gr.qty_return_ejr rh_gr_qty_return_ejr
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_gr                        /* Geldrueckgaben */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS rl                       /* Geldrueckgaben Zeilen */
ON rh_gr.client_id                                  = rl.client_id
AND rh_gr.store_id                                  = rl.store_id
AND rh_gr.orig_receipt_nr_ejr                       = rl.orig_receipt_nr_ejr
AND rh_gr.pos_terminal_id                           = rl.pos_terminal_id
AND rh_gr.time_receipt_ejr                          = rl.time_receipt_ejr
AND rh_gr.dat_formdate                              = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st_pr   /* Pruefung der Filiale, ob fuer Beladung relevant */
ON rh_gr.client_id                                  = st_pr.client_id
AND rh_gr.store_id                                  = st_pr.store_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st          /* Ermittlung der store_id fuer Verkaufsbon */
ON rl.client_id                   = st.client_id
AND rl.original_orig_store_nr_ejr = st.orig_store_nr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb                  /* Verkaufsbon */
ON rh_vb.client_id             = rl.client_id
AND rh_vb.store_id             = st.store_id
AND rh_vb.orig_receipt_nr_ejr  = rl.original_orig_receipt_nr_ejr
AND rh_vb.pos_terminal_id      = rl.original_pos_terminal_id_ejr
AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
AND rh_vb.checker_id                                = rh_gr.checker_id    /* Same checker_id for both Geldruckgabe und Originalbon  */
LEFT OUTER JOIN /* Doppeltipper */
(SELECT
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
      ,1 AS is_doppeltipper
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
       -- this indicates whether current record is a part of series (previous or next line has the same item_1)
      ,CASE WHEN item_entry_method_cd_ejr='RP' THEN 1 ELSE 0 END AS is_rp
      ,CASE WHEN item_entry_method_cd_ejr='KE' THEN 1 ELSE 0 END AS is_manual
      ,qty_piece_ejr
      ,qty_weight_ejr
      ,CASE WHEN item_entry_method_cd_ejr='SC' THEN 1 ELSE 0 END AS is_scanned
	  FROM (SELECT * ,RANK() OVER ( PARTITION BY client_id,store_id,checker_id,dat_formdate,orig_receipt_nr_ejr 
	                              ORDER BY timestamp_begin_ejr,orig_receipt_serial_nr_ejr) AS rank_by_timestamp
          FROM P_LEW_MART_MSI.v_mat0_zkp_etl_ejr_receiptline_extract_1) rle
    INNER JOIN P_LEW_MART_MSI.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr
    ON rle.store_id = revstr.store_id
      AND rle.client_id = revstr.client_id
      AND rle.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    WHERE transactiontype_id BETWEEN '140' AND '149'
        OR transactiontype_id = '101'
   -- only return lines
   QUALIFY series=1
  -- select only series (at least 2 subsequent receipt lines with the same item_1)
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
) AS dopp
ON dopp.client_id                                 = rh_vb.client_id
AND dopp.store_id                                  = rh_vb.store_id
AND dopp.orig_receipt_nr_ejr                       = rh_vb.orig_receipt_nr_ejr
AND dopp.pos_terminal_id                           = rh_vb.pos_terminal_id
AND dopp.dat_formdate                              = rh_vb.dat_formdate
AND dopp.item_id									= rl.item_id
/* Doppeltipper END */
WHERE rh_gr.transactiontype_id                        = '150'         /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
AND rh_vb.transactiontype_id                        = '100'
AND rl.transactiontype_id BETWEEN '140' AND '149'               /* Filter Geldrueckgaben-Zeilen */ 
AND (COALESCE(dopp.is_doppeltipper,0) = 0 OR rh_gr.cnt_return_ejr > 1) /* Filter out doppeltippers */
) AS rets
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS tr
ON tr.client_id             = rets.rh_gr_client_id
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- next receipt
  ON rh_gr_client_id                = tr_next.client_id
  AND rh_gr_store_id                = tr_next.store_id
  AND receipt_foll                  = tr_next.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = tr_next.pos_terminal_id
  AND rh_gr_dat_formdate            = tr_next.dat_formdate
INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_orig_next -- next receipt after original receipt
  ON s_client_id_ejr                = tr_orig_next.client_id
  AND st_orig_store_id              = tr_orig_next.store_id
  AND orig_receipt_foll             = tr_orig_next.orig_receipt_nr_ejr
  AND s_pos_terminal_id_ejr         = tr_orig_next.pos_terminal_id
  AND s_dat_formdate_ejr            = tr_orig_next.dat_formdate
LEFT OUTER JOIN													/* Join to the header and receipt line views with a filter which, apart from standard return lines, includes also returned deposits (transactiontype_id = 120) that take part in Bonsumme calculations - BBT-6847 */
	(
		SELECT
			rl.store_id
			, rl.client_id
			, rl.pos_terminal_id
			, rl.dat_formdate
			, rl.orig_receipt_nr_ejr
			, SUM(COALESCE(rl.val_retail_ejr, 0)) AS total_value
		FROM
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr
		INNER JOIN
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
				ON rh_gr.client_id = rl.client_id
				AND rh_gr.store_id = rl.store_id
				AND rh_gr.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
				AND rh_gr.pos_terminal_id = rl.pos_terminal_id
				AND rh_gr.time_receipt_ejr = rl.time_receipt_ejr
				AND rh_gr.dat_formdate = rl.dat_formdate
		WHERE
			(rl.transactiontype_id BETWEEN 140 AND 149
			OR rl.transactiontype_id = 120)
			AND rh_gr.transactiontype_id = 150
		GROUP BY
			rl.store_id
			, rl.client_id
			, rl.pos_terminal_id
			, rl.dat_formdate
			, rl.orig_receipt_nr_ejr
	) tval
		ON rets.rh_gr_client_id = tval.client_id
		AND rets.rh_gr_store_id = tval.store_id
		AND rets.rh_gr_orig_receipt_nr_ejr = tval.orig_receipt_nr_ejr
		AND rets.rh_gr_pos_terminal_id = tval.pos_terminal_id
		AND rets.rh_gr_dat_formdate = tval.dat_formdate
LEFT OUTER JOIN													/* Join to the payment type table to fetch cash payments and merge with the return receipt's follower - BBT-6847 */
	(
		SELECT
			store_id
			, client_id
			, pos_terminal_id
			, dat_formdate
			, time_receipt_ejr
			, orig_receipt_nr_ejr
			, val_retail_payment_ejr
		FROM
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_1
		WHERE
			tendertype_cd_ejr = 11
			AND cnt_payment_ejr = 1
		QUALIFY
			ROW_NUMBER() OVER(PARTITION BY store_id, client_id, pos_terminal_id, dat_formdate, time_receipt_ejr, orig_receipt_nr_ejr ORDER BY orig_receipt_serial_nr_ejr) = 1
	) pmt
  ON tr_next.store_id = pmt.store_id
  AND tr_next.client_id = pmt.client_id
  AND tr_next.pos_terminal_id = pmt.pos_terminal_id
  AND tr_next.dat_formdate = pmt.dat_formdate
  AND tr_next.time_receipt_ejr = pmt.time_receipt_ejr
  AND tr_next.orig_receipt_nr_ejr = pmt.orig_receipt_nr_ejr
  WHERE ABS(rh_gr_val_retail_ejr) <> tr_next.val_retail_ejr
  -- Wert der Geldrückgabe (Bonsumme) ist nicht gleich wie die Bonsumme des Folgebons nach der Geldrückgabe
  AND ABS(rh_gr_val_retail_ejr) <> tr_orig_next.val_retail_ejr
  -- Wert der Geldrückgabe (Bonsumme) ist nicht gleich wie die Bonsumme des Folgebons nach dem dazugehörigen Originalbon
  AND rets.r_val_retail_ejr > tr.return_same_checker_val
  /* Filter out rows where the return amount is the same as the amount paid in cash in the next receipt - BBT-6847 */
  AND COALESCE(pmt.val_retail_payment_ejr, 0) <> ABS(tval.total_value)
)
  WHERE cnt_return_item < rh_gr_cnt_return_ejr-rh_gr_cnt_deposit_ejr
  -- Count of cases that item_1 sales_1 on next receipt has to be lower than total number of position on return 
  -- (Alle Rückgabeartikel sind nicht auf dem Folgebon nach der Geldrückgabe) 
   AND (NVL(tr_next_cnt_sell_item,0) > 1
        OR rh_gr_cnt_return_ejr - rh_gr_cnt_deposit_ejr > 1 
        OR NVL(tr_next_qty_piece_ejr,0) <> ABS(CASE WHEN rl_weight_item_fg=1 THEN rl_qty_weight_ejr ELSE rh_gr_qty_return_ejr END)
        OR (NVL(tr_next_qty_piece_ejr,0) = 1 AND ABS(CASE WHEN rl_weight_item_fg=1 THEN rl_qty_weight_ejr ELSE rh_gr_qty_return_ejr END) = 1))
-- Exclude returns with Folgebon with the same sold quantity (except quantity 1)
UNION ALL
/* BBT-1567 : is_return_not_dv */
SELECT
 rh_gr.client_id                                         AS client_id
,rh_gr.store_id                                          AS store_id
,rh_gr.pos_terminal_id                                   AS pos_terminal_id
,rh_gr.dat_formdate                                      AS dat_formdate
,rh_gr.time_receipt_ejr                                  AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                               AS orig_receipt_nr_ejr
,rh_gr.checker_id                                        AS checker_id
,CAST(rl.client_id AS SMALLINT)                          AS s_client_id_ejr
,CAST(rl.original_orig_store_nr_ejr AS VARCHAR(100))     AS s_orig_store_nr_ejr
,rl.original_dat_formdate_ejr                            AS s_dat_formdate_ejr
,CAST(rl.original_orig_receipt_nr_ejr AS VARCHAR(100))   AS s_orig_receipt_nr_ejr
,CAST(rl.original_pos_terminal_id_ejr AS VARCHAR(100))   AS s_pos_terminal_id_ejr
,rl.item_id                                              AS item_id
,CAST(0 AS INTEGER)                                      AS cnt_return_item
,rh_gr.dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,CAST(0 AS SMALLINT)                                     AS return_seq
,CAST(0 AS DECIMAL(18,4))                                AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(1 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr           /* Geldrueckgaben       */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl          /* Geldrueckgabe Zeilen */
ON rh_gr.client_id                  = rl.client_id
  AND rh_gr.store_id                = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
  AND rh_gr.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr   /* Pruefung der Filiale, ob fuer Beladung relevant */
ON rh_gr.client_id                  = st_pr.client_id
  AND rh_gr.store_id                = st_pr.store_id
WHERE rh_gr.transactiontype_id       = '150'                                   /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
  AND rl.item_entry_method_cd_ejr    = 'KE'                                    /* Manual Entry of Original Bon Nr */
  AND rl.transactiontype_id BETWEEN '140' AND '149'                            /* Filter Geldrueckgaben-Zeilen */
  AND rl.item_entry_method_cd_ejr <> 'DV'                                      /* Entry different from DV */
UNION ALL
/* BBT-1567 : is_return_dv */
SELECT
 rh_gr.client_id                                         AS client_id
,rh_gr.store_id                                          AS store_id
,rh_gr.pos_terminal_id                                   AS pos_terminal_id
,rh_gr.dat_formdate                                      AS dat_formdate
,rh_gr.time_receipt_ejr                                  AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                               AS orig_receipt_nr_ejr
,rh_gr.checker_id                                        AS checker_id
,CAST(rl.client_id AS SMALLINT)                          AS s_client_id_ejr
,CAST(rl.original_orig_store_nr_ejr AS VARCHAR(100))     AS s_orig_store_nr_ejr
,rl.original_dat_formdate_ejr                            AS s_dat_formdate_ejr
,CAST(rl.original_orig_receipt_nr_ejr AS VARCHAR(100))   AS s_orig_receipt_nr_ejr
,CAST(rl.original_pos_terminal_id_ejr AS VARCHAR(100))   AS s_pos_terminal_id_ejr
,rl.item_id                                              AS item_id
,CAST(0 AS INTEGER)                                      AS cnt_return_item
,rh_gr.dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,CAST(0 AS SMALLINT)                                     AS return_seq
,CAST(0 AS DECIMAL(18,4))                                AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(1 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr           /* Geldrueckgaben       */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl          /* Geldrueckgabe Zeilen */
ON rh_gr.client_id                  = rl.client_id
  AND rh_gr.store_id                = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
  AND rh_gr.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr   /* Pruefung der Filiale, ob fuer Beladung relevant */
ON rh_gr.client_id                  = st_pr.client_id
  AND rh_gr.store_id                = st_pr.store_id
WHERE rh_gr.transactiontype_id = '150'                                         /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
  AND rl.transactiontype_id BETWEEN '140' AND '149'                            /* Filter Geldrueckgaben-Zeilen */
  AND rl.item_entry_method_cd_ejr = 'DV'                                       /* DV Entry */
UNION ALL
/* BBT-1567 : is_return_orig_same_checker */
SELECT
 rh_gr.client_id                                         AS client_id
,rh_gr.store_id                                          AS store_id
,rh_gr.pos_terminal_id                                   AS pos_terminal_id
,rh_gr.dat_formdate                                      AS dat_formdate
,rh_gr.time_receipt_ejr                                  AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                               AS orig_receipt_nr_ejr
,rh_gr.checker_id                                        AS checker_id
,CAST(rl.client_id AS SMALLINT)                          AS s_client_id_ejr
,CAST(rl.original_orig_store_nr_ejr AS VARCHAR(100))     AS s_orig_store_nr_ejr
,rl.original_dat_formdate_ejr                            AS s_dat_formdate_ejr
,CAST(rl.original_orig_receipt_nr_ejr AS VARCHAR(100))   AS s_orig_receipt_nr_ejr
,CAST(rl.original_pos_terminal_id_ejr AS VARCHAR(100))   AS s_pos_terminal_id_ejr
,rl.item_id                                              AS item_id
,CAST(0 AS INTEGER)                                      AS cnt_return_item
,rh_gr.dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,CAST(0 AS SMALLINT)                                     AS return_seq
,CAST(0 AS DECIMAL(18,4))                                AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(1 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr           /* Geldrueckgaben       */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl          /* Geldrueckgabe Zeilen */
ON rh_gr.client_id                  = rl.client_id
  AND rh_gr.store_id                = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
  AND rh_gr.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr   /* Pruefung der Filiale, ob fuer Beladung relevant */
ON rh_gr.client_id                  = st_pr.client_id
  AND rh_gr.store_id                = st_pr.store_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st      /* Ermittlung der store_id fuer Verkaufsbon */
ON rl.client_id                     = st.client_id
  AND rl.original_orig_store_nr_ejr = st.orig_store_nr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb                  /* Verkaufsbon */
ON rh_vb.client_id                                    = rl.client_id
  AND rh_vb.store_id                                  = st.store_id
  AND rh_vb.orig_receipt_nr_ejr = rl.original_orig_receipt_nr_ejr
  AND rh_vb.pos_terminal_id     = rl.original_pos_terminal_id_ejr
  AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
  AND rh_vb.checker_id                                = rh_gr.checker_id             /* Same checker_id for both GeldrÃ¸Â¼ckgabe und Originalbon  */
WHERE rh_gr.transactiontype_id = '150'                                         /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
  AND rl.transactiontype_id BETWEEN '140' AND '149'                            /* Filter Geldrueckgaben-Zeilen */ /* Filter Geldrueckgaben-Zeilen */
UNION ALL
/* BBT-1567 : is_return_orig_same_checker_day */
SELECT
 rh_gr.client_id                                         AS client_id
,rh_gr.store_id                                          AS store_id
,rh_gr.pos_terminal_id                                   AS pos_terminal_id
,rh_gr.dat_formdate                                      AS dat_formdate
,rh_gr.time_receipt_ejr                                  AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                               AS orig_receipt_nr_ejr
,rh_gr.checker_id                                        AS checker_id
,CAST(rl.client_id AS SMALLINT)                          AS s_client_id_ejr
,CAST(rl.original_orig_store_nr_ejr AS VARCHAR(100))     AS s_orig_store_nr_ejr
,rl.original_dat_formdate_ejr                            AS s_dat_formdate_ejr
,CAST(rl.original_orig_receipt_nr_ejr AS VARCHAR(100))   AS s_orig_receipt_nr_ejr
,CAST(rl.original_pos_terminal_id_ejr AS VARCHAR(100))   AS s_pos_terminal_id_ejr
,rl.item_id                                              AS item_id
,CAST(0 AS INTEGER)                                      AS cnt_return_item
,rh_gr.dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,CAST(0 AS SMALLINT)                                     AS return_seq
,CAST(0 AS DECIMAL(18,4))                                AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(1 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr           /* Geldrueckgaben       */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl          /* Geldrueckgabe Zeilen */
ON rh_gr.client_id                  = rl.client_id
  AND rh_gr.store_id                = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
  AND rh_gr.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr   /* Pruefung der Filiale, ob fuer Beladung relevant */
ON rh_gr.client_id                  = st_pr.client_id
  AND rh_gr.store_id                = st_pr.store_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st      /* Ermittlung der store_id fuer Verkaufsbon */
ON rl.client_id                     = st.client_id
  AND rl.original_orig_store_nr_ejr = st.orig_store_nr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb                  /* Verkaufsbon */
ON rh_vb.client_id                                    = rl.client_id
  AND rh_vb.store_id                                  = st.store_id
  AND rh_vb.orig_receipt_nr_ejr = rl.original_orig_receipt_nr_ejr
  AND rh_vb.pos_terminal_id     = rl.original_pos_terminal_id_ejr
  AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
  AND rh_vb.checker_id                                = rh_gr.checker_id             /* Same checker_id for both GeldrÃ¸Â¼ckgabe und Originalbon  */
  AND rh_vb.dat_formdate                              = rh_gr.dat_formdate           /* Same date for both GeldrÃ¸Â¼ckgabe und Originalbon  */
WHERE rh_gr.transactiontype_id = '150'                                         /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
  AND rl.transactiontype_id BETWEEN '140' AND '149'                            /* Filter Geldrueckgaben-Zeilen */ /* Filter Geldrueckgaben-Zeilen */
UNION ALL
/* BBT-1567 : is_return_no_orig_receipt */
SELECT
 rh_gr.client_id                                         AS client_id
,rh_gr.store_id                                          AS store_id
,rh_gr.pos_terminal_id                                   AS pos_terminal_id
,rh_gr.dat_formdate                                      AS dat_formdate
,rh_gr.time_receipt_ejr                                  AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                               AS orig_receipt_nr_ejr
,rh_gr.checker_id                                        AS checker_id
,CAST(rl.client_id AS SMALLINT)                          AS s_client_id_ejr
,CAST(rl.original_orig_store_nr_ejr AS VARCHAR(100))     AS s_orig_store_nr_ejr
,rl.original_dat_formdate_ejr                            AS s_dat_formdate_ejr
,CAST(rl.original_orig_receipt_nr_ejr AS VARCHAR(100))   AS s_orig_receipt_nr_ejr
,rl.original_pos_terminal_id_ejr                         AS s_pos_terminal_id_ejr
,rl.item_id                                              AS item_id
,CAST(0 AS INTEGER)                                      AS cnt_return_item
,rh_gr.dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,CAST(0 AS SMALLINT)                                     AS return_seq
,CAST(0 AS DECIMAL(18,4))                                AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(1 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr           /* Geldrueckgaben       */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl          /* Geldrueckgabe Zeilen */
ON rh_gr.client_id                  = rl.client_id
  AND rh_gr.store_id                = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
  AND rh_gr.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr   /* Pruefung der Filiale, ob fuer Beladung relevant */
ON rh_gr.client_id                  = st_pr.client_id
  AND rh_gr.store_id                = st_pr.store_id
AND NOT EXISTS
(SELECT
orig_receipt_nr_ejr
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb      /* Kein Verkaufsbon */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st    /* Ermittlung der store_id fuer Verkaufsbon */
ON rl.client_id                     = st.client_id
  AND rl.original_orig_store_nr_ejr = st.orig_store_nr
WHERE rh_vb.client_id                                 = rl.client_id
  AND rh_vb.store_id                                  = st.store_id
  AND rh_vb.orig_receipt_nr_ejr = rl.original_orig_receipt_nr_ejr
  AND rh_vb.pos_terminal_id     = rl.original_pos_terminal_id_ejr
  AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr)
WHERE rh_gr.transactiontype_id = '150'                                         /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
AND rl.transactiontype_id BETWEEN '140' AND '149'                            /* Filter Geldrueckgaben-Zeilen */ /* Filter Geldrueckgaben-Zeilen */
UNION ALL
/* 20210216_2750_ZKP_RET_NO_RECEIPT : is_return_sc */
SELECT
   rh_gr.client_id                                         AS client_id
  ,rh_gr.store_id                                          AS store_id
  ,rh_gr.pos_terminal_id                                   AS pos_terminal_id
  ,rh_gr.dat_formdate                                      AS dat_formdate
  ,rh_gr.time_receipt_ejr                                  AS time_receipt_ejr
  ,rh_gr.orig_receipt_nr_ejr                               AS orig_receipt_nr_ejr
  ,rh_gr.checker_id                                        AS checker_id
  ,CAST(rl.client_id AS SMALLINT)                          AS s_client_id_ejr
  ,CAST(rl.original_orig_store_nr_ejr AS VARCHAR(100))     AS s_orig_store_nr_ejr
  ,rl.original_dat_formdate_ejr                            AS s_dat_formdate_ejr
  ,CAST(rl.original_orig_receipt_nr_ejr AS VARCHAR(100))   AS s_orig_receipt_nr_ejr
  ,CAST(rl.original_pos_terminal_id_ejr AS VARCHAR(100))   AS s_pos_terminal_id_ejr
  ,rl.item_id                                              AS item_id
  ,CAST(0 AS INTEGER)                                      AS cnt_return_item
  ,rh_gr.dat_formdate                                      AS dat_last_returndate
  ,CAST(0 AS INTEGER)                                      AS cnt_sale_item
  ,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
  ,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
  ,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
  ,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
  ,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
  ,CAST(0 AS SMALLINT)                                     AS return_seq
  ,CAST(0 AS DECIMAL(18,4))                                AS val_return_same_receipt
  ,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
  ,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
  ,CAST(0 AS BYTEINT)                                      AS is_return_dv
  ,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
  ,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
  ,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
  ,CAST(1 AS BYTEINT)                                      AS is_return_sc
  ,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
  ,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
  ,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
  ,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr           /* Geldrueckgaben       */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl          /* Geldrueckgabe Zeilen */
ON rh_gr.client_id                  = rl.client_id
  AND rh_gr.store_id                = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
  AND rh_gr.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr   /* Pruefung der Filiale, ob fuer Beladung relevant */
ON rh_gr.client_id                  = st_pr.client_id
  AND rh_gr.store_id                = st_pr.store_id
WHERE rh_gr.transactiontype_id = '150'                                         /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
  AND rl.transactiontype_id BETWEEN '140' AND '149'                            /* Filter Geldrueckgaben-Zeilen */
  AND rl.item_entry_method_cd_ejr = 'SC'                                       /* SC Entry */
UNION ALL
/* AP0177990: Same checker, same day with manual returns only and not DV */
SELECT
 rh_gr.client_id                                         AS client_id
,rh_gr.store_id                                          AS store_id
,rh_gr.pos_terminal_id                                   AS pos_terminal_id
,rh_gr.dat_formdate                                      AS dat_formdate
,rh_gr.time_receipt_ejr                                  AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                               AS orig_receipt_nr_ejr
,rh_gr.checker_id                                        AS checker_id
,CAST(rl.client_id AS SMALLINT)                          AS s_client_id_ejr
,CAST(rl.original_orig_store_nr_ejr AS VARCHAR(100))     AS s_orig_store_nr_ejr
,rl.original_dat_formdate_ejr                            AS s_dat_formdate_ejr
,CAST(rl.original_orig_receipt_nr_ejr AS VARCHAR(100))   AS s_orig_receipt_nr_ejr
,CAST(rl.original_pos_terminal_id_ejr AS VARCHAR(100))   AS s_pos_terminal_id_ejr
,rl.item_id                                              AS item_id
,CAST(0 AS INTEGER)                                      AS cnt_return_item
,rh_gr.dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,CAST(0 AS SMALLINT)                                     AS return_seq
,CAST(0 AS DECIMAL(18,4))                                AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(1 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr           /* Geldrueckgaben       */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl          /* Geldrueckgabe Zeilen */
ON rh_gr.client_id                  = rl.client_id
  AND rh_gr.store_id                = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
  AND rh_gr.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr   /* Pruefung der Filiale, ob fuer Beladung relevant */
ON rh_gr.client_id                  = st_pr.client_id
  AND rh_gr.store_id                = st_pr.store_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st      /* Ermittlung der store_id fuer Verkaufsbon */
ON rl.client_id                     = st.client_id
  AND rl.original_orig_store_nr_ejr = st.orig_store_nr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb                  /* Verkaufsbon */
ON rh_vb.client_id                                    = rl.client_id
  AND rh_vb.store_id                                  = st.store_id
  AND rh_vb.orig_receipt_nr_ejr = rl.original_orig_receipt_nr_ejr
  AND rh_vb.pos_terminal_id     = rl.original_pos_terminal_id_ejr
  AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
  AND rh_vb.checker_id                                = rh_gr.checker_id             /* Same checker_id for both GeldrÃ¸Â¼ckgabe und Originalbon  */
  AND rh_vb.dat_formdate                              = rh_gr.dat_formdate           /* Same date for both GeldrÃ¸Â¼ckgabe und Originalbon  */
WHERE rh_gr.transactiontype_id = '150'                                         /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
  AND rl.transactiontype_id BETWEEN '140' AND '149'                            /* Filter Geldrueckgaben-Zeilen */
  AND rl.item_entry_method_cd_ejr   = 'KE'                                    /* Manual Entry of Original Bon Nr */
  AND rl.item_entry_method_cd_ejr <> 'DV'                                      /* Entry different from DV */
UNION ALL
/* AP0152808: Manual returns with no original receipt */
SELECT
 rh_gr_client_id                                         AS client_id
,rh_gr_store_id                                          AS store_id
,rh_gr_pos_terminal_id                                   AS pos_terminal_id
,rh_gr_dat_formdate                                      AS dat_formdate
,rh_gr_time_receipt_ejr                                  AS time_receipt_ejr
,rh_gr_orig_receipt_nr_ejr                               AS orig_receipt_nr_ejr
,rh_gr_checker_id                                        AS checker_id
,CAST(rh_gr_client_id AS SMALLINT)                       AS s_client_id_ejr
,CAST(rl_original_orig_store_nr_ejr AS VARCHAR(100))     AS s_orig_store_nr_ejr
,rl_original_dat_formdate_ejr                            AS s_dat_formdate_ejr
,CAST(rl_original_orig_receipt_nr_ejr AS VARCHAR(100))   AS s_orig_receipt_nr_ejr
,rl_original_pos_terminal_id_ejr                         AS s_pos_terminal_id_ejr
,rl_item_id                                              AS item_id
,CAST(0 AS INTEGER)                                      AS cnt_return_item
,rh_gr_dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,CAST(0 AS SMALLINT)                                     AS return_seq
,CAST(0 AS DECIMAL(18,4))                                AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(1 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(0 AS BYTEINT)                                      AS is_return_many_itm
,CAST(0 AS BYTEINT)                                      AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM (
SELECT
 rh_gr_client_id
,rh_gr_store_id
,rh_gr_pos_terminal_id
,rh_gr_dat_formdate
,rh_gr_time_receipt_ejr
,rh_gr_checker_id
,rh_gr_orig_receipt_nr_ejr
,rh_gr_cnt_return_ejr
,receipt_foll
,rl_original_orig_store_nr_ejr
,rl_original_orig_receipt_nr_ejr
,rl_original_pos_terminal_id_ejr
,rl_original_dat_formdate_ejr
,rh_gr_val_retail_ejr
,rl_item_id
, (SELECT COUNT(*) -- count of item_1 sales_1 on following receipt
  FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub
  WHERE rh_gr_client_id          = rl_sub.client_id
  AND rh_gr_store_id                = rl_sub.store_id
  AND receipt_foll                  = rl_sub.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = rl_sub.pos_terminal_id
  AND rh_gr_dat_formdate            = rl_sub.dat_formdate
  AND rl_item_id                    = rl_sub.item_id
) cnt_itm_foll
FROM (
SELECT
 rh_gr.client_id rh_gr_client_id
,rh_gr.store_id rh_gr_store_id
,rh_gr.pos_terminal_id rh_gr_pos_terminal_id
,rh_gr.dat_formdate rh_gr_dat_formdate
,rh_gr.time_receipt_ejr rh_gr_time_receipt_ejr
,rh_gr.checker_id rh_gr_checker_id
,rh_gr.orig_receipt_nr_ejr rh_gr_orig_receipt_nr_ejr
,rh_gr.val_retail_ejr rh_gr_val_retail_ejr
,rh_gr.cnt_return_ejr rh_gr_cnt_return_ejr
,rh_gr.cnt_deposit_ejr rh_gr_cnt_deposit_ejr
,rh_gr.qty_return_ejr rh_gr_qty_return_ejr
,(SELECT MIN(tr_next.orig_receipt_nr_ejr)
  FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- follower of current receipt
  WHERE rh_gr.client_id = tr_next.client_id
  AND rh_gr.store_id = tr_next.store_id
  AND rh_gr.pos_terminal_id = tr_next.pos_terminal_id
  AND rh_gr.dat_formdate = tr_next.dat_formdate
  AND rh_gr.checker_id = tr_next.checker_id
  AND tr_next.orig_receipt_nr_ejr > rh_gr.orig_receipt_nr_ejr
  AND tr_next.transactiontype_id NOT IN (400, 405, 420, 425, 430, 480, 150)) receipt_foll
,rl.original_orig_receipt_nr_ejr rl_original_orig_receipt_nr_ejr
,rl.original_pos_terminal_id_ejr rl_original_pos_terminal_id_ejr
,rl.original_dat_formdate_ejr rl_original_dat_formdate_ejr
,rl.original_orig_store_nr_ejr rl_original_orig_store_nr_ejr
,rl.item_id rl_item_id
,rl.qty_weight_ejr rl_qty_weight_ejr
,rl.weight_item_fg rl_weight_item_fg
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr           /* Geldrueckgaben       */
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 tr
ON tr.client_id = rh_gr.client_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl          /* Geldrueckgabe Zeilen */
ON rh_gr.client_id                  = rl.client_id
  AND rh_gr.store_id                = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
  AND rh_gr.dat_formdate            = rl.dat_formdate
  INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr   /* Pruefung der Filiale, ob fuer Beladung relevant */
  ON rh_gr.client_id                  = st_pr.client_id
  AND rh_gr.store_id                = st_pr.store_id
WHERE rh_gr.transactiontype_id = '150'                                       /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
AND rl.transactiontype_id BETWEEN '140' AND '149'                            /* Filter Geldrueckgaben-Zeilen */
AND rl.item_entry_method_cd_ejr = 'KE'                                       /* Manual entry */
AND ABS(rh_gr.val_retail_ejr) > tr.return_no_receipt_val					           /* Threshold comparison against transact follower (Bon level) */
AND NOT EXISTS
(SELECT orig_receipt_nr_ejr
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb      /* Kein Verkaufsbon */
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st    /* Ermittlung der store_id fuer Verkaufsbon */
ON rl.client_id                     = st.client_id
  AND rl.original_orig_store_nr_ejr = st.orig_store_nr
WHERE rh_vb.client_id           = rl.client_id
  AND rh_vb.store_id            = st.store_id
  AND rh_vb.orig_receipt_nr_ejr = rl.original_orig_receipt_nr_ejr
  AND rh_vb.pos_terminal_id     = rl.original_pos_terminal_id_ejr
  AND rh_vb.dat_formdate        = rl.original_dat_formdate_ejr)
  )
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- left join in order to keep the receipts when next receipt is not found.
  ON rh_gr_client_id                = tr_next.client_id
  AND rh_gr_store_id                = tr_next.store_id
  AND receipt_foll                  = tr_next.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = tr_next.pos_terminal_id
  AND rh_gr_dat_formdate            = tr_next.dat_formdate
LEFT OUTER JOIN													/* Join to the header and receipt line views with a filter which, apart from standard return lines, includes also returned deposits (transactiontype_id = 120) that take part in Bonsumme calculations - BBT-6847 */
	(
		SELECT
			rl.store_id
			, rl.client_id
			, rl.pos_terminal_id
			, rl.dat_formdate
			, rl.orig_receipt_nr_ejr
			, SUM(COALESCE(rl.val_retail_ejr, 0)) AS total_value
		FROM
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr
		INNER JOIN
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
				ON rh_gr.client_id = rl.client_id
				AND rh_gr.store_id = rl.store_id
				AND rh_gr.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
				AND rh_gr.pos_terminal_id = rl.pos_terminal_id
				AND rh_gr.time_receipt_ejr = rl.time_receipt_ejr
				AND rh_gr.dat_formdate = rl.dat_formdate
		WHERE
			(rl.transactiontype_id BETWEEN 140 AND 149
			OR rl.transactiontype_id = 120)
			AND rh_gr.transactiontype_id = 150
		GROUP BY
			rl.store_id
			, rl.client_id
			, rl.pos_terminal_id
			, rl.dat_formdate
			, rl.orig_receipt_nr_ejr
	) tval
		ON rh_gr_client_id = tval.client_id
		AND rh_gr_store_id = tval.store_id
		AND rh_gr_orig_receipt_nr_ejr = tval.orig_receipt_nr_ejr
		AND rh_gr_pos_terminal_id = tval.pos_terminal_id
		AND rh_gr_dat_formdate = tval.dat_formdate
LEFT OUTER JOIN													/* Join to the payment type table to fetch cash payments and merge with the return receipt's follower - BBT-6847 */
	(
		SELECT
			store_id
			, client_id
			, pos_terminal_id
			, dat_formdate
			, time_receipt_ejr
			, orig_receipt_nr_ejr
			, val_retail_payment_ejr
		FROM
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_1
		WHERE
			tendertype_cd_ejr = 11
			AND cnt_payment_ejr = 1
		QUALIFY
			ROW_NUMBER() OVER(PARTITION BY store_id, client_id, pos_terminal_id, dat_formdate, time_receipt_ejr, orig_receipt_nr_ejr ORDER BY orig_receipt_serial_nr_ejr) = 1
	) pmt
  ON tr_next.store_id = pmt.store_id
  AND tr_next.client_id = pmt.client_id
  AND tr_next.pos_terminal_id = pmt.pos_terminal_id
  AND tr_next.dat_formdate = pmt.dat_formdate
  AND tr_next.time_receipt_ejr = pmt.time_receipt_ejr
  AND tr_next.orig_receipt_nr_ejr = pmt.orig_receipt_nr_ejr
WHERE  ABS(rh_gr_val_retail_ejr) <> tr_next.val_retail_ejr
-- Wert der Geldrückgabe (Bonsumme) ist nicht gleich wie die Bonsumme des Folgebons nach der Geldrückgabe
AND (NVL(tr_next.cnt_sell_item,0) > 1
     OR rh_gr_cnt_return_ejr - rh_gr_cnt_deposit_ejr > 1 
     OR NVL(tr_next.qty_piece_ejr,0) <> ABS(CASE WHEN rl_weight_item_fg=1 THEN rl_qty_weight_ejr ELSE rh_gr_qty_return_ejr END)
     OR (NVL(tr_next.qty_piece_ejr,0) = 1 AND ABS(CASE WHEN rl_weight_item_fg=1 THEN rl_qty_weight_ejr ELSE rh_gr_qty_return_ejr END) = 1))
	-- Exclude returns with Folgebon with the same sold quantity (except quantity 1)
/* Filter out rows where the return amount is the same as the amount paid in cash in the next receipt - BBT-6847 */	
AND COALESCE(pmt.val_retail_payment_ejr, 0) <> ABS(tval.total_value)
QUALIFY SUM(CASE WHEN cnt_itm_foll>= 1 THEN 1 ELSE 0 END) OVER(PARTITION BY rh_gr_client_id,rh_gr_store_id,rh_gr_pos_terminal_id,rh_gr_dat_formdate,rh_gr_orig_receipt_nr_ejr) < rh_gr_cnt_return_ejr-rh_gr_cnt_deposit_ejr
-- Count of cases that item_1 sales_1 on next receipt has to be lower than total number of position on return
-- (Alle Rückgabeartikel sind nicht auf dem Folgebon nach der Geldrückgabe)
)UNION ALL
/* AP0170366: Returns of many items with an original receipt */
SELECT
 rh_gr_client_id                                         AS client_id
,rh_gr_store_id                                          AS store_id
,rh_gr_pos_terminal_id                                   AS pos_terminal_id
,rh_gr_dat_formdate                                      AS dat_formdate
,rh_gr_time_receipt_ejr                                  AS time_receipt_ejr
,rh_gr_orig_receipt_nr_ejr                               AS orig_receipt_nr_ejr
,rh_gr_checker_id                                        AS checker_id
,CAST(rh_gr_client_id AS SMALLINT)                       AS s_client_id_ejr
,CAST(rl_original_orig_store_nr_ejr AS VARCHAR(100))     AS s_orig_store_nr_ejr
,rl_original_dat_formdate_ejr                            AS s_dat_formdate_ejr
,CAST(rl_original_orig_receipt_nr_ejr AS VARCHAR(100))   AS s_orig_receipt_nr_ejr
,rl_original_pos_terminal_id_ejr                         AS s_pos_terminal_id_ejr
,rl_item_id                                              AS item_id
,CAST(0 AS INTEGER)                                      AS cnt_return_item
,rh_gr_dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INTEGER)                                      AS cnt_sale_item
,CAST(0 AS INTEGER)                                      AS is_returned_wo_bon_per_day
,CAST(0 AS INTEGER)                                      AS is_returned_gt_original
,CAST(0 AS INTEGER)                                      AS cnt_returned_gt_original
,CAST(0 AS DECIMAL(18,4))                                AS cnt_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_not_authorised
,CAST(0 AS SMALLINT)                                     AS return_seq
,CAST(0 AS DECIMAL(18,4))                                AS val_return_same_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_not_dv
,CAST(0 AS BYTEINT)                                      AS is_return_dv
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt
,CAST(0 AS BYTEINT)                                      AS is_return_sc
,CAST(0 AS BYTEINT)                                      AS is_return_no_orig_receipt_man
,CAST(1 AS BYTEINT)                                      AS is_return_many_itm
,is_return_same_itm_nb                                   AS is_return_same_itm_nb
,CAST(0 AS BYTEINT)                                      AS is_return_orig_same_checker_day_not_dv_man
FROM (
SELECT
 rh_gr_client_id
,rh_gr_store_id
,rh_gr_pos_terminal_id
,rh_gr_dat_formdate
,rh_gr_time_receipt_ejr
,rh_gr_checker_id
,rh_gr_orig_receipt_nr_ejr
,rh_gr_cnt_return_ejr
,receipt_foll
,rl_original_orig_store_nr_ejr
,rl_original_orig_receipt_nr_ejr
,rl_original_pos_terminal_id_ejr
,rl_original_dat_formdate_ejr
,st_orig_store_id
,rh_gr_val_retail_ejr
,orig_receipt_foll
,rl_item_id
, (SELECT COUNT(*) -- count of item_1 sales_1 on following receipt
  FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub
  WHERE rh_gr_client_id          = rl_sub.client_id
  AND rh_gr_store_id                = rl_sub.store_id
  AND receipt_foll                  = rl_sub.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = rl_sub.pos_terminal_id
  AND rh_gr_dat_formdate            = rl_sub.dat_formdate
  AND rl_item_id                    = rl_sub.item_id
) cnt_itm_foll
, CASE WHEN rh_gr_cnt_return_ejr = tr_orig.cnt_sell_item THEN 1 ELSE 0 END AS is_return_same_itm_nb
-- 1 wenn alle Artikel_1 zurückgenommen werden, die auf dem Originalbon kassiert wurden.
FROM (
SELECT
 rh_gr.client_id rh_gr_client_id
,rh_gr.store_id rh_gr_store_id
,rh_gr.pos_terminal_id rh_gr_pos_terminal_id
,rh_gr.dat_formdate rh_gr_dat_formdate
,rh_gr.time_receipt_ejr rh_gr_time_receipt_ejr
,rh_gr.checker_id rh_gr_checker_id
,rh_gr.orig_receipt_nr_ejr rh_gr_orig_receipt_nr_ejr
,rh_gr.val_retail_ejr rh_gr_val_retail_ejr
,rh_gr.cnt_return_ejr rh_gr_cnt_return_ejr
,rh_gr.cnt_deposit_ejr rh_gr_cnt_deposit_ejr
,(SELECT MIN (tr_next.orig_receipt_nr_ejr)
  FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- follower of current receipt
  WHERE rh_gr.client_id = tr_next.client_id
  AND rh_gr.store_id = tr_next.store_id
  AND rh_gr.pos_terminal_id = tr_next.pos_terminal_id
  AND rh_gr.dat_formdate = tr_next.dat_formdate
  AND rh_gr.checker_id = tr_next.checker_id
  AND tr_next.orig_receipt_nr_ejr > rh_gr.orig_receipt_nr_ejr
  AND tr_next.transactiontype_id NOT IN (150, 400, 405, 420, 425, 430, 480)) receipt_foll
,rl.original_orig_receipt_nr_ejr rl_original_orig_receipt_nr_ejr
,rl.original_pos_terminal_id_ejr rl_original_pos_terminal_id_ejr
,rl.original_dat_formdate_ejr rl_original_dat_formdate_ejr
,rl.original_orig_store_nr_ejr rl_original_orig_store_nr_ejr
,(SELECT MIN (tr_next.orig_receipt_nr_ejr)
  FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- follower of original receipt
  WHERE rl.client_id = tr_next.client_id
  AND st.store_id = tr_next.store_id
  AND rl.original_pos_terminal_id_ejr  = tr_next.pos_terminal_id
  AND rl.original_dat_formdate_ejr = tr_next.dat_formdate
  AND tr_next.orig_receipt_nr_ejr > rl.original_orig_receipt_nr_ejr
  AND tr_next.transactiontype_id NOT IN (150, 400, 405, 420, 425, 430, 480)) orig_receipt_foll
,rl.item_id rl_item_id
,st.store_id st_orig_store_id
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr           /* Geldrueckgaben       */
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 tr
ON tr.client_id = rh_gr.client_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl          /* Geldrueckgabe Zeilen */
ON rh_gr.client_id                  = rl.client_id
  AND rh_gr.store_id                = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
  AND rh_gr.dat_formdate            = rl.dat_formdate
  INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st         /* Ermittlung der store_id */
  ON rl.client_id                                    = st.client_id
  AND rl.original_orig_store_nr_ejr                  = st.orig_store_nr
  INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr   /* Pruefung der Filiale, ob fuer Beladung relevant */
  ON rh_gr.client_id                  = st_pr.client_id
  AND rh_gr.store_id                = st_pr.store_id
WHERE rh_gr.transactiontype_id = '150'                                       /* Filter Geldrueckgaben (Header-transactiontype_id = 150) */
AND rl.transactiontype_id BETWEEN '140' AND '149'                            /* Filter Geldrueckgaben-Zeilen */
AND rh_gr.cnt_return_ejr >= tr.return_many_itm_cnt                           /* Total number of returns greater or eq threshold */
AND ABS(rh_gr.val_retail_ejr) >= tr.return_many_itm_val                      /* Total value of returns greater or eq threshold */
AND EXISTS  /* Original receipt has to exist */
(SELECT orig_receipt_nr_ejr
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb      
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st    
ON rl.client_id                     = st.client_id
  AND rl.original_orig_store_nr_ejr = st.orig_store_nr
WHERE rh_vb.client_id               = rl.client_id
  AND rh_vb.store_id                = st.store_id
  AND rh_vb.orig_receipt_nr_ejr     = rl.original_orig_receipt_nr_ejr
  AND rh_vb.pos_terminal_id         = rl.original_pos_terminal_id_ejr
  AND rh_vb.dat_formdate            = rl.original_dat_formdate_ejr)
  )
INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next -- next receipt
  ON rh_gr_client_id                = tr_next.client_id
  AND rh_gr_store_id                = tr_next.store_id
  AND receipt_foll                  = tr_next.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = tr_next.pos_terminal_id
  AND rh_gr_dat_formdate            = tr_next.dat_formdate
INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_orig --  original receipt
  ON rh_gr_client_id                  = tr_orig.client_id
  AND st_orig_store_id                = tr_orig.store_id
  AND rl_original_orig_receipt_nr_ejr = tr_orig.orig_receipt_nr_ejr
  AND rl_original_pos_terminal_id_ejr = tr_orig.pos_terminal_id
  AND rl_original_dat_formdate_ejr    = tr_orig.dat_formdate
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_orig_next -- next receipt after original receipt
  ON rh_gr_client_id                  = tr_orig_next.client_id
  AND st_orig_store_id                = tr_orig_next.store_id
  AND orig_receipt_foll               = tr_orig_next.orig_receipt_nr_ejr
  AND rl_original_pos_terminal_id_ejr = tr_orig_next.pos_terminal_id
  AND rl_original_dat_formdate_ejr    = tr_orig_next.dat_formdate
LEFT OUTER JOIN													/* Join to the header and receipt line views with a filter which, apart from standard return lines, includes also returned deposits (transactiontype_id = 120) that take part in Bonsumme calculations - BBT-6847 */
	(
		SELECT
			rl.store_id
			, rl.client_id
			, rl.pos_terminal_id
			, rl.dat_formdate
			, rl.orig_receipt_nr_ejr
			, SUM(COALESCE(rl.val_retail_ejr, 0)) AS total_value
		FROM
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr
		INNER JOIN
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
				ON rh_gr.client_id = rl.client_id
				AND rh_gr.store_id = rl.store_id
				AND rh_gr.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
				AND rh_gr.pos_terminal_id = rl.pos_terminal_id
				AND rh_gr.time_receipt_ejr = rl.time_receipt_ejr
				AND rh_gr.dat_formdate = rl.dat_formdate
		WHERE
			(rl.transactiontype_id BETWEEN 140 AND 149
			OR rl.transactiontype_id = 120)
			AND rh_gr.transactiontype_id = 150
		GROUP BY
			rl.store_id
			, rl.client_id
			, rl.pos_terminal_id
			, rl.dat_formdate
			, rl.orig_receipt_nr_ejr
	) tval
		ON rh_gr_client_id = tval.client_id
		AND rh_gr_store_id = tval.store_id
		AND rh_gr_orig_receipt_nr_ejr = tval.orig_receipt_nr_ejr
		AND rh_gr_pos_terminal_id = tval.pos_terminal_id
		AND rh_gr_dat_formdate = tval.dat_formdate
LEFT OUTER JOIN													/* Join to the payment type table to fetch cash payments and merge with the return receipt's follower - BBT-6847 */
	(
		SELECT
			store_id
			, client_id
			, pos_terminal_id
			, dat_formdate
			, time_receipt_ejr
			, orig_receipt_nr_ejr
			, val_retail_payment_ejr
		FROM
			p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_1
		WHERE
			tendertype_cd_ejr = 11
			AND cnt_payment_ejr = 1
		QUALIFY
			ROW_NUMBER() OVER(PARTITION BY store_id, client_id, pos_terminal_id, dat_formdate, time_receipt_ejr, orig_receipt_nr_ejr ORDER BY orig_receipt_serial_nr_ejr) = 1
	) pmt
  ON tr_next.store_id = pmt.store_id
  AND tr_next.client_id = pmt.client_id
  AND tr_next.pos_terminal_id = pmt.pos_terminal_id
  AND tr_next.dat_formdate = pmt.dat_formdate
  AND tr_next.time_receipt_ejr = pmt.time_receipt_ejr
  AND tr_next.orig_receipt_nr_ejr = pmt.orig_receipt_nr_ejr
  WHERE  ABS(rh_gr_val_retail_ejr) <> tr_next.val_retail_ejr
  -- Wert der Geldrückgabe (Bonsumme) ist nicht gleich wie die Bonsumme des Folgebons nach der Geldrückgabe
  AND ABS(rh_gr_val_retail_ejr) <> tr_orig_next.val_retail_ejr
  -- Wert der Geldrückgabe (Bonsumme) ist nicht gleich wie die Bonsumme des Folgebons nach dem dazugehörigen Originalbon
  /* Filter out rows where the return amount is the same as the amount paid in cash in the next receipt - BBT-6847 */	
  AND COALESCE(pmt.val_retail_payment_ejr, 0) <> ABS(tval.total_value)
  QUALIFY SUM(CASE WHEN cnt_itm_foll>= 1 THEN 1 ELSE 0 END) OVER(PARTITION BY rh_gr_client_id,rh_gr_store_id,rh_gr_pos_terminal_id,rh_gr_dat_formdate,rh_gr_orig_receipt_nr_ejr) < rh_gr_cnt_return_ejr-rh_gr_cnt_deposit_ejr
  -- Count of cases that item_1 sales_1 on next receipt has to be lower than total number of position on return (Alle Rückgabeartikel sind nicht auf dem Folgebon nach der Geldrückgabe)
)
;