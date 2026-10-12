/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_HANDLING_UNIT_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. November 2024 16:45:39
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_WAREHOUSE_HANDLING_UNIT_2 (
   HANDLING_UNIT_SID                   NUMBER          NOT NULL COMMENT 'Surrogate Key of the Handling Unit. Generated based on src_handling_unit_id, sap_sys_name, sap_client_id
            A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. ',
   SRC_HANDLING_UNIT_ID                VARCHAR(64)     COMMENT 'The ID of the Handling Unit_2 in the source system
            A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. ',
   HANDLING_UNIT_NR                    VARCHAR(40)     COMMENT 'Identifier of the handling unit_2 coming from the source system.',
   WH_SID                              NUMBER          COMMENT 'The unique identifier (surrogate key) for the warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   STORAGE_PLACE_NR                    VARCHAR(40)     COMMENT 'Identifier of the place where the handling unit_2 is stored. This is a static place within a warehouse (shelf, room ... )',
   SRC_CHANGE_TMSP                     TIMESTAMP_NTZ(9) COMMENT 'Timestamp of the last update of the record in the source system.',
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
   CONSTRAINT PK_T_DIM_WAREHOUSE_HANDLING_UNIT PRIMARY KEY (HANDLING_UNIT_SID) NOT ENFORCED 
)  COMMENT = 'A Dimensional table that describes handling units. A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. This table contains one row per handling unit_2 (container/bin) 
             
             This is an SCD type1 dimension - we do not store history, we store only the current state "as-is".  Handling units change places very often - many times per day. Keeping history of changes is not required by the business and would lead to explosion of rows so until business requests explicitly to store history,  we will overwrite existing records
             
             We physically delete records from this table. Hard delete is chosen instead of soft delete because a record can be deleted from source for two reasons - Handling unit_2 is no longer used, or record was a mistake. We cannot differentiate between both reasons so we cannot use a column "is_active"/"is_valid". And also the business defines they need only existing handling units and do not care about wrong or deleted. They do not need to see them or history when they were deleted.';
