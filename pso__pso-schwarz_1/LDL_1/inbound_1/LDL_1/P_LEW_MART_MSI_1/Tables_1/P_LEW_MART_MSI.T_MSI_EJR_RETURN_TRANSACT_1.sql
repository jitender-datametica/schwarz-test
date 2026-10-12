/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_RETURN_TRANSACT_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  05.01.2017    Michael Ueding           Change Primary Index
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.5  31.01.2018    Wieber.Harald            Release 2.3
#  1.6  31.01.2018    Wieber,Harald            Release 2.3
#  1.7  12.07.2018    Wandtke,Andrzej          20180711_1760_Add_New_Column_Rep1 Add return_seq
#  1.8  03.07.2019    Morris, Michael          20190703_2143_ZKP_MFRGB: Add column val_return_same_receipt
#  1.9  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) New column is_return_same_checker
#  2.0  06.03.2020    Cheryl Barlow            Removal of MVC - Patch No:2408 IDMO: 2786-20200226_2408_MVC_SMALL_18_DWH20
#  2.1  26.05.2020    Wandtke,Andrzej          20200526_2482_ZKP_Einzelbedienerbericht: Add columns is_return_not_dv, is_return_dv, is_return_orig_same_checker, is_return_orig_same_checker_day, is_return_no_orig_receipt
#  2.2  13.05.2021    Wandtke,Andrzej          AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: Add column is_return_sc
#  2.3  20.03.2023    Wandtke,Andrzej          AP0152808 : Add column is_return_no_orig_receipt_man
#  2.4  13.04.2023    Wandtke,Andrzej          AP0170366 : Add columns is_return_many_itm, is_return_same_itm_nb
#  2.5  28.08.2023    Kowalik,Aleksander       AP0170990 : Add column is_return_orig_same_checker_day_not_dv_man
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_MSI.T_MSI_EJR_RETURN_TRANSACT_1 (
	CLIENT_ID NUMBER(38,0),
	ST_LOC_SID NUMBER(38,0),
	POS_TERMINAL_ID NUMBER(38,0),
	DAT_FORMDATE DATE,
	TIME_RECEIPT_EJR TIME(0),
	ORIG_RECEIPT_NR_EJR NUMBER(38,0),
	CHECKER_ID NUMBER(38,0),
	S_CLIENT_ID_EJR NUMBER(38,0),
	S_ORIG_STORE_NR_EJR NUMBER(38,0),
	S_DAT_FORMDATE_EJR DATE,
	S_ORIG_RECEIPT_NR_EJR NUMBER(38,0),
	S_POS_TERMINAL_ID_EJR NUMBER(38,0),
	ITEM_SID NUMBER(38,0),
	CNT_RETURN_ITEM NUMBER(38,0),
	DAT_LAST_RETURNDATE DATE,
	CNT_SALE_ITEM NUMBER(38,0),
	IS_RETURNED_WO_BON_PER_DAY NUMBER(38,0),
	IS_RETURNED_GT_ORIGINAL NUMBER(38,0),
	CNT_RETURNED_GT_ORIGINAL NUMBER(38,0),
	CNT_RETURN_SAME_RECEIPT NUMBER(18,4),
	IS_RETURN_NOT_AUTHORISED NUMBER(38,0),
	RETURN_SEQ NUMBER(38,0),
	VAL_RETURN_SAME_RECEIPT NUMBER(18,4),
	IS_RETURN_SAME_CHECKER NUMBER(38,0),
	IS_RETURN_NOT_DV NUMBER(38,0),
	IS_RETURN_DV NUMBER(38,0),
	IS_RETURN_ORIG_SAME_CHECKER NUMBER(38,0),
	IS_RETURN_ORIG_SAME_CHECKER_DAY NUMBER(38,0),
	IS_RETURN_NO_ORIG_RECEIPT NUMBER(38,0),
	IS_RETURN_SC NUMBER(38,0),
	IS_RETURN_NO_ORIG_RECEIPT_MAN NUMBER(38,0),
	IS_RETURN_MANY_ITM NUMBER(38,0),
	IS_RETURN_SAME_ITM_NB NUMBER(38,0),
	IS_RETURN_ORIG_SAME_CHECKER_DAY_NOT_DV_MAN NUMBER(38,0)
);