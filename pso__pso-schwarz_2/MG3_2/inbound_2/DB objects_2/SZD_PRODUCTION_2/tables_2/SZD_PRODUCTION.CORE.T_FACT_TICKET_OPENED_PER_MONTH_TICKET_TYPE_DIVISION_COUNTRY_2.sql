create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_TICKET_OPENED_PER_MONTH_TICKET_TYPE_DIVISION_COUNTRY_2 (
	TICKET_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the discriminators for ticket types.',
	CY_MONTH NUMBER(38,0) NOT NULL COMMENT 'The calendar_2 month as a number of the form YYYYMM, where YYYY is the calendar_2 year and MM_2 is month of the calendar_2 year.',
	TICKET_CREATOR_COUNTRY_BUSINESS_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the business country_2 (region_2 in IT4You). Key generation based on META table for party key space.',
	TICKET_CREATOR_DIVISION_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
	TICKET_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - A name for the discriminators for ticket types',
	TICKET_CREATOR_COUNTRY_BUSINESS_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - The name by which the business country_2 of creator-user is known,',
	TICKET_CREATOR_DIVISION_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - The name by which the division of creator-user is known,',
	TICKET_CREATED_CNT NUMBER(38,0) NOT NULL COMMENT 'Fact - additive/aggregatable - tickets count of created tickets as last month snapshot.',
	TICKET_OPENED_CNT NUMBER(38,0) NOT NULL COMMENT 'Fact - non additive/aggregatable - tickets count of opened tickets as last month snapshot. It means all tickets that were created before the end of  last month and the resolved date can still be empty or must be after the first of current month. In order to filter possible errors coming from the source system concerning INC and NSR tickets,  the status_2 of such tickets must not be closed.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_FACT_TICKET_OPENED_PER_MONTH_TICKET_TYPE_DIVISION_COUNTRY primary key (TICKET_TYPE_ID, CY_MONTH, TICKET_CREATOR_COUNTRY_BUSINESS_LOCATION_SID, TICKET_CREATOR_DIVISION_PARTY_SID)
)COMMENT='Fact table - Analytical - Granularity - by month & ticket type & users division & users country_2 - Periodic Snapshot_2 - contains aggregated status_2 of completed (previous) month generated on the first of every month. Due to nature of a snapshot_2 only the latest number of created and opened tickets from previous month will be taken in to account_2 . - Source - IT4You Service Now.'
;