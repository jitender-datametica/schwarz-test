/* --------------------------------------------------------------------------------
   DDL for table: T_INTERNAL_ORGANIZATIONAL_UNIT_REL_1
   generated from Powerdesigner on Montag, 18. November 2024 13:22:46
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INTERNAL_ORGANIZATIONAL_UNIT_REL_1 (
   CHILD_INTERNAL_ORG_UNIT_PARTY_SID   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   PARENT_INTERNAL_ORG_UNIT_PARTY_SID  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_INTERNAL_ORGANIZATIONAL_UNIT_REL PRIMARY KEY (CHILD_INTERNAL_ORG_UNIT_PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'This relation table holds the internal organizational units under Schwarz Group and their child units.- Source - IT4You ServiceNow';
