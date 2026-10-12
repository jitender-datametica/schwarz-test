create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_CAL_DATE_ADJUSTMENT_TYPE_1 (
	CAL_DT_ADJUST_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'A code for the rule, which defines, how a calendar_1 date is related to its equivalent day(s) in the previous year(s).',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	CAL_DT_ADJUST_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A description of the rule, how a calendar_1 date is related to its equivalent day(s) in the previous year(s).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CAL_DATE_ADJUSTMENT_TYPE primary key (CAL_DT_ADJUST_TYPE_CD, LANG_CD)
)COMMENT='This minor entity defines the rules, which describe, how a date is related to its equivalent date(s) in the previous year(s). In case of leap years this may result in a many-to-many relationship. One rule is used on month-level. E.g. 28th of February 2021 is mapped to both 28th and 29 of February 2020. Another rule maps the 28 of February 2021 to both March 1st and March 2nd of 2019, so that the integrity of business years is maintained.'
;