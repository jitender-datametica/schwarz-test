CREATE TABLE CORE.T_DIM_SURVEY_TYPE_1 (
	SURV_TYPE_CD VARCHAR(5) NOT NULL COMMENT 'The code for the types for customer survey',
	SURV_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the types for customer survey in group language (German).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_SURVEY_TYPE PRIMARY KEY (SURV_TYPE_CD)
)COMMENT='This minor dimension defines the types for customer survey'
;