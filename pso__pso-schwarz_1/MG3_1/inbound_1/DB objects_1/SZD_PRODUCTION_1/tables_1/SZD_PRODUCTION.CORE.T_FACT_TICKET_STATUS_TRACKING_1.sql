create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_TICKET_STATUS_TRACKING_1 (
	TICKET_AGREEMENT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the agreement ticket. Key generation based on META table for party key space.',
	USER_GROUP_PARTY_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party group as user group. Key generation based on META table for party key space.',
	TICKET_STATUS_ID NUMBER(38,0) NOT NULL COMMENT 'The code identifying the discriminators for tickets status_1',
	STATUS_CHANGE_DT DATE NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	STATUS_CHANGE_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'A point in time, identified by a date and a time component.',
	STATUS_CHANGE_DAY_OF_WEEK_ID NUMBER(38,0) NOT NULL COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
	STATUS_CHANGE_HR_ID NUMBER(38,0) NOT NULL COMMENT 'The hour of day, i.e.a number in the range from 0 to 23.',
	USER_DIVISION_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division of the user who is status_1 changer. Key generation based on META table for party key space.',
	USER_COUNTRY_BUSINESS_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the location_1 as a country_1 of the user who is status_1 changer. Key generation based on META table for party key space.',
	TICKET_NR VARCHAR(250) NOT NULL COMMENT 'Denormalized Attribute - Natural/Business Key -  Ticket Nummer (z.B. INC1234567) of a ticket created in e.g. IT4You.',
	ASSIGNED_USER_GROUP_NR NUMBER(38,0) NOT NULL COMMENT 'Denormalized Attribute - Natural/Business Key - id of user group',
	ASSIGNED_USER_GROUP_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - The group name by which the user group is identified on the system.',
	SOURCE_SYS_NR VARCHAR(100) NOT NULL COMMENT 'Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.',
	SOURCE_UPDATED_ON_TMSP TIMESTAMP_TZ(9) COMMENT 'Source system payload attribute - The point in time when this record was last modified in the source system. (In case the record has not been modified since its creation, source_updated_on is identical to creation timestamp)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_FACT_TICKET_STATUS_TRACKING primary key (TICKET_AGREEMENT_SID, USER_GROUP_PARTY_GROUP_SID, TICKET_STATUS_ID, STATUS_CHANGE_TMSP)
)COMMENT='Fact table - Transactional -Permuted  Periodic Snapshot_1 - containing NOT necessary every status_1 change of a ticket, Due to nature of a snapshot_1 only the latest status_1 of ticket will be exported from source system. So gaps in status_1 change chain are possible. These gaps are artificially filled in the DWH day after day if a ticket has not undergone a status_1 change on that day. This means that the last status_1 can be more than 1 day in the past - Source - IT4You Service Now.'
;