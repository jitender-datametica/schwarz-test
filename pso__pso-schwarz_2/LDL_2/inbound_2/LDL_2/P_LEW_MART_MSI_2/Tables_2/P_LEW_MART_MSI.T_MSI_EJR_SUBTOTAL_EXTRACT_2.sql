/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_SUBTOTAL_EXTRACT_2 
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  05.01.2017    Michael Ueding           Change Primary Index
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.5  31.01.2018    Wieber.Harald            Release 2.3
#  1.6  31.01.2018    Wieber,Harald            Release 2.3
#  1.7  27.07.2023    Wandtke,Andrzej          AP0177530: add column timestamp_begin_ejr
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_MSI.T_MSI_EJR_SUBTOTAL_EXTRACT_2 CLUSTER BY (st_loc_sid)(
	 ST_LOC_SID NUMBER(38,0) NOT NULL
	,CLIENT_ID NUMBER(38,0) NOT NULL
	,POS_TERMINAL_ID NUMBER(38,0) NOT NULL
	,DAT_FORMDATE DATE NOT NULL
	,TIME_RECEIPT_EJR TIME(0) NOT NULL
	,ORIG_RECEIPT_NR_EJR NUMBER(38,0) NOT NULL
	,ORIG_RECEIPT_SERIAL_NR_EJR NUMBER(38,0) NOT NULL
	,TIMEZONE_CD NUMBER(38,0) NOT NULL
	,DAT_DAYEND DATE NOT NULL
	,CHECKER_ID NUMBER(38,0) NOT NULL
	,TRANSACTIONTYPE_ID VARCHAR(3) NOT NULL COLLATE 'en-ci'
	,AUTHORITY_ID VARCHAR(40) COLLATE 'en-ci'
	,LOAD_ID NUMBER(38,0) NOT NULL
	,TIMESTAMP_BEGIN_EJR TIMESTAMP_NTZ(9)
);