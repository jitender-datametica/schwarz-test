create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_FACT_TICKET_STATUS_TRACKING_RESOLVING_PER_MONTH_TICKET_TYPE (
	TICKET_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the discriminators for ticket types.',
	CY_MONTH NUMBER(38,0) NOT NULL COMMENT 'The calendar month as a number of the form YYYYMM, where YYYY is the calendar year and MM is month of the calendar year.',
	TICKET_CREATOR_COUNTRY_BUSINESS_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the business country (region in IT4You). Key generation based on META table for party key space.',
	TICKET_CREATOR_DIVISION_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
	TICKET_SOLVER_COUNTRY_BUSINESS_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the location. Key generation based on META table for party key space.',
	TICKET_SOLVER_DIVISION_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
	TICKET_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - A name for the discriminators for ticket types',
	TICKET_CREATOR_COUNTRY_BUSINESS_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - The name by which the business country of creator-user is known,',
	TICKET_SOLVER_COUNTRY_BUSINESS_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - The name by which the business country of solver-user is known,',
	TICKET_RESOLVED_CNT NUMBER(38,0) NOT NULL COMMENT 'Fact - non additive/aggregatable - tickets count of resolved tickets as last month snapshot',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_FACT_TICKET_STATUS_TRACKING_RESOLVING_PER_MONTH_TICKET_TYPE primary key (TICKET_TYPE_ID, CY_MONTH, TICKET_CREATOR_COUNTRY_BUSINESS_LOCATION_SID, TICKET_CREATOR_DIVISION_PARTY_SID, TICKET_SOLVER_COUNTRY_BUSINESS_LOCATION_SID, TICKET_SOLVER_DIVISION_PARTY_SID)
);