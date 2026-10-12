create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_MDM_PRICE_SCENARIO_1 (
	MDM_PRICE_SCENARIO_NR NUMBER(38,0) NOT NULL COMMENT 'identifier of the price scenario',
	MDM_PRICE_TYPE_CD VARCHAR(100) COMMENT 'representing code of the price type',
	LOB_CD VARCHAR(5) COLLATE 'en-ci' COMMENT 'line of business code ''LDL'',''KFL'', distinguishes between Lidl and Kaufland related clients',
	MARKET_SID NUMBER(38,0) COMMENT 'foreign key NFPO market\n            depends on source column name by scenario',
	INCOTERM_CD VARCHAR(100) COMMENT 'code of the incoterm used to specify the scenario',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',
	constraint PK_T_MDM_PRICE_SCENARIO primary key (MDM_PRICE_SCENARIO_NR)
)COMMENT='price scenarios used in the non food product development and ordering process drived from price types and the used additional dimentsion lob, market\n             prices which are differenciated by targeted intenal organisation are not included here'
;
