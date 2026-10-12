CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_return_transact_1
AS

SELECT
 rh_gr.client_id                                         AS client_id
,rh_gr.store_id                                          AS store_id
,rh_gr.pos_terminal_id                                   AS pos_terminal_id
,rh_gr.dat_formdate                                      AS dat_formdate
,rh_gr.time_receipt_ejr                                  AS time_receipt_ejr
,rh_gr.orig_receipt_nr_ejr                               AS orig_receipt_nr_ejr
,rh_gr.checker_id                                        AS checker_id
,CAST(0 AS INT64 )                                       AS s_client_id_ejr
,'-1'                                                    AS s_orig_store_nr_ejr
,CAST(NULL AS DATE)                                      AS s_dat_formdate_ejr
,NULL                                                    AS s_orig_receipt_nr_ejr
,NULL                                                    AS s_pos_terminal_id_ejr
,rl.item_id                                              AS item_id
,CAST(0 AS INT64)                                        AS cnt_return_item
,rh_gr.dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INT64)                                        AS cnt_sale_item
,CAST(1 AS INT64)                                        AS is_returned_wo_bon_per_day
,CAST(0 AS INT64)                                        AS is_returned_gt_original
,CAST(0 AS INT64)                                        AS cnt_returned_gt_original
,CAST(0 AS NUMERIC)                                      AS cnt_return_same_receipt
,CAST(0 AS INT64 )                                       AS is_return_not_authorised
,CAST(0 AS INT64 )                                       AS return_seq
,CAST(0 AS NUMERIC)                                      AS val_return_same_receipt
,CAST(0 AS INT64 )                                       AS is_return_same_checker
,CAST(0 AS INT64 )                                       AS is_return_not_dv
,CAST(0 AS INT64 )                                       AS is_return_dv
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker_day
,CAST(0 AS INT64 )                                       AS is_return_no_orig_receipt
,CAST(0 AS INT64 )                                       AS is_return_sc
,CAST(0 AS INT64 )                                       AS is_return_no_orig_receipt_man
,CAST(0 AS INT64 )                                       AS is_return_many_itm
,CAST(0 AS INT64 )                                       AS is_return_same_itm_nb
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker_day_not_dv_man
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr            

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl          
ON rh_gr.client_id                  = rl.client_id
  AND rh_gr.store_id                = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
  AND rh_gr.dat_formdate            = rl.dat_formdate
INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr   
ON rh_gr.client_id                  = st_pr.client_id
  AND rh_gr.store_id                = st_pr.store_id

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st      
ON rl.client_id                     = st.client_id
  AND CAST(rl.original_orig_store_nr_ejr AS INT64) = st.orig_store_nr

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_vb     
ON rh_vb.client_id                  = rl.client_id
  AND rh_vb.store_id                = st.store_id
  AND rh_vb.orig_receipt_nr_ejr     = CAST(rl.original_orig_receipt_nr_ejr AS INT64)
  AND rh_vb.pos_terminal_id         = CAST(rl.original_pos_terminal_id_ejr AS INT64)
  AND rh_vb.dat_formdate            = rl.original_dat_formdate_ejr
INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 tr
ON tr.client_id = rh_gr.client_id
WHERE rh_gr.transactiontype_id = '150'                                         
  AND rh_vb.transactiontype_id = '100'
  AND rl.transactiontype_id BETWEEN '140'   AND '149'                          
  AND NOT EXISTS
(SELECT
1
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rlv        
WHERE  rh_vb.client_id             = rlv.client_id
     AND rh_vb.store_id            = rlv.store_id
     AND rh_vb.orig_receipt_nr_ejr = rlv.orig_receipt_nr_ejr
     AND rh_vb.pos_terminal_id     = rlv.pos_terminal_id
     AND rh_vb.dat_formdate        = rlv.dat_formdate
     AND rl.item_id                = rlv.item_id
     AND rlv.transactiontype_id BETWEEN '101' AND '102'                
)
AND rl.price_retail_ejr > tr.return_tot_val

UNION ALL


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
,CAST(0 AS INT64)                                        AS is_returned_wo_bon_per_day
,CAST(1 AS INT64)                                        AS is_returned_gt_original
,CASE WHEN     returnx.dat_formdate = returnx.dat_last_returndate
             AND returnx.time_receipt_ejr = returnx.last_time_receipt_ejr THEN CAST(1 AS INT64)
ELSE 0 END                                         AS cnt_returned_gt_original
,CAST(0 AS NUMERIC)                                      AS cnt_return_same_receipt
,CAST(0 AS INT64 )                                       AS is_return_not_authorised
,CAST(0 AS INT64 )                                       AS return_seq
,CAST(0 AS NUMERIC)                                      AS val_return_same_receipt
,CAST(0 AS INT64 )                                       AS is_return_same_checker
,CAST(0 AS INT64 )                                       AS is_return_not_dv
,CAST(0 AS INT64 )                                       AS is_return_dv
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker_day
,CAST(0 AS INT64 )                                       AS is_return_no_orig_receipt
,CAST(0 AS INT64 )                                       AS is_return_sc
,CAST(0 AS INT64 )                                       AS is_return_no_orig_receipt_man
,CAST(0 AS INT64 )                                       AS is_return_many_itm
,CAST(0 AS INT64 )                                       AS is_return_same_itm_nb
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker_day_not_dv_man
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
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr   

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl  
ON rh_gr.client_id               = rl.client_id
AND rh_gr.store_id                = rl.store_id
AND rh_gr.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
AND rh_gr.pos_terminal_id         = rl.pos_terminal_id
AND rh_gr.time_receipt_ejr        = rl.time_receipt_ejr
AND rh_gr.dat_formdate            = rl.dat_formdate

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr 
ON rh_gr.client_id               = st_pr.client_id
AND rh_gr.store_id                = st_pr.store_id

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1  st   
ON rl.client_id                  = st.client_id
AND CAST(rl.original_orig_store_nr_ejr AS INT64) = st.orig_store_nr

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_vb   
ON rh_vb.client_id                                 = rl.client_id
AND rh_vb.store_id                                  = st.store_id
AND rh_vb.orig_receipt_nr_ejr = CAST(rl.original_orig_receipt_nr_ejr AS INT64)
AND rh_vb.pos_terminal_id     = CAST(rl.original_pos_terminal_id_ejr AS INT64)
AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rlv       
ON rh_vb.client_id                                 = rlv.client_id
AND rh_vb.store_id                                  = rlv.store_id
AND rh_vb.orig_receipt_nr_ejr                       = rlv.orig_receipt_nr_ejr
AND rh_vb.pos_terminal_id                           = rlv.pos_terminal_id
AND rh_vb.dat_formdate                              = rlv.dat_formdate
AND rl.item_id                                      = rlv.item_id
INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 tr
ON tr.client_id                                    =   rh_gr.client_id
WHERE rh_gr.transactiontype_id                        = '150'                
AND ABS(rh_gr.val_retail_ejr)                       > tr.return_tot_val
AND rh_vb.transactiontype_id                        = '100'                
AND rl.transactiontype_id  BETWEEN '140'   AND '149'                       
AND rlv.transactiontype_id BETWEEN '101'   AND '102'                       
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
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr         

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl        
ON rh_gr.client_id                                 = rl.client_id
AND rh_gr.store_id                                  = rl.store_id
AND rh_gr.orig_receipt_nr_ejr                       = rl.orig_receipt_nr_ejr
AND rh_gr.pos_terminal_id                           = rl.pos_terminal_id
AND rh_gr.time_receipt_ejr                          = rl.time_receipt_ejr
AND rh_gr.dat_formdate                              = rl.dat_formdate

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 st_pr 
ON rh_gr.client_id                                 = st_pr.client_id
AND rh_gr.store_id                                  = st_pr.store_id

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1  st   
ON rl.client_id                                    = st.client_id
AND CAST(rl.original_orig_store_nr_ejr AS INT64)                   = st.orig_store_nr

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_vb   
ON rh_vb.client_id                                 = rl.client_id
AND rh_vb.store_id                                  = st.store_id
AND rh_vb.orig_receipt_nr_ejr  = CAST(rl.original_orig_receipt_nr_ejr AS INT64)
AND rh_vb.pos_terminal_id      = CAST(rl.original_pos_terminal_id_ejr AS INT64)
AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rlv       
ON rh_vb.client_id                                 = rlv.client_id
AND rh_vb.store_id                                  = rlv.store_id
AND rh_vb.orig_receipt_nr_ejr                       = rlv.orig_receipt_nr_ejr
AND rh_vb.pos_terminal_id                           = rlv.pos_terminal_id
AND rh_vb.dat_formdate                              = rlv.dat_formdate
AND rl.item_id                                      = rlv.item_id
INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 tr
ON tr.client_id                                    =   rh_gr.client_id
WHERE rh_gr.transactiontype_id                        = '150'                
AND ABS(rh_gr.val_retail_ejr)                       > tr.return_tot_val
AND rh_vb.transactiontype_id                        = '100'                
AND rl.transactiontype_id BETWEEN '140'    AND '149'                       
AND rlv.transactiontype_id BETWEEN '101'   AND '102'                       
) temp
) x2
) salex
ON returnx.s_client_id_ejr       = salex.s_client_id_ejr
AND returnx.s_orig_store_nr_ejr   = salex.s_orig_store_nr_ejr
AND returnx.s_dat_formdate_ejr    = salex.s_dat_formdate_ejr
AND returnx.s_orig_receipt_nr_ejr = salex.s_orig_receipt_nr_ejr
AND returnx.s_pos_terminal_id_ejr = salex.s_pos_terminal_id_ejr
AND returnx.item_id               = salex.item_id
WHERE COALESCE(ABS(salex.cnt_sale_item), 0)            > 0
AND COALESCE(ABS(salex.cnt_sale_item), 0)            < returnx.cnt_return_item
UNION ALL

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
,CAST(rets.s_orig_receipt_nr_ejr AS STRING)        AS s_orig_receipt_nr_ejr
,CAST(rets.s_pos_terminal_id_ejr AS STRING)        AS s_pos_terminal_id_ejr
,CAST(-1 AS INT64)                                       AS item_id
,CAST(0 AS INT64)                                        AS cnt_return_item
,rets.dat_formdate                                       AS dat_last_returndate
,CAST(0 AS INT64)                                        AS cnt_sale_item
,CAST(0 AS INT64)                                        AS is_returned_wo_bon_per_day
,CAST(0 AS INT64)                                        AS is_returned_gt_original
,CAST(0 AS INT64)                                        AS cnt_returned_gt_original
,CAST(SUM(rets.cnt_return_same_receipt) OVER (
                    PARTITION BY
                      rets.s_client_id_ejr
                      ,rets.s_orig_store_nr_ejr
                      ,rets.s_dat_formdate_ejr
                      ,rets.s_orig_receipt_nr_ejr
                      ,rets.s_pos_terminal_id_ejr
                ) AS NUMERIC)                         AS cnt_return_same_receipt
,CAST(0 AS INT64 )                                       AS is_return_not_authorised
,CAST(RANK() OVER (PARTITION BY
                      rets.client_id
                     ,rets.s_orig_store_nr_ejr
                     ,rets.s_dat_formdate_ejr
                     ,rets.s_orig_receipt_nr_ejr
                     ,rets.s_pos_terminal_id_ejr
     ORDER BY   rets.dat_formdate
              , rets.time_receipt_ejr) AS INT64 )        AS return_seq
,rets.r_val_retail_ejr                                   AS val_return_same_receipt
,CAST(0 AS INT64 )                                       AS is_return_same_checker
,CAST(0 AS INT64 )                                       AS is_return_not_dv
,CAST(0 AS INT64 )                                       AS is_return_dv
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker_day
,CAST(0 AS INT64 )                                       AS is_return_no_orig_receipt
,CAST(0 AS INT64 )                                       AS is_return_sc
,CAST(0 AS INT64 )                                       AS is_return_no_orig_receipt_man
,CAST(0 AS INT64 )                                       AS is_return_many_itm
,CAST(0 AS INT64 )                                       AS is_return_same_itm_nb
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker_day_not_dv_man
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
      )                                                  AS r_val_retail_ejr
,CAST(1 AS NUMERIC)                             AS cnt_return_same_receipt
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_gr             

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS rl               
ON rh_gr.client_id                                 = rl.client_id
AND rh_gr.store_id                                  = rl.store_id
AND rh_gr.orig_receipt_nr_ejr                       = rl.orig_receipt_nr_ejr
AND rh_gr.pos_terminal_id                           = rl.pos_terminal_id
AND rh_gr.time_receipt_ejr                          = rl.time_receipt_ejr
AND rh_gr.dat_formdate                              = rl.dat_formdate

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st_pr       
ON rh_gr.client_id                                 = st_pr.client_id
AND rh_gr.store_id                                  = st_pr.store_id

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st         
ON rl.client_id                                    = st.client_id
AND CAST(rl.original_orig_store_nr_ejr AS INT64)                   = st.orig_store_nr

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb         
ON rh_vb.client_id                                 = rl.client_id
AND rh_vb.store_id                                  = st.store_id
AND rh_vb.orig_receipt_nr_ejr = CAST(rl.original_orig_receipt_nr_ejr AS INT64)
AND rh_vb.pos_terminal_id     = CAST(rl.original_pos_terminal_id_ejr AS INT64)
AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS tr
ON tr.client_id                                    = rh_gr.client_id
WHERE rh_gr.transactiontype_id                        = '150'                        
AND rh_vb.transactiontype_id                        = '100'
AND rl.transactiontype_id BETWEEN '140'   AND '149'                                
) AS rets
INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS tr
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
,CAST(s_orig_receipt_nr_ejr AS STRING)             AS s_orig_receipt_nr_ejr
,CAST(s_pos_terminal_id_ejr AS STRING)             AS s_pos_terminal_id_ejr
,CAST(-1 AS INT64)                                       AS item_id
,(SELECT COUNT(item_id)
  FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub 
  WHERE rh_gr_client_id          = rl_sub.client_id
  AND rh_gr_store_id             = rl_sub.store_id
  AND rh_gr_orig_receipt_nr_ejr  = rl_sub.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id      = rl_sub.pos_terminal_id
  AND rh_gr_dat_formdate         = rl_sub.dat_formdate
  AND rl_sub.transactiontype_id BETWEEN '140' AND '149'
  AND rl_sub.item_id IN (
      SELECT rl_sub_foll.item_id
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub_foll
      WHERE rh_gr_client_id          = rl_sub_foll.client_id
      AND rh_gr_store_id             = rl_sub_foll.store_id
      AND receipt_foll               = rl_sub_foll.orig_receipt_nr_ejr
      AND rh_gr_pos_terminal_id      = rl_sub_foll.pos_terminal_id
      AND rh_gr_dat_formdate         = rl_sub_foll.dat_formdate
  )
) AS cnt_return_item
,rh_gr_dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INT64)                                        AS cnt_sale_item
,CAST(0 AS INT64)                                        AS is_returned_wo_bon_per_day
,CAST(0 AS INT64)                                        AS is_returned_gt_original
,CAST(0 AS INT64)                                        AS cnt_returned_gt_original
,CAST(0 AS NUMERIC)                                      AS cnt_return_same_receipt
,CAST(1 AS INT64 )                                       AS is_return_not_authorised
,0                                                       AS return_seq
,CAST(0 AS INT64 )                                       AS val_return_same_receipt
,CAST(0 AS INT64 )                                       AS is_return_same_checker
,CAST(0 AS INT64 )                                       AS is_return_not_dv
,CAST(0 AS INT64 )                                       AS is_return_dv
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker_day
,CAST(0 AS INT64 )                                       AS is_return_no_orig_receipt
,CAST(0 AS INT64 )                                       AS is_return_sc
,CAST(0 AS INT64 )                                       AS is_return_no_orig_receipt_man
,CAST(0 AS INT64 )                                       AS is_return_many_itm
,CAST(0 AS INT64 )                                       AS is_return_same_itm_nb
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker_day_not_dv_man
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
              , rets.time_receipt_ejr) AS INT64 )      AS return_seq
,rets.r_val_retail_ejr           
,rets.receipt_foll
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
       )                                       AS r_val_retail_ejr
,(SELECT MIN(tr_next.orig_receipt_nr_ejr)
  FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next 
  WHERE rh_gr.client_id = tr_next.client_id
  AND rh_gr.store_id = tr_next.store_id
  AND rh_gr.pos_terminal_id = tr_next.pos_terminal_id
  AND rh_gr.dat_formdate = tr_next.dat_formdate
  AND rh_gr.checker_id = tr_next.checker_id
  AND tr_next.orig_receipt_nr_ejr > rh_gr.orig_receipt_nr_ejr
  AND CAST(tr_next.transactiontype_id AS INT64) NOT IN (150, 400, 405, 420, 425, 430, 480)) receipt_foll
,rl.original_orig_receipt_nr_ejr rl_original_orig_receipt_nr_ejr
,rl.original_pos_terminal_id_ejr rl_original_pos_terminal_id_ejr
,rl.original_dat_formdate_ejr rl_original_dat_formdate_ejr
,rl.original_orig_store_nr_ejr rl_original_orig_store_nr_ejr
,rl.qty_weight_ejr rl_qty_weight_ejr
,rl.weight_item_fg rl_weight_item_fg
,(SELECT MIN(tr_next.orig_receipt_nr_ejr)
  FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next 
  WHERE rl.client_id = tr_next.client_id
  AND st.store_id = tr_next.store_id
  AND CAST(rl.original_pos_terminal_id_ejr AS INT64)  = tr_next.pos_terminal_id
  AND rl.original_dat_formdate_ejr = tr_next.dat_formdate
  AND tr_next.orig_receipt_nr_ejr > CAST(rl.original_orig_receipt_nr_ejr AS INT64)
  AND CAST(tr_next.transactiontype_id AS INT64) NOT IN (150, 400, 405, 420, 425, 430, 480)) orig_receipt_foll
,st.store_id st_orig_store_id
,rh_gr.val_retail_ejr rh_gr_val_retail_ejr
,rh_gr.cnt_return_ejr rh_gr_cnt_return_ejr
,rh_gr.cnt_deposit_ejr rh_gr_cnt_deposit_ejr
,rh_gr.qty_return_ejr rh_gr_qty_return_ejr
                     
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_gr                        

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS rl                        
ON rh_gr.client_id                                 = rl.client_id
AND rh_gr.store_id                                  = rl.store_id
AND rh_gr.orig_receipt_nr_ejr                       = rl.orig_receipt_nr_ejr
AND rh_gr.pos_terminal_id                           = rl.pos_terminal_id
AND rh_gr.time_receipt_ejr                          = rl.time_receipt_ejr
AND rh_gr.dat_formdate                              = rl.dat_formdate
AND rl.authority_id                                   IS NULL

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st_pr   
ON rh_gr.client_id                                 = st_pr.client_id
AND rh_gr.store_id                                  = st_pr.store_id

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st          
ON rl.client_id                                    = st.client_id
AND CAST(rl.original_orig_store_nr_ejr AS INT64)                   = st.orig_store_nr

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb                  
ON rh_vb.client_id                                 = rl.client_id
AND rh_vb.store_id                                  = st.store_id
AND rh_vb.orig_receipt_nr_ejr                       = CAST(rl.original_orig_receipt_nr_ejr AS INT64)
AND rh_vb.pos_terminal_id                           = CAST(rl.original_pos_terminal_id_ejr AS INT64)
AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
LEFT  JOIN 
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
      ,STDDEV(qty_piece_ejr) stdev_qty_sold  
      ,STDDEV(qty_weight_ejr) stdev_wgt_sold 
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
       
      ,CASE WHEN item_entry_method_cd_ejr='RP' THEN 1 ELSE 0 END AS is_rp
      ,CASE WHEN item_entry_method_cd_ejr='KE' THEN 1 ELSE 0 END AS is_manual
      ,qty_piece_ejr
      ,qty_weight_ejr
      ,CASE WHEN item_entry_method_cd_ejr='SC' THEN 1 ELSE 0 END AS is_scanned
      FROM (SELECT * ,RANK() OVER ( PARTITION BY client_id,store_id,checker_id,dat_formdate,orig_receipt_nr_ejr 
                               ORDER BY timestamp_begin_ejr,orig_receipt_serial_nr_ejr) AS rank_by_timestamp
          FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1) rle
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr
    ON rle.store_id = revstr.store_id
      AND rle.client_id = revstr.client_id
      AND rle.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    WHERE transactiontype_id BETWEEN '140' AND '149'
        OR transactiontype_id = '101'
   
   QUALIFY series=1
  
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
AND dopp.item_id                                    = rl.item_id

WHERE rh_gr.transactiontype_id                        = '150'         
AND rh_vb.transactiontype_id                        = '100'
AND rl.transactiontype_id BETWEEN '140' AND '149'               
AND (COALESCE(dopp.is_doppeltipper,0) = 0 OR rh_gr.cnt_return_ejr > 1) 
) AS rets
INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS tr
ON tr.client_id             = rets.rh_gr_client_id

LEFT  JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next 
  ON rh_gr_client_id                = tr_next.client_id
  AND rh_gr_store_id                = tr_next.store_id
  AND receipt_foll                  = tr_next.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = tr_next.pos_terminal_id
  AND rh_gr_dat_formdate            = tr_next.dat_formdate

INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_orig_next 
  ON s_client_id_ejr                  = tr_orig_next.client_id
  AND st_orig_store_id                = tr_orig_next.store_id
  AND orig_receipt_foll               = tr_orig_next.orig_receipt_nr_ejr
  AND s_pos_terminal_id_ejr           = tr_orig_next.pos_terminal_id
  AND s_dat_formdate_ejr              = tr_orig_next.dat_formdate
LEFT  JOIN                                                  
    (
        SELECT
            rl.store_id
            , rl.client_id
            , rl.pos_terminal_id
            , rl.dat_formdate
            , rl.orig_receipt_nr_ejr
            , SUM(COALESCE(rl.val_retail_ejr, 0)) AS total_value
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr
        INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
                ON rh_gr.client_id = rl.client_id
                AND rh_gr.store_id = rl.store_id
                AND rh_gr.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
                AND rh_gr.pos_terminal_id = rl.pos_terminal_id
                AND rh_gr.time_receipt_ejr = rl.time_receipt_ejr
                AND rh_gr.dat_formdate = rl.dat_formdate
        WHERE
            (CAST(rl.transactiontype_id AS INT64) BETWEEN 140 AND 149
            OR CAST(rl.transactiontype_id AS INT64) = 120)
            AND CAST(rh_gr.transactiontype_id AS INT64) = 150
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
LEFT  JOIN                                                  
    (
        SELECT
            store_id
            , client_id
            , pos_terminal_id
            , dat_formdate
            , time_receipt_ejr
            , orig_receipt_nr_ejr
            , val_retail_payment_ejr
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_1
        WHERE
            CAST(tendertype_cd_ejr AS INT64) = 11
            AND CAST(cnt_payment_ejr AS INT64) = 1
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
  
  AND ABS(rh_gr_val_retail_ejr) <> tr_orig_next.val_retail_ejr
  
  AND
  (
  
  (rets.r_val_retail_ejr <= tr.return_not_authorised_val AND rets.r_val_retail_ejr > tr.return_not_authorised_val2)
  OR
  
  (rets.r_val_retail_ejr <= COALESCE(tr.return_not_authorised_val, 99999999999999) AND rets.r_val_retail_ejr > tr.return_not_authorised_val2)
  OR
  
  (rets.r_val_retail_ejr <= tr.return_not_authorised_val AND rets.r_val_retail_ejr > COALESCE(tr.return_not_authorised_val2,0))
  
  )
  
  AND COALESCE(pmt.val_retail_payment_ejr, 0) <> ABS(tval.total_value)
)


  WHERE (SELECT COUNT(item_id)
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub 
      WHERE rh_gr_client_id          = rl_sub.client_id
      AND rh_gr_store_id             = rl_sub.store_id
      AND rh_gr_orig_receipt_nr_ejr  = rl_sub.orig_receipt_nr_ejr
      AND rh_gr_pos_terminal_id      = rl_sub.pos_terminal_id
      AND rh_gr_dat_formdate         = rl_sub.dat_formdate
      AND rl_sub.transactiontype_id BETWEEN '140' AND '149'
      AND rl_sub.item_id IN (
          SELECT rl_sub_foll.item_id
          FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub_foll
          WHERE rh_gr_client_id          = rl_sub_foll.client_id
          AND rh_gr_store_id             = rl_sub_foll.store_id
          AND receipt_foll               = rl_sub_foll.orig_receipt_nr_ejr
          AND rh_gr_pos_terminal_id      = rl_sub_foll.pos_terminal_id
          AND rh_gr_dat_formdate         = rl_sub_foll.dat_formdate
      )
  ) < rh_gr_cnt_return_ejr-rh_gr_cnt_deposit_ejr
  
  
  AND (COALESCE(tr_next_cnt_sell_item, 0) > 1
       OR rh_gr_cnt_return_ejr - rh_gr_cnt_deposit_ejr > 1 
       OR COALESCE(tr_next_qty_piece_ejr, 0) <> ABS(CASE WHEN rl_weight_item_fg=1 THEN rl_qty_weight_ejr ELSE rh_gr_qty_return_ejr END)
       OR (COALESCE(tr_next_qty_piece_ejr, 0) = 1 AND ABS(CASE WHEN rl_weight_item_fg=1 THEN rl_qty_weight_ejr ELSE rh_gr_qty_return_ejr END) = 1))

UNION ALL

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
,CAST(s_orig_receipt_nr_ejr AS STRING)         AS s_orig_receipt_nr_ejr
,CAST(s_pos_terminal_id_ejr AS STRING)         AS s_pos_terminal_id_ejr
,CAST(-1 AS INT64)                                  AS item_id
,(SELECT COUNT(item_id)
  FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub 
  WHERE rh_gr_client_id          = rl_sub.client_id
  AND rh_gr_store_id             = rl_sub.store_id
  AND rh_gr_orig_receipt_nr_ejr  = rl_sub.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id      = rl_sub.pos_terminal_id
  AND rh_gr_dat_formdate         = rl_sub.dat_formdate
  AND rl_sub.transactiontype_id BETWEEN '140' AND '149'
  AND rl_sub.item_id IN (
      SELECT rl_sub_foll.item_id
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub_foll
      WHERE rh_gr_client_id          = rl_sub_foll.client_id
      AND rh_gr_store_id             = rl_sub_foll.store_id
      AND receipt_foll               = rl_sub_foll.orig_receipt_nr_ejr
      AND rh_gr_pos_terminal_id      = rl_sub_foll.pos_terminal_id
      AND rh_gr_dat_formdate         = rl_sub_foll.dat_formdate
  )
) AS cnt_return_item
,rh_gr_dat_formdate                                      AS dat_last_returndate
,CAST(0 AS INT64)                                        AS cnt_sale_item
,CAST(0 AS INT64)                                        AS is_returned_wo_bon_per_day
,CAST(0 AS INT64)                                        AS is_returned_gt_original
,CAST(0 AS INT64)                                        AS cnt_returned_gt_original
,cnt_return_same_receipt                                 AS cnt_return_same_receipt
,CAST(0 AS INT64 )                                       AS is_return_not_authorised
,return_seq                                              AS return_seq
,r_val_retail_ejr                                        AS val_return_same_receipt
,CAST(1 AS INT64 )                                       AS is_return_same_checker
,CAST(0 AS INT64 )                                       AS is_return_not_dv
,CAST(0 AS INT64 )                                       AS is_return_dv
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker_day
,CAST(0 AS INT64 )                                       AS is_return_no_orig_receipt
,CAST(0 AS INT64 )                                       AS is_return_sc
,CAST(0 AS INT64 )                                       AS is_return_no_orig_receipt_man
,CAST(0 AS INT64 )                                       AS is_return_many_itm
,CAST(0 AS INT64 )                                       AS is_return_same_itm_nb
,CAST(0 AS INT64 )                                       AS is_return_orig_same_checker_day_not_dv_man
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
                ) AS NUMERIC)                       AS cnt_return_same_receipt
,CAST(RANK() OVER (PARTITION BY
                      rets.rh_gr_client_id
                     ,rets.s_orig_store_nr_ejr
                     ,rets.s_dat_formdate_ejr
                     ,rets.s_orig_receipt_nr_ejr
                     ,rets.s_pos_terminal_id_ejr
                     ,rets.checker_id
     ORDER BY   rets.rh_gr_dat_formdate
              , rets.time_receipt_ejr) AS INT64 )        AS return_seq
,rets.r_val_retail_ejr           
,rets.receipt_foll
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
           )                                             AS r_val_retail_ejr
,COUNT(rh_gr.checker_id) OVER (
           PARTITION BY
             rh_gr.client_id
            ,rh_gr.store_id
            ,rh_gr.dat_formdate
            ,rh_gr.orig_receipt_nr_ejr
            ,rh_gr.pos_terminal_id
            ,rh_gr.time_receipt_ejr
           )                                             AS cnt_return_same_receipt
,(SELECT MIN(tr_next.orig_receipt_nr_ejr)
  FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next 
  WHERE rh_gr.client_id = tr_next.client_id
  AND rh_gr.store_id = tr_next.store_id
  AND rh_gr.pos_terminal_id = tr_next.pos_terminal_id
  AND rh_gr.dat_formdate = tr_next.dat_formdate
  AND rh_gr.checker_id = tr_next.checker_id
  AND tr_next.orig_receipt_nr_ejr > rh_gr.orig_receipt_nr_ejr
  AND CAST(tr_next.transactiontype_id AS INT64) NOT IN (150, 400, 405, 420, 425, 430, 480)) receipt_foll
,rl.original_orig_receipt_nr_ejr rl_original_orig_receipt_nr_ejr
,rl.original_pos_terminal_id_ejr rl_original_pos_terminal_id_ejr
,rl.original_dat_formdate_ejr rl_original_dat_formdate_ejr
,rl.original_orig_store_nr_ejr rl_original_orig_store_nr_ejr
,rl.qty_weight_ejr rl_qty_weight_ejr
,rl.weight_item_fg rl_weight_item_fg
,(SELECT MIN(tr_next.orig_receipt_nr_ejr)
  FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next 
  WHERE rl.client_id = tr_next.client_id
  AND st.store_id = tr_next.store_id
  AND CAST(rl.original_pos_terminal_id_ejr AS INT64)  = tr_next.pos_terminal_id
  AND rl.original_dat_formdate_ejr = tr_next.dat_formdate
  AND tr_next.orig_receipt_nr_ejr > CAST(rl.original_orig_receipt_nr_ejr AS INT64)
  AND CAST(tr_next.transactiontype_id AS INT64) NOT IN (150, 400, 405, 420, 425, 430, 480)) orig_receipt_foll
,st.store_id st_orig_store_id
,rh_gr.val_retail_ejr rh_gr_val_retail_ejr
,rh_gr.cnt_return_ejr rh_gr_cnt_return_ejr
,rh_gr.cnt_deposit_ejr rh_gr_cnt_deposit_ejr
,rh_gr.qty_return_ejr rh_gr_qty_return_ejr
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_gr                        
INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS rl                        
ON rh_gr.client_id                                  = rl.client_id
AND rh_gr.store_id                                  = rl.store_id
AND rh_gr.orig_receipt_nr_ejr                       = rl.orig_receipt_nr_ejr
AND rh_gr.pos_terminal_id                           = rl.pos_terminal_id
AND rh_gr.time_receipt_ejr                          = rl.time_receipt_ejr
AND rh_gr.dat_formdate                              = rl.dat_formdate

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st_pr   
ON rh_gr.client_id                                  = st_pr.client_id
AND rh_gr.store_id                                  = st_pr.store_id

INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st         
ON rl.client_id                   = st.client_id
AND CAST(rl.original_orig_store_nr_ejr AS INT64) = st.orig_store_nr
 
INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb                  
ON rh_vb.client_id             = rl.client_id
AND rh_vb.store_id             = st.store_id
AND rh_vb.orig_receipt_nr_ejr  = CAST(rl.original_orig_receipt_nr_ejr AS INT64)
AND rh_vb.pos_terminal_id      = CAST(rl.original_pos_terminal_id_ejr AS INT64)
AND rh_vb.dat_formdate                              = rl.original_dat_formdate_ejr
AND rh_vb.checker_id                                = rh_gr.checker_id    
LEFT  JOIN 
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
      ,STDDEV(qty_piece_ejr) stdev_qty_sold  
      ,STDDEV(qty_weight_ejr) stdev_wgt_sold 
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
       
      ,CASE WHEN item_entry_method_cd_ejr='RP' THEN 1 ELSE 0 END AS is_rp
      ,CASE WHEN item_entry_method_cd_ejr='KE' THEN 1 ELSE 0 END AS is_manual
      ,qty_piece_ejr
      ,qty_weight_ejr
      ,CASE WHEN item_entry_method_cd_ejr='SC' THEN 1 ELSE 0 END AS is_scanned
      FROM (SELECT * ,RANK() OVER ( PARTITION BY client_id,store_id,checker_id,dat_formdate,orig_receipt_nr_ejr 
                               ORDER BY timestamp_begin_ejr,orig_receipt_serial_nr_ejr) AS rank_by_timestamp
          FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1) rle
    INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr
    ON rle.store_id = revstr.store_id
      AND rle.client_id = revstr.client_id
      AND rle.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    WHERE transactiontype_id BETWEEN '140' AND '149'
        OR transactiontype_id = '101'
   
   QUALIFY series=1
  
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
ON dopp.client_id                                  = rh_vb.client_id
AND dopp.store_id                                  = rh_vb.store_id
AND dopp.orig_receipt_nr_ejr                       = rh_vb.orig_receipt_nr_ejr
AND dopp.pos_terminal_id                           = rh_vb.pos_terminal_id
AND dopp.dat_formdate                              = rh_vb.dat_formdate
AND dopp.item_id                                    = rl.item_id

WHERE rh_gr.transactiontype_id                        = '150'         
AND rh_vb.transactiontype_id                        = '100'
AND rl.transactiontype_id BETWEEN '140' AND '149'               
AND (COALESCE(dopp.is_doppeltipper,0) = 0 OR rh_gr.cnt_return_ejr > 1) 
) AS rets
INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS tr
ON tr.client_id             = rets.rh_gr_client_id

LEFT  JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_next 
  ON rh_gr_client_id                = tr_next.client_id
  AND rh_gr_store_id                = tr_next.store_id
  AND receipt_foll                  = tr_next.orig_receipt_nr_ejr
  AND rh_gr_pos_terminal_id         = tr_next.pos_terminal_id
  AND rh_gr_dat_formdate            = tr_next.dat_formdate

INNER JOIN ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 tr_orig_next 
  ON s_client_id_ejr                  = tr_orig_next.client_id
  AND st_orig_store_id                = tr_orig_next.store_id
  AND orig_receipt_foll               = tr_orig_next.orig_receipt_nr_ejr
  AND s_pos_terminal_id_ejr           = tr_orig_next.pos_terminal_id
  AND s_dat_formdate_ejr              = tr_orig_next.dat_formdate
LEFT  JOIN                                                  
    (
        SELECT
            rl.store_id
            , rl.client_id
            , rl.pos_terminal_id
            , rl.dat_formdate
            , rl.orig_receipt_nr_ejr
            , SUM(COALESCE(rl.val_retail_ejr, 0)) AS total_value
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 rh_gr
        INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
                ON rh_gr.client_id = rl.client_id
                AND rh_gr.store_id = rl.store_id
                AND rh_gr.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
                AND rh_gr.pos_terminal_id = rl.pos_terminal_id
                AND rh_gr.time_receipt_ejr = rl.time_receipt_ejr
                AND rh_gr.dat_formdate = rl.dat_formdate
        WHERE
            (CAST(rl.transactiontype_id AS INT64) BETWEEN 140 AND 149
            OR CAST(rl.transactiontype_id AS INT64) = 120)
            AND CAST(rh_gr.transactiontype_id AS INT64) = 150
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
LEFT  JOIN                                                  
    (
        SELECT
            store_id
            , client_id
            , pos_terminal_id
            , dat_formdate
            , time_receipt_ejr
            , orig_receipt_nr_ejr
            , val_retail_payment_ejr
        FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_1
        WHERE
            CAST(tendertype_cd_ejr AS INT64) = 11
            AND CAST(cnt_payment_ejr AS INT64) = 1
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
  
  AND ABS(rh_gr_val_retail_ejr) <> tr_orig_next.val_retail_ejr
  
  
  AND COALESCE(pmt.val_retail_payment_ejr, 0) <> ABS(tval.total_value)
)


  WHERE (SELECT COUNT(item_id)
      FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub 
      WHERE rh_gr_client_id          = rl_sub.client_id
      AND rh_gr_store_id             = rl_sub.store_id
      AND rh_gr_orig_receipt_nr_ejr  = rl_sub.orig_receipt_nr_ejr
      AND rh_gr_pos_terminal_id      = rl_sub.pos_terminal_id
      AND rh_gr_dat_formdate         = rl_sub.dat_formdate
      AND rl_sub.transactiontype_id BETWEEN '140' AND '149'
      AND rl_sub.item_id IN (
          SELECT rl_sub_foll.item_id
          FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl_sub_foll
          WHERE rh_gr_client_id          = rl_sub_foll.client_id
          AND rh_gr_store_id             = rl_sub_foll.store_id
          AND receipt_foll               = rl_sub_foll.orig_receipt_nr_ejr
          AND rh_gr_pos_terminal_id      = rl_sub_foll.pos_terminal_id
          AND rh_gr_dat_formdate         = rl_sub_foll.dat_formdate
      )
  ) < rh_gr_cnt_return_ejr-rh_gr_cnt_deposit_ejr
  
  
   AND (COALESCE(tr_next_cnt_sell_item, 0) > 1
        OR rh_gr_cnt_return_ejr - rh_gr_cnt_deposit_ejr > 1 
        OR COALESCE(tr_next_qty_piece_ejr, 0) <> ABS(CASE WHEN rl_weight_item_fg=1 THEN rl_qty_weight_ejr ELSE rh_gr_qty_return_ejr END)
        OR (COALESCE(tr_next_qty_piece_ejr, 0) = 1 AND ABS(CASE WHEN rl_weight_item_fg=1 THEN rl_qty_weight_ejr ELSE rh_gr_qty_return_ejr END) = 1));