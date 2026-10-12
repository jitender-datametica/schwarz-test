/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_STOCK_INVENTORY_L8V_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 27. Februar 2025 12:57:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_stock_inventory_l8v_1 (
wh_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique ID (surogate key) of the warehouse associated with the particular inbound movement.'),
stock_item_id STRING(100) NOT NULL
OPTIONS(description='The ID of the particular physical stock item_1 which is transported with the given handling unit_1 and its movement within the warehouse is recorded with the particular log entry.'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
prod_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product variant.'),
stock_item_index STRING(5)
OPTIONS(description='This stock item_1 index helps in identifying and managing individual stock items within the handling unit. It gives a hint in which SAP stock table more information about the item_1 can be found (e.g. /SCWM/STOCK_IW01, /SCWM/STOCK_IW02).'),
stock_managing_org_cd STRING(32)
OPTIONS(description='This is the code of the stock managing organization which is in charge of moving stock within the warehouse, sending it to customers or disposing it.             This code is introduced because there is a SAP functionality which allows multiple parties (organizations) to use the same warehouse for storing their stock.             Warehouses, used by Lidl E-Commerce (LEC) will always have the value LEC populated in this field as they are used solely by LEC.'),
stock_owner_cd STRING(10)
OPTIONS(description='The code of the owner of the articles processed with the particular task. In most cases this code is the same as the warehouse code. Sometimes, the owner can be the stationary business, i.e. the stores. Whenever a stock at the Venlo warehouse arrives for the first time from a supplier_1, the stock owner is going to be Venlo. Otherwise, the stock owner at the Venlo warehouse is going to be the warehouse that the stock is intended for, i.e. the warehouse where the stock is going to be shipped.'),
wh_stock_avail_type_cd STRING(5)
OPTIONS(description='The code for the availability type of warehouse stock (e.g. F1 = freely available stock, S1 = blocked stock, F2 = Venlo stock)'),
prod_batch_id STRING(32)
OPTIONS(description='A unique ID for each article, even if they are the same, they are assigned a different BATCHID.'),
wh_stock_counter_nr BIGNUMERIC
OPTIONS(description='Counts the number of appearences for a certain prod_vatiant in a certain wh_stock_avail_type_cd.'),
wh_order_cat_cd STRING(6)
OPTIONS(description='The code for the category of the warehouse inbound or outbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, stock_item_id) NOT ENFORCED
)
OPTIONS(description='The ETL table contains warehouse stock information which is then used for tracking inventory within the warehouse, ensuring accurate stock levels and efficient warehouse operations.                          Source: /SCWM/STOCK_IW01, /SCWM/STOCK_IW02, /SCWM/STOCK_IW03, /SCWM/STOCK_IW04 from L8V source system.');