CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_customer_goodwill_line_2 (
cust_order_goodwill_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the goodwill of customer order            The unique identifier (surrogate key) for the goodwill of customer order'),
cust_order_goodwill_pos_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='A number of an particular position (product) in the goodwill order'),
wshop_cd STRING(5) OPTIONS(description='The unique code for the Lidl webshop'),
cust_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_pos_nr BIGNUMERIC(38,0) OPTIONS(description='The particular position number of an item_2 in an order'),
prod_variant_sid BIGNUMERIC OPTIONS(description='A product in the goodwill'),
prod_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
cust_order_type_cd STRING(5)
OPTIONS(description='This field contains codes for two credit notes: ZCGW for price reduction/compensation (for goodwill credit note) and ZCMR for item_2 refund (value credit note)'),
cust_paym_method_cd STRING(5) OPTIONS(description='Unique code of the payment method'),
delivery_addr_sid BIGNUMERIC
OPTIONS(description='The unique identifier (sk) for the delivery address_2 where original order was delivered'),
billing_addr_sid BIGNUMERIC OPTIONS(description='The unique identifier (sk) for the billing address_2'),
goodwill_reason_cd STRING(5) OPTIONS(description='The code for the goodwill reason.'),
cust_order_goodwill_nr STRING(20) OPTIONS(description='An original goodwill order number'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
cust_order_goodwill_create_tmsp TIMESTAMP
OPTIONS(description='Creation timestamp of the goodwill.'),
cust_order_create_tmsp TIMESTAMP
OPTIONS(description='The timestamp when order was created in source system ( is used in reporting)'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_2 independent'),
cust_order_dt DATE OPTIONS(description='The date when order was made'),
cust_order_goodwill_dt DATE OPTIONS(description='The date when goodwill was made'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product in the goodwill'),
is_ghost_pack_fg BOOL
OPTIONS(description='Indicator if the package_2 was lost during the transfer process from the warehouse to the logistics company (carrier).'),
is_pack_lost_by_hauler_fg BOOL
OPTIONS(description='Indicator if the package_2 was lost during the transfer process from the logistics company (hauler) to the customer.'),
prod_price_goodwill_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the product price (net in local currency)'),
prod_price_goodwill_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the product price (gross in local currency)'),
prod_price_goodwill_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the VAT of the product price (local currency)'),
prod_coupon_goodwill_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the discount coupon value (net in local currency)'),
prod_coupon_goodwill_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the discount coupon value  (gross in local currency)'),
prod_coupon_goodwill_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the VAT of the discount coupon value (local currency)'),
delivery_cost_goodwill_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the delivery costs for the product (net in local currency). This cost is optional and mostly article dependent. An example is a fridge which has additional delivery costs.'),
delivery_cost_goodwill_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the delivery costs for the product (gross in local currency). This cost is optional and mostly article dependent. An example is a fridge which has additional delivery costs.'),
delivery_cost_goodwill_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the delivery vat value for the product in local currency. This tax value is optional and mostly article dependent. An example is a fridge which has additional delivery costs for which taxes might have to be paid.'),
delivery_paushal_goodwill_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the paushal for delivery costs specific to the product (net in local currency).'),
delivery_paushal_goodwill_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the paushal for delivery costs specific to the product (gross in local currency).'),
delivery_paushal_goodwill_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the VAT value of the paushal delivery costs specific to the product (in local currency).'),
add_delivery_paushal_goodwill_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the additional net delivery fee/paushal for special destinations (Distribution Zones),  splitted per every order position in local currency.'),
add_delivery_paushal_goodwill_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the additional gross delivery fee/paushal for special destinations (Distribution Zones),  splitted per every order position in local currency'),
add_delivery_paushal_goodwill_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the additional vat on delivery fee/paushal for special destinations (Distribution Zones),  splitted per every order position in local currency'),
delivery_paushal_coupon_goodwill_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the discount value net for paushal delivery cost specific to the product (in local currency).'),
delivery_paushal_coupon_goodwill_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the discount value gross for paushal delivery cost specific to the product (in local currency).'),
delivery_paushal_coupon_goodwill_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill amount from the discount vat value for paushal delivery cost specific to the product (in local currency).'),
add_services_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill vat amount for Additional services in local currency. This cost is optional and mostly article dependent.'),
add_services_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill gross amount for Additional services in local currency. This cost is optional and mostly article dependent.'),
add_services_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Goodwill net amount for Additional services in local currency. This cost is optional and mostly article dependent.'),
dropshipment_order_fg BOOL
OPTIONS(description='In case the material is being sent from the supplier_2 this field will be filled.'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
dist_channel_type_cd STRING(5)
OPTIONS(description='A  type of distribution channel ( Wshop for LD Webshop , IC for Intercompany)'),
dist_country_cd STRING(5)
OPTIONS(description='The unique code for a country_2 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
dist_zone_cd STRING(5) OPTIONS(description='The unique code for a distribution zone ( f.e. BAL , CAN, etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_order_goodwill_sid, cust_order_goodwill_pos_nr) NOT ENFORCED
)
OPTIONS(description='The goodwill is a situation when a certain amount was returned to the customer from his paid order by an onlineshop without the customer having to return the good (e.g. damaged item_2). Table contain information about details of individual goodwill cases.');