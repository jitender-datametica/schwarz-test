/* --------------------------------------------------------------------------------
   DDL for table: T_TICKET_TYPE
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_TICKET_TYPE (
   TICKET_TYPE_ID                      NUMBER(38, 0)   NOT NULL COMMENT 'The code identifying the discriminators for ticket types (Incident, NSR, Problem)',
   TICKET_TYPE_NAME                    VARCHAR(100)    NOT NULL COMMENT 'A textual name for the discriminators for ticket types',
   SYNONYM_TICKET_TYPE_NAME            VARCHAR(100)    NOT NULL COMMENT 'Descriptive Attribute - The synonym name of the ticket specified for IT4You.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_TICKET_TYPE PRIMARY KEY (TICKET_TYPE_ID) NOT ENFORCED 
)  COMMENT = 'Minor Entity - entity defines the discriminators for tickets (INC, NSR, PRB). Source - based on IT4You Service Now';
