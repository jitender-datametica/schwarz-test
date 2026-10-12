--==============================================================
-- Table: t_oracle_v_fk_supplier_final_order_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_supplier_final_order_2
   generated from Powerdesigner on Donnerstag, 13. Juni 2024 15:59:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_supplier_final_order_2 (
country_2 STRING(2) NOT NULL OPTIONS(description='Country_2; sourcefield: COUNTRY_2'),
wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of a Warehouse; sourcefield: FO_SUPPLIER_WH'),
supplier_nr STRING(16777216) NOT NULL
OPTIONS(description='Identification number of supplier_2 of an warehouse; sourcefield: FO_SUPPLIER_NR'),
item_nr STRING(16777216) NOT NULL
OPTIONS(description='Global item_2 number, item_nr is equal to other xx_item_nr from other tables; sourcefield: FO_ITEM_NR'),
item_packagecapacity BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Amount of salesitems that can be placed in one case; sourcefield: FO_ITEM_PACKAGECAPACITY'),
calculation_number STRING(30) NOT NULL OPTIONS(description='Number of an order; sourcefield: FO_CALCULATION_NUMBER'),
is_sent_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Check if order was sent to supplier_2 (No = 0, Yes = 1); sourcefield: FO_IS_SENT'),
order_sent_date TIMESTAMP NOT NULL
OPTIONS(description='Date when an order was sent to a supplier_2; sourcefield: FO_SENDING_TIME'),
orders_arrival_date DATE NOT NULL
OPTIONS(description='Date when an order will be delivered to a warehouse; sourcefield: FO_DELIVERY_DATE'),
generation_date TIMESTAMP NOT NULL
OPTIONS(description='Date of the creation of an order; sourcefield: FO_GENERATION_DATE'),
order_unit_id BIGNUMERIC(38,0)
OPTIONS(description='Packaging unit_2 that was used for an order (piece, colli = 0, layer = 1, DD = 2, EP = 3); sourcefield: FO_ORDER_UNIT_ID'),
order_unit_quantity BIGNUMERIC(38,0)
OPTIONS(description='Amount of pieces used in a packaging unit_2 (Field ORDER_UNIT_ID); sourcefield: FO_ORDER_UNIT_QUANTITY'),
corrected_order_unit_quantity BIGNUMERIC(38,0)
OPTIONS(description='Correction of amount of purchase order quantity unit_2 by a user in UI-Panel; sourcefield: FO_CORRECTED_ORDER_UNIT_QUANTITY'),
corrected_order_unit_id BIGNUMERIC(38,0)
OPTIONS(description='Correction of purchase order quantity unit_2 by a user in UI-Panel; sourcefield: FO_CORRECTED_ORDER_UNIT_ID'),
mod_date TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of altering entries inside the table, is usually null. Sourcefield: mod_date'),
source_extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.'),
snflk_insert_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake loading process.'),
snflk_update_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake table update process.'),
PRIMARY KEY (country_2, wh, supplier_nr, item_nr, item_packagecapacity, calculation_number, is_sent_fg, order_sent_date,
 orders_arrival_date, generation_date) NOT ENFORCED
) OPTIONS(description='Orders created via ADL-System; Sourcetable FO_SUPPLIER_FINAL_ORDER');