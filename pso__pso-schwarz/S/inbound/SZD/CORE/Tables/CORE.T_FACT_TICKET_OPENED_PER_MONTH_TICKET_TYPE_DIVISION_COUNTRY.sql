/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_TICKET_OPENED_PER_MONTH_TICKET_TYPE_DIVISION_COUNTRY
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_TICKET_OPENED_PER_MONTH_TICKET_TYPE_DIVISION_COUNTRY (
   TICKET_TYPE_ID                      NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the discriminators for ticket types.',
   CY_MONTH                            NUMBER(38, 0)   NOT NULL COMMENT 'The calendar month as a number of the form YYYYMM, where YYYY is the calendar year and MM is month of the calendar year.',
   TICKET_CREATOR_COUNTRY_BUSINESS_LOCATION_SID NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the business country (region in IT4You). Key generation based on META table for party key space.',
   TICKET_CREATOR_DIVISION_PARTY_SID   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
   TICKET_TYPE_NAME                    VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - A name for the discriminators for ticket types',
   TICKET_CREATOR_COUNTRY_BUSINESS_NAME VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The name by which the business country of creator-user is known,',
   TICKET_CREATOR_DIVISION_NAME        VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The name by which the division of creator-user is known,',
   TICKET_CREATED_CNT                  NUMBER(38,0)    NOT NULL COMMENT 'Fact - additive/aggregatable - tickets count of created tickets as last month snapshot.',
   TICKET_OPENED_CNT                   NUMBER(38,0)    NOT NULL COMMENT 'Fact - non additive/aggregatable - tickets count of opened tickets as last month snapshot. It means all tickets that were created before the end of  last month and the resolved date can still be empty or must be after the first of current month. In order to filter possible errors coming from the source system concerning INC and NSR tickets,  the status of such tickets must not be closed.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_FACT_TICKET_OPENED_PER_MONTH_TICKET_TYPE_DIVISION_COUNTRY PRIMARY KEY (TICKET_TYPE_ID, CY_MONTH, TICKET_CREATOR_COUNTRY_BUSINESS_LOCATION_SID, TICKET_CREATOR_DIVISION_PARTY_SID) NOT ENFORCED 
)  COMMENT = 'Fact table - Analytical - Granularity - by month & ticket type & users division & users country - Periodic Snapshot - contains aggregated status of completed (previous) month generated on the first of every month. Due to nature of a snapshot only the latest number of created and opened tickets from previous month will be taken in to account . - Source - IT4You Service Now.';
