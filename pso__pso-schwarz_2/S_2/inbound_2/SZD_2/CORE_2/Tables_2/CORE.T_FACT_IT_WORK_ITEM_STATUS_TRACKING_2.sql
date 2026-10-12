/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_IT_WORK_ITEM_STATUS_TRACKING_2
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:27
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_IT_WORK_ITEM_STATUS_TRACKING_2 (
   IT_WORK_ITEM_RESOURCE_ITEM_SID      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.',
   IT_WORK_ITEM_STATUS_ID              NUMBER(38, 0)   NOT NULL COMMENT 'The code identifying the discriminators for it work item_2 status_2 (of project, working package_2, specification)',
   IT_WORK_ITEM_STATUS_CHANGE_TMSP     TIMESTAMP_TZ(9) NOT NULL COMMENT 'A point in time, identified by a date and a time component.',
   RISK_ASSESSMENT_AGREEMENT_SID       NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier (surrogate key) for risk assessment',
   RISK_ASSESSMENT_STATUS_ID           NUMBER(38, 0)   NOT NULL COMMENT 'The code identifying the discriminators for it work item_2 status_2 (of project, working package_2, specification)',
   RELATED_SOLUTION_RESOURCE_ITEM_SID  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.',
   IT_WORK_ITEM_TYPE_ID                NUMBER(38, 0)   NOT NULL COMMENT ' Denormalized Attribute- ID identifying the discriminators for it resource types in IT4You like Project, Task, Specification',
   IT_WORK_ITEM_NR                     VARCHAR(250)    NOT NULL COMMENT 'Denormalized Attribute - Business Key / Natural Key -  Number for the project, task, specification in IT4 you',
   RISK_ASSESSMENT_NR                  VARCHAR(250)    NOT NULL COMMENT 'Natural Key/Business Key - SARA Business Key',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_FACT_IT_WORK_ITEM_STATUS_TRACKING PRIMARY KEY (IT_WORK_ITEM_RESOURCE_ITEM_SID, IT_WORK_ITEM_STATUS_ID, IT_WORK_ITEM_STATUS_CHANGE_TMSP) NOT ENFORCED 
)  COMMENT = 'Fact table - Transactional - Snapshot_2 - containing NOT necessary every status_2 change of a IT Work Item_2 (PRJ, AP, SPEC) with its corresponding risk assessment (RA_2). Status_2 of SARA dont'' cause new records in a table & are only additional - Source - IT4You Service Now.';
