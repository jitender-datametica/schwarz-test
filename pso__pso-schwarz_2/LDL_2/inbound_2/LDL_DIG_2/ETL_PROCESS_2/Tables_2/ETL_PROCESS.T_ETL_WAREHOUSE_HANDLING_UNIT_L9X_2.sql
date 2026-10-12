/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_HANDLING_UNIT_L9X_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. November 2024 17:03:27
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_HANDLING_UNIT_L9X_2 (
   HANDLING_UNIT_SID                   NUMBER          NOT NULL COMMENT 'Surrogate Key of the Handling Unit. Generated based on src_handling_unit_id, sap_sys_name, sap_client_id
            A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. ',
   SRC_HANDLING_UNIT_ID                VARCHAR(64)     COMMENT 'The ID of the Handling Unit_2 in the source system
            A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. ',
   WH_SID                              NUMBER          COMMENT 'The unique identifier(surrogate key) of  warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'Warehouse code',
   HANDLING_UNIT_NR                    VARCHAR(40)     COMMENT 'Identifier of the handling unit_2 coming from the source system.',
   STORAGE_PLACE_NR                    VARCHAR(40)     COMMENT 'Identifier of the place where the handling unit_2 is stored. This is a static place within a warehouse (shelf, room ... )',
   SRC_CHANGE_TMSP                     TIMESTAMP_NTZ   COMMENT 'Timestamp of the last update of the record in the source system.',
   HANDLING_UNIT_TOTAL_WEIGHT_UOM_SID  NUMBER          COMMENT 'The surrogate key for the unit_2 of measurement for the total weight (handling_unit_total_weight_meas).',
   HANDLING_UNIT_TOTAL_WEIGHT_UOM_CD   VARCHAR(10)     COMMENT 'The code for the unit_2 of measurement for the total weight (handling_unit_total_weight_meas).',
   HANDLING_UNIT_LOAD_WEIGHT_UOM_SID   NUMBER          COMMENT 'The surrogate key for the unit_2 of measurement for the load weight (handling_unit_load_weight_meas).',
   HANDLING_UNIT_LOAD_WEIGHT_UOM_CD    VARCHAR(10)     COMMENT 'The code for the unit_2 of measurement for the load weight (handling_unit_load_weight_meas).',
   HANDLING_UNIT_TOTAL_VOLUME_UOM_SID  NUMBER          COMMENT 'The surrogate key for the unit_2 of measurement for the total volume (handling_unit_total_volume_meas).',
   HANDLING_UNIT_TOTAL_VOLUME_UOM_CD   VARCHAR(10)     COMMENT 'The code for the unit_2 of measurement for the total volume (handling_unit_total_volume_meas).',
   HANDLING_UNIT_VOLUME_UOM_SID        NUMBER          COMMENT 'The surrogate key for the unit_2 of measurement for the Handling Unit_2 volume (handling_unit_volume_meas).',
   HANDLING_UNIT_VOLUME_UOM_CD         VARCHAR(10)     COMMENT 'The code for the unit_2 of measurement for the Handling Unit_2 volume (handling_unit_volume_meas).',
   HANDLING_UNIT_UOM_SID               NUMBER          COMMENT 'The surrogate key for the unit_2 of measurement for the length, width and height of the Handling Unit.',
   HANDLING_UNIT_UOM_CD                VARCHAR(10)     COMMENT 'The code for the unit_2 of measurement for the length, width and height of the Handling Unit.',
   VIRTUAL_HANDLING_UNIT_CD            VARCHAR(5)      COMMENT 'A code that shows for what reason the virtual handling unit_2 has to be created.The virtual handling unit_2 is almost always used temporarily to indicate handling unit_2 availability. A few examples for the code; A = Dummy_2 Handling Unit_2 für Lokation, B = Geplante Handling Unit_2, P = Dummy_2 Handling Unit_2 für Pending Differences.',
   HANDLING_UNIT_POS_CD                VARCHAR(5)      COMMENT 'The code describes the physical position of the Handling Unit_2 like shelf numbers. It is used to make the position of the Handling Unit_2 clearer in large storage places.',
   HANDLING_UNIT_EXT_POS_CD            VARCHAR(22)     COMMENT 'The code that describes the position of the Handling Unit_2 given by the Hauler/Carrier.',
   NESTED_HANDLING_UNIT_CREATE_CD      VARCHAR(5)      COMMENT 'The code that defines the conditions in case there is a nested Handling Unit_2 created. A Nested Handling Unit_2 is created when a Handling Unit_2 is placed with in or on another Handling Unit_2 e.g. A Carton on a Pallet. Some code examples would be, A = Create without label, B = Create with Label. ',
   STORAGE_TYPE_CD                     VARCHAR(10)     COMMENT 'A storage type is a physical space characterized by its function in the warehouse where Handling Units could be stored e.g. Bulk Storage Area, General Storage Area etc. A storage type consists of one or more storage units.',
   STORAGE_SUBTYPE_CD                  VARCHAR(10)     COMMENT 'It is a subdivision of a storage type in the warehouse which groups together storage units with similar attributes e.g. Wine Section, General Storage Section, Valuable etc.',
   STORAGE_UNIT_ID                     VARCHAR(20)     COMMENT 'A physical place where you can store a Handling Unit. This ID represents an object (storage unit_2) unlike handling_unit_loc_id which is a GUID for a location_2 in a warehouse.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_HANDLING_UNIT_L9X PRIMARY KEY (HANDLING_UNIT_SID) NOT ENFORCED 
)  COMMENT = 'Support tables related to Warehouse Inbound Header.
             A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. 
             This table contains one row per handling unit_2 (container/bin) 
             The data is coming from source L9X (there are 3 other tables with the same structure that hold data from other sources) We split the ETL tables by source for performance reason - to  be able to load them in parallel';
