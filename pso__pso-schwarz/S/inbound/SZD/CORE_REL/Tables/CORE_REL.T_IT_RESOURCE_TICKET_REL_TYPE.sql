/* --------------------------------------------------------------------------------
   DDL for table: T_IT_RESOURCE_TICKET_REL_TYPE
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_IT_RESOURCE_TICKET_REL_TYPE (
   IT_RESOURCE_TICKET_REL_TYPE_CD      VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the discriminators for relation types between IT resources & tickets',
   IT_RESOURCE_TICKET_REL_TYPE_DESCR   VARCHAR(250)    NOT NULL COMMENT 'A textual description for the discriminators for relation types between IT resources & tickets',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_IT_RESOURCE_TICKET_REL_TYPE PRIMARY KEY (IT_RESOURCE_TICKET_REL_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - table holds the relation types (affected or causative) of IT resources (application, solution etc.) to their assigned tickets.';
