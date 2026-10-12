/* --------------------------------------------------------------------------------
   DDL for table: T_TICKET_CLOSING_REASON_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_TICKET_CLOSING_REASON_2 (
   TICKET_CLOSING_REASON_ID            NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the discriminators for ticket closing reasons',
   LANG_CD                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   TICKET_TYPE_ID                      NUMBER(38, 0)   NOT NULL COMMENT 'The code identifying the discriminators for ticket types (Incident, NSR, Problem)',
   TICKET_CLOSING_REASON_CD            VARCHAR(50)     NOT NULL COMMENT 'A code for the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed successully, Declined, CBBC for Rückruf vor Abschluss. In some cases also numbered codes',
   TICKET_CLOSING_REASON_NAME          VARCHAR(100)    NOT NULL COMMENT 'A name for the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed successully, Declined',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_TICKET_CLOSING_REASON PRIMARY KEY (TICKET_CLOSING_REASON_ID, LANG_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - defines the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed, successully Declined
             Source - IT4You Service Now';
