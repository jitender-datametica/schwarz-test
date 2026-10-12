/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_TRANSPORTATION_UNIT_L9X_REL_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 30. Mai 2024 15:03:57
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_TRANSPORTATION_UNIT_L9X_REL_1 (
   WH_TRANSPORTATION_UNIT_SID          NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key for the warehouse transportation unit. The SID is generated based on wh_transportation_unit_nr, sap_client_id and sap_system_name. ',
   WH_TRANSPORTATION_UNIT_NR           VARCHAR(50)     COMMENT 'The unique internal ID for the warehouse transportation unit_1 delivering the products associated with a given order line. This internal ID is generated for the originally provided warehouse transportation unit_1 number by the external transportation service provider (ext_wh_transportation_unit_nr).  In case the external warehouse transportation unit_1 number changes, the internal ID will remain the same and there will be another row for the new unique combination of ext_wh_transportation_unit_nr and wh_transportation_unit_nr',
   ALT_WH_TRANSPORTATION_UNIT_NR       VARCHAR(50)     COMMENT 'An alternative unique identifier for the warehouse transportation unit_1 that is maintained manually by the warehouse employees.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_TRANSPORTATION_UNIT_L9X_REL PRIMARY KEY (WH_TRANSPORTATION_UNIT_SID) NOT ENFORCED 
)  COMMENT = 'An ETL table that relates natural key from the system and the one that is maintained manually for transportation units from L9X source system.';
