create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_TCACHE_SAPHANA_REVENUE_ACCRUAL_IMDT_1 (
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization to which the revenue is accrued.',
	INT_ORG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country_1 organization.',
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	ACCRUAL_DT DATE NOT NULL COMMENT 'The day when the the revenue was accrued',
	BUS_DT DATE NOT NULL COMMENT 'The day for which the revenue is accrued.',
	RECEIPT_CNT NUMBER(38,0) COMMENT 'The number of receipts generated on this day in this internal organization (store).',
	TURNOVER_NET_VAL NUMBER(38,5) COMMENT 'The accrued net amount in the currency indicated by the currency code.',
	CURR_CD VARCHAR(3) COMMENT 'The code identifying the currency, according to ISO 4217.',
	OBJECT_TYPE VARCHAR(3),
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_REVENUE_ACCRUAL primary key (INT_ORG_SID, BUS_DT, ACCRUAL_DT)
);