/* --------------------------------------------------------------------------------
   DDL for table: T_IT_RESOURCE_TICKET_REL_1
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_IT_RESOURCE_TICKET_REL_1 (
   IT_RESOURCE_RESOURCE_ITEM_SID       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.',
   TICKET_AGREEMENT_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the agreement ticket. Key generation based on META table for party key space.',
   IT_RESOURCE_TICKET_REL_TYPE_CD      VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the discriminators for relation types between IT resources & tickets',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_IT_RESOURCE_TICKET_REL PRIMARY KEY (IT_RESOURCE_RESOURCE_ITEM_SID, TICKET_AGREEMENT_SID, IT_RESOURCE_TICKET_REL_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'M:N Relation Entity - This relation table holds the the relation of it resources (application, solution etc.) to their assigned tickets. Relation types can be affected or causative.';
