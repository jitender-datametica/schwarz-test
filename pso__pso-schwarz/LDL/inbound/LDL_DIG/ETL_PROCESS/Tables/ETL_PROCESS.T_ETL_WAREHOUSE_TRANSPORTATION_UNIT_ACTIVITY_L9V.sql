/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_TRANSPORTATION_UNIT_ACTIVITY_L9V
   GENERATED FROM POWERDESIGNER ON Montag, 10. Juni 2024 17:25:58
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_TRANSPORTATION_UNIT_ACTIVITY_L9V (
   WH_TRANSPORTATION_UNIT_SID          NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key for the warehouse transportation unit. The SID is generated based on wh_transportation_unit_nr, sap_client_id and sap_system_name. ',
   WH_TRANSPORTATION_UNIT_ACTIVITY_NR  VARCHAR(20)     NOT NULL COMMENT 'The unique ID for the activity of the transportation unit at the warehouse. The activity relates to the process of loading and unloading, whenever a transportation unit is docked at the warehouse. ',
   WH_TRANSPORTATION_UNIT_NR           VARCHAR(50)     COMMENT 'The unique internal ID for the warehouse transportation unit delivering the products associated with a given order line. This internal ID is generated for the originally provided warehouse transportation unit number by the external transportation service provider (alt_wh_transportation_unit_nr).  In case the alternate warehouse transportation unit number changes, the internal ID will remain the same and there will be another row for the new unique combination of alt_wh_transportation_unit_nr and wh_transportation_unit_nr',
   ACTIVITY_START_ACTUAL_TMSP          TIMESTAMP_LTZ(9) COMMENT 'The timestamp when the activity of loading or unloading of the transportation unit actually starts at the warehouse.',
   ACTIVITY_END_ACTUAL_TMSP            TIMESTAMP_LTZ(9) COMMENT 'The timestamp when the activity of loading or unloading of the transportation unit actually ends at the warehouse.',
   ACTIVITY_START_PLAN_TMSP            TIMESTAMP_LTZ(9) COMMENT 'The timestamp when the activity of loading or unloading of the transportation unit was planned at the warehouse. It could be different than activity_start_actual_tmsp.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_TRANSPORTATION_UNIT_ACTIVITY_L9V PRIMARY KEY (WH_TRANSPORTATION_UNIT_SID, WH_TRANSPORTATION_UNIT_ACTIVITY_NR) NOT ENFORCED 
)  COMMENT = 'An ETL table to represent the shipping and receiving activities of a transportation unit from the L9V source system.';
