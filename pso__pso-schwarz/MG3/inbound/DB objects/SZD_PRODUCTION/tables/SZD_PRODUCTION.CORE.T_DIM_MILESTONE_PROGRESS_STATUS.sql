create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_MILESTONE_PROGRESS_STATUS (
	MILESTONE_PROGRESS_DETAIL_CD VARCHAR(50) NOT NULL COMMENT 'Code for a more detailed status of progress of a lot/container refered to as ''Container Status 1''',
	MILESTONE_PROGRESS_OVERALL_CD VARCHAR(50) NOT NULL COMMENT 'Code for broader status of progress of a lot/container refered to as ''Container Status 2''',
	MILESTONE_PROGRESS_DETAIL_DESCR VARCHAR(250) NOT NULL COMMENT 'Descriptive Attribute - Descriptive text of a more detailed progress status of a lot/container',
	MILESTONE_PROGRESS_OVERALL_DESCR VARCHAR(250) NOT NULL COMMENT 'Descriptive Attribute - Descriptive text of a broader progress status of a lot/container',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_DIM_MILESTONE_PROGRESS_STATUS primary key (MILESTONE_PROGRESS_DETAIL_CD)
)COMMENT='Minor Entity - Combination of detailed status codes with a more broader classification of status and it''s corresponding descriptions. - Source - Manual'
;