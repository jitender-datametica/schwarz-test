/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_GHOST_PACKAGE_CONFIGURATION_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 20. Februar 2024 12:41:19
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_GHOST_PACKAGE_CONFIGURATION_1 (
   HAULER_SID                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for hauler.',
   DIST_CHANNEL_CD                     VARCHAR(5)      NOT NULL COMMENT 'The code for the distribution channel ( a channel  through which the goods are sold )',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   FIRST_SCAN_DAYS_CNT                 NUMBER          COMMENT 'Number of days without scan since the goods are issued, to consider the package_1  to be a "ghost".',
   DELIVERY_DAYS_CNT                   NUMBER          COMMENT 'Number of days without delivery since the goods are issued, to consider the package_1  to be a "ghost".',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_ETL_GHOST_PACKAGE_CONFIGURATION PRIMARY KEY (HAULER_SID, DIST_CHANNEL_CD, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'ETL table used for configuration purposes for evaluating Ghost Packages (missing packages).';
