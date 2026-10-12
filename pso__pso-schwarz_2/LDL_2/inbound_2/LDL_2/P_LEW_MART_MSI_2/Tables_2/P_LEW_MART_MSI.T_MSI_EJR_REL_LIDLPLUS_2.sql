/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_REL_LIDLPLUS_2
#----------------------------------------------------------------------------
# History:
#  1.0  27.03.2024    Szewczyk,Milosz		AP0188368: ZKP Lidlplus
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_MSI.T_MSI_EJR_REL_LIDLPLUS_2 (
 CLIENT_ID NUMBER(38,0),
 STORE_ID NUMBER(38,0),
 POS_TERMINAL_ID NUMBER(38,0),
 TIME_RECEIPT_EJR TIME(0),
 DAT_FORMDATE DATE,
 ORIG_RECEIPT_NR_EJR NUMBER(38,0),
 WH_ID NUMBER(38,0),
 CHECKER_ID NUMBER(38,0),
 LIDLPLUS_CUSTOMER_CD VARCHAR(32),
 LIDLPLUS_IDENT_TYPE_CD VARCHAR(3),
 VAL_RETAIL_EJR NUMBER(38,4)
);