/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_GOODS_MOVEMENT_HANDLING_UNIT_HEADER_L9X
   GENERATED FROM POWERDESIGNER ON Montag, 23. September 2024 13:15:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_goods_movement_handling_unit_header_l9x (
handling_unit_log_id STRING(100) NOT NULL
OPTIONS(description='The handling unit log id represents a specific log entry which is generated for each handling unit movement within the warehouse.'),
handling_unit_sid BIGNUMERIC NOT NULL
OPTIONS(description='Surrogate Key of the Handling Unit. Generated based on src_handling_unit_id, sap_sys_name, sap_client_id            A Handling unit is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. '),
src_sys_id STRING(20)
OPTIONS(description='It shows from which system the warehouse system the task comes from, e.g. L8V or another system. One source system could have multiple clients which are then identified by this ID.'),
src_handling_unit_id STRING(64)
OPTIONS(description='The ID of the Handling Unit in the source system            A Handling unit is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. '),
unhashed_src_handling_unit_id STRING(40) OPTIONS(description='Unhashed version of the scr_handling_unit_id.'),
handling_unit_loc_id STRING(100)
OPTIONS(description='The GUID of the location of the Handling Unit in the warehouse where it is stored. It is different than storage_unit_id as it represents the location in a warehouse whereas the storage_unit_id represents an ID for an object (storage unit).'),
wh_sid BIGNUMERIC OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
task_id STRING(30) OPTIONS(description='Code of Warehouse Task'),
pack_material_id STRING(64)
OPTIONS(description='The GUID for the packaging material which shows what kind of the material is used. It is unique for each package e.g. Even if 3 cartons are made of the same material, they all will get unique ID.'),
wh_task_created_by_name STRING(100)
OPTIONS(description='The name of the User or the System that created the warehouse task.'),
wh_task_create_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the warehouse task was created.'),
wh_task_changed_by_name STRING(100)
OPTIONS(description='The name of the User or the System that changed/updated the task.'),
wh_task_change_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the warehouse task was changed/updated.'),
handling_unit_total_weight_meas BIGNUMERIC(38,5)
OPTIONS(description='The weight of the Handling Unit and the items loaded on it.'),
handling_unit_total_weight_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit of measurement for the total weight (handling_unit_total_weight_meas).'),
handling_unit_total_weight_uom_cd STRING(10)
OPTIONS(description='The code for the unit of measurement for the total weight (handling_unit_total_weight_meas).'),
handling_unit_load_weight_meas BIGNUMERIC(38,5)
OPTIONS(description='The weight of only the loaded items on the Handling Unit.'),
handling_unit_load_weight_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit of measurement for the load weight (handling_unit_load_weight_meas).'),
handling_unit_load_weight_uom_cd STRING(10)
OPTIONS(description='The code for the unit of measurement for the load weight (handling_unit_load_weight_meas).'),
handling_unit_total_volume_meas BIGNUMERIC(38,5)
OPTIONS(description='The volume of the Handling Unit and the items loaded on it.'),
handling_unit_total_volume_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit of measurement for the total volume (handling_unit_total_volume_meas).'),
handling_unit_total_volume_uom_cd STRING(10)
OPTIONS(description='The code for the unit of measurement for the total volume (handling_unit_total_volume_meas).'),
handling_unit_load_volume_meas BIGNUMERIC(38,5)
OPTIONS(description='The volume of only the loaded items on the Handling Unit.'),
handling_unit_volume_meas BIGNUMERIC(38,5)
OPTIONS(description='The volume of the Handling Unit without the items loaded in it.'),
handling_unit_volume_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit of measurement for the Handling Unit volume (handling_unit_volume_meas).'),
handling_unit_volume_uom_cd STRING(10)
OPTIONS(description='The code for the unit of measurement for the Handling Unit volume (handling_unit_volume_meas).'),
handling_unit_capacity_meas BIGNUMERIC(38,5)
OPTIONS(description='It is the total capacity of the Handling unit and the items loaded on it. There is no unit of measure. For example if you define a Storage bin with a capacity of 10. And a Handling Unit Type A with a Capacity of 3 and an other Handling Unit type B with a Capacity of 1.                        Than you would be able to place 3 HUs of Type A on it (3 x 3 = 9) and one HU of type B (9 + 1 = 10).'),
handling_unit_net_capacity_meas BIGNUMERIC(38,5)
OPTIONS(description='The capacity of only the Handling Unit without the items loaded on it.'),
handling_unit_total_capacity_meas BIGNUMERIC(38,5)
OPTIONS(description='The total capacity of the Handling Unit and the items loaded on it when the size of the Items exceed the size of the Handling Unit.'),
handling_unit_length_meas BIGNUMERIC(38,5) OPTIONS(description='The length of the Handling Unit.'),
handling_unit_width_meas BIGNUMERIC(38,5) OPTIONS(description='The width of the Handling Unit.'),
handling_unit_height_meas BIGNUMERIC(38,5) OPTIONS(description='The height of the Handling Unit.'),
handling_unit_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit of measurement for the length, width and height of the Handling Unit.'),
handling_unit_uom_cd STRING(10)
OPTIONS(description='The code for the unit of measurement for the length, width and height of the Handling Unit.'),
is_handling_unit_closed_fg BOOL
OPTIONS(description='A flag indicating whether a Handling Unit is closed or not. Closed refering to the fact that it cannot handle anymore stock, even when it is not full. It could be packed or wrapped up.'),
pack_capacity_meas BIGNUMERIC(38,5)
OPTIONS(description='The maximum capacity of the package or the cartons placed on the Handling Unit. It doesn\'t refer to the capacity of a storage bin or a shelf.'),
virtual_handling_unit_cd STRING(5)
OPTIONS(description='A code that shows for what reason the virtual handling unit has to be created.The virtual handling unit is almost always used temporarily to indicate handling unit availability. A few examples for the code; A = Dummy Handling Unit für Lokation, B = Geplante Handling Unit, P = Dummy Handling Unit für Pending Differences.'),
handling_unit_type_cd STRING(10)
OPTIONS(description='The code shows the type of the Handling Unit e.g. a pallete, a carton etc.'),
is_handling_unit_avail_fg BOOL
OPTIONS(description='A flag that shows whether the Handling Unit is available for use or not.'),
is_handling_unit_task_open_fg BOOL
OPTIONS(description='A flag that shows whether there is any open warehouse task for the Handling Unit or not.'),
storage_process_step_cd STRING(10)
OPTIONS(description='This code defines the specific storage process step that is part of the storage process (e.g. Unload, Count, Deconsolidate, Put Away, Remove from Stock, Pack, etc.)'),
storage_process_type_cd STRING(10)
OPTIONS(description='This code denotes a type of storage process that summarizes storage process steps in order to define complex processes for putaway, stock removal, and warehouse internal movements (e.g. a goods receipt process may contain the storage process steps for unloading and putaway, whereas a goods issue process may contain the storage process steps for stock removal, packing, staging and loading).'),
is_handling_unit_process_complete_fg BOOL
OPTIONS(description='A flag that shows whether all the planned process for the Handling Unit are complete or not.'),
consolidation_grp_name STRING(20)
OPTIONS(description='The name of the consolidation group that the articles processed with the particular task belong to. The consolidation group denotes where the warehouse the articles are going to be sorted.'),
stock_managing_org_cd STRING(32)
OPTIONS(description='This is the code of the stock managing organization which is in charge of moving stock within the warehouse, sending it to customers or disposing it.             This code is introduced because there is a SAP functionality which allows multiple parties (organizations) to use the same warehouse for storing their stock.             Warehouses, used by Lidl E-Commerce (LEC) will always have the value LEC populated in this field as they are used solely by LEC.'),
storage_type_cd STRING(10)
OPTIONS(description='A storage type is a physical space characterized by its function in the warehouse where Handling Units could be stored e.g. Bulk Storage Area, General Storage Area etc. A storage type consists of one or more storage units.'),
storage_subtype_cd STRING(10)
OPTIONS(description='It is a subdivision of a storage type in the warehouse which groups together storage units with similar attributes e.g. Wine Section, General Storage Section, Valuable etc.'),
storage_unit_id STRING(20)
OPTIONS(description='A physical place where you can store a Handling Unit. This ID represents an object (storage unit) unlike handling_unit_loc_id which is a GUID for a location in a warehouse.'),
wh_task_processing_type_cd STRING(10)
OPTIONS(description='A technical field to describe the process of a task. e.g. Fragile items should be picked carefully.'),
is_handling_unit_system_created_fg BOOL
OPTIONS(description='A flag that shows whether the Handling Unit was created automatically by the system or not.'),
item_defect_cd STRING(5)
OPTIONS(description='A code that shows if there is any defected item present on Handling Unit and what kind of a defect there is. e.g partially damaged or completely damaged and so on.'),
handling_unit_create_tmsp TIMESTAMP
OPTIONS(description='The point in time when the Handling Unit was created.'),
pack_size_cd STRING(10) OPTIONS(description='The code for the size of the package.'),
pack_group_cd STRING(10)
OPTIONS(description='The code for the group of the packages. e.g. there could 3 different kinds of cartons varying either in size or type but they could be grouped under Pallets.'),
handling_unit_status_cd STRING(5)
OPTIONS(description='The status of the Handling Unit to see if it is available, deleted or completed.'),
is_handling_unit_highest_hierarchy_fg BOOL
OPTIONS(description='A flag that shows whether the Handling Unit belongs to the heighest hierarchy or not. The hierarchy is as follows Bin > Palett > Cartons. When its true then it refers to Bins. When both hierarchy flags (highest and lowest) are false, it refers to Pallets.'),
is_handling_unit_lowest_hierarchy_fg BOOL
OPTIONS(description='A flag that shows whether the Handling Unit belongs to the lowest hierarchy or not. The hierarchy is as follows Bin > Palett > Cartons. When its true, it refers to Cartons. When both hierarchy flags (highest and lowest) are false, it refers to Pallets.'),
is_wh_task_assigned_fg BOOL
OPTIONS(description='A flag that shows whether the goods on the Handling Unit have a warehouse task assigned to them or not.'),
is_hazardous_substance_fg BOOL
OPTIONS(description='A flag that shows whether there is any hazardous substance present on the Handling Unit or not.'),
handling_unit_pos_cd STRING(5)
OPTIONS(description='The code describes the physical position of the Handling Unit like shelf numbers. It is used to make the position of the Handling Unit clearer in large storage places.'),
handling_unit_ext_pos_cd STRING(22)
OPTIONS(description='The code that describes the position of the Handling Unit given by the Hauler/Carrier.'),
handling_unit_process_status_cd STRING(5)
OPTIONS(description='The code describes the status of the Handling Unit when it arrives in the warehouse e.g. C = Cross-Docking, H = Consolidation of Goods in holding area standard putaway process.'),
nested_handling_unit_create_cd STRING(5)
OPTIONS(description='The code that defines the conditions in case there is a nested Handling Unit created. A Nested Handling Unit is created when a Handling Unit is placed with in or on another Handling Unit e.g. A Carton on a Pallet. Some code examples would be, A = Create without label, B = Create with Label. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (handling_unit_log_id, handling_unit_sid) NOT ENFORCED
)
OPTIONS(description='ETL table containing data about the goods movement at header level with a particular handling unit within a warehouse.                           Source: /SCWM/GMHUHDR from L9X source system.');