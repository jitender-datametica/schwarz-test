/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL
#----------------------------------------------------------------------------
# History:
#  1.0  01.08.2022    Bialek, Aleksander       Initial Version Part of Liefertreue Dashboard RPA Alternative solution. AD WI: 356666 (Main WI:350713)
#
#----------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_PRECORE.T_CACHE_EKS_FILE_2 (
	IAN VARCHAR(100),
	EKS_NUMMER VARCHAR(100),
	LAND_VERHANDELT VARCHAR(100),
	EINKAUFER VARCHAR(100),
	INT_LIEFERANTENNUMMER VARCHAR(100),
	BEZEICHNUNG_VERTRAGSPARTNER VARCHAR(100),
	ARTIKELBEZ VARCHAR(200),
	BELIEFERUNGSLAND VARCHAR(100),
	TRANSPORTWEG_KURZ VARCHAR(100),
	TRANSPORTWEG_LANG VARCHAR(200),
	FILE_NAME VARCHAR(100) COLLATE 'en-ci',
	DWH_LOAD_ID NUMBER(38,0),
	DWH_CREATED TIMESTAMP_NTZ(6),
	DWH_UPDATED TIMESTAMP_NTZ(6)
);