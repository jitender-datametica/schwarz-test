create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_TIME_PERIOD (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key of the non personalized discount.',
	NP_DISCOUNT_ACTION_NR NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the action for a non-personalized discount.',
	DAY_OF_WEEK NUMBER(38,0) NOT NULL COMMENT 'The day of the week on which the non- personalized discount is active within its validity period.',
	NP_DISCOUNT_START_DT DATE NOT NULL COMMENT 'Start date of the non-personalized discount.',
	NP_DISCOUNT_END_DT DATE NOT NULL COMMENT 'End date of the non-personalized discount.',
	NP_DISCOUNT_START_TIME TIME(0) NOT NULL COMMENT 'The start time at which the the non-personalized discount  becomes active within its validity period.',
	NP_DISCOUNT_END_TIME TIME(0) NOT NULL COMMENT 'The end time until which the non-personalized discount  remains active within its validity period.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_NON_PERSONALIZED_DISCOUNT_TIME_PERIOD primary key (NP_DISCOUNT_SID, NP_DISCOUNT_ACTION_NR, DAY_OF_WEEK)
)COMMENT='This table defines the validity intervals for non-personalized discount.'
;
