create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_MDM_PRICE_TYPE_1 (
	MDM_PRICE_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'representing code of the price type',
	MDM_PRICE_TYPE_NAME VARCHAR(100) COMMENT 'name of the price type',
	MDM_PRICE_TYPE_DESCR VARCHAR(250) COMMENT 'description of the price type',
	LOB_FG NUMBER(38,0) COMMENT 'indicates whether the price type has different prices for different lines of business (LDL/KFL)',
	MARKET_FG NUMBER(38,0) COMMENT 'indicates whether the price type has different prices for different markets_1 (EU/US)',
	INCOTERM_FG NUMBER(38,0) COMMENT 'indicates whether the price type has different prices for different incoterms (FOB/DDP)',
	INT_ORG_FG NUMBER(38,0) COMMENT 'indicates whether the price type has different prices for different targeted internal organisations',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',
	constraint PK_T_MDM_PRICE_TYPE primary key (MDM_PRICE_TYPE_CD)
)COMMENT='price types used in the non food product development and ordering process'
;
