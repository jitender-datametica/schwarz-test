/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_ORDER_LINE_PROCESS_STATUS
   GENERATED FROM POWERDESIGNER ON Dienstag 2023-05-15
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_WAREHOUSE_ORDER_LINE_PROCESS_STATUS (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
   WH_ORDER_SID                        NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for a warehouse order',
   WH_ORDER_POS_NR                     NUMBER          NOT NULL COMMENT 'The particular position number of a position in an order',
   WAVE_ID                             VARCHAR(20)     NOT NULL COMMENT 'Number of wave (aggregation of positions which have the same picking process in the warehouse)',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   WH_ORDER_NR                         VARCHAR(20)     COMMENT 'Delivery order number ',
   WH_ORDER_LINE_PROCESS_STATUS_CD     NUMBER          COMMENT 'The processing status of a certaing Warehouse Order Line in a Wave',
   STORAGE_UNIT_NR                     VARCHAR(50)     COMMENT 'Identification number of the storage unit used for this step of  processing. The type of storage unit can be different depending on the status (step) of the processing (for example bin/cart/trolley/pallet)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_WAREHOUSE_ORDER_LINE_PROCESS_STATUS PRIMARY KEY (WH_SID, WH_ORDER_SID, WH_ORDER_POS_NR, WAVE_ID) NOT ENFORCED
 )  COMMENT= 'A fact table with the most recent processing status of an Warehouse Order Line in a Wave. We have only the status column in this separate table because statuses change frequently and we want to be able to update them quickly.';