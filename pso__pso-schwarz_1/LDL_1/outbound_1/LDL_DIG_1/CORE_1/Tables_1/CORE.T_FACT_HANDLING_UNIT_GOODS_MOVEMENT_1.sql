/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_HANDLING_UNIT_GOODS_MOVEMENT_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 5. November 2024 13:03:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_handling_unit_goods_movement_1 (
handling_unit_log_id STRING(100) NOT NULL
OPTIONS(description='The handling unit_1 log id represents a specific log entry which is generated for each handling unit_1 movement within the warehouse for the transportation of particular stock item_1(s).'),
handling_unit_sid BIGNUMERIC NOT NULL
OPTIONS(description='Surrogate Key of the Handling Unit. Generated based on src_handling_unit_id, sap_sys_name, sap_client_id            A Handling unit_1 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. '),
stock_item_id STRING(100) NOT NULL
OPTIONS(description='The ID of the particular physical stock item_1 which is transported with the given handling unit_1 and its movement within the warehouse is recorded with the particular log entry.'),
src_handling_unit_id STRING(100)
OPTIONS(description='The ID of the Handling Unit_1 in the source system (GUID_PARENT). A Handling unit_1 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin.'),
unhashed_src_handling_unit_id STRING(40) OPTIONS(description='Unhashed version of the scr_handling_unit_id.'),
handling_unit_loc_id STRING(100)
OPTIONS(description='The GUID of the location_1 of the Handling Unit_1 in the warehouse where it is stored. It is different than storage_unit_id as it represents the location_1 in a warehouse whereas the storage_unit_id represents an ID for an object (storage unit_1).'),
src_sys_id STRING(20)
OPTIONS(description='It shows from which system the warehouse system the task comes from, e.g. L8V or another system. One source system could have multiple clients which are then identified by this ID.'),
wh_sid BIGNUMERIC OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
stock_item_qty BIGNUMERIC(38,5)
OPTIONS(description='This field indicates the quantity of the stock item_1 transported with the handling unit. It helps in managing the inventory levels. This value is not updated even if the stock_item_reduce_fg is set - indicating that the actual stock item_1 quantity on the handling unit_1 is smaller.'),
virtual_stock_fg BOOL
OPTIONS(description='The virtual stock indicator is almost always used temporarily to indicate stock availability (e.g. upon arrival of the goods at the warehouse the virtual stock indicator can be set for 100 items before they are actually counted. After counting, the virtual stock indicator is removed).'),
stock_item_index STRING(5)
OPTIONS(description='This stock item_1 index helps in identifying and managing individual stock items within the handling unit. It gives a hint in which SAP stock table more information about the item_1 can be found (e.g. /SCWM/STOCK_IW01, /SCWM/STOCK_IW02).'),
orig_stock_item_id STRING(100)
OPTIONS(description='This field is used as reference to the original stock_item_id before any changes or movements. In the warehouse there is the possibilty to post one stock to another, which means that they can change a product number. The original stock item_1 id therefore helps in maintaining the history and traceability of stock movements.'),
uom_sid BIGNUMERIC OPTIONS(description='A surrogate key for the unit_1 of measure of the processed product quantity'),
uom_cd STRING(5)
OPTIONS(description='A code for the unit_1 of measure of the processed product quantity (e.g. ST = Stück)'),
alt_uom_cd STRING(5)
OPTIONS(description='A code for an alternative unit_1 of measure of the processed product quantity (e.g. instead of processing the products as single items, they could be processed in boxes).'),
task_load_net_weight_meas BIGNUMERIC(38,5)
OPTIONS(description='The net weight of all loaded items processed with the particular task'),
weight_uom_sid BIGNUMERIC OPTIONS(description='Unit_1 of measurement for weight'),
weight_uom_cd STRING(5) OPTIONS(description='A code for the unit_1 of measure for weight'),
task_load_net_volume_meas BIGNUMERIC(38,5)
OPTIONS(description='The net volume of all loaded items processed with the particular task'),
volume_uom_sid BIGNUMERIC OPTIONS(description='Unit_1 of measurement for volume'),
volume_uom_cd STRING(5) OPTIONS(description='A code for the unit_1 of measure for volume'),
handling_unit_capacity_meas BIGNUMERIC(38,5)
OPTIONS(description='This field indicates the maximum quantity or volume that the handling unit_1 can have. Based on the src_handling_unit_id (GUID_PARENT) the maximum capacity (quantity/volume/weight etc) can be identified. For example if you define a Storage bin with a capacity of 10 and a Handling Unit_1 Type A with a Capacity of 3 and another Handling Unit_1 type B with a Capacity of 1, than you would be able to place 3 HUs of Type A (3 x 3 = 9) and one HU of type B (9 + 1 = 10) within the storage bin.'),
stock_avail_tmsp TIMESTAMP
OPTIONS(description='The timestamp showing when the stock items processed with the given task start to be available for ordering to the customer'),
shelf_life_expiration_dt DATE
OPTIONS(description='The shelf life expiration date indicates the expiration date of the stock item_1 transported with the handling unit.'),
restricted_batch_fg BOOL
OPTIONS(description='This flag indicates any batch restrictions associated with the stock item. (e.g. the stock item_1 is not available for ordering as the batch needs to undergo inventory, etc.)'),
stock_item_plate_nr STRING(20)
OPTIONS(description='This field contains the identification plate number of the stock item. It is used for tracking and identification purposes.'),
wh_order_cat_cd STRING(6)
OPTIONS(description='The code for the category of the warehouse inbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)'),
wh_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for a warehouse order'),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)'),
wh_order_pos_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).'),
plan_inventory_fg BOOL
OPTIONS(description='This flag shows if inventory is planned for the stock item_1 transported with the given handling unit.'),
consolidation_grp_name STRING(20)
OPTIONS(description='The name of the consolidation group that the articles processed with the particular task belong to. The consolidation group denotes where in the warehouse the articles are going to be sorted. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
serial_nr_requirement_cd STRING(5)
OPTIONS(description='This field indicates the serial number requirement code of the stock. The serial number requirement on stock level is used to store the exact storage bin information for a serial number.'),
stock_item_reduce_fg BOOL
OPTIONS(description='This flag is used to indicate if the given stock item_1 transported with the handling unit_1 has been canceled. It helps in managing the status_1 of the handling unit_1 stock items during warehouse operations'),
certificate_nr STRING(5)
OPTIONS(description='The certificate number is relevant only for wine articles and denotes in which year they were produced. One task can process only wines produced in the same year as they are going to be sorted into a specific section within the warehouse.'),
task_id STRING(30)
OPTIONS(description='Code of Warehouse Task. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
pack_material_id STRING(64)
OPTIONS(description='The GUID for the packaging material which shows what kind of the material is used. It is unique for each package_1 e.g. Even if 3 cartons are made of the same material, they all will get unique ID.'),
wh_task_created_by_name STRING(100)
OPTIONS(description='The name of the User or the System that created the warehouse task. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
wh_task_create_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the warehouse task was created. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
wh_task_changed_by_name STRING(100)
OPTIONS(description='The name of the User or the System that changed/updated the task. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
wh_task_change_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the warehouse task was changed/updated. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_total_weight_meas BIGNUMERIC(38,5)
OPTIONS(description='The weight of the Handling Unit_1 and the items loaded on it. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_total_weight_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit_1 of measurement for the total weight (handling_unit_total_weight_meas). Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_total_weight_uom_cd STRING(10)
OPTIONS(description='The code for the unit_1 of measurement for the total weight (handling_unit_total_weight_meas). Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_load_weight_meas BIGNUMERIC(38,5)
OPTIONS(description='The weight of only the loaded items on the Handling Unit. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_load_weight_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit_1 of measurement for the load weight (handling_unit_load_weight_meas). Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_load_weight_uom_cd STRING(10)
OPTIONS(description='The code for the unit_1 of measurement for the load weight (handling_unit_load_weight_meas). Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_total_volume_meas BIGNUMERIC(38,5)
OPTIONS(description='The volume of the Handling Unit_1 and the items loaded on it. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_total_volume_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit_1 of measurement for the total volume (handling_unit_total_volume_meas). Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_total_volume_uom_cd STRING(10)
OPTIONS(description='The code for the unit_1 of measurement for the total volume (handling_unit_total_volume_meas). Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_load_volume_meas BIGNUMERIC(38,5)
OPTIONS(description='The volume of only the loaded items on the Handling Unit. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_volume_meas BIGNUMERIC(38,5)
OPTIONS(description='The volume of the Handling Unit_1 without the items loaded in it. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_volume_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit_1 of measurement for the Handling Unit_1 volume (handling_unit_volume_meas). Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_volume_uom_cd STRING(10)
OPTIONS(description='The code for the unit_1 of measurement for the Handling Unit_1 volume (handling_unit_volume_meas). Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_net_capacity_meas BIGNUMERIC(38,5)
OPTIONS(description='The capacity of only the Handling Unit_1 without the items loaded on it. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_total_capacity_meas BIGNUMERIC(38,5)
OPTIONS(description='The total capacity of the Handling Unit_1 and the items loaded on it when the size of the Items exceed the size of the Handling Unit. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_length_meas BIGNUMERIC(38,5)
OPTIONS(description='The length of the Handling Unit. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_width_meas BIGNUMERIC(38,5)
OPTIONS(description='The width of the Handling Unit. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_height_meas BIGNUMERIC(38,5)
OPTIONS(description='The height of the Handling Unit. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_uom_sid BIGNUMERIC
OPTIONS(description='The surrogate key for the unit_1 of measurement for the length, width and height of the Handling Unit. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_uom_cd STRING(10)
OPTIONS(description='The code for the unit_1 of measurement for the length, width and height of the Handling Unit. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
is_handling_unit_closed_fg BOOL
OPTIONS(description='A flag indicating whether a Handling Unit_1 is closed or not. Closed refering to the fact that it cannot handle anymore stock, even when it is not full. It could be packed or wrapped up. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
pack_capacity_meas BIGNUMERIC(38,5)
OPTIONS(description='The maximum capacity of the package_1 or the cartons placed on the Handling Unit. It doesn\'t refer to the capacity of a storage bin or a shelf. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
virtual_handling_unit_cd STRING(5)
OPTIONS(description='A code that shows for what reason the virtual handling unit_1 has to be created.The virtual handling unit_1 is almost always used temporarily to indicate handling unit_1 availability. A few examples for the code; A = Dummy_1 Handling Unit_1 für Lokation, B = Geplante Handling Unit_1, P = Dummy_1 Handling Unit_1 für Pending Differences. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_type_cd STRING(10)
OPTIONS(description='The code shows the type of the Handling Unit_1 e.g. a pallete, a carton etc. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
is_handling_unit_avail_fg BOOL
OPTIONS(description='A flag that shows whether the Handling Unit_1 is available for use or not. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
is_handling_unit_task_open_fg BOOL
OPTIONS(description='A flag that shows whether there is any open warehouse task for the Handling Unit_1 or not. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
storage_process_step_cd STRING(10)
OPTIONS(description='This code defines the specific storage process step that is part of the storage process (e.g. Unload, Count, Deconsolidate, Put Away, Remove from Stock, Pack, etc.). Same for all stock items transported on a handling unit_1 with the same handling log id.'),
storage_process_type_cd STRING(10)
OPTIONS(description='This code denotes a type of storage process that summarizes storage process steps in order to define complex processes for putaway, stock removal, and warehouse internal movements (e.g. a goods receipt process may contain the storage process steps for unloading and putaway, whereas a goods issue process may contain the storage process steps for stock removal, packing, staging and loading). Same for all stock items transported on a handling unit_1 with the same handling log id.'),
is_handling_unit_process_complete_fg BOOL
OPTIONS(description='A flag that shows whether all the planned process for the Handling Unit_1 are complete or not. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
stock_managing_org_cd STRING(32)
OPTIONS(description='This is the code of the stock managing organization which is in charge of moving stock within the warehouse, sending it to customers or disposing it.             This code is introduced because there is a SAP functionality which allows multiple parties (organizations) to use the same warehouse for storing their stock.             Warehouses, used by Lidl E-Commerce (LEC) will always have the value LEC populated in this field as they are used solely by LEC. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
storage_type_cd STRING(10)
OPTIONS(description='A storage type is a physical space characterized by its function in the warehouse where Handling Units could be stored e.g. Bulk Storage Area, General Storage Area etc. A storage type consists of one or more storage units.'),
storage_subtype_cd STRING(10)
OPTIONS(description='It is a subdivision of a storage type in the warehouse which groups together storage units with similar attributes e.g. Wine Section, General Storage Section, Valuable etc.'),
storage_unit_id STRING(20)
OPTIONS(description='A physical place where you can store a Handling Unit. This ID represents an object (storage unit_1) unlike handling_unit_loc_id which is a GUID for a location_1 in a warehouse.'),
wh_task_processing_type_cd STRING(10)
OPTIONS(description='A technical field to describe the process of a task. e.g. Fragile items should be picked carefully.'),
is_handling_unit_system_created_fg BOOL
OPTIONS(description='A flag that shows whether the Handling Unit_1 was created automatically by the system or not. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
item_defect_cd STRING(5)
OPTIONS(description='A code that shows if there is any defected item_1 present on Handling Unit_1 and what kind of a defect there is. e.g partially damaged or completely damaged and so on. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_create_tmsp TIMESTAMP
OPTIONS(description='The point in time when the Handling Unit_1 was created. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
pack_size_cd STRING(10) OPTIONS(description='The code for the size of the package.'),
pack_group_cd STRING(10)
OPTIONS(description='The code for the group of the packages. e.g. there could 3 different kinds of cartons varying either in size or type but they could be grouped under Pallets.'),
handling_unit_status_cd STRING(5)
OPTIONS(description='The status_1 of the Handling Unit_1 to see if it is available, deleted or completed. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
is_handling_unit_highest_hierarchy_fg BOOL
OPTIONS(description='A flag that shows whether the Handling Unit_1 belongs to the heighest hierarchy_1 or not. The hierarchy_1 is as follows Bin > Palett > Cartons. When its true then it refers to Bins. When both hierarchy_1 flags (highest and lowest) are false, it refers to Pallets. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
is_handling_unit_lowest_hierarchy_fg BOOL
OPTIONS(description='A flag that shows whether the Handling Unit_1 belongs to the lowest hierarchy_1 or not. The hierarchy_1 is as follows Bin > Palett > Cartons. When its true, it refers to Cartons. When both hierarchy_1 flags (highest and lowest) are false, it refers to Pallets. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
is_wh_task_assigned_fg BOOL
OPTIONS(description='A flag that shows whether the goods on the Handling Unit_1 have a warehouse task assigned to them or not. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
is_hazardous_substance_fg BOOL
OPTIONS(description='A flag that shows whether there is any hazardous substance present on the Handling Unit_1 or not. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_pos_cd STRING(5)
OPTIONS(description='The code describes the physical position of the Handling Unit_1 like shelf numbers. It is used to make the position of the Handling Unit_1 clearer in large storage places. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_ext_pos_cd STRING(22)
OPTIONS(description='The code that describes the position of the Handling Unit_1 given by the Hauler/Carrier. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
handling_unit_process_status_cd STRING(5)
OPTIONS(description='The code describes the status_1 of the Handling Unit_1 when it arrives in the warehouse e.g. C = Cross-Docking, H = Consolidation of Goods in holding area standard putaway process. Same for all stock items transported on a handling unit_1 with the same handling log id.'),
nested_handling_unit_create_cd STRING(5)
OPTIONS(description='The code that defines the conditions in case there is a nested Handling Unit_1 created. A Nested Handling Unit_1 is created when a Handling Unit_1 is placed with in or on another Handling Unit_1 e.g. A Carton on a Pallet. Some code examples would be, A = Create without label, B = Create with Label. Same for all stock items transported on a handling unit_1 with the same handling log id. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (handling_unit_log_id, handling_unit_sid, stock_item_id) NOT ENFORCED
)
OPTIONS(description='This transactional fact table contains data about the movement of stock items within a warehouse with a particular handling unit.             Source: /SCWM/GMHUITM from the L8V, L9V, L9X and LJX SAP instances.');