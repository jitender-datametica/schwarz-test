/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUPPLIER_ORDER_SCHEDULE_AGREEMENT_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 5. Januar 2023 14:53:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_supplier_order_schedule_agreement_1 (
supplier_order_nr STRING(20) NOT NULL OPTIONS(description='Supplier_1 Order Number present in the Purchase Order'),
supplier_order_pos_nr BIGNUMERIC NOT NULL OPTIONS(description='Product position number on purchase order'),
delivery_schedule_line_nr NUMERIC(4) NOT NULL OPTIONS(description='ETENR (Delivery Schedule Line Counter)'),
item_delivery_dt DATE OPTIONS(description='The agreement is made for the item_1 to be delivered at this date'),
prod_qty_scheduled BIGNUMERIC(38,3) OPTIONS(description='Scheduled Quantity (Einteilungsmenge)'),
prod_qty_received BIGNUMERIC(38,3) OPTIONS(description='Quantity of Goods Received (Gelieferte Menge)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (supplier_order_nr, supplier_order_pos_nr, delivery_schedule_line_nr) NOT ENFORCED
)
OPTIONS(description='The ETL support table holding order position details (agreement delivery date) placed by Lidl purchase department ( DE ) from a supplier_1 ');