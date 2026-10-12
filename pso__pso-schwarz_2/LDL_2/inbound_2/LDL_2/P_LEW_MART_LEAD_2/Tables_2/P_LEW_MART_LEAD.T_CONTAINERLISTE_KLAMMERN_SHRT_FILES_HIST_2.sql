CREATE TABLE P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILES_HIST_2 (
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL
#----------------------------------------------------------------------------
# History:
#  1.0  19.05.2022    Bialek, Aleksander       Initial Version Part of SOMO AP2, Ek-Wa_SoMo_AP2_SF_objects, BBT-3832, AD Work Item_2: 291570
#----------------------------------------------------------------------------
*/
	ID  VARCHAR(100) NOT NULL COLLATE 'en-ci',
	CONTAINER_ART VARCHAR(100) COLLATE 'en-ci',
	CONTAINER_ART_GROESSE VARCHAR(100) COLLATE 'en-ci',
	CONTAINER_ART_SORTIMENTSBEREICH VARCHAR(100) COLLATE 'en-ci',
	CONTAINER_SORTIMENTSBEREICH VARCHAR(100) COLLATE 'en-ci',
	ID_LOCAL NUMBER(38,0) NOT NULL,	
	COUNTRY_2 VARCHAR(100) NOT NULL COLLATE 'en-ci',	
	DESC_INT VARCHAR(100) COLLATE 'en-ci',
	FILE_NAME VARCHAR(100) COLLATE 'en-ci',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL,
	DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL
);