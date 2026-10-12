create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_CAL_CUM_BUSINESS_YEAR_TO_HALF_YEAR (
	BUS_HALF_YEAR NUMBER(38,0) NOT NULL COMMENT 'The business half year for which the business-year-to-half-year interval is defined.',
	INCL_BUS_HALF_YEAR NUMBER(38,0) NOT NULL COMMENT 'The business half year that needs to be included in the business-year-to-half-year interval.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CAL_CUM_BUSINESS_YEAR_TO_HALF_YEAR primary key (BUS_HALF_YEAR, INCL_BUS_HALF_YEAR)
)COMMENT='This table relates a business half year to all business half years that form the business-half-year-to-year interval of this business half year. E.g. for the20211 this is 20211 and 20212.'
;