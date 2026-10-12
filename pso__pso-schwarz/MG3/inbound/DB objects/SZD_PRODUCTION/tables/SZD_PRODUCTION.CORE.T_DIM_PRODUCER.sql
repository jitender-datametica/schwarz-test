create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_PRODUCER (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the producer',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	PRODUCER_NAME VARCHAR(100) NOT NULL COMMENT 'Natural Key/Business Key - The name of  the producer ',
	SOURCE_PRODUCER_NAME_ADDRESS_CITY_TXT VARCHAR(1000) NOT NULL COMMENT 'Descriptive Attribute - the name of the producer directly from source. Source: VMT',
	EMAIL_TXT VARCHAR(1000) COMMENT 'Descriptive Attribute - Email of the company',
	STATUS_CD VARCHAR(50) NOT NULL COMMENT 'The status code for the company',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_DIM_PRODUCER primary key (PARTY_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Dimension - A company which produced products for Lidl. - Source - VMT'
;