/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_PROCESSING_2
   GENERATED FROM POWERDESIGNER ON Freitag, 21. Februar 2025 15:56:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_warehouse_processing_2 (
wh_order_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a warehouse order'),
wh_order_pos_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The particular position number of a position in an order'),
wh_order_nr STRING(20) NOT NULL OPTIONS(description='Delivery order number '),
wave_id STRING(20) NOT NULL
OPTIONS(description='Number of wave (aggregation of positions which have the same picking process in the warehouse)'),
task_id STRING(20) NOT NULL OPTIONS(description='Code of Warehouse Task'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
wh_process_type_cd STRING(5) OPTIONS(description='The code for warehouse process type (2010, 2011, etc)'),
wh_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
wh_task_status_cd STRING(5)
OPTIONS(description='Status_2 of warehouse task depending on source table. If Document on item_2 level is coming from ORDIM_O then\"Offen\" (open), if it\'s coming from ORDIM_C then\"quittiert\" (confirmed).'),
wh_task_confirm_tmsp TIMESTAMP
OPTIONS(description='Time of Confirmation of Warehouse Tasks Confirmed'),
wh_task_create_tmsp TIMESTAMP
OPTIONS(description='Creation date of a confirmed or open warehouse task'),
sort_track_name STRING(100)
OPTIONS(description='Sorting track where a sorting trolley is placed on after picking articles (\"S1-05-03\",\"S2-04-02\")'),
sort_trolley_name STRING(100)
OPTIONS(description='Trolley/vehicle which is used for sorting (\"FW-1046\",\"FW-1057\" etc )'),
pack_sort_track_name STRING(100)
OPTIONS(description='Planned bin for the handling unit_2 (\"S1-04\",\"S1-05\",\"S1-06\"'),
dest_storage_unit_nr STRING(50)
OPTIONS(description='Destination storage unit_2 number of Warehouse Tasks Confirmed (Package_2 number)'),
prod_qty BIGNUMERIC(38,0) OPTIONS(description='The actual quantity of the product in base Unit_2 of Measure'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
tgt_pick_qty BIGNUMERIC(38,5)
OPTIONS(description='The quantity that has to be picked when a warehouse order is created'),
max_wave_qty BIGNUMERIC(38,5)
OPTIONS(description='The maximum quantity of one article in a wave, which are related to one or multiple warehouse orders.'),
actual_pick_qty BIGNUMERIC(38,5)
OPTIONS(description='The actual quantity after the picking is fully done - when there is no warehouse task or wave assigned - then it means there is a real handling unit_2 physically picked.'),
task_pos_nr STRING(20) NOT NULL OPTIONS(description='Position Number of Warehouse Task'),
wh_order_pos_id STRING(80)
OPTIONS(description='A technical field, which is being used by business to filter on a specific warehouse-order-number-position-combination within the SAP GUI.'),
wh_task_processing_status_cd STRING(5)
OPTIONS(description='The Warehouse Task Processing Status_2 Code is representing the specific granualar status_2 of a warehouse task. It can be: NULL/ Empty = Open, A = Canceled, B = Waiting, C = Confirmed'),
wh_order_pos_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).'),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)'),
wh_processing_order_nr STRING(20)
OPTIONS(description='Warehouse processing order number generated for each warehouse process involving inbound, outbound and all other types of warehouse movements.'),
origin_storage_unit_nr STRING(100)
OPTIONS(description='Origin storage unit_2 number of Warehouse Tasks Confirmed (Package_2 number)'),
origin_storage_type_cd STRING(10)
OPTIONS(description='The type of storage within the warehouse where the processing of the task begins (e.g. Pickbereich, Reservebereich, Eingangsstore, etc.)'),
dest_storage_type_cd STRING(10)
OPTIONS(description='The type of storage within the warehouse where the processing of the task ends (e.g. Pickbereich, Reservebereich, Eingangsstore, etc.)'),
dest_storage_subtype_cd STRING(10)
OPTIONS(description='The storage section within a certain storage type in the warehouse where the processing of the task ends (e.g. wine storage section)'),
prod_variant_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
wh_stock_avail_type_cd STRING(5)
OPTIONS(description='The code for the availability type of warehouse stock (e.g. F1 = freely available stock, S1 = blocked stock, F2 = Venlo stock)'),
wh_processing_order_created_by_name STRING(20)
OPTIONS(description='The user who created the warehouse processing order in the EWM system (e.g. number in the format like LUD-LAG-.../ PIL-LAG..  etc --> Spared warehouse device where employee_2 can log into and create a task, 8-digit number --> Personal user account_2 of an employee_2, number starting with RFC --> User accounts of machines in the warehouse, which automatically create a task) '),
wh_processing_order_confirmed_by_name STRING(20)
OPTIONS(description='The user who confirmed the creation of the warehouse processing order in the EWM system (e.g. number in the format like LUD-LAG-.../ PIL-LAG..  etc --> Spared warehouse device where employee_2 can log into and confirm a task, 8-digit number --> Personal user account_2 of an employee_2, number starting with RFC --> User accounts of machines in the warehouse, which automatically confirm a task)'),
storage_queue_name STRING(20)
OPTIONS(description='The name of the queue for the articles processed with the particular task. For each storage type, there is a separate queue. (e.g. Internal, P-ALC-WARM, etc)'),
prod_condition_cd STRING(20)
OPTIONS(description='The condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping). Commonly referred to as batch.'),
origin_resource_name STRING(20)
OPTIONS(description='The name of the resource (tool) used for counting the articles processed with the particular task at the source location. Not all processes require counting at the source location_2, so sometimes this field can be left as null.'),
dest_resource_name STRING(20)
OPTIONS(description='The name of the resource (tool) used for counting the articles processed with the particular task at the destination location. Not all processes require counting at the destination, so sometimes this field can be left as null.'),
task_processing_start_tmsp TIMESTAMP
OPTIONS(description='The timestamp showing when the processing of the task started'),
entire_handling_unit_fg BOOL
OPTIONS(description='This flag denotes if an entire handling unit_2 is used for the processing of the particular task (e.g. when just one article has remained on the handling unit_2 or when all articles on the handling unit_2 are processed by the same task)'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='A surrogate key for the unit_2 of measure of the processed product quantity'),
uom_cd STRING(5)
OPTIONS(description='A code for the unit_2 of measure of the processed product quantity (e.g. ST = Stück)'),
diff_processed_prod_qty BIGNUMERIC(38,14)
OPTIONS(description='The difference between the product quantity that initially had to be processed with the task and the quantity that was actually processed.'),
stock_owner_cd STRING(10)
OPTIONS(description='The code of the owner of the articles processed with the particular task. In most cases this code is the same as the warehouse code. Sometimes, the owner can be the stationary business, i.e. the stores. Whenever a stock at the Venlo warehouse arrives for the first time from a supplier_2, the stock owner is going to be Venlo. Otherwise, the stock owner at the Venlo warehouse is going to be the warehouse that the stock is intended for, i.e. the warehouse where the stock is going to be shipped.'),
consolidation_grp_name STRING(20)
OPTIONS(description='The name of the consolidation group that the articles processed with the particular task belong to. The consolidation group denotes where the warehouse the articles are going to be sorted.'),
stock_avail_tmsp TIMESTAMP
OPTIONS(description='The timestamp showing when the articles processed with the given task start to be available for ordering to the customer'),
task_load_net_weight_meas BIGNUMERIC(38,5)
OPTIONS(description='The net weight of all loaded articles processed with the particular task'),
weight_uom_sid BIGNUMERIC(38,0) OPTIONS(description='Unit_2 of measurement for weight'),
weight_uom_cd STRING(5) OPTIONS(description='A code for the unit_2 of measure for weight'),
task_load_net_volume_meas BIGNUMERIC(38,5)
OPTIONS(description='The net volume of all loaded articles processed with the particular task'),
volume_uom_sid BIGNUMERIC(38,0) OPTIONS(description='Unit_2 of measurement for volume'),
volume_uom_cd STRING(5) OPTIONS(description='A code for the unit_2 of measure for volume'),
certificate_nr STRING(5)
OPTIONS(description='The certificate number is relevant only for wine articles and denotes in which year they were produced. One task can process only wines produced in the same year as they are going to be sorted into e specific section within the warehouse.'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
storage_process_type_cd STRING(10)
OPTIONS(description='This code denotes a type of storage process that summarizes storage process steps in order to define complex processes for putaway, stock removal, and warehouse internal movements (e.g. a goods receipt process may contain the storage process steps for unloading and putaway, whereas a goods issue process may contain the storage process steps for stock removal, packing, staging and loading).'),
storage_process_step_cd STRING(10)
OPTIONS(description='This code defines the specific storage process step is part of the storage process (e.g. Unload, Count, Deconsolidate, Put Away, Remove from Stock, Pack, etc.)'),
processing_activity_wh_area_cd STRING(10)
OPTIONS(description='The activity area code shows in which area within the warehouse the processing activity took place (e.g. at the doors of the warehouse).'),
alt_uom_cd STRING(5)
OPTIONS(description='A code for an alternative unit_2 of measure of the processed product quantity (e.g. instead of processing the products as single items, they could be processed in boxes).'),
alt_uom_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='The actual processed product quantity in the alternative Unit_2 of Measure.'),
wh_process_cat_cd STRING(5)
OPTIONS(description='This code defines the warehouse process category (e,g, 1 - Putaway, 2 - Stock Removal, 3 - Internal Warehouse Movement, 4 - Physical Inventory, etc.)'),
wh_processing_exception_cd STRING(5)
OPTIONS(description='This code describes exceptions which took place during processing of the warehouse task because of unexpected issues. (e.g. ZHBD = Change Destination Bin and storage type - this code can be chosen whenever the destination for a putaway task had to be changed because the initially chosen shelf was broken/dirty, etc.)'),
transport_mode_type_cd STRING(20)
OPTIONS(description='The code for the type of the transportation mode used. Example: ZTRK.'),
PRIMARY KEY (wh_order_sid, wh_order_pos_nr, wave_id, task_id, task_pos_nr, dwh_valid_from_tmsp, wh_sid) NOT ENFORCED
)
OPTIONS(description='This transactional fact tracks the progress of the steps related to processing Warehouse Orders\n             A Warehouse order may say\"we need to prepare 10 shirts for delivery\", and in result we will have tasks to pickup the shirts, sort them, pack them ...\n\n             Historization is introduced to keep track of status_2 progress,\n\n             Main Src - SAP EWM tables: /SCWM/ORDIM_O , /SCWM/ORDIM_C');