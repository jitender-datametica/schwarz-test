/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_OPEN_STORES
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-09-30 Rodrigo Cione           Table added to be used for filtering in FE
#                                         20200930_2603_Add_obj_QV_Dummy_Recs
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# Table DDL
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_QV_OPEN_STORES (
	CLIENT_ID NUMBER(38,0) NOT NULL,
	MOVE_TO_STORE_ID NUMBER(38,0) NOT NULL,
	ASPECT_ID NUMBER(38,0) NOT NULL,
	SALES_MANAGER_ID NUMBER(38,0),
	ACCOUNT_MANAGER_ID NUMBER(38,0),
	WH_ID NUMBER(38,0),
	WH_ID_EXP NUMBER(38,0),
	QV_OPEN_STORE_FLAG NUMBER(38,0),
	DWH_LOAD_ID NUMBER(38,0) NOT NULL,
	DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL,
	UNIQUE (CLIENT_ID, MOVE_TO_STORE_ID, ASPECT_ID)
)COMMENT='QuickView load table : Open stores (any store with a transaction in the last 13 months)'
;