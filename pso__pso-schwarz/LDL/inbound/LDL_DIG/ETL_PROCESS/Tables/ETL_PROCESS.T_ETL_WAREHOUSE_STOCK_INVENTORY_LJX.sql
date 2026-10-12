/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_STOCK_INVENTORY_LJX
   GENERATED FROM POWERDESIGNER ON Donnerstag, 27. Februar 2025 12:59:48
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_STOCK_INVENTORY_LJX (
   WH_SID                              NUMBER(38,0)    NOT NULL COMMENT 'The unique ID (surogate key) of the warehouse associated with the particular inbound movement.',
   STOCK_ITEM_ID                       VARCHAR(100)    NOT NULL COMMENT 'The ID of the particular physical stock item which is transported with the given handling unit and its movement within the warehouse is recorded with the particular log entry.',
   WH_CD                               VARCHAR(5)      COMMENT 'Warehouse code',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'The unique identifier (surrogate key) for the product variant.',
   STOCK_ITEM_INDEX                    VARCHAR(5)      COMMENT 'This stock item index helps in identifying and managing individual stock items within the handling unit. It gives a hint in which SAP stock table more information about the item can be found (e.g. /SCWM/STOCK_IW01, /SCWM/STOCK_IW02).',
   STOCK_MANAGING_ORG_CD               VARCHAR(32)     COMMENT 'This is the code of the stock managing organization which is in charge of moving stock within the warehouse, sending it to customers or disposing it. 
            This code is introduced because there is a SAP functionality which allows multiple parties (organizations) to use the same warehouse for storing their stock. 
            Warehouses, used by Lidl E-Commerce (LEC) will always have the value LEC populated in this field as they are used solely by LEC.',
   STOCK_OWNER_CD                      VARCHAR(10)     COMMENT 'The code of the owner of the articles processed with the particular task. In most cases this code is the same as the warehouse code. Sometimes, the owner can be the stationary business, i.e. the stores. Whenever a stock at the Venlo warehouse arrives for the first time from a supplier, the stock owner is going to be Venlo. Otherwise, the stock owner at the Venlo warehouse is going to be the warehouse that the stock is intended for, i.e. the warehouse where the stock is going to be shipped.',
   WH_STOCK_AVAIL_TYPE_CD              VARCHAR(5)      COMMENT 'The code for the availability type of warehouse stock (e.g. F1 = freely available stock, S1 = blocked stock, F2 = Venlo stock)',
   PROD_BATCH_ID                       VARCHAR(32)     COMMENT 'A unique ID for each article, even if they are the same, they are assigned a different BATCHID.',
   WH_STOCK_COUNTER_NR                 NUMBER          COMMENT 'Counts the number of appearences for a certain prod_vatiant in a certain wh_stock_avail_type_cd.',
   WH_ORDER_CAT_CD                     VARCHAR(6)      COMMENT 'The code for the category of the warehouse inbound or outbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_STOCK_INVENTORY_LJX PRIMARY KEY (WH_SID, STOCK_ITEM_ID) NOT ENFORCED 
)  COMMENT = 'The ETL table contains warehouse stock information which is then used for tracking inventory within the warehouse, ensuring accurate stock levels and efficient warehouse operations.
             
             Source: /SCWM/STOCK_IW01, /SCWM/STOCK_IW02, /SCWM/STOCK_IW03, /SCWM/STOCK_IW04 from LJX source system.';
