/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.t_msi_ejr_show_price_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  05.01.2017    Michael Ueding           Change Primary Index
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.5  31.01.2018    Wieber.Harald            Release 2.3
#  1.6  31.01.2018    Wieber,Harald            Release 2.3
#  1.7  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Felder: is_kleinstbon_man & is_abmeld_man
#  1.8  08.02.2022    Wandtke,Andrzej          AP0085915_ZKP_SHOW_PRICE add column PR_SHOW_ORIG_RECEIPT_NR_EJR: receipt number of show price operation. For price series it marks end of series, otherwise equal to orig_receipt_nr_ejr
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_MSI.T_MSI_EJR_SHOW_PRICE_2 (
 ORIG_RECEIPT_NR_EJR NUMBER(38,0),
 PR_SHOW_ORIG_RECEIPT_NR_EJR NUMBER(38,0),
 ST_LOC_SID NUMBER(38,0),
 DAT_FORMDATE DATE,
 POS_TERMINAL_ID NUMBER(38,0),
 CLIENT_ID NUMBER(38,0),
 TIME_RECEIPT_EJR TIME(0),
 CHECKER_ID NUMBER(38,0),
 NEXT_VAL_RETAIL_EJR NUMBER(18,4),
 VAL_RETAIL_EJR NUMBER(18,4),
 NEXT_ORIG_RECEIPT_NR_EJR NUMBER(38,0),
 NEXT_TIME_RECEIPT_EJR TIME(0),
 TRANSACTIONTYPE_ID VARCHAR(3) COLLATE 'en-ci',
 NEXT_TRANSACTIONTYPE_ID VARCHAR(3) COLLATE 'en-ci',
 RANK_LOGIN_NR NUMBER(38,0),
 IS_KLEINSTBON NUMBER(38,0),
 IS_ABMELDUNG NUMBER(38,0),
 IS_SHOW_PRICE_SERIES NUMBER(38,0),
 CNT_SAME_TRANSACTIONTYPE NUMBER(38,0),
 IS_KLEINSTBON_MAN NUMBER(38,0),
 IS_ABMELD_MAN NUMBER(38,0)
);