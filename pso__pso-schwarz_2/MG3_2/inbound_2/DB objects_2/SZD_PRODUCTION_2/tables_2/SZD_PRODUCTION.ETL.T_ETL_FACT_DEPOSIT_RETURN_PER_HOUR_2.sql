create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_FACT_DEPOSIT_RETURN_PER_HOUR_2 (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
	RETURN_HOUR NUMBER(38,0) NOT NULL COMMENT 'The code for the deposit item_2 return hour.',
	DEPOSIT_ITEM_SUB_CAT_ID NUMBER(38,0) NOT NULL COMMENT 'The code for the item_2 return type of deposits.',
	DEPOSIT_ITEM_CNT NUMBER(38,0) NOT NULL COMMENT 'The amount of returned deposit items per hour',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_DEPOSIT_RETURN_PER_H primary key (CAL_DT, RVM_SID, DEPOSIT_ITEM_SUB_CAT_ID, RETURN_HOUR)
);