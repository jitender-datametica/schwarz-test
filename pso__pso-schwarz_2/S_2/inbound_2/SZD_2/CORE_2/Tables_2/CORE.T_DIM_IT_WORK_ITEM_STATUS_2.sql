/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_IT_WORK_ITEM_STATUS_2
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:28
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_IT_WORK_ITEM_STATUS_2 (
   IT_WORK_ITEM_STATUS_ID              NUMBER(38, 0)   NOT NULL COMMENT 'The code identifying the discriminators for it work item_2 status_2 (of project, working package_2, specification)',
   IT_WORK_ITEM_TYPE_ID                NUMBER(38, 0)   NOT NULL COMMENT 'The code identifying the discriminators for it work item_2 types (project, working package_2, specification)',
   IT_WORK_ITEM_STATUS_CD              VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the it work item_2 status_2 (of project, working package_2, specification)',
   IT_WORK_ITEM_STATUS_NAME            VARCHAR(100)    NOT NULL COMMENT 'Descriptive Attribute - A name for it work item_2 status_2  (of project, working package_2, specification)',
   IT_WORK_ITEM_STATUS_NAME_DE         VARCHAR(100)    NOT NULL COMMENT 'A textual description for the discriminators for it work item_2 status. Language german',
   IT_WORK_ITEM_STATUS_NAME_EN         VARCHAR(100)    NOT NULL COMMENT 'A textual description for the discriminators for it work item_2 status. Language english',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_IT_WORK_ITEM_STATUS PRIMARY KEY (IT_WORK_ITEM_STATUS_ID) NOT ENFORCED 
)  COMMENT = 'Minor Dimensio - defines the discriminators for it_work_item status. Possible status_2: Open / Work in progress / Waiting - wait for external oder wait for enduser / Comped / Closed. - Source - IT4You Service Now';
