/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for t_msi_sys_revision_request_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_MSI.T_MSI_SYS_REVISION_REQUEST_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL,
	WH_LOC_SID NUMBER(38,0) NOT NULL,
	ORIG_STORE_NR NUMBER(38,0),
	REQUESTING_USER VARCHAR(100) NOT NULL COLLATE 'en-ci' DEFAULT CURRENT_USER(),
	TIMESTAMP_REQUEST TIMESTAMP_NTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	APPROVAL_USER VARCHAR(100) COLLATE 'en-ci',
	APPROVAL_FG NUMBER(38,0) NOT NULL DEFAULT 0,
	TIMESTAMP_APPROVAL TIMESTAMP_NTZ(9),
	DAT_FORMDATE_FROM DATE NOT NULL,
	DAT_FORMDATE_UNTIL DATE NOT NULL,
	VOID_FG NUMBER(38,0) NOT NULL DEFAULT 1,
	DEPOSIT_FG NUMBER(38,0) NOT NULL DEFAULT 1,
	RETURN_FG NUMBER(38,0) NOT NULL DEFAULT 1,
	ABORTED_SUSPENDED_FG NUMBER(38,0) NOT NULL DEFAULT 1,
	DISCOUNT_FG NUMBER(38,0) NOT NULL DEFAULT 1,
	OTHER_FG NUMBER(38,0) NOT NULL DEFAULT 1,
	REVISION_TEST_FG NUMBER(38,0) NOT NULL DEFAULT 0
);