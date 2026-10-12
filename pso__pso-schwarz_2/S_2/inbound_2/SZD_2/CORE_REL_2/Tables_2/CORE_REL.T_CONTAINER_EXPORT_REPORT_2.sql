/* --------------------------------------------------------------------------------
   DDL for table: T_CONTAINER_EXPORT_REPORT_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CONTAINER_EXPORT_REPORT_2 (
   CONTAINER_RESOURCE_ITEM_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the container.',
   CONTAINER_EXPORT_REPORT_NAME        VARCHAR(100)    NOT NULL COMMENT 'The name of a export report that can be "P1", "P2", "P3", "P4"',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CONTAINER_EXPORT_STATUS_NR          VARCHAR(50)    NOT NULL COMMENT 'Descriptive Attribute - A value indicating the status_2 of the corresponding export report',
   CONTAINER_EXPORT_DT                 DATE            COMMENT 'Descriptive Attribute - The date when the report for this container is generated',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_CONTAINER_EXPORT_REPORT PRIMARY KEY (CONTAINER_RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP, CONTAINER_EXPORT_REPORT_NAME) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - Container was listed in an important system generated export - Source - VMT';
