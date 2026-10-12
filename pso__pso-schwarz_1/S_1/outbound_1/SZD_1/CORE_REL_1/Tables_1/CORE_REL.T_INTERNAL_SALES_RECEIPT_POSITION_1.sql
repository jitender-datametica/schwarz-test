/* --------------------------------------------------------------------------------
   DDL for table: T_INTERNAL_SALES_RECEIPT_POSITION_1
   generated from Powerdesigner on Donnerstag, 28. November 2024 11:30:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_internal_sales_receipt_position_1 (
sales_receipt_nr STRING(250) NOT NULL
OPTIONS(description='The business number of the sales_1 receipt this delivery is connected to.'),
sales_receipt_position_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The position number on the receipt'),
event_dt DATE NOT NULL OPTIONS(description='The timestamp when the transaction happens'),
product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant.'),
input_product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant.'),
price_product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant.'),
submitting_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the political country.'),
receiving_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the political country.'),
distribution_nr STRING(250) OPTIONS(description='The business number of the distribution.'),
distribution_position_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number of the position of the delivery.'),
position_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive attribute - short text describing the article of this position on the receipt'),
conversion_factor_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - non-additive - The conversion factor to calculate the base quantity unit_1 from the sales_1 quantity unit_1'),
net_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - semi-additive - The net value of this receipt position using the receipt currency'),
order_qty BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - additive - The quantity defined in the order.'),
delivery_qty BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - additive - The expected quantity of the delivery.'),
confirmed_sales_unit_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The confirmed quantity measured in  sales_1 unit_1 of measure.'),
confirmed_base_unit_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The confirmed quantity measured in base unit_1 of measure.'),
gross_weight_meas BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - The gross weight of the position.'),
net_weight_meas BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - The net weight of the position.'),
volume_qty BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - The quantity of the volume of the position.'),
net_price_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - semi-additive - The net price of the product of this position.'),
accounting_group_cd STRING(50) NOT NULL OPTIONS(description='The code identifying the accounting group.'),
subtotal_1_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - semi-additive - The first subtotal amount from the calculation schema.'),
subtotal_2_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - semi-additive - The second subtotal amount from the calculation schema.'),
subtotal_3_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - semi-additive - The third subtotal amount from the calculation schema.'),
subtotal_4_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - semi-additive - The fourth subtotal amount from the calculation schema.'),
created_delivery_dt DATE
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
promised_delivery_dt DATE
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
promised_delivery_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The promised quantity to be delivered measured in sales_1 units.'),
requested_qty BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - additive - The quantity requested by the recipient'),
package_type_cd STRING(50) NOT NULL
OPTIONS(description='Descriptive attribute - code that descripbes the type of packaging, currently only value is "Y001"'),
customer_reference_nr STRING(250) OPTIONS(description='Descriptive attribute - a text referencing the customer.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (sales_receipt_nr, sales_receipt_position_nr, event_dt) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Contains a position of a receipt for the internal sale of goods to stores from the LExIS system. - Source - Lexis');