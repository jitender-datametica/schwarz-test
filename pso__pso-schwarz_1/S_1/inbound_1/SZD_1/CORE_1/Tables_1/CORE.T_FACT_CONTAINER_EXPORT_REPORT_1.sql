/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CONTAINER_EXPORT_REPORT_1
   generated from Powerdesigner on Freitag, 2. August 2024 08:21:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CONTAINER_EXPORT_REPORT_1 DATA_RETENTION_TIME_IN_DAYS = 7 (
   CONTAINER_RESOURCE_ITEM_SID         NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The unique identifier (surrogate key) for the container.',
   CONTAINER_EXPORT_REPORT_NAME        VARCHAR(100)    NOT NULL COMMENT 'Natural Key/Business Key - A milestone is an event in the container lifecycle. Table contains the list of the possible event results',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CONTAINER_EXPORT_STATUS_NR          VARCHAR(50)     NOT NULL COMMENT 'Descriptive Attribute - A milestone is an event in the container lifecycle. Table contains the list of the possible events',
   CONTAINER_EXPORT_DT                 DATE            COMMENT 'The date when the report for this container is generated',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_FACT_CONTAINER_EXPORT_REPORT PRIMARY KEY (CONTAINER_RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP, CONTAINER_EXPORT_REPORT_NAME) NOT ENFORCED 
)  COMMENT = 'Fact table - Transactional Events - Transaction - Container was listed in an important system generated export. - Source - VMT';
