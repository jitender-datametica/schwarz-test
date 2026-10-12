create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_DEPOSIT_RETURN_PER_HOUR (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
	RETURN_HOUR NUMBER(38,0) NOT NULL COMMENT 'The code for the deposit item return hour.',
	DEPOSIT_ITEM_SUB_CAT_ID NUMBER(38,0) NOT NULL COMMENT 'The code for the item return type of deposits.',
	DEPOSIT_ITEM_CNT NUMBER(38,0) NOT NULL COMMENT 'The amount of returned deposit items per hour',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_DEPOSIT_RETURN_PER_H primary key (CAL_DT, RVM_SID, DEPOSIT_ITEM_SUB_CAT_ID, RETURN_HOUR)
)COMMENT='Transactional facts capturing returning items per hour'
;