/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for V_MAT_ZKP_ETL_EJR_RETURN_PRICE_2
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  01.12.2021    Wandtke,Andrzej          AP0089687 replace p_lew_process.t_sap_migration_client_2 (not anymore maintained in Cloud) by p_lew_core.t_client_migration_per_2 (subquery mastmig)
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_RETURN_PRICE_2
AS
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
,returnx.rt_price_retail_ejr
,salex.s_price_retail_ejr
,itmprc.max_wawi_price
,CASE WHEN returnx.rt_price_retail_ejr > salex.s_price_retail_ejr   AND returnx.s_client_id_ejr IS NOT NULL THEN 1 ELSE 0 END AS is_return_price_gt_sale
,CASE WHEN returnx.rt_price_retail_ejr > itmprc.max_wawi_price      AND returnx.s_client_id_ejr IS NULL     THEN 1 ELSE 0 END AS is_return_price_gt_wawi
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
 ,MAX(x1.rt_price_retail_ejr) Over (PARTITION BY
                       x1.client_id
                      ,x1.store_id
                      ,x1.pos_terminal_id
                      ,x1.dat_formdate
                      ,x1.time_receipt_ejr
                      ,x1.orig_receipt_nr_ejr
                      ,x1.item_id) AS rt_price_retail_ejr
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
  ,temp.rt_price_retail_ejr
  FROM
  (SELECT
    rh_gr.client_id                 AS client_id
   ,rh_gr.store_id                  AS store_id
   ,rh_gr.pos_terminal_id           AS pos_terminal_id
   ,rh_gr.dat_formdate              AS dat_formdate
   ,rh_gr.time_receipt_ejr          AS time_receipt_ejr
   ,rh_gr.orig_receipt_nr_ejr       AS orig_receipt_nr_ejr
   ,rh_gr.checker_id                AS checker_id
   ,rh_vb.client_id                 AS s_client_id_ejr
   ,rh_vb.store_id                  AS s_orig_store_nr_ejr
   ,rh_vb.dat_formdate              AS s_dat_formdate_ejr
   ,rh_vb.orig_receipt_nr_ejr       AS s_orig_receipt_nr_ejr
   ,rh_vb.pos_terminal_id           AS s_pos_terminal_id_ejr
   ,rl.item_id
   ,rl.orig_receipt_serial_nr_ejr   AS r_orig_receipt_serial_nr_ejr
   ,rl.price_retail_adjstd_ejr      AS rt_price_retail_ejr
   ,rlv.price_retail_adjstd_ejr     AS s_price_retail_ejr
   ,rlv.orig_receipt_serial_nr_ejr  AS s_orig_receipt_serial_nr_ejr
   FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 rh_gr  -- Geldrueckgaben
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 rl -- Geldrueckgabe-Zeilen
   ON rh_gr.client_id = rl.client_id
     AND rh_gr.store_id = rl.store_id
     AND rh_gr.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
     AND rh_gr.pos_terminal_id = rl.pos_terminal_id
     AND rh_gr.time_receipt_ejr = rl.time_receipt_ejr
     AND rh_gr.dat_formdate = rl.dat_formdate
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 st_pr -- Pruefung der Filiale  ,ob fuer Beladung relevant
   ON rh_gr.client_id = st_pr.client_id
   AND rh_gr.store_id = st_pr.store_id
   LEFT OUTER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2  st -- Ermittlung der store_id fuer Verkaufsbon
   ON rl.client_id = st.client_id
   AND rl.original_orig_store_nr_ejr = Cast(st.orig_store_nr AS VARCHAR(100))
   LEFT OUTER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 rh_vb -- Verkaufsbon
   ON rh_vb.client_id = rl.client_id
   AND rh_vb.store_id = st.store_id
   AND Cast(rh_vb.orig_receipt_nr_ejr AS VARCHAR(100)) = rl.original_orig_receipt_nr_ejr
   AND Cast(rh_vb.pos_terminal_id AS VARCHAR(100)) = rl.original_pos_terminal_id_ejr
   AND rh_vb.dat_formdate = rl.original_dat_formdate_ejr
   AND rh_vb.transactiontype_id = '100'
   LEFT OUTER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 rlv  -- Receiptline Verkauf
   ON rh_vb.client_id = rlv.client_id
   AND rh_vb.store_id = rlv.store_id
   AND rh_vb.orig_receipt_nr_ejr = rlv.orig_receipt_nr_ejr
   AND rh_vb.pos_terminal_id = rlv.pos_terminal_id
   AND rh_vb.dat_formdate = rlv.dat_formdate
   AND rl.item_id = rlv.item_id
   WHERE rh_gr.transactiontype_id = '150'  -- Filter Geldrueckgaben (Header-transactiontype_id = '150')
   -- Filter Geldrueckgaben (Header-transactiontype_id = '150')
   ) temp
 ) x1
) returnx
LEFT OUTER JOIN
(SELECT DISTINCT
  x2.s_client_id_ejr
 ,x2.s_orig_store_nr_ejr
 ,x2.s_dat_formdate_ejr
 ,x2.s_orig_receipt_nr_ejr
 ,x2.s_pos_terminal_id_ejr
 ,x2.item_id
 ,MAX(x2.s_price_retail_ejr) Over (PARTITION BY
                       x2.s_client_id_ejr
                      ,x2.s_orig_store_nr_ejr
                      ,x2.s_dat_formdate_ejr
                      ,x2.s_orig_receipt_nr_ejr
                      ,x2.s_pos_terminal_id_ejr
                      ,x2.item_id) AS s_price_retail_ejr
 FROM
 (SELECT DISTINCT
  temp.s_client_id_ejr
 ,temp.s_orig_store_nr_ejr
 ,temp.s_dat_formdate_ejr
 ,temp.s_orig_receipt_nr_ejr
 ,temp.s_pos_terminal_id_ejr
 ,temp.item_id
 ,temp.s_orig_receipt_serial_nr_ejr
 ,temp.s_price_retail_ejr
 FROM
 (SELECT
   rh_gr.client_id                 AS client_id
  ,rh_gr.store_id                  AS store_id
  ,rh_gr.pos_terminal_id           AS pos_terminal_id
  ,rh_gr.dat_formdate              AS dat_formdate
  ,rh_gr.time_receipt_ejr          AS time_receipt_ejr
  ,rh_gr.orig_receipt_nr_ejr       AS orig_receipt_nr_ejr
  ,rh_gr.checker_id                AS checker_id
  ,rh_vb.client_id                 AS s_client_id_ejr
  ,rh_vb.store_id                  AS s_orig_store_nr_ejr
  ,rh_vb.dat_formdate              AS s_dat_formdate_ejr
  ,rh_vb.orig_receipt_nr_ejr       AS s_orig_receipt_nr_ejr
  ,rh_vb.pos_terminal_id           AS s_pos_terminal_id_ejr
  ,rl.item_id
  ,rl.orig_receipt_serial_nr_ejr   AS r_orig_receipt_serial_nr_ejr
  ,rl.price_retail_adjstd_ejr      AS rt_price_retail_ejr
  ,rlv.price_retail_adjstd_ejr     AS s_price_retail_ejr
  ,rlv.orig_receipt_serial_nr_ejr  AS s_orig_receipt_serial_nr_ejr
  FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 rh_gr  -- Geldrueckgaben
  INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 rl -- Geldrueckgabe-Zeilen
  ON rh_gr.client_id = rl.client_id
  AND rh_gr.store_id = rl.store_id
  AND rh_gr.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
  AND rh_gr.pos_terminal_id = rl.pos_terminal_id
  AND rh_gr.time_receipt_ejr = rl.time_receipt_ejr
  AND rh_gr.dat_formdate = rl.dat_formdate
  INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 st_pr -- Pruefung der Filiale  ,ob fuer Beladung relevant
  ON rh_gr.client_id = st_pr.client_id
  AND rh_gr.store_id = st_pr.store_id
  LEFT OUTER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2  st -- Ermittlung der store_id fuer Verkaufsbon
  ON rl.client_id = st.client_id
  AND rl.original_orig_store_nr_ejr = Cast(st.orig_store_nr AS VARCHAR(100))
  LEFT OUTER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 rh_vb -- Verkaufsbon
  ON rh_vb.client_id = rl.client_id
  AND rh_vb.store_id = st.store_id
  AND Cast(rh_vb.orig_receipt_nr_ejr AS VARCHAR(100)) = rl.original_orig_receipt_nr_ejr
  AND Cast(rh_vb.pos_terminal_id AS VARCHAR(100)) = rl.original_pos_terminal_id_ejr
  AND rh_vb.dat_formdate = rl.original_dat_formdate_ejr
  AND rh_vb.transactiontype_id = '100'
  LEFT OUTER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 rlv  -- Receiptline Verkauf
  ON rh_vb.client_id = rlv.client_id
  AND rh_vb.store_id = rlv.store_id
  AND rh_vb.orig_receipt_nr_ejr = rlv.orig_receipt_nr_ejr
  AND rh_vb.pos_terminal_id = rlv.pos_terminal_id
  AND rh_vb.dat_formdate = rlv.dat_formdate
  AND rl.item_id = rlv.item_id
  WHERE rh_gr.transactiontype_id = '150'  -- Filter Geldrueckgaben (Header-transactiontype_id = '150')
-- Filter Geldrueckgaben (Header-transactiontype_id = '150')
 ) temp
) x2
) salex
ON returnx.s_client_id_ejr = salex.s_client_id_ejr
AND returnx.s_orig_store_nr_ejr = salex.s_orig_store_nr_ejr
AND returnx.s_dat_formdate_ejr = salex.s_dat_formdate_ejr
AND returnx.s_orig_receipt_nr_ejr = salex.s_orig_receipt_nr_ejr
AND returnx.s_pos_terminal_id_ejr = salex.s_pos_terminal_id_ejr
AND returnx.item_id = salex.item_id
LEFT OUTER JOIN
(SELECT
  itmprcsub.client_id
 ,itmprcsub.item_id
 ,itmprcsub.store_id
 ,MAX(itmprcsub.max_wawi_price) AS max_wawi_price
 FROM
  (SELECT
    pr.client_id
   ,pr.item_id
   ,dtx.store_id
   ,MAX(pr.price_retail) AS max_wawi_price
   FROM p_lew_mart_msi.v_mat0_zkp_etl_itm_price_2 pr
   INNER JOIN
   (SELECT
     dtt.client_id
    ,dtt.store_id
    ,MIN(dtt.dat_formdate_from) AS dat_formdate_from
    ,MAX(dtt.dat_formdate_until) AS dat_formdate_until
    FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 dtt
    GROUP BY
    dtt.client_id
   ,dtt.store_id
  ) dtx
-- Finde den hoechsten Preis im Betrachtungszeitraum
 ON pr.dat_valid_until >= dtx.dat_formdate_from
 AND pr.dat_valid_from <= dtx.dat_formdate_until
 AND pr.client_id = dtx.client_id
 GROUP BY
  pr.client_id
 ,pr.item_id
 ,dtx.store_id

 UNION
 SELECT
  ejrmaxprc.client_id
 ,ejrmaxprc.item_id
 ,ejrmaxprc.store_id
 ,ejrmaxprc.max_wawi_price
 FROM
  (SELECT
   rcplext.client_id
  ,rcplext.item_id
  ,dtx.store_id
  ,rcplext.max_wawi_price
  FROM
  (SELECT
   rcplex.client_id
  ,rcplex.item_id
  ,dtt.wh_id
  ,MAX(rcplex.price_retail_ejr) AS max_wawi_price
   FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 rcplex
   -- Necessary INNER JOIN to get WH_ID.
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 dtt
   ON rcplex.client_id = dtt.client_id
   AND rcplex.store_id = dtt.store_id
   GROUP BY
    rcplex.client_id
   ,rcplex.item_id
   ,dtt.wh_id
  ) rcplext
  INNER JOIN
  (SELECT
    dtt.client_id
   ,dtt.wh_id
   ,dtt.store_id
   ,MIN(dtt.dat_formdate_from) AS dat_formdate_from
   ,MAX(dtt.dat_formdate_until) AS dat_formdate_until
  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 dtt
  GROUP BY
   dtt.client_id
  ,dtt.wh_id
  ,dtt.store_id
  ) dtx
  ON rcplext.client_id = dtx.client_id
  AND rcplext.wh_id = dtx.wh_id
  INNER JOIN
  -- Only stores already migrated to SAP.
  (SELECT
     client_id
    ,migration_dat_valid_from
    ,migration_dat_valid_to
   FROM p_lew_core.t_client_migration_per_2) mastmig
   ON rcplext.client_id = mastmig.client_id
   AND dtx.dat_formdate_until BETWEEN mastmig.migration_dat_valid_from AND migration_dat_valid_to
 ) ejrmaxprc
) itmprcsub
GROUP BY 1,2,3
) itmprc
ON returnx.client_id = itmprc.client_id
AND returnx.item_id = itmprc.item_id
AND returnx.store_id = itmprc.store_id
INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_2 tr
ON tr.client_id = returnx.client_id
WHERE (      rt_price_retail_ejr > s_price_retail_ejr
           AND rt_price_retail_ejr >= tr.return_item_price
           AND returnx.s_client_id_ejr IS NOT NULL)
   OR (      rt_price_retail_ejr > itmprc.max_wawi_price
           AND rt_price_retail_ejr >= tr.return_item_price
           AND returnx.s_client_id_ejr IS NULL)
;
