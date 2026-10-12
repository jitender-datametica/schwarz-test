--==============================================================
-- Table: t_oracle_v_fk_supplier_order_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_supplier_order_1
   generated from Powerdesigner on Donnerstag, 13. Juni 2024 15:47:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_supplier_order_1 (
country_1 STRING(2) NOT NULL OPTIONS(description='Country_1; sourcefield: COUNTRY_1'),
wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of a Warehouse; sourcefield: SUPPLIER_WH'),
supplier_nr STRING(16777216) NOT NULL
OPTIONS(description='Identification number of supplier_1 of an warehouse; sourcefield: SUPPLIER_NR'),
item_nr STRING(16777216) NOT NULL
OPTIONS(description='Global item_1 number, item_nr is equal to other xx_item_nr from other tables; sourcefield: ITEM_NR'),
item_packagecapacity BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Amount of salesitems that can be placed in one case; sourcefield: ITEM_PACKAGECAPACITY'),
order_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of an order; sourcefield: ORDER_NR'),
order_sent_date DATE NOT NULL OPTIONS(description='Date when an order was sent to a supplier_1; sourcefield: ORDER_SENT'),
orders_arrival_date DATE NOT NULL
OPTIONS(description='Date when an order will be delivered to a warehouse; sourcefield: ORDERS_ARRIVAL_DATE'),
order_unit_id BIGNUMERIC(38,0)
OPTIONS(description='Packaging unit_1 that was used for an order (piece, colli = 0, layer = 1, DD = 2, EP = 3); sourcefield: ORDER_UNIT_ID'),
orders_outstanding BIGNUMERIC(38,0)
OPTIONS(description='Open orders for a specific item_1 (past view); sourcefield: ORDERS_OUTSTANDING'),
orders_future BIGNUMERIC(38,0)
OPTIONS(description='Open orders for a specific item_1 (future view); sourcefield: ORDERS_FUTURE'),
orders_total BIGNUMERIC(38,0) OPTIONS(description='Sum of open orders (outstanding + total); sourcefield: ORDERS_TOTAL'),
mod_date DATETIME NOT NULL
OPTIONS(description='Timestamp of altering entries inside the table, is usually null. Sourcefield: mod_date'),
source_extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.'),
snflk_insert_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake loading process.'),
snflk_update_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake table update process.'),
PRIMARY KEY (country_1, wh, supplier_nr, order_nr, item_nr, item_packagecapacity, orders_arrival_date, order_sent_date)
NOT ENFORCED
) OPTIONS(description='Orders created via DIS-System; Sourcetable FO_SUPPLIER_ORDER');