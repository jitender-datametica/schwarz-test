/* --------------------------------------------------------------------------------
   DDL for table: T_TICKET_ASSIGNMENT_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_TICKET_ASSIGNMENT_2 (
   TICKET_AGREEMENT_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the agreement ticket. Key generation based on META table for party key space.',
   ASSIGNMENT_USER_GROUP_PARTY_GROUP_SID NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party group as user group. Key generation based on META table for party key space.',
   PREV_ASSIGNMENT_USER_GROUP_PARTY_GROUP_SID NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party group as previous assignement group. Key generation based on META table for party key space.',
   TICKET_ASSIGNMENT_DT                DATE            NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   TICKET_ASSIGNMENT_TMSP              TIMESTAMP_TZ(9) NOT NULL COMMENT 'A point in time, identified by a date and a time component.',
   TICKET_ASSIGNMENT_DAY_OF_WEEK_ID    NUMBER(38, 0)   NOT NULL COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
   TICKET_ASSIGNMENT_HR_ID             NUMBER(38, 0)   NOT NULL COMMENT 'The hour of day, i.e.a number in the range from 0 to 23.',
   FINAL_ASSIGNMENT_FG                 BOOLEAN         NOT NULL COMMENT 'Flag for designating if final assignement',
   FULLFILLER_DELEGATED_FG             BOOLEAN         NOT NULL COMMENT 'Record is on TRUE if fullfiller creates a ticket & directly delegates it to another group in fullfiller ticket creation method.',
   SOURCE_SYS_NR                       VARCHAR(100)    NOT NULL COMMENT 'Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.',
   SOURCE_UPDATED_ON_TMSP              TIMESTAMP_TZ(9) COMMENT 'Source system payload attribute - The point in time when this record was last modified in the source system. (In case the record has not been modified since its creation, source_updated_on is identical to creation timestamp)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_TICKET_ASSIGNMENT PRIMARY KEY (TICKET_AGREEMENT_SID, ASSIGNMENT_USER_GROUP_PARTY_GROUP_SID, PREV_ASSIGNMENT_USER_GROUP_PARTY_GROUP_SID, TICKET_ASSIGNMENT_TMSP) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional Events - containing every assignement after ticket creation to an assignment group, - Source - IT4You Service Now.';
