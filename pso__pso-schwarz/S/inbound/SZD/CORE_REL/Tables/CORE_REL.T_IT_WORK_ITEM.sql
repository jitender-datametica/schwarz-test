/* --------------------------------------------------------------------------------
   DDL for table: T_IT_WORK_ITEM
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:27
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_IT_WORK_ITEM (
   RESOURCE_ITEM_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   IT_WORK_ITEM_TYPE_ID                NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - ID identifying the discriminators for it resource types in IT4You like Project, Task, Specification',
   PARENT_IT_WORK_ITEM_RESOURCE_ITEM_SID NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.',
   RISK_ASSESSMENT_AGREEMENT_SID       NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier (surrogate key)',
   RELATED_SOLUTION_RESOURCE_ITEM_SID  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.',
   IT_WORK_ITEM_CATEGORY_CD            VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - code identifying category of working packages',
   RISK_ASSESSMENT_RELEVANT_FG         BOOLEAN         NOT NULL COMMENT 'Flag for identifying working package (AP) that must be analyzed by a risk assessment prozess (SARA).TRUE - AP must be analyszed by  SARA .FALSE - AP must not be analyzed by SARA.
            The filter used to identify the AP that must not be analyzed by  SARA.
            APs that have no Solution attached (Field "No Solution available (Initiate SIP)" is True)
            APs whose category is created from project, have a project reference and the project has the flag "SARA relevant" to True
            APs whose category is created from project, and have no project reference',
   IT_WORK_ITEM_NR                     VARCHAR(250)    NOT NULL COMMENT 'Business Key / Natural Key -  Number for the project, task, specification in IT4 you',
   IT_WORK_ITEM_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Descriptive Attribute - project, task, specification in IT4 you',
   IT_WORK_ITEM_CREATION_DT            DATE            NOT NULL COMMENT 'Descriptive Attribute - Start date for project, task, specification in IT4 you',
   IT_WORK_ITEM_CLOSING_DT             DATE            COMMENT 'Descriptive Attribute - Closing date of project, specification in IT4 you',
   SOURCE_SYS_NR                       VARCHAR(100)    NOT NULL COMMENT 'Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(250)    NOT NULL COMMENT 'The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_IT_WORK_ITEM PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - Entity is inherited from IT Resource & contains main items in the context of development/audit/risk assessment processes like Project (PRJ), Working Package (AP), Specification (SPEC) etc. Start & closing dates are added as an excpetion due to transactional nature - Source - IT4You ServiceNow';
