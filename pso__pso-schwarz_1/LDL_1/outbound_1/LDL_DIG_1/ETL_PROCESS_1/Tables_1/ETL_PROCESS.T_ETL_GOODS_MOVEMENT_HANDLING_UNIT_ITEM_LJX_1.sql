/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_GOODS_MOVEMENT_HANDLING_UNIT_ITEM_LJX_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 11. September 2024 15:25:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_goods_movement_handling_unit_item_ljx_1 (
handling_unit_log_id STRING(100) NOT NULL
OPTIONS(description='The handling unit_1 log id represents a specific log entry which is generated for each handling unit_1 movement within the warehouse for the transportation of particular stock item_1(s).'),
handling_unit_sid BIGNUMERIC NOT NULL
OPTIONS(description='Surrogate Key of the Handling Unit. Generated based on src_handling_unit_id, sap_sys_name, sap_client_id            A Handling unit_1 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. '),
stock_item_id STRING(100) NOT NULL
OPTIONS(description='The ID of the particular physical stock item_1 which is transported with the given handling unit_1 and its movement within the warehouse is recorded with the particular log entry.'),
src_handling_unit_id STRING(100)
OPTIONS(description='The ID of the Handling Unit_1 in the source system (GUID_PARENT). A Handling unit_1 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin.'),
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
OPTIONS(description='The name of the consolidation group that the articles processed with the particular task belong to. The consolidation group denotes where in the warehouse the articles are going to be sorted.'),
serial_nr_requirement_cd STRING(5)
OPTIONS(description='This field indicates the serial number requirement code of the stock. The serial number requirement on stock level is used to store the exact storage bin information for a serial number.'),
stock_item_reduce_fg BOOL
OPTIONS(description='This flag is used to indicate if the given stock item_1 transported with the handling unit_1 has been canceled. It helps in managing the status_1 of the handling unit_1 stock items during warehouse operations'),
certificate_nr STRING(5)
OPTIONS(description='The certificate number is relevant only for wine articles and denotes in which year they were produced. One task can process only wines produced in the same year as they are going to be sorted into a specific section within the warehouse.'),
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
OPTIONS(description='ETL table containing data about the movement of stock items within a warehouse with a particular handling unit.             Source: /SCWM/GMHUITM from LJX  sap instance');