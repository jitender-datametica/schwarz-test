/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SUPPLIER_ORDER_LINE
   GENERATED FROM POWERDESIGNER ON Freitag, 27. Oktober 2023 11:59:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_supplier_order_line (
supplier_order_nr STRING(20) NOT NULL OPTIONS(description='Supplier Order Number present in the Purchase Order'),
supplier_order_pos_nr BIGNUMERIC NOT NULL OPTIONS(description='Product position number on purchase order'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
prod_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
supplier_order_dt DATE
OPTIONS(description='The order date of the purchase document. It can be different from the creation date in SAP.'),
supplier_order_confirm_dt DATE
OPTIONS(description='On this date the supplier confirmed that it will provide this product quantity'),
tgt_prod_delivery_dt DATE OPTIONS(description='The agreement is made for the item to be delivered at this date'),
supplier_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for supplier account number present in the purchaseorder'),
supplier_nr STRING(20) OPTIONS(description='Account number of supplier/vendor from the sorce system'),
cust_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
cust_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of an item in an order'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a certain product ordered in a purchasing document'),
delivered_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of the product that is confirmed will be delivered. May  be more or less then ordered product quantity'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
prod_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Net Price in document currency as was per agreement according to which purchase happend.'),
prod_price_vat_pct BIGNUMERIC(38,5) OPTIONS(description='Input tax percentage on purchased items.'),
dropshipment_order_fg BOOL
OPTIONS(description='An indicator on the the type of delivery orders.i.e. if a dropshipment order.'),
is_delivery_completed_fg BOOL OPTIONS(description='Flag indicating if delivery from supplier to Lidl was completed'),
wh_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
storage_loc_cd STRING(10) OPTIONS(description='The code which identifies the storage location (10001, 1002, etc)'),
supplier_order_type_cd STRING(5) OPTIONS(description='The unique code for the purchase order document  '),
tax_country_cd STRING(5)
OPTIONS(description='The unique code for a country according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
tax_type_cd STRING(5) OPTIONS(description='The code identifying the tax type'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
deletion_in_purch_doc_fg BOOL OPTIONS(description='Flag indicating if position was deleted in purchasing document'),
supplier_order_cancel_dt DATE OPTIONS(description='The date when the purchase order gets cancelled.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (supplier_order_nr, supplier_order_pos_nr, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='The order placed by Lidl purchase department ( DE ) from a supplier to buy products');