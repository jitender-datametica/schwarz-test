create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_TICKET_ASSIGNMENT_PER_DAY_TICKETTYPE_USERGROUP_2 (
	ASSIGNMENT_USER_GROUP_PARTY_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party group as user group. Key generation based on META table for party key space.',
	TICKET_ASSIGNMENT_DT DATE NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
	TICKET_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The code identifying the discriminators for ticket types.',
	TICKET_ASSIGNMENT_DAY_OF_WEEK_ID NUMBER(38,0) NOT NULL COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
	ASSIGNMENT_USER_GROUP_NR NUMBER(38,0) NOT NULL COMMENT 'Denormalized Attribute - Natural/Business Key - id of user group',
	ASSIGNMENT_USER_GROUP_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - The group name by which the user group is identified on the system.',
	TICKET_ASSIGNMENT_CNT NUMBER(38,0) NOT NULL COMMENT 'Fact - additive/aggregatable - ticket assignement count per per day / ticket type / user group',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_FACT_TICKET_ASSIGNMENT_PER_DAY_TICKETTYPE_USERGROUP primary key (ASSIGNMENT_USER_GROUP_PARTY_GROUP_SID, TICKET_ASSIGNMENT_DT, TICKET_TYPE_ID)
)COMMENT='Fact table - Analytical - Granularity - by day & ticket type & assignement user group - Aggregate - containing every assignement after ticket creation to an assignement group - Source - IT4You Service Now.'
;