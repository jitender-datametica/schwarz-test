/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for t_msi_ejr_org_checker_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  05.01.2017    Michael Ueding           Change Primary Index
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.5  31.01.2018    Wieber.Harald            Release 2.3
#  1.6  31.01.2018    Wieber,Harald            Release 2.3
#  1.7  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_MART_MSI.T_MSI_EJR_ORG_CHECKER_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL,
	ST_LOC_SID NUMBER(38,0) NOT NULL,
	ORIG_STORE_NR NUMBER(38,0) NOT NULL,
	CHECKER_ID NUMBER(38,0) NOT NULL,
	VOID_FG NUMBER(38,0) NOT NULL,
	DEPOSIT_FG NUMBER(38,0) NOT NULL,
	RETURN_FG NUMBER(38,0) NOT NULL,
	ABORTED_SUSPENDED_FG NUMBER(38,0) NOT NULL,
	DISCOUNT_FG NUMBER(38,0) NOT NULL,
	OTHER_FG NUMBER(38,0) NOT NULL,
	LINK_PARAM VARCHAR(1000) COLLATE 'en-ci'
);