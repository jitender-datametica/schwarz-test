/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CUSTOMER_RETURN_PACKAGE_SHIPMENT_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 28. Februar 2023 14:39:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_customer_return_package_shipment_1 (
cust_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_pos_nr BIGNUMERIC NOT NULL OPTIONS(description='The particular position number of an item_1 in an order'),
cust_order_pos_seq_nr BIGNUMERIC NOT NULL
OPTIONS(description='In case a customer returns items from the same order position (ex 5 hats) in two different steps (two separate returns, or one return with two different packages ...) this column will contain consecutive number for each return per customer order position.'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
return_pack_sid BIGNUMERIC OPTIONS(description='The unique identifier(surrogate key) for the package_1 of the return'),
pack_tracking_nr STRING(100)
OPTIONS(description='ID, whcih links the shipment to customer with the actual package_1 and can also be searched for within the the carrier url'),
return_pack_tracking_nr STRING(100)
OPTIONS(description='ID, whcih links the shipment of the return (from customer to Lidl Digital) with the actual package_1 and can also be searched for within the the carrier url'),
return_request_nr STRING(20)
OPTIONS(description='Internal Return Request Number, created by Lidl when a customer creates a Returnr Request.  Not every Return Request is turned into Return Order'),
return_request_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of an item_1 in a return request '),
cust_order_return_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for return of customer order'),
cust_order_return_nr STRING(20) OPTIONS(description='An original return order number'),
cust_order_return_pos_nr BIGNUMERIC
OPTIONS(description='A number of an particular position ( product ) in an return order'),
request_create_dt DATE OPTIONS(description='Date when a return request is created by a customer'),
real_arrival_wh_dt DATE OPTIONS(description='Date when a return is received and registed back in the warehouse. '),
return_wh_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for the warehouse to which the return is sent'),
return_wh_cd STRING(5) OPTIONS(description='A short  unique code for warehouse to which the return is sent'),
origin_country_cd STRING(5)
OPTIONS(description='The unique code for a country_1 from which the customer sends back the package_1(s) (according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France)'),
hauler_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for hauler'),
hauler_name STRING(100)
OPTIONS(description='The name of the hauler (Carrier) used by the customer to sent back the shipment'),
hauler_pickup_ref_nr STRING(50)
OPTIONS(description='Reference created by Hauler (Carrier), when he issues a label and take the package_1 via Pickup'),
return_ship_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The shipping costs for lidl digital for each article included in a package_1 (only Return process)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_order_sid, cust_order_pos_nr, cust_order_pos_seq_nr) NOT ENFORCED
)
OPTIONS(description='A fact table that contains one row for every package_1 of return items sent back by a customer. Customer may place one order with one position for 5 T-shirts. Then he/she can return 2 t-shirts in one return packaged and 2 more shirts in another return package. ');