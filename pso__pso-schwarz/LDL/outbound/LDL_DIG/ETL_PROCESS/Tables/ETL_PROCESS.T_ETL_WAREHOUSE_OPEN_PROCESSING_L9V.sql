/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_OPEN_PROCESSING_L9V
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juni 2024 14:52:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_open_processing_l9v (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
task_id STRING(20) NOT NULL OPTIONS(description='Code of Warehouse Task'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
wh_processing_order_nr STRING(20)
OPTIONS(description='Warehouse processing order number generated for each warehouse process involving inbound, outbound and all other types of warehouse movements.'),
wh_process_type_cd STRING(5) OPTIONS(description='The code for warehouse process type (2010, 2011, etc)'),
origin_storage_unit_nr STRING(100)
OPTIONS(description='Origin storage unit number of Warehouse Tasks Confirmed (Package number)'),
wave_id STRING(20)
OPTIONS(description='Number of wave (aggregation of positions which have the same picking process in the warehouse)'),
pack_sort_track_name STRING(100) OPTIONS(description='Planned bin for the handling unit ("S1-04", "S1-05", "S1-06"'),
origin_storage_type_cd STRING(10)
OPTIONS(description='The type of storage within the warehouse where the processing of the task begins (e.g. Pickbereich, Reservebereich, Eingangsstore, etc.)'),
dest_storage_type_cd STRING(10)
OPTIONS(description='The type of storage within the warehouse where the processing of the task ends (e.g. Pickbereich, Reservebereich, Eingangsstore, etc.)'),
dest_storage_subtype_cd STRING(10)
OPTIONS(description='The storage section within a certain storage type in the warehouse where the processing of the task ends (e.g. wine storage section)'),
sort_track_name STRING(100)
OPTIONS(description='Sorting track where a sorting trolley is placed on after picking articles ("S1-05-03", "S2-04-02")'),
tgt_pick_qty BIGNUMERIC(38,5)
OPTIONS(description='The quantity that has to be picked when a warehouse order is created'),
prod_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
wh_stock_avail_type_cd STRING(5)
OPTIONS(description='The code for the availability type of warehouse stock (e.g. F1 = freely available stock, S1 = blocked stock, F2 = Venlo stock)'),
wh_task_processing_status_cd STRING(5)
OPTIONS(description='The Warehouse Task Processing Status Code is representing the specific granualar status of a warehouse task. It can be: NULL/ Empty = Open, A = Canceled, B = Waiting, C = Confirmed'),
wh_task_create_tmsp TIMESTAMP
OPTIONS(description='Creation date of a confirmed or open warehouse task'),
wh_processing_order_created_by_name STRING(20)
OPTIONS(description='The user who created the warehouse processing order in the EWM system (e.g. number in the format like LUD-LAG-.../ PIL-LAG..  etc --> Spared warehouse device where employee can log into and create a task, 8-digit number --> Personal user account of an employee, number starting with RFC --> User accounts of machines in the warehouse, which automatically create a task) '),
dest_storage_unit_nr STRING(50)
OPTIONS(description='Destination storage unit number of Warehouse Tasks Confirmed (Package number)'),
storage_queue_name STRING(20)
OPTIONS(description='The name of the queue for the articles processed with the particular task. For each storage type, there is a separate queue. (e.g. Internal, P-ALC-WARM, etc)'),
prod_condition_cd STRING(20)
OPTIONS(description='The condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping). Commonly referred to as batch.'),
storage_process_type_cd STRING(10)
OPTIONS(description='This code denotes a type of storage process that summarizes storage process steps in order to define complex processes for putaway, stock removal, and warehouse internal movements (e.g. a goods receipt process may contain the storage process steps for unloading and putaway, whereas a goods issue process may contain the storage process steps for stock removal, packing, staging and loading).'),
storage_process_step_cd STRING(10)
OPTIONS(description='This code defines the specific storage process step is part of the storage process (e.g. Unload, Count, Deconsolidate, Put Away, Remove from Stock, Pack, etc.)'),
origin_resource_name STRING(20)
OPTIONS(description='The name of the resource (tool) used for counting the articles processed with the particular task at the source location. Not all processes require counting at the source location, so sometimes this field can be left as null.'),
dest_resource_name STRING(20)
OPTIONS(description='The name of the resource (tool) used for counting the articles processed with the particular task at the destination location. Not all processes require counting at the destination, so sometimes this field can be left as null.'),
entire_handling_unit_fg BOOL
OPTIONS(description='This flag denotes if an entire handling unit is used for the processing of the particular task (e.g. when just one article has remained on the handling unit or when all articles on the handling unit are processed by the same task)'),
uom_sid BIGNUMERIC OPTIONS(description='A surrogate key for the unit of measure of the processed product quantity'),
uom_cd STRING(5)
OPTIONS(description='A code for the unit of measure of the processed product quantity (e.g. ST = Stück)'),
wh_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for a warehouse order'),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)'),
wh_order_pos_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).'),
stock_owner_cd STRING(10)
OPTIONS(description='The code of the owner of the articles processed with the particular task. In most cases this code is the same as the warehouse code. Sometimes, the owner can be the stationary business, i.e. the stores. Whenever a stock at the Venlo warehouse arrives for the first time from a supplier, the stock owner is going to be Venlo. Otherwise, the stock owner at the Venlo warehouse is going to be the warehouse that the stock is intended for, i.e. the warehouse where the stock is going to be shipped.'),
consolidation_grp_name STRING(20)
OPTIONS(description='The name of the consolidation group that the articles processed with the particular task belong to. The consolidation group denotes where the warehouse the articles are going to be sorted.'),
stock_avail_tmsp TIMESTAMP
OPTIONS(description='The timestamp showing when the articles processed with the given task start to be available for ordering to the customer'),
processing_activity_wh_area_cd STRING(10)
OPTIONS(description='The activity area code shows in which area within the warehouse the processing activity took place (e.g. at the doors of the warehouse).'),
task_load_net_weight_meas BIGNUMERIC(38,5)
OPTIONS(description='The net weight of all loaded articles processed with the particular task'),
weight_uom_sid BIGNUMERIC OPTIONS(description='Unit of measurement for weight'),
weight_uom_cd STRING(5) OPTIONS(description='A code for the unit of measure for weight'),
task_load_net_volume_meas BIGNUMERIC(38,5)
OPTIONS(description='The net volume of all loaded articles processed with the particular task'),
volume_uom_sid BIGNUMERIC OPTIONS(description='Unit of measurement for volume'),
volume_uom_cd STRING(5) OPTIONS(description='A code for the unit of measure for volume'),
certificate_nr STRING(5)
OPTIONS(description='The certificate number is relevant only for wine articles and denotes in which year they were produced. One task can process only wines produced in the same year as they are going to be sorted into e specific section within the warehouse.'),
alt_uom_cd STRING(5)
OPTIONS(description='A code for an alternative unit of measure of the processed product quantity (e.g. instead of processing the products as single items, they could be processed in boxes).'),
wh_process_cat_cd STRING(5)
OPTIONS(description='This code defines the warehouse process category (e,g, 1 - Putaway, 2 - Stock Removal, 3 - Internal Warehouse Movement, 4 - Physical Inventory, etc.)'),
sguid_hu_cd STRING(100) OPTIONS(description='Identifier'),
dguid_hu_cd STRING(100) OPTIONS(description='Identifier'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, task_id) NOT ENFORCED
)
OPTIONS(description='ETL  table to support loading open warehouse processings in T_FACT_WAREHOUSE_PROCESSING from the L9V source system (/SCWM/ORDIM_O). This is one of the tables that will replace t_etl_warehouse_processing_task.');