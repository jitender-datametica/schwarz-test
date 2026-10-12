/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_VOID_TRANSACTION_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  05.01.2017    Michael Ueding           Change Primary Index
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.5  31.01.2018    Wieber.Harald            Release 2.3
#  1.6  31.01.2018    Wieber,Harald            Release 2.3
#  1.7  24.05.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: Add columns total_value_void, is_pay_exact, is_subtotal_bef_storno, is_void_not_authorised, is_highest_val, is_alk_tab, is_1_itm
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_MSI.T_MSI_EJR_VOID_TRANSACTION_1 (
	CLIENT_ID NUMBER(38,0),
	ST_LOC_SID NUMBER(38,0),
	POS_TERMINAL_ID NUMBER(38,0),
	TIME_RECEIPT_EJR TIME(0),
	DAT_FORMDATE DATE,
	ORIG_RECEIPT_NR_EJR NUMBER(38,0),
	WH_LOC_SID NUMBER(38,0),
	CHECKER_ID NUMBER(38,0),
	LAST_VOID_LINE_NR NUMBER(38,0),
	IS_VOIDED_AFTER_SUBTOTAL NUMBER(38,0),
	CNT_VOID_AFTER_SUBTOTAL NUMBER(38,0),
	IS_SALE_AFTER_SUBTOTAL NUMBER(38,0),
	LAST_SUBTOTAL_LINE NUMBER(38,0),
	VOIDED_VALUE_AFT_SUBTOTAL NUMBER(18,4),
	IS_VOIDED_VALUE_AFT_SUBTOTAL NUMBER(38,0),
	IS_VOIDED_ITEM_INNEXT NUMBER(38,0),
	TOTAL_VALUE_VOID NUMBER(18,4),
	IS_PAY_EXACT NUMBER(38,0),
	IS_SUBTOTAL_BEF_STORNO NUMBER(38,0),
	IS_VOID_NOT_AUTHORISED NUMBER(38,0),
	IS_HIGHEST_VAL NUMBER(38,0),
	IS_ALK_TAB NUMBER(38,0),
	IS_1_ITM NUMBER(38,0));
