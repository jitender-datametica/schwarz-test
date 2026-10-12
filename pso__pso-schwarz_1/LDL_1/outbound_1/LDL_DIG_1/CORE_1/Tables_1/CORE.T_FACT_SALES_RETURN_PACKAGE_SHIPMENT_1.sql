CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_sales_return_package_shipment_1 (
return_pack_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier(surrogate key) for the package_1 of the return'),
prod_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant being returned'),
return_request_nr STRING(50)
OPTIONS(description='Internal return request number, created by Lidl when a customer creates a return request.  Not every return request is turned into return order.'),
return_pack_tracking_nr STRING(1000)
OPTIONS(description='ID, which links the shipment of the return (from customer to Lidl Digital) with the actual package_1 and can also be searched for within the the carrier url'),
return_pack_tracking_url STRING(500) OPTIONS(description='URL to track the return package_1 shipment'),
sale_order_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the sales_1 order'),
sale_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
sale_order_pos_nr BIGNUMERIC(38,0) OPTIONS(description='The particular position number of an item_1 in an order'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
hauler_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for hauler'),
origin_country_cd STRING(5)
OPTIONS(description='The unique code for a country_1 from which the customer sends back the package_1(s) (according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France)'),
pack_size_handle_group_cd STRING(5)
OPTIONS(description='A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it -\' 1 person\'  ,\'2 persons\' etc'),
return_wh_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the warehouse handling the return.'),
return_option_cd STRING(50) OPTIONS(description='Return option of the shipment, it can be LABEL or PICK_UP.'),
return_request_tmsp TIMESTAMP
OPTIONS(description='Time when the return request was made by the customer.'),
return_request_dt DATE OPTIONS(description='Date when the return request was made by the customer.'),
handover_to_carrier_tmsp TIMESTAMP
OPTIONS(description='Time when the package_1 is handed over to the carrier.'),
handover_to_carrier_dt DATE OPTIONS(description='Date when the package_1 is handed over to the carrier.'),
first_intake_scan_hub_tmsp TIMESTAMP
OPTIONS(description='Time of first hub scan in return logistics.'),
first_intake_scan_hub_dt DATE OPTIONS(description='Date of first hub scan in return logistics.'),
return_hub_tmsp TIMESTAMP OPTIONS(description='Time when the package_1 is returned to carrier hub.'),
return_hub_dt DATE OPTIONS(description='Date when the package_1 is returned to carrier hub.'),
return_wh_tmsp TIMESTAMP
OPTIONS(description='Time when the package_1 is returned to the Lidl warehouse.'),
return_wh_dt DATE OPTIONS(description='Date when the package_1 is returned to the Lidl warehouse.'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product returned.'),
request_to_carrier_dur_day BIGNUMERIC(38,0)
OPTIONS(description='Duration in days between the return request from the customer and the handover of the package_1 to the carrier.'),
request_to_carrier_dur_hr NUMERIC(31,6)
OPTIONS(description='Duration in hours between the return request from the customer and the handover of the package_1 to the carrier.'),
carrier_to_hub_dur_day BIGNUMERIC(38,0)
OPTIONS(description='Duration in days between the handover of the package_1 to the carrier and the return of the package_1 to the carrier hub.'),
carrier_to_hub_dur_hr NUMERIC(31,6)
OPTIONS(description='Duration in hours between the handover of the package_1 to the carrier and the return of the package_1 to the carrier hub.'),
hub_to_wh_dur_day BIGNUMERIC(38,0)
OPTIONS(description='Duration in days between the arrival of the package_1 at the carrier hub and the arrival of the package_1 at the Lidl warehouse.'),
hub_to_wh_dur_hr NUMERIC(31,6)
OPTIONS(description='Duration in hours between the arrival of the package_1 at the carrier hub and the arrival of the package_1 at the Lidl warehouse.'),
carrier_to_wh_dur_day BIGNUMERIC(38,0)
OPTIONS(description='Duration in days between the handover of the package_1 to the carrier and its arrival at the Lidl warehouse.'),
carrier_to_wh_dur_hr NUMERIC(31,6)
OPTIONS(description='Duration in hours between the handover of the package_1 to the carrier and its arrival at the Lidl warehouse.'),
return_ship_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Lidl costs for shipping and transport (Return process)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
is_legacy_fg BOOL
OPTIONS(description='Technical field used to identify legacy data for further use as a filter condition. Legacy data used to come from SAP, and the current data comes from carrier layer.'),
return_paym_to_cust_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the payment is transferred to the customer in case of a returned item.'),
PRIMARY KEY (return_pack_sid, prod_variant_sid) NOT ENFORCED
)
OPTIONS(description='A fact table that contains one row for every package_1 of return items sent back by a customer. Customer may place one order with one position for 5 T-shirts. Then he/she can return 2 t-shirts in one return packaged and 2 more shirts in another return package. ');