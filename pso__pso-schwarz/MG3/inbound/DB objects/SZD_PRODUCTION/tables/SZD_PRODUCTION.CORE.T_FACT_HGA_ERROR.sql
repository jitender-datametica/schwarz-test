create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_HGA_ERROR (
	HGA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
	ERROR_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The timestamp of the error occurence ',
	HGA_ERROR_CD VARCHAR(250) NOT NULL COMMENT 'The code of error occured (error name)',
	HGA_ERROR_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for the hga error type',
	ERROR_STATUS_FG BOOLEAN NOT NULL COMMENT 'The indicator for the status of error (true or false)',
	IS_IN_OPERATION_FG BOOLEAN NOT NULL COMMENT 'The indicator for hot beverage automate beeing in operation = true, if only partial failure, if total failure then false',
	MANUFACTURER_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a company which produces deposit machines.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_HGA_ERROR primary key (HGA_SID, ERROR_TMSP, HGA_ERROR_CD, ERROR_STATUS_FG)
)COMMENT='Transactional facts capturing the error code, status and timestamp when the error occured'
;