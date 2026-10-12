/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUPPLIER_ORDER_POSITION_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 13. Dezember 2022 11:34:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_supplier_order_position_1 (
supplier_order_nr STRING(20) NOT NULL OPTIONS(description='Supplier_1 Order Number present in the Purchase Order'),
supplier_order_pos_nr BIGNUMERIC NOT NULL OPTIONS(description='Product position number on purchase order'),
prod_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a certain product ordered in a purchasing document'),
deletion_in_purch_doc_cd STRING(5) OPTIONS(description='Code indicating if position was deleted in purchasing document'),
deletion_in_purch_doc_fg BOOL OPTIONS(description='Flag indicating if position was deleted in purchasing document'),
delivery_completed_cd STRING(5) OPTIONS(description='Code indicating if delivery was completed'),
delivery_completed_fg BOOL OPTIONS(description='Flag indicating if delivery was completed'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (supplier_order_nr, supplier_order_pos_nr) NOT ENFORCED
)
OPTIONS(description='The ETL support table holding the order position details placed by Lidl purchase department ( DE ) from a supplier_1 ');