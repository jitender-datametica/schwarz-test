/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_INTERNAL_ORGANIZATIONAL_UNIT_HIERARCHY
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_INTERNAL_ORGANIZATIONAL_UNIT_HIERARCHY (
   LVL0_INT_ORG_UNIT_PARTY_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space. Level 0 Internal Org Unit built in the data warehouse and 
            corresponds to the root with the value "alles".',
   LVL0_INT_ORG_UNIT_NAME              VARCHAR(100)    NOT NULL COMMENT 'The name of the organizational unit at level 0. It is built in the data warehouse and corresponds to the root with the value "alles".',
   LVL1_INT_ORG_UNIT_PARTY_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space. Level 1 Internal Org Unit',
   LVL1_INT_ORG_UNIT_NAME              VARCHAR(100)    NOT NULL COMMENT 'The name of the organizational unit at level1',
   LVL2_INT_ORG_UNIT_PARTY_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 2 Internal Org Unit',
   LVL2_INT_ORG_UNIT_NAME              VARCHAR(100)    NOT NULL COMMENT 'The name of the organizational unit at level2',
   LVL3_INT_ORG_UNIT_PARTY_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 3 Internal Org Unit',
   LVL3_INT_ORG_UNIT_NAME              VARCHAR(100)    NOT NULL COMMENT 'The name of the organizational unit at level3',
   LVL4_INT_ORG_UNIT_PARTY_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 4 Internal Org Unit',
   LVL4_INT_ORG_UNIT_NAME              VARCHAR(100)    NOT NULL COMMENT 'The name of the organizational unit at level4',
   LVL5_INT_ORG_UNIT_PARTY_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 5 Internal Org Unit',
   LVL5_INT_ORG_UNIT_NAME              VARCHAR(100)    NOT NULL COMMENT 'The name of the organizational unit at level5',
   LVL6_INT_ORG_UNIT_PARTY_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 6 Internal Org Unit',
   LVL6_INT_ORG_UNIT_NAME              VARCHAR(100)    NOT NULL COMMENT 'The name of the organizational unit at level6',
   LVL7_INT_ORG_UNIT_PARTY_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 7 Internal Org Unit',
   LVL7_INT_ORG_UNIT_NAME              VARCHAR(100)    NOT NULL COMMENT 'The name of the organizational unit at level7',
   LVL8_INT_ORG_UNIT_PARTY_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 8 Internal Org Unit',
   LVL8_INT_ORG_UNIT_NAME              VARCHAR(100)    NOT NULL COMMENT 'The name of the organizational unit at level8',
   LVL9_INT_ORG_UNIT_PARTY_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 9 Internal Org Unit',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   LVL9_INT_ORG_UNIT_NAME              VARCHAR(100)    NOT NULL COMMENT 'The name of the organizational unit at level9',
   INT_ORG_UNIT_HIERARCHY_LVL_NR       NUMBER(38, 0)   NOT NULL COMMENT 'The hierarchial level number of the organizational unit',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_INTERNAL_ORGANIZATIONAL_UNIT_HIERARCHY PRIMARY KEY (LVL9_INT_ORG_UNIT_PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - The flattened hierarchy table. The level is fixed. Table holds the hierarchy levels of organizational unit - Source - IT4You Service Now';
