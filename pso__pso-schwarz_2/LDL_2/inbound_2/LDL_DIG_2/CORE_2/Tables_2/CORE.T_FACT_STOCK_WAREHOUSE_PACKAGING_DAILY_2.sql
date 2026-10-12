CREATE TABLE CORE.T_FACT_STOCK_WAREHOUSE_PACKAGING_DAILY_2 (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
   STORAGE_LOC_CD                      VARCHAR(10)     NOT NULL COMMENT 'The code which identifies the storage location_2 (10001, 1002, etc)',
   PACK_MATERIAL_NR                    VARCHAR(20)     NOT NULL COMMENT 'The packaging material number (e..g 420000026,  420000028)',
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   ACTIVE_FG                           BOOLEAN         COMMENT 'An indicator showing the current record from a business perspective,',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   BLOCKED_STOCK_CNT                   NUMBER          COMMENT 'Stock of a product stored in the warehouse but currently blocked (not usable / not sellable).',
   UNRESTRICTED_STOCK_CNT              NUMBER          COMMENT 'An unrestricted batch is stock we can offer to a customer, and therefore is included in the ATP calculation. The status_2 is first set to unrestricted use upon receipt of a new batch. ',
   RESTRICTED_STOCK_CNT                NUMBER          COMMENT 'A restricted batch is stock we cannot offer to a customer, and therefore is not included in the ATP calculation.',
   IN_TRANSFER_CNT                     NUMBER          COMMENT 'Stock in transfer from one storage location_2 to another',
   IN_QTY_INSPECTION_CNT               NUMBER          COMMENT 'Quality inspection stock is delivered material that is retained for quality inspection',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_STOCK_WAREHOUSE_PACKAGING_DAILY PRIMARY KEY (WH_SID, STORAGE_LOC_CD, PACK_MATERIAL_NR, CAL_DT) NOT ENFORCED
 )  COMMENT= 'The table contains the intraday updates of available products in a stock of an particular warehouse.';
