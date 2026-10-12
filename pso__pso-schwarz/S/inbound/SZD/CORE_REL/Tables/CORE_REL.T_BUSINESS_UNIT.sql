/* --------------------------------------------------------------------------------
   DDL for table: T_BUSINESS_UNIT
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_BUSINESS_UNIT (
   PARTY_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   BUSINESS_UNIT_NR                    VARCHAR(250)    NOT NULL COMMENT 'The identifier of a business unit.',
   BUSINESS_UNIT_NAME                  VARCHAR(100)    NOT NULL COMMENT 'The textual name of a business unit.',
   SYNONYM_BUSINESS_UNIT_NAME          VARCHAR(100)    COMMENT 'Descriptive Attribute - The synonym name of the business unit specified for IT4You, could be slightly different, denpendent on business requirement',
   SOURCE_SYS_NR                       VARCHAR(100)    NOT NULL COMMENT 'Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.',
   SOURCE_UPDATED_ON_TMSP              TIMESTAMP_TZ(9) COMMENT 'Source system payload attribute - The point in time when this record was last modified in the source system. (In case the record has not been modified since its creation, source_updated_on is identical to creation timestamp)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_BUSINESS_UNIT PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - lists the business units under Schwarz Group (e.g. Verwaltung, IT (S), IT(K), IT (L) etc.) - Source - IT4You ServiceNow';
