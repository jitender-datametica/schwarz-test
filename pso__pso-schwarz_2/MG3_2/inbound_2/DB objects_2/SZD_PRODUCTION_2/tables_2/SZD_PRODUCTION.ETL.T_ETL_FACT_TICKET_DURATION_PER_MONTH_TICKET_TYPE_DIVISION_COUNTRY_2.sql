create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_FACT_TICKET_DURATION_PER_MONTH_TICKET_TYPE_DIVISION_COUNTRY_2 (
	TICKET_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the discriminators for ticket types.',
	CY_MONTH NUMBER(38,0) NOT NULL COMMENT 'The calendar_2 month as a number of the form YYYYMM, where YYYY is the calendar_2 year and MM_2 is month of the calendar_2 year.',
	TICKET_CREATOR_COUNTRY_BUSINESS_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the business country_2 (region_2 in IT4You). Key generation based on META table for party key space.',
	TICKET_CREATOR_DIVISION_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
	TICKET_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - A name for the discriminators for ticket types',
	TICKET_CREATOR_COUNTRY_BUSINESS_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - The name by which the country_2 is known,',
	TICKET_DURATION_TOTAL_MEAS NUMBER(38,0) NOT NULL COMMENT 'Fact - non additive/aggregatable - tickets duration (in sec) defined as status_2 timestamp resolved - created as last month snapshot.',
	TICKET_DURATION_UNIT_ID NUMBER(38,0) NOT NULL COMMENT 'Id of the unit_2 (e.g. material unit_2, production line parameter) for all duration measures',
	TICKET_AVG_DURATION_MEAS NUMBER(38,0) NOT NULL COMMENT 'Fact - non additive/aggregatable - average duration of tickets (in sec) based on tables granularity - created as last month snapshot.',
	TICKET_AVG_DURATION_UNIT_ID NUMBER(38,0) NOT NULL COMMENT 'Id of the unit_2 (e.g. material unit_2, production line parameter) for all average measures',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_FACT_TICKET_DURATION_PER_MONTH_TICKET_TYPE_DIVISION_COUNTRY primary key (TICKET_TYPE_ID, CY_MONTH, TICKET_CREATOR_COUNTRY_BUSINESS_LOCATION_SID, TICKET_CREATOR_DIVISION_PARTY_SID)
);