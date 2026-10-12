create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_CLIENT_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key CLIENT',
	SRC_CLIENT_ID NUMBER(38,0) COMMENT 'WAWI-DWH CLIENT_ID',
	SRC_COUNTRY_LIDL_CD VARCHAR(160) COMMENT 'Codes der Lidl-Laender: Oesterreich=AT;Nord-Irland:NI; USA=US; Deutschland=DE',
	SRC_COUNTRY_CBX_CD VARCHAR(160) COMMENT 'Codes bekannt aus CBX: Deutschland=DE, OnlineShopDeutschland=OSDE',
	CLIENT_NAME VARCHAR(800) NOT NULL COMMENT 'Name des Mandanten in Stiftungs-Sprache',
	COUNTRY_SID NUMBER(38,0) COMMENT 'Lidl-Land_2; FK auf COUNTRY_2',
	COUNTRY_CD VARCHAR(160) NOT NULL COMMENT 'Lidl-Land_2-Code',
	CURR_SID NUMBER(38,0) COMMENT 'Landeswaehrung; FK auf CURRENCY',
	CURR_CD VARCHAR(160) COMMENT 'Landeswaehrung - Code; manuelle Befuellung, da keine direkte Quelle vorhanden',
	CLIENT_ONLINE_FG NUMBER(38,0) NOT NULL COMMENT 'Client is Online Shop;',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9),
	LOB_CD VARCHAR(5) COLLATE 'en-ci' COMMENT 'line of business code LDL,KFL, distinguishes between Lidl and Kaufland related clients',
	unique (CLIENT_ID)
);
