create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_TICKET_STATUS_TRACKING (
	TICKET_AGREEMENT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the agreement ticket. Key generation based on META table for party key space.',
	USER_GROUP_PARTY_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party group as user group. Key generation based on META table for party key space.',
	TICKET_STATUS_ID NUMBER(38,0) NOT NULL COMMENT 'The code identifying the discriminators for tickets status',
	STATUS_CHANGE_DT DATE NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
	STATUS_CHANGE_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'A point in time, identified by a date and a time component.',
	STATUS_CHANGE_DAY_OF_WEEK_ID NUMBER(38,0) NOT NULL COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
	STATUS_CHANGE_HR_ID NUMBER(38,0) NOT NULL COMMENT 'The hour of day, i.e.a number in the range from 0 to 23.',
	USER_DIVISION_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division of the user who is status changer. Key generation based on META table for party key space.',
	USER_COUNTRY_BUSINESS_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the location as a business country of the user who is status changer. Key generation based on META table for party key space.',
	SOURCE_SYS_NR VARCHAR(100) NOT NULL COMMENT 'Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.',
	SOURCE_UPDATED_ON_TMSP TIMESTAMP_TZ(9) COMMENT 'Source system payload attribute - The point in time when this record was last modified in the source system. (In case the record has not been modified since its creation, source_updated_on is identical to creation timestamp)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_TICKET_STATUS_TRACKING primary key (TICKET_AGREEMENT_SID, USER_GROUP_PARTY_GROUP_SID, TICKET_STATUS_ID, STATUS_CHANGE_TMSP)
);