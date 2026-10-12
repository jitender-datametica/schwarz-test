/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_TICKET_STATUS_TRACKING_RESOLVING_PER_MONTH_TICKET_TYPE_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_TICKET_STATUS_TRACKING_RESOLVING_PER_MONTH_TICKET_TYPE_2 (
   TICKET_TYPE_ID                      NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the discriminators for ticket types.',
   CY_MONTH                            NUMBER(38, 0)   NOT NULL COMMENT 'The calendar_2 month as a number of the form YYYYMM, where YYYY is the calendar_2 year and MM_2 is month of the calendar_2 year.',
   TICKET_CREATOR_COUNTRY_BUSINESS_LOCATION_SID NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the business country_2 (region_2 in IT4You). Key generation based on META table for party key space.',
   TICKET_CREATOR_DIVISION_PARTY_SID   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
   TICKET_SOLVER_COUNTRY_BUSINESS_LOCATION_SID NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location. Key generation based on META table for party key space.',
   TICKET_SOLVER_DIVISION_PARTY_SID    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
   TICKET_TYPE_NAME                    VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - A name for the discriminators for ticket types',
   TICKET_CREATOR_COUNTRY_BUSINESS_NAME VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The name by which the business country_2 of creator-user is known,',
   TICKET_SOLVER_COUNTRY_BUSINESS_NAME VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The name by which the business country_2 of solver-user is known,',
   TICKET_RESOLVED_CNT                 NUMBER(38,0)    NOT NULL COMMENT 'Fact - non additive/aggregatable - tickets count of resolved tickets as last month snapshot_2',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_FACT_TICKET_STATUS_TRACKING_RESOLVING_PER_MONTH_TICKET_TYPE PRIMARY KEY (TICKET_TYPE_ID, CY_MONTH, TICKET_CREATOR_COUNTRY_BUSINESS_LOCATION_SID, TICKET_CREATOR_DIVISION_PARTY_SID, TICKET_SOLVER_COUNTRY_BUSINESS_LOCATION_SID, TICKET_SOLVER_DIVISION_PARTY_SID) NOT ENFORCED 
)  COMMENT = 'Fact table - Analytical - Granularity - by month & ticket type  & users division & users country_2 - Accumulating Snapshot_2 - contains aggregated status_2 of completed (previous) month generated on the first of every month.Contains NOT necessary every status_2 change of a ticket, Due to nature of a snapshot_2 only the latest status_2 (current status_2) of ticket will be exported from source system. So gaps in status_2 change chain are possible - Source - IT4You Service Now.';
