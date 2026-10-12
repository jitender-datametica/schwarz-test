/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_lead.t_item_prpty_lst_lkup_2
#----------------------------------------------------------------------------
# History:
#  1.0  03.12.2019    Michal Malinowski        Initial Version
#                                              Patch: 20191128_2313_Artmerkmale_for_Art_Monitor
#                                              IDMO: IDMO-2511
#  1.1  28.07.2022    Torsten Bachmann         Increase VARCHAR columns to 1000 for large strings
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_ITEM_PRPTY_LST_LKUP_2 (
	CLIENT_ID NUMBER(38,0),
	ITEM_PRPTY_LST_ID NUMBER(38,0),
	ITEM_PRPTY_ID_CONCAT VARCHAR(1000) COLLATE 'en-ci',
	ITEM_PRPTY_LST_NAME VARCHAR(1000) COLLATE 'en-ci',
	ITEM_PRPTY_LST_LOCAL_NAME VARCHAR(1000) COLLATE 'en-ci'
);