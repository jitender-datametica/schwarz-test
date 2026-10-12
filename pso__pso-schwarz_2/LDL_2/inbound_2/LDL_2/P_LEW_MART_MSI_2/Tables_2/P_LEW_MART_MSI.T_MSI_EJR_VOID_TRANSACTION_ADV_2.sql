/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_VOID_TRANSACTION_ADV_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.11.2023    Szewczyk,Milosz         Storno Beguenstigungen AP0182639 Based on a T_MSI_EJR_VOID_TRANSACTION_2 table
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_MSI.T_MSI_EJR_VOID_TRANSACTION_ADV_2 (
	CLIENT_ID NUMBER(38,0),
	ST_LOC_SID NUMBER(38,0),
	POS_TERMINAL_ID NUMBER(38,0),
	TIME_RECEIPT_EJR TIME(0),
	DAT_FORMDATE DATE,
	ORIG_RECEIPT_NR_EJR NUMBER(38,0),
	WH_LOC_SID NUMBER(38,0),
	CHECKER_ID NUMBER(38,0),
	IS_VOIDED_AFTER_SUBTOTAL NUMBER(38,0),
	CNT_VOID_AFTER_SUBTOTAL NUMBER(38,0),
	IS_VOIDED_ITEM_INNEXT NUMBER(38,0),
	TOTAL_VALUE_VOID NUMBER(18,4),
	IS_PAY_EXACT NUMBER(38,0),
	IS_SUBTOTAL_BEF_STORNO NUMBER(38,0),
	IS_VOID_NOT_AUTHORISED NUMBER(38,0),
	IS_HIGHEST_VAL NUMBER(38,0),
	IS_ALK_TAB NUMBER(38,0),
	IS_VOIDED_VALUE_AFT_SUBTOTAL_2 NUMBER(38,0),
	IS_1_ITM_2 NUMBER(38,0),
	IS_OUTSIDE_HOURS NUMBER(38,0),
	IS_MAN_DISCOUNT NUMBER(38,0),
	CNT_VOID_EJR NUMBER(38,0),
	IS_MAN_DISCOUNT_ITEM NUMBER(38,0)
	);