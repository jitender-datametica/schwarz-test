/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_TICKET_CREATION_METHOD_TYPE
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_TICKET_CREATION_METHOD_TYPE (
   TICKET_CREATION_METHOD_TYPE_ID      NUMBER(38, 0)   NOT NULL COMMENT 'The code identifying the discriminators for  ticket creation method type like Fullfiller or Enduserportal',
   TICKET_TYPE_ID                      NUMBER(38, 0)   NOT NULL COMMENT 'The code identifying the discriminators for ticket types.',
   TICKET_CREATION_METHOD_TYPE_CD      VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the discriminators for  ticket creation method type like Fullfiller or Enduserportal',
   TICKET_CREATION_METHOD_TYPE_NAME    VARCHAR(100)    NOT NULL COMMENT 'A textual description for the discriminators for ticket creation method type',
   TICKET_CREATION_METHOD_TYPE_NAME_DE VARCHAR(100)    NOT NULL COMMENT 'A textual description for the discriminators for ticket creation method type. Language german',
   TICKET_CREATION_METHOD_TYPE_NAME_EN VARCHAR(100)    NOT NULL COMMENT 'A textual description for the discriminators for ticket creation method type. Language english',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_TICKET_CREATION_METHOD_TYPE PRIMARY KEY (TICKET_CREATION_METHOD_TYPE_ID) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - defines the discriminators for ticket creation method type like Fullfiller or Enduserportal. Source - Manually filled';
