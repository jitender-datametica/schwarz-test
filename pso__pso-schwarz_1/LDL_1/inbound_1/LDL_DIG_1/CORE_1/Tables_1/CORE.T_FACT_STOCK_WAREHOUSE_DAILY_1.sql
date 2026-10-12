/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_STOCK_WAREHOUSE_DAILY_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 8. März 2023 16:54:05
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_STOCK_WAREHOUSE_DAILY_1 (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   ACTIVE_FG                           BOOLEAN         COMMENT 'An indicator showing the current record from a business perspective,',
   AVAIL_TO_PROMISE_CNT                NUMBER          COMMENT 'The amount of stock which is currently available within the specific warehouse.
            All of the stock can be sold within the onlineshop and is stored in an internal warehouse.',
   AVAIL_TO_SELL_CNT                   NUMBER          COMMENT 'Available for Sale is the high level rack''s and pick-area''s stock within the system.',
   RECEIV_ON_DOCK_CNT                  NUMBER          COMMENT '"Received on dock" is the incoming goods area''s stock within the system. In case of a new delivery the stock would be stated first as ROD.',
   IN_TRANSIT_CNT                      NUMBER          COMMENT 'Thies field describes products/ articles which are in a transit between a warehouse and another. The TRAME builds up the Stock which is palnt to be delivert for a product to a warehouse.',
   BLOCKED_STOCK_CNT                   NUMBER          COMMENT 'Stock of a product stored in the warehouse but currently blocked (not usable / not sellable).',
   BLOCKED_STOCK_RETURN_CNT            NUMBER          COMMENT 'This is the stock of the customer returns, which is not used as a regular stock to sell the articles to the customers.',
   UNRESTRICTED_STOCK_CNT              NUMBER          COMMENT 'An unrestricted batch is stock we can offer to a customer, and therefore is included in the ATP calculation. The status_1 is first set to unrestricted use upon receipt of a new batch. ',
   RESTRICTED_STOCK_CNT                NUMBER          COMMENT 'A restricted batch is stock we cannot offer to a customer, and therefore is not included in the ATP calculation.',
   IN_TRANSFER_CNT                     NUMBER          COMMENT 'Stock in transfer from one storage location_1 to another',
   IN_QTY_INSPECTION_CNT               NUMBER          COMMENT 'Quality inspection stock is delivered material that is retained for quality inspection',
   TOTAL_STOCK_CNT                     NUMBER          COMMENT 'The sum of (blocked_stock_cnt,blocked_stock_return_cnt,unrestricted_stock_cnt,restricted_stock_cnt,in_transfer_cnt and in_qty_inspection_cnt)',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_STOCK_WAREHOUSE_DAILY PRIMARY KEY (WH_SID, PROD_VARIANT_SID, CAL_DT) NOT ENFORCED
 )  COMMENT= 'The table contains the daily updates of available products in a stock of an particular warehouse .';
