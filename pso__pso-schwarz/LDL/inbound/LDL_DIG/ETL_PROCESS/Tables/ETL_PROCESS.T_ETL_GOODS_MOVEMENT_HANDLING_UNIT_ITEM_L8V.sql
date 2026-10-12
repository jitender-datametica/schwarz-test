/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_GOODS_MOVEMENT_HANDLING_UNIT_ITEM_L8V
   GENERATED FROM POWERDESIGNER ON Mittwoch, 11. September 2024 15:23:17
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_GOODS_MOVEMENT_HANDLING_UNIT_ITEM_L8V (
   HANDLING_UNIT_LOG_ID                VARCHAR(100)    NOT NULL COMMENT 'The handling unit log id represents a specific log entry which is generated for each handling unit movement within the warehouse for the transportation of particular stock item(s).',
   HANDLING_UNIT_SID                   NUMBER          NOT NULL COMMENT 'Surrogate Key of the Handling Unit. Generated based on src_handling_unit_id, sap_sys_name, sap_client_id
            A Handling unit is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. ',
   STOCK_ITEM_ID                       VARCHAR(100)    NOT NULL COMMENT 'The ID of the particular physical stock item which is transported with the given handling unit and its movement within the warehouse is recorded with the particular log entry.',
   SRC_HANDLING_UNIT_ID                VARCHAR(100)    COMMENT 'The ID of the Handling Unit in the source system (GUID_PARENT). A Handling unit is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin.',
   STOCK_ITEM_QTY                      NUMBER(38, 5)   COMMENT 'This field indicates the quantity of the stock item transported with the handling unit. It helps in managing the inventory levels. This value is not updated even if the stock_item_reduce_fg is set - indicating that the actual stock item quantity on the handling unit is smaller.',
   VIRTUAL_STOCK_FG                    BOOLEAN         COMMENT 'The virtual stock indicator is almost always used temporarily to indicate stock availability (e.g. upon arrival of the goods at the warehouse the virtual stock indicator can be set for 100 items before they are actually counted. After counting, the virtual stock indicator is removed).',
   STOCK_ITEM_INDEX                    VARCHAR(5)      COMMENT 'This stock item index helps in identifying and managing individual stock items within the handling unit. It gives a hint in which SAP stock table more information about the item can be found (e.g. /SCWM/STOCK_IW01, /SCWM/STOCK_IW02).',
   ORIG_STOCK_ITEM_ID                  VARCHAR(100)    COMMENT 'This field is used as reference to the original stock_item_id before any changes or movements. In the warehouse there is the possibilty to post one stock to another, which means that they can change a product number. The original stock item id therefore helps in maintaining the history and traceability of stock movements.',
   UOM_SID                             NUMBER          COMMENT 'A surrogate key for the unit of measure of the processed product quantity',
   UOM_CD                              VARCHAR(5)      COMMENT 'A code for the unit of measure of the processed product quantity (e.g. ST = Stück)',
   ALT_UOM_CD                          VARCHAR(5)      COMMENT 'A code for an alternative unit of measure of the processed product quantity (e.g. instead of processing the products as single items, they could be processed in boxes).',
   TASK_LOAD_NET_WEIGHT_MEAS           NUMBER(38, 5)   COMMENT 'The net weight of all loaded items processed with the particular task',
   WEIGHT_UOM_SID                      NUMBER          COMMENT 'Unit of measurement for weight',
   WEIGHT_UOM_CD                       VARCHAR(5)      COMMENT 'A code for the unit of measure for weight',
   TASK_LOAD_NET_VOLUME_MEAS           NUMBER(38, 5)   COMMENT 'The net volume of all loaded items processed with the particular task',
   VOLUME_UOM_SID                      NUMBER          COMMENT 'Unit of measurement for volume',
   VOLUME_UOM_CD                       VARCHAR(5)      COMMENT 'A code for the unit of measure for volume',
   HANDLING_UNIT_CAPACITY_MEAS         NUMBER(38, 5)   COMMENT 'This field indicates the maximum quantity or volume that the handling unit can have. Based on the src_handling_unit_id (GUID_PARENT) the maximum capacity (quantity/volume/weight etc) can be identified. For example if you define a Storage bin with a capacity of 10 and a Handling Unit Type A with a Capacity of 3 and another Handling Unit type B with a Capacity of 1, than you would be able to place 3 HUs of Type A (3 x 3 = 9) and one HU of type B (9 + 1 = 10) within the storage bin.',
   STOCK_AVAIL_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The timestamp showing when the stock items processed with the given task start to be available for ordering to the customer',
   SHELF_LIFE_EXPIRATION_DT            DATE            COMMENT 'The shelf life expiration date indicates the expiration date of the stock item transported with the handling unit.',
   RESTRICTED_BATCH_FG                 BOOLEAN         COMMENT 'This flag indicates any batch restrictions associated with the stock item. (e.g. the stock item is not available for ordering as the batch needs to undergo inventory, etc.)',
   STOCK_ITEM_PLATE_NR                 VARCHAR(20)     COMMENT 'This field contains the identification plate number of the stock item. It is used for tracking and identification purposes.',
   WH_ORDER_CAT_CD                     VARCHAR(6)      COMMENT 'The code for the category of the warehouse inbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)',
   WH_ORDER_SID                        NUMBER          COMMENT 'The unique identifier (surrogate key) for a warehouse order',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)',
   WH_ORDER_POS_SID                    NUMBER(38,0)    COMMENT 'The unique surrogate key within the DWH for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement. (generated from itemid + sap_client_id + sap_sys_name from the source)',
   SRC_WH_ORDER_POS_ID                 VARCHAR(64)     COMMENT 'The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).',
   PLAN_INVENTORY_FG                   BOOLEAN         COMMENT 'This flag shows if inventory is planned for the stock item transported with the given handling unit.',
   CONSOLIDATION_GRP_NAME              VARCHAR(20)     COMMENT 'The name of the consolidation group that the articles processed with the particular task belong to. The consolidation group denotes where in the warehouse the articles are going to be sorted.',
   SERIAL_NR_REQUIREMENT_CD            VARCHAR(5)      COMMENT 'This field indicates the serial number requirement code of the stock. The serial number requirement on stock level is used to store the exact storage bin information for a serial number.',
   STOCK_ITEM_REDUCE_FG                BOOLEAN         COMMENT 'This flag is used to indicate if the given stock item transported with the handling unit has been canceled. It helps in managing the status of the handling unit stock items during warehouse operations',
   CERTIFICATE_NR                      VARCHAR(5)      COMMENT 'The certificate number is relevant only for wine articles and denotes in which year they were produced. One task can process only wines produced in the same year as they are going to be sorted into a specific section within the warehouse.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_ETL_GOODS_MOVEMENT_HANDLING_UNIT_ITEM_L8V PRIMARY KEY (HANDLING_UNIT_LOG_ID, HANDLING_UNIT_SID, STOCK_ITEM_ID) NOT ENFORCED 
)  COMMENT = 'ETL table containing data about the movement of stock items within a warehouse with a particular handling unit.
             Source: /SCWM/GMHUITM from L8V  sap instance';
