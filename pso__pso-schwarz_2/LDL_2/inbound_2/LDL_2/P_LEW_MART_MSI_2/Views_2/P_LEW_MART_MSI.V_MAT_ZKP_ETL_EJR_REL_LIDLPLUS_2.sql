/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_REL_LIDLPLUS_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2023    Szewczyk,Milosz          AP0188368: ZKP new scenario Lidl Plus
#  1.1  20.09.2024    Szewczyk,Milosz          AP676219: Fix to disable countries without set thresholds for LidlPlus
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_REL_LIDLPLUS_2 (
  CLIENT_ID
  ,STORE_ID
  ,POS_TERMINAL_ID
  ,TIME_RECEIPT_EJR
  ,DAT_FORMDATE
  ,ORIG_RECEIPT_NR_EJR
  ,WH_ID
  ,CHECKER_ID
  ,LIDLPLUS_CUSTOMER_CD
  ,LIDLPLUS_IDENT_TYPE_CD
  ,VAL_RETAIL_EJR
) AS
SELECT
   t1.client_id
  ,t1.store_id
  ,t1.pos_terminal_id
  ,t1.time_receipt_ejr
  ,t1.dat_formdate
  ,t1.orig_receipt_nr_ejr
  ,MAX(revstr.wh_id) AS wh_id
  ,MAX(t1.checker_id) AS checker_id
  ,MAX(t1.lidlplus_customer_cd) AS lidlplus_customer_cd
  ,MAX(t1.lidlplus_ident_type_cd) AS lidlplus_ident_type_cd
  ,MAX(t1.val_retail_ejr) AS val_retail_ejr
FROM (SELECT * ,RANK() OVER ( PARTITION BY client_id,store_id,checker_id,dat_formdate,orig_receipt_nr_ejr 
	                              ORDER BY timestamp_begin_ejr,orig_receipt_serial_nr_ejr) AS rank_by_timestamp
          FROM P_LEW_MART_MSI.v_ejr_receiptheader_2) t1_2
	  -- Join to *load_store to get only the relevant stores
INNER JOIN P_LEW_MART_MSI.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr
  ON t1.store_id = revstr.store_id
    AND t1.client_id = revstr.client_id
    AND t1.dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
    -- Join to thresholds table to remove countries without any thresholds set
INNER JOIN  P_LEW_MART_MSI.v_ejr_lp_threshold_receipt_2 tr
  ON tr.client_id = t1.client_id
    AND tr.PLUS_REC_MONTH IS NOT NULL
    AND tr.PLUS_REC_DAY IS NOT NULL
WHERE t1.lidlplus_customer_cd IS NOT NULL
GROUP BY t1.client_id,t1.store_id,t1.pos_terminal_id,t1.time_receipt_ejr,t1.dat_formdate,t1.orig_receipt_nr_ejr
;