/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_HANDLING_UNIT_LJX_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. November 2024 17:03:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_handling_unit_ljx_2 (
handling_unit_sid BIGNUMERIC NOT NULL
OPTIONS(description='Surrogate Key of the Handling Unit. Generated based on src_handling_unit_id, sap_sys_name, sap_client_id            A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. '),
src_handling_unit_id STRING(64)
OPTIONS(description='The ID of the Handling Unit_2 in the source system            A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. '),
wh_sid BIGNUMERIC OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
handling_unit_nr STRING(40) OPTIONS(description='Identifier of the handling unit_2 coming from the source system.'),
storage_place_nr STRING(40)
OPTIONS(description='Identifier of the place where the handling unit_2 is stored. This is a static place within a warehouse (shelf, room ... )'),
src_change_tmsp DATETIME OPTIONS(description='Timestamp of the last update of the record in the source system.'),
handling_unit_total_weight_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit_2 of measurement for the total weight (handling_unit_total_weight_meas).'),
handling_unit_total_weight_uom_cd STRING(10)
OPTIONS(description='The code for the unit_2 of measurement for the total weight (handling_unit_total_weight_meas).'),
handling_unit_load_weight_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit_2 of measurement for the load weight (handling_unit_load_weight_meas).'),
handling_unit_load_weight_uom_cd STRING(10)
OPTIONS(description='The code for the unit_2 of measurement for the load weight (handling_unit_load_weight_meas).'),
handling_unit_total_volume_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit_2 of measurement for the total volume (handling_unit_total_volume_meas).'),
handling_unit_total_volume_uom_cd STRING(10)
OPTIONS(description='The code for the unit_2 of measurement for the total volume (handling_unit_total_volume_meas).'),
handling_unit_volume_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit_2 of measurement for the Handling Unit_2 volume (handling_unit_volume_meas).'),
handling_unit_volume_uom_cd STRING(10)
OPTIONS(description='The code for the unit_2 of measurement for the Handling Unit_2 volume (handling_unit_volume_meas).'),
handling_unit_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit_2 of measurement for the length, width and height of the Handling Unit.'),
handling_unit_uom_cd STRING(10)
OPTIONS(description='The code for the unit_2 of measurement for the length, width and height of the Handling Unit.'),
virtual_handling_unit_cd STRING(5)
OPTIONS(description='A code that shows for what reason the virtual handling unit_2 has to be created.The virtual handling unit_2 is almost always used temporarily to indicate handling unit_2 availability. A few examples for the code; A = Dummy_2 Handling Unit_2 für Lokation, B = Geplante Handling Unit_2, P = Dummy_2 Handling Unit_2 für Pending Differences.'),
handling_unit_pos_cd STRING(5)
OPTIONS(description='The code describes the physical position of the Handling Unit_2 like shelf numbers. It is used to make the position of the Handling Unit_2 clearer in large storage places.'),
handling_unit_ext_pos_cd STRING(22)
OPTIONS(description='The code that describes the position of the Handling Unit_2 given by the Hauler/Carrier.'),
nested_handling_unit_create_cd STRING(5)
OPTIONS(description='The code that defines the conditions in case there is a nested Handling Unit_2 created. A Nested Handling Unit_2 is created when a Handling Unit_2 is placed with in or on another Handling Unit_2 e.g. A Carton on a Pallet. Some code examples would be, A = Create without label, B = Create with Label. '),
storage_type_cd STRING(10)
OPTIONS(description='A storage type is a physical space characterized by its function in the warehouse where Handling Units could be stored e.g. Bulk Storage Area, General Storage Area etc. A storage type consists of one or more storage units.'),
storage_subtype_cd STRING(10)
OPTIONS(description='It is a subdivision of a storage type in the warehouse which groups together storage units with similar attributes e.g. Wine Section, General Storage Section, Valuable etc.'),
storage_unit_id STRING(20)
OPTIONS(description='A physical place where you can store a Handling Unit. This ID represents an object (storage unit_2) unlike handling_unit_loc_id which is a GUID for a location_2 in a warehouse.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (handling_unit_sid) NOT ENFORCED
)
OPTIONS(description='Support tables related to Warehouse Inbound Header.             A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin.              This table contains one row per handling unit_2 (container/bin)              The data is coming from source LJX (there are 3 other tables with the same structure that hold data from other sources) We split the ETL tables by source for performance reason - to  be able to load them in parallel');