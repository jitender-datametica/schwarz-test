/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_RISK_ASSESSMENT_1
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:28
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_RISK_ASSESSMENT_1 (
   AGREEMENT_SID                       NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier (surrogate key)',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   RISK_ASSESSMENT_NR                  VARCHAR(250)    NOT NULL COMMENT 'Natural Key/Business Key - SARA Business Key',
   RISK_ASSESSMENT_NAME                VARCHAR(500)    NOT NULL COMMENT 'Descriptive Attribute - SARA name in IT4U source system',
   SOURCE_SYS_NR                       VARCHAR(100)    NOT NULL COMMENT 'Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.',
   SOURCE_UPDATED_ON_TMSP              TIMESTAMP_TZ(9) COMMENT 'Source system payload attribute - The point in time when this record was last modified in the source system. (In case the record has not been modified since its creation, source_updated_on is identical to creation timestamp)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(250)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_RISK_ASSESSMENT PRIMARY KEY (AGREEMENT_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - Schwarz Agile Risk assessment process (e.g. SARA) for a specific working package_1 or project, which will be assessed for risks like infosec - Source - IT4You ServiceNow';
