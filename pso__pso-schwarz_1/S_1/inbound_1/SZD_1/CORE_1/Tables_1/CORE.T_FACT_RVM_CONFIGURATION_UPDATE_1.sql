CREATE TABLE CORE.T_FACT_RVM_CONFIGURATION_UPDATE_1 (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	UPDATE_DT DATE NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	UPDATE_TM TIME(9) NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	RVM_CONFIG_SOURCE_CD VARCHAR(50) NOT NULL COMMENT 'The code for the deposit machine configuration source e.g. donwload article meta data 1,...',
	REC_CNT NUMBER(38,0) NOT NULL COMMENT 'The number for the configuration update records.',
	UPDATE_STATUS_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if the update status_1 has an error',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_FACT_RVM_CONFIGURATION_UPDATE PRIMARY KEY (CAL_DT, RVM_SID, UPDATE_DT, UPDATE_TM, RVM_CONFIG_SOURCE_CD)
)COMMENT='Transactional facts capturing the downloading and importing of DPG articles'
;