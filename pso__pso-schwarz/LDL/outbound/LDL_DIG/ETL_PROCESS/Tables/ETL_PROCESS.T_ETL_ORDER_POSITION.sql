CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_order_position (
cust_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_create_tmsp TIMESTAMP
OPTIONS(description='The date and time when order was created in source system ( is used in reporting)'),
prod_variant_sid BIGNUMERIC OPTIONS(description='Ordered product'),
cust_order_nr STRING(20) NOT NULL OPTIONS(description='The original order number of the source system'),
cust_order_pos_nr BIGNUMERIC NOT NULL OPTIONS(description='The particular position number of an item in an order'),
reference_document_order_sid BIGNUMERIC OPTIONS(description='The unique identifier for the reference document order'),
reference_document_order_nr STRING(20) OPTIONS(description='The original order number of the reference document'),
reference_document_order_pos_nr BIGNUMERIC
OPTIONS(description='The particular order position number of the reference document'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered'),
bundle_header_pos_nr BIGNUMERIC
OPTIONS(description='In case of a line being a composition part of the bundle-header (see bundle header code field), it can be allocated with this field to its header item'),
curr_cd STRING(5) OPTIONS(description='Currency code in which order has been payed'),
prod_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net price of a product in local currency'),
prod_price_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) vat value on price of a product in local currency'),
prod_price_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='The gross local price of the product sold to customers OR the Intercompany price invoiced to the selling partner'),
prod_coupon_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='The net discount value for the (original/listed) product in local currency'),
prod_coupon_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='The gross discount value for the (original/listed) product in local currency'),
prod_coupon_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='The discount vat value for the (original/listed) product in local currency'),
cogs_price_net_local_val BIGNUMERIC(38,5) OPTIONS(description='Cost of Goods sold'),
delivery_cost_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Article specific gross delivery cost in local currency. This cost is optional and mostly article dependent. An example is a fridge which has additional delivery costs.'),
delivery_coupon_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='The net discount value for article specific delivery costs in local currency.'),
delivery_coupon_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='The gross discount value for article specific delivery costs in local currency.'),
delivery_coupon_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='The discount vat value for article specific delivery costs in local currency'),
delivery_paushal_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='A paushal for delivery costs splitted per every order position in netto and local currency'),
delivery_paushal_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='A paushal for delivery costs splitted per every order position in gross and local currency'),
delivery_paushal_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='The vat value of the paushal delivery costs splitted per every order position in local currency'),
add_delivery_paushal_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Additional gross delivery fee/paushal for special destinations (Distribution Zones),  splitted per every order position in local currency'),
add_delivery_paushal_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Additional vat on delivery fee/paushal for special destinations (Distribution Zones),  splitted per every order position in local currency'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
delivery_paushal_coupon_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount value gross for paushal delivery cost splitted per every order position in local currency'),
tax_class_cd STRING(5) OPTIONS(description='The code identifying the tax class'),
order_cancel_reason_cd STRING(5)
OPTIONS(description='The code for reason why the customer has cancelled or got been cancelled an order line/product'),
is_order_cancel_fg BOOL
OPTIONS(description='Flag telling whether the order has been cancelled by the customer or Lidl Digital'),
is_order_migrated_fg BOOL OPTIONS(description='An indicator showing whether the order is migrated or not'),
cust_delivery_tgt_dt DATE
OPTIONS(description='The first date which has been communicated to the customer until when the shipment is meant to arrive'),
cust_order_return_create_tmsp TIMESTAMP OPTIONS(description='Creation timestamp of the return. '),
wh_sid BIGNUMERIC
OPTIONS(description='The unique identifier (sk) for the warehouse from where particular product will be sent'),
wh_cd STRING(5) OPTIONS(description='The code for the warehouse from where particular product will be sent'),
prod_assortment_class_cd STRING(5) OPTIONS(description='The code for the product assortment classification'),
dropshipment_order_fg BOOL
OPTIONS(description='In case the material is being sent from the supplier this field will be filled.'),
shipping_point_cd STRING(5) OPTIONS(description='The code for the shipping point'),
return_reason_cd STRING(5) OPTIONS(description='The code for the return reason'),
delivery_src_type_cd STRING(5)
OPTIONS(description='The code for source location of product from where it is delivered i.e. from supplier or warehouse directly'),
delivery_status_cd STRING(5) OPTIONS(description='Code for the delivery status of the item'),
delivery_status_nr BIGNUMERIC OPTIONS(description='Generated number for the code for the delivery status of the item'),
overall_delivery_status_for_item_cd STRING(5) OPTIONS(description='Code for the overall delivery status of the item'),
overall_delivery_status_for_item_nr BIGNUMERIC
OPTIONS(description='Generated number for the code for the overall delivery status of the item'),
lead_src_log_sys_cd STRING(100) OPTIONS(description='Technical field - source code'),
lead_src_name STRING(100) OPTIONS(description='Technical field - source name '),
prod_condition_cd STRING(20)
OPTIONS(description='The condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping)'),
invoice_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Net value amount visible on the invoice. It is the net total considering all the different order positions and their respective price conditions (in case of cust_order -> sum of all different conditions, in case of internal processes what it is been paid via invoice)'),
invoice_price_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Gross value amount visible on the invoice. It is the gross total considering all the different order positions and their respective price conditions (in case of cust_order -> sum of all different conditions, in case of internal processes what it is been paid via invoice)'),
invoice_price_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='VAT value amount visible on the invoice. It is the VAT total considering all the different order positions and their respective price conditions (in case of cust_order -> sum of all different conditions, in case of internal processes what it is been paid via invoice)'),
add_delivery_paushal_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Additional net delivery fee/paushal for special destinations (Distribution Zones),  splitted per every order position in local currency.'),
cust_order_perform_dt DATE
OPTIONS(description='Date when goods leave the warehouse for delivery to the customer. It serves as the legal and fiscal date for fulfilling a customer\'s order. This date is mandatory for OSES migrated sales orders, where it is always populated from SAP.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
PRIMARY KEY (cust_order_sid, cust_order_pos_nr) NOT ENFORCED
)
OPTIONS(description='The order placed from a customer within the onlineshop to receive the wanted items. Such orders can be also cancelled, returned or free resends to customers.');