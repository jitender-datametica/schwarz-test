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


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_return_price_2 AS -- Geldrueckgaben
 -- Geldrueckgabe-Zeilen

-- Pruefung der Filiale  ,ob fuer Beladung relevant
 -- Ermittlung der store_id fuer Verkaufsbon
 -- Verkaufsbon

-- Receiptline Verkauf
 -- Geldrueckgaben
 -- Geldrueckgabe-Zeilen
 -- Pruefung der Filiale  ,ob fuer Beladung relevant

-- Ermittlung der store_id fuer Verkaufsbon
 -- Verkaufsbon
 -- Receiptline Verkauf

-- Finde den hoechsten Preis im Betrachtungszeitraum
 -- Necessary INNER JOIN to get WH_ID.

-- Only stores already migrated to SAP.
 SELECT returnx.client_id,
 returnx.store_id,
 returnx.pos_terminal_id,
 returnx.dat_formdate,
 returnx.time_receipt_ejr,
 returnx.orig_receipt_nr_ejr,
 returnx.checker_id,
 returnx.s_client_id_ejr,
 returnx.s_orig_store_nr_ejr,
 returnx.s_dat_formdate_ejr,
 returnx.s_orig_receipt_nr_ejr,
 returnx.s_pos_terminal_id_ejr,
 returnx.item_id,
 returnx.rt_price_retail_ejr_0 AS rt_price_retail_ejr,
 salex.s_price_retail_ejr_0 AS s_price_retail_ejr,
 itmprc.max_wawi_price,
  CASE
  WHEN returnx.rt_price_retail_ejr_0 > salex.s_price_retail_ejr_0 AND returnx.s_client_id_ejr IS NOT NULL
  THEN 1
  ELSE 0
  END AS is_return_price_gt_sale,
  CASE
  WHEN returnx.rt_price_retail_ejr_0 > itmprc.max_wawi_price AND returnx.s_client_id_ejr IS NULL
  THEN 1
  ELSE 0
  END AS is_return_price_gt_wawi
FROM (SELECT DISTINCT client_id,
   store_id,
   pos_terminal_id,
   dat_formdate,
   time_receipt_ejr,
   orig_receipt_nr_ejr,
   checker_id,
   s_client_id_ejr,
   s_orig_store_nr_ejr,
   s_dat_formdate_ejr,
   s_orig_receipt_nr_ejr,
   s_pos_terminal_id_ejr,
   item_id,
   MAX(rt_price_retail_ejr) OVER (PARTITION BY client_id, store_id, pos_terminal_id, dat_formdate, time_receipt_ejr,
      orig_receipt_nr_ejr, item_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS rt_price_retail_ejr_0
  FROM (SELECT DISTINCT RH_GR.client_id,
     RH_GR.store_id,
     RH_GR.pos_terminal_id,
     RH_GR.dat_formdate,
     RH_GR.time_receipt_ejr,
     RH_GR.orig_receipt_nr_ejr,
     RH_GR.checker_id,
     RH_VB.client_id AS s_client_id_ejr,
     RH_VB.store_id AS s_orig_store_nr_ejr,
     RH_VB.dat_formdate AS s_dat_formdate_ejr,
     RH_VB.orig_receipt_nr_ejr AS s_orig_receipt_nr_ejr,
     RH_VB.pos_terminal_id AS s_pos_terminal_id_ejr,
     RL.item_id,
     RL.orig_receipt_serial_nr_ejr AS r_orig_receipt_serial_nr_ejr,
     RL.price_retail_adjstd_ejr AS rt_price_retail_ejr
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 AS RH_GR
     INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 AS RL ON RH_GR.client_id = RL.client_id AND
           RH_GR.store_id = RL.store_id AND RH_GR.orig_receipt_nr_ejr = RL.orig_receipt_nr_ejr AND RH_GR.pos_terminal_id
          = RL.pos_terminal_id AND RH_GR.time_receipt_ejr = RL.time_receipt_ejr AND RH_GR.dat_formdate = RL.dat_formdate
       
     INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS ST_PR ON RH_GR.client_id = ST_PR.client_id
        AND RH_GR.store_id = ST_PR.store_id
     LEFT JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS ST ON RL.client_id = ST.client_id AND RL
       .original_orig_store_nr_ejr = CAST(ST.orig_store_nr AS STRING)
     LEFT JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 AS RH_VB ON RL.client_id = RH_VB.client_id
          AND ST.store_id = RH_VB.store_id AND CAST(RH_VB.orig_receipt_nr_ejr AS STRING) = RL.original_orig_receipt_nr_ejr
           AND CAST(RH_VB.pos_terminal_id AS STRING) = RL.original_pos_terminal_id_ejr AND RL.original_dat_formdate_ejr
        = RH_VB.dat_formdate AND RH_VB.transactiontype_id = '100'
     LEFT JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 AS RLV ON RH_VB.client_id = RLV.client_id AND
           RH_VB.store_id = RLV.store_id AND RH_VB.orig_receipt_nr_ejr = RLV.orig_receipt_nr_ejr AND RH_VB.pos_terminal_id
          = RLV.pos_terminal_id AND RH_VB.dat_formdate = RLV.dat_formdate AND RL.item_id = RLV.item_id
    WHERE RH_GR.transactiontype_id = '150' -- Filter Geldrueckgaben (Header-transactiontype_id = '150')

      -- Filter Geldrueckgaben (Header-transactiontype_id = '150')
) AS x1) AS returnx
 LEFT JOIN (SELECT DISTINCT s_client_id_ejr,
   s_orig_store_nr_ejr,
   s_dat_formdate_ejr,
   s_orig_receipt_nr_ejr,
   s_pos_terminal_id_ejr,
   item_id,
   MAX(s_price_retail_ejr) OVER (PARTITION BY s_client_id_ejr, s_orig_store_nr_ejr, s_dat_formdate_ejr,
      s_orig_receipt_nr_ejr, s_pos_terminal_id_ejr, item_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
   AS s_price_retail_ejr_0
  FROM (SELECT DISTINCT RH_VB0.client_id AS s_client_id_ejr,
     RH_VB0.store_id AS s_orig_store_nr_ejr,
     RH_VB0.dat_formdate AS s_dat_formdate_ejr,
     RH_VB0.orig_receipt_nr_ejr AS s_orig_receipt_nr_ejr,
     RH_VB0.pos_terminal_id AS s_pos_terminal_id_ejr,
     RL0.item_id,
     RLV0.orig_receipt_serial_nr_ejr AS s_orig_receipt_serial_nr_ejr,
     RLV0.price_retail_adjstd_ejr AS s_price_retail_ejr
    FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 AS RH_GR0
     INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 AS RL0 ON RH_GR0.client_id = RL0.client_id AND
           RH_GR0.store_id = RL0.store_id AND RH_GR0.orig_receipt_nr_ejr = RL0.orig_receipt_nr_ejr AND RH_GR0.pos_terminal_id
          = RL0.pos_terminal_id AND RH_GR0.time_receipt_ejr = RL0.time_receipt_ejr AND RH_GR0.dat_formdate = RL0.dat_formdate
       
     INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS ST_PR0 ON RH_GR0.client_id = ST_PR0.client_id
        AND RH_GR0.store_id = ST_PR0.store_id
     LEFT JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS ST0 ON RL0.client_id = ST0.client_id AND
       RL0.original_orig_store_nr_ejr = CAST(ST0.orig_store_nr AS STRING)
     LEFT JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 AS RH_VB0 ON RL0.client_id = RH_VB0.client_id
            AND ST0.store_id = RH_VB0.store_id AND CAST(RH_VB0.orig_receipt_nr_ejr AS STRING) = RL0.original_orig_receipt_nr_ejr
           AND CAST(RH_VB0.pos_terminal_id AS STRING) = RL0.original_pos_terminal_id_ejr AND RL0.original_dat_formdate_ejr
         = RH_VB0.dat_formdate AND RH_VB0.transactiontype_id = '100'
     LEFT JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 AS RLV0 ON RH_VB0.client_id = RLV0.client_id
          AND RH_VB0.store_id = RLV0.store_id AND RH_VB0.orig_receipt_nr_ejr = RLV0.orig_receipt_nr_ejr AND RH_VB0.pos_terminal_id
          = RLV0.pos_terminal_id AND RH_VB0.dat_formdate = RLV0.dat_formdate AND RL0.item_id = RLV0.item_id
    WHERE RH_GR0.transactiontype_id = '150' -- Filter Geldrueckgaben (Header-transactiontype_id = '150')

      -- Filter Geldrueckgaben (Header-transactiontype_id = '150')
) AS x2) AS salex ON returnx.s_client_id_ejr = salex
       .s_client_id_ejr AND returnx.s_orig_store_nr_ejr = salex.s_orig_store_nr_ejr AND returnx.s_dat_formdate_ejr =
      salex.s_dat_formdate_ejr AND returnx.s_orig_receipt_nr_ejr = salex.s_orig_receipt_nr_ejr AND returnx.s_pos_terminal_id_ejr
     = salex.s_pos_terminal_id_ejr AND returnx.item_id = salex.item_id
 LEFT JOIN (SELECT client_id,
   item_id,
   store_id,
   MAX(max_wawi_price) AS max_wawi_price
  FROM (SELECT PR.client_id,
      PR.item_id,
      dtx.store_id,
      MAX(PR.price_retail) AS max_wawi_price
     FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_itm_price_2 AS PR
      INNER JOIN (SELECT client_id,
        store_id,
        MIN(dat_formdate_from) AS dat_formdate_from,
        MAX(dat_formdate_until) AS dat_formdate_until
       FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS DTT
       GROUP BY client_id,
        store_id) AS dtx ON PR.dat_valid_until >= dtx.dat_formdate_from AND PR.dat_valid_from <= dtx.dat_formdate_until
       AND PR.client_id = dtx.client_id
     GROUP BY PR.client_id,
      PR.item_id,
      dtx.store_id
     UNION DISTINCT
     SELECT rcplext.client_id,
      rcplext.item_id,
      dtx.store_id,
      rcplext.max_wawi_price
     FROM (SELECT RCPLEX.client_id,
        RCPLEX.item_id,
        DTT.wh_id,
        MAX(RCPLEX.price_retail_ejr) AS max_wawi_price
       FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 AS RCPLEX
        INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS DTT ON RCPLEX.client_id = DTT.client_id
           AND RCPLEX.store_id = DTT.store_id
       GROUP BY RCPLEX.client_id,
        RCPLEX.item_id,
        DTT.wh_id) AS rcplext
      INNER JOIN (SELECT client_id,
        wh_id,
        store_id,
        MIN(dat_formdate_from) AS dat_formdate_from,
        MAX(dat_formdate_until) AS dat_formdate_until
       FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS DTT
       GROUP BY client_id,
        wh_id,
        store_id) AS dtx ON rcplext.client_id = dtx.client_id AND rcplext.wh_id = dtx.wh_id
      INNER JOIN (SELECT client_id,
        migration_dat_valid_from,
        migration_dat_valid_to
       FROM ldl_p_lew_core.t_client_migration_per_2) AS mastmig ON rcplext.client_id = mastmig.client_id AND dtx.dat_formdate_until
        BETWEEN mastmig.migration_dat_valid_from AND mastmig.migration_dat_valid_to) AS itmprcsub
  GROUP BY client_id,
   item_id,
   store_id) AS itmprc ON returnx.client_id = itmprc.client_id AND returnx.item_id = itmprc.item_id AND returnx.store_id
    = itmprc.store_id
 INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_2 AS TR ON returnx.client_id = TR.client_id
WHERE returnx.rt_price_retail_ejr_0 > salex.s_price_retail_ejr_0 AND returnx.rt_price_retail_ejr_0 >= TR.return_item_price
     AND returnx.s_client_id_ejr IS NOT NULL
 OR returnx.rt_price_retail_ejr_0 > itmprc.max_wawi_price AND returnx.rt_price_retail_ejr_0 >= TR.return_item_price AND
  returnx.s_client_id_ejr IS NULL;