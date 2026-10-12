/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_LP_THRESHOLD_MANUAL_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  17.01.2018    Wieber.Harald            Release 2.2
#  1.3  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.4  31.01.2018    Wieber.Harald            Release 2.3
#  1.5  31.01.2018    Wieber,Harald            Release 2.3
#  1.6  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Felder mshow_price_val_cnt_checker & mshow_price_low_nxt_receipt_val.
#  1.7  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New columns for discount (Rabatt) metrics
#  1.8  29.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Complete column comments
#  1.9  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  2.0  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: New column mreturn_no_orig_receipt_cnt_checker for metrics Money return with no original receipt
#  2.1  07.07.2023    Kowalik, Aleksander      AP0122629 Anpassung Kennzahlen Preisanzeige: New columns added for new threshold metrics: MSHOW_PRICE_VAL_NF_LOW and MSHOW_PRICE_CNT_VG_INFOLGE_LOW
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_MSI.T_MSI_EJR_LP_THRESHOLD_MANUAL_2 (
	CLIENT_ID NUMBER(38,0),
	DAT_REC_START DATE NOT NULL,
	DAT_REC_END DATE NOT NULL,
	MVOID_QUOTE_CNT_CHECKER NUMBER(18,4),
	MVOID_PER100_TRANS_CNT_CHECKER NUMBER(18,4),
	MVOID_VAL_CNT_CHECKER NUMBER(18,4),
	MABO_QTY_TRANS_CNT_CHECKER NUMBER(18,4),
	MABO_VAL_CNT_CHECKER NUMBER(18,4),
	MSUSP_QTY_TRANS_CNT_CHECKER NUMBER(18,4),
	MRETURN_QUOTE_CNT_CHECKER NUMBER(18,4),
	MRETURN_VAL_CNT_CHECKER NUMBER(18,4),
	MRET_AMOUNT_TRANS_CNT_CHECKER NUMBER(18,4),
	MDEPOSIT_QUOTE_CNT_CHECKER NUMBER(18,4),
	MDEPOSIT_MAN_VAL_CNT_CHECKER NUMBER(18,4),
	MDEPOSIT_ALL_VAL_CNT_CHECKER NUMBER(18,4),
	MOTHERS_QTY_LOWVAL_CNT_CHECKER NUMBER(18,4),
	MOTHERS_QTY_LOGIN_CNT_CHECKER NUMBER(18,4),
	MSUSP_ABORTED_RECEIPT_VAL NUMBER(18,4),
	MOTHERS_LOW_RECEIPT_VAL NUMBER(18,4),
	MVOID_SAME_ITEM_CNT NUMBER(18,4),
	MVOID_ITEM_VAL NUMBER(18,4),
	MRECEIPT_VOID_VAL NUMBER(18,4),
	MRETURN_MANUAL_CNT_CHECKER NUMBER(18,4),
	MSHOW_PRICE_VAL_CNT_CHECKER NUMBER(18,4),
	MSHOW_PRICE_LOW_NXT_RECEIPT_VAL NUMBER(18,4),
	MDISCOUNT_CNT_CHECKER NUMBER(18,4), 
	MDISCOUNT_QUOTE_CHECKER NUMBER(18,4),
	MDISCOUNT_CNT_RECEIPT  NUMBER(18,4), 
	MDISCOUNT_VAL_RECEIPT NUMBER(18,4),
	MRETURN_NO_ORIG_RECEIPT_CNT_CHECKER NUMBER(18,4),
	REQUESTING_USER VARCHAR(128) NOT NULL COLLATE 'en-ci' DEFAULT CURRENT_USER(),
	TIMESTAMP_REQUEST TIMESTAMP_NTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	APPROVAL_FG NUMBER(38,0) NOT NULL,
	APPROVAL_USER VARCHAR(128) COLLATE 'en-ci',
	TIMESTAMP_APPROVAL TIMESTAMP_NTZ(9),
	APPROVAL2_USER VARCHAR(128) COLLATE 'en-ci',
	TIMESTAMP_APPROVAL2 TIMESTAMP_NTZ(9),
	MSHOW_PRICE_VAL_NF_LOW NUMBER(18,4),
	MSHOW_PRICE_CNT_VG_INFOLGE_LOW NUMBER(18,4)
);