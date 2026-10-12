/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_LIDLPLUS
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    Szewczyk,Milosz          AP0188368: ZKP new scenario Lidl Plus
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_LIDLPLUS
(	
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
)	
AS	
  SELECT	
    ow.CLIENT_ID
    ,ow.STORE_ID
    ,ow.POS_TERMINAL_ID
    ,ow.TIME_RECEIPT_EJR
    ,ow.DAT_FORMDATE
    ,ow.ORIG_RECEIPT_NR_EJR
    ,wh.SRC_WH_ID AS WH_ID
    ,ow.CHECKER_ID
    ,ow.LIDLPLUS_CUSTOMER_CD
    ,ow.LIDLPLUS_IDENT_TYPE_CD
    ,ow.VAL_RETAIL_EJR
  FROM P_LEW_MART_MSI.T_MSI_EJR_REL_LIDLPLUS ow	
  INNER JOIN p_lew_bil_ac.v_warehouse AS wh	
    ON wh.client_id = ow.client_id	
      AND wh.src_wh_id = ow.wh_id	
      AND wh.dwh_actual_fg = 1
      ;