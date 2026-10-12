/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_EJR_LIDLPLUS_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    Szewczyk,Milosz          AP0188368: ZKP new scenario Lidl Plus
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_EJR_LIDLPLUS_1
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
  FROM P_LEW_MART_MSI.V_EJR_LIDLPLUS_1
  ;