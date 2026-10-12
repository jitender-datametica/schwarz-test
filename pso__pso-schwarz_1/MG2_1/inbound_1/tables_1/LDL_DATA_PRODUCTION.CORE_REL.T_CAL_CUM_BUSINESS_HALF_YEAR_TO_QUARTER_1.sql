create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_CAL_CUM_BUSINESS_HALF_YEAR_TO_QUARTER_1 (
	BUS_YEAR_QTR NUMBER(38,0) NOT NULL COMMENT 'The business year quarter for which the business-half-year-to-quarter interval is defined.',
	INCL_BUS_YEAR_QTR NUMBER(38,0) NOT NULL COMMENT 'The business year quarter that needs to be included in the business-half-year-to-quarter interval.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CAL_CUM_BUSINESS_HALF_YEAR_TO_QUARTER primary key (BUS_YEAR_QTR, INCL_BUS_YEAR_QTR)
)COMMENT='This table relates a business year quarter to all business year quarters that form the business-half-year-to-quarter interval of this quarter. E.g. for Q2/2021 this is Q1/2021 and Q2/2021.'
;