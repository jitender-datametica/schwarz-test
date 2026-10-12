create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_CAL_CUM_BUSINESS_YEAR_QUARTER_TO_PARTIAL_WEEK (
	PART_WEEK NUMBER(38,0) NOT NULL COMMENT 'The partial week for which the business-year-quarter-to-partial-week interval is defined',
	INCL_PART_WEEK NUMBER(38,0) NOT NULL COMMENT 'The partial week that needs to be included in the business-year-quarter-to-partial-week interval.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CAL_CUM_BUSINESS_YEAR_QUARTER_TO_PARTIAL_WEEK primary key (PART_WEEK, INCL_PART_WEEK)
)COMMENT='This table relates a partial week to all partial weeks that form its business-year-quarter-to-partial-week interval.'
;