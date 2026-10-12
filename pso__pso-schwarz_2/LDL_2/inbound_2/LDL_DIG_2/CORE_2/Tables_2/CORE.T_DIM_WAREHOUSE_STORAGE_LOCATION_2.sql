CREATE TABLE CORE.T_DIM_WAREHOUSE_STORAGE_LOCATION_2 (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   STORAGE_LOC_CD                      VARCHAR(10)     NOT NULL COMMENT 'The code which identifies the storage location_2 (10001, 1002, etc)',
   STORAGE_LOC_DESCR                   VARCHAR(250)    COMMENT 'A textual description for  the storage location_2 (Main Storage, Customer Returns, etc)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_WAREHOUSE_STORAGE_LOCATION PRIMARY KEY (WH_SID, STORAGE_LOC_CD)
       NOT ENFORCED
)
COMMENT = 'This minor dimension defines the type of the storage location_2 (1001 - Main Storage, 1002 - Customer Returns, etc)';