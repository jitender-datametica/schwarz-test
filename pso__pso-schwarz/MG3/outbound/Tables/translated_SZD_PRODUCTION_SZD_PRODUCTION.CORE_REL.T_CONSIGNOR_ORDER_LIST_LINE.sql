CREATE OR REPLACE TABLE szd_production_core_rel.t_consignor_order_list_line (
trader_reference_nr STRING(250) NOT NULL
OPTIONS(description='Natural Key/Business Key - This is a reference assigned by the declarant for the goods covered by the declaration.'),
order_dt DATE NOT NULL
OPTIONS(description='Natural Key/Business Key - The date when the goods were ordered by the consignor.'),
item_position_seq INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The position number within the order (truck load)'),
product_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product (only for products from WWT).'),
customs_product_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the customs product (only for products from BEI).'),
origin_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the origin country of the product.'),
alcoholic_beverage_tax_rate_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the tax rate for alcoholic beverages within the country (only BEI).'),
invoice_finance_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the invoice.'),
invoice_position_finance_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the invoice position.'),
purchase_order_item_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The order position identifier. The first part describes the position of the product and the second part describes the position of the variant within the product.'),
product_nr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - The product number of the item (IAN for a product from WWT, SAP Item number for a product from BEI).'),
additional_cd STRING(50) NOT NULL OPTIONS(description='An additional code that is appended to the product number.'),
product_name STRING(100) OPTIONS(description='Descriptive Attribute - The name of product either from BEI or WWT.'),
net_weight_meas NUMERIC(29,5) NOT NULL OPTIONS(description='Fact - addtive - The net weight in KG of the goods.'),
gross_weight_meas NUMERIC(29,5) NOT NULL OPTIONS(description='Fact - addtive - The gross weight in KG of the goods.'),
weight_uom_id INTEGER NOT NULL OPTIONS(description='Id of the unit the weight is measured in.'),
allocation_cnt INTEGER NOT NULL OPTIONS(description='Fact - additive - Number of items in a carton.'),
packages_cnt INTEGER NOT NULL OPTIONS(description='Fact - additive - Number of packages/cartons.'),
packages_uom_id INTEGER NOT NULL OPTIONS(description='Id of the unit the packages are counted.'),
item_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - The item count (usually the product of allocation count and package count)'),
item_uom_id INTEGER NOT NULL OPTIONS(description='Id of the unit the items are counted.'),
net_val NUMERIC(29,5) NOT NULL OPTIONS(description='Fact - additive - The net value of the order position.'),
net_curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency of the net value.'),
original_amount_val NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The original amount of the order position as declared on the invoice (only BEI).'),
original_amount_curr_cd STRING(3) NOT NULL
OPTIONS(description='The code identifying the currency of the original amount (only BEI).'),
item_price_val NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The price of the item, uses the same currency as the net value (only WWT).'),
freight_cost_val NUMERIC(29,5) NOT NULL OPTIONS(description='Fact - additive - The amount of freight costs (only BEI).'),
freight_cost_curr_cd STRING(3) NOT NULL
OPTIONS(description='The code identifying the currency of the freight cost amount (only BEI).'),
insurance_cost_val NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The amount of insurance costs (only BEI).'),
insurance_cost_curr_cd STRING(3) NOT NULL
OPTIONS(description='The code identifying the currency of the insurance cost amount (only BEI).'),
license_cost_val NUMERIC(29,5) NOT NULL OPTIONS(description='Fact - additive - The amount of license costs (only BEI).'),
license_cost_curr_cd STRING(3) NOT NULL
OPTIONS(description='The code identifying the currency of the license cost amount (only BEI).'),
abv_pct NUMERIC(29,5) NOT NULL OPTIONS(description='Fact - non additive - Alcoholic percentage of a beverage.'),
inbound_item_nr STRING(250)
OPTIONS(description='Descriptive Attribute - A delivery position reference number (only BEI).'),
tax_indicator_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - A text containing information regarding the tax (only BEI).'),
article_variant_nr STRING(250)
OPTIONS(description='Descriptive Attribute - A article variant number from the source system (only BEI).'),
additional_codes_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - Additional code to the commodity code (customs tariff number) (only BEI).'),
gtin_nr STRING(250) OPTIONS(description='Descriptive Attribute - The B2B GTIN number of the article (only BEI).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
batch_nr STRING(50)
OPTIONS(description='Descriptive Attribute - The number of the batch the product is part of (only for products from WWT).'),
PRIMARY KEY (trader_reference_nr, order_dt, item_position_seq) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - This is a specific order position within the BEI consignor order list. - Source - BEI Report');