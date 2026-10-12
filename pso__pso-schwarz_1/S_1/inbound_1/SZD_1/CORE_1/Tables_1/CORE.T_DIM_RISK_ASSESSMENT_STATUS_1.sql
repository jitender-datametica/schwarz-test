/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_RISK_ASSESSMENT_STATUS_1
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:27
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_RISK_ASSESSMENT_STATUS_1 (
   RISK_ASSESSMENT_STATUS_ID           NUMBER(38, 0)   NOT NULL COMMENT 'The code identifying the discriminators for it work item_1 status_1 (of project, working package_1, specification)',
   RISK_ASSESSMENT_STATUS_CD           VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the risk assessment status_1 (of SARA or SARA Taks)',
   RISK_ASSESSMENT_TYPE_CD             VARCHAR(50)     NOT NULL COMMENT 'The static code identifying the risk assessment types (values RA_1, RAT)',
   RISK_ASSESSMENT_STATUS_NAME         VARCHAR(100)    NOT NULL COMMENT 'Descriptive Attribute - A name for the risk assessment status_1 (of SARA or SARA Taks)',
   RISK_ASSESSMENT_STATUS_NAME_DE      VARCHAR(100)    NOT NULL COMMENT 'A textual description for the discriminators for risk assessment status. Language german',
   RISK_ASSESSMENT_STATUS_NAME_EN      VARCHAR(100)    NOT NULL COMMENT 'A textual description for the discriminators for risk assessment status. Language english',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_RISK_ASSESSMENT_STATUS PRIMARY KEY (RISK_ASSESSMENT_STATUS_ID) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - defines the discriminators for risk assessment & assessment task status. Possible status_1 SARA: Stammdaten in Bearbeitung / Relevanzfragen in Bearbeitung & SARA-Task: Offen / In Bearbeitung / Abgeschlossen  - Source - IT4You Service Now';
