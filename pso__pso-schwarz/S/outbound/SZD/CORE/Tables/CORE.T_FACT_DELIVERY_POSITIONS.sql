/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_DELIVERY_POSITIONS
   generated from Powerdesigner on Freitag, 8. August 2025 13:28:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_delivery_positions (
delivery_nr STRING(250) NOT NULL
OPTIONS(description='Business/Natural Key - The unique business identifier of the delivery.'),
delivery_position_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Business/Natural Key - The unique business identifier of the position within the delivery.'),
transport_unit_nr STRING(250) NOT NULL
OPTIONS(description='Business/Natural Key - The unique identification number of the transport unit (either a container or a truck).'),
transport_unit_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code for the general type of the transport unit (CONTAINER or TRUCK)'),
transport_unit_type_name STRING(100)
OPTIONS(description='Descriptive Attribute - A descriptive name for the special type of the transport unit.'),
transport_unit_package_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The quantity of packages within the transport unit.'),
sales_variant_product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant.'),
delivery_target_name STRING(100)
OPTIONS(description='Descriptive Attribute - The name of the warehouse or store that is the target of the delivery.'),
etd_dt DATE OPTIONS(description='Descriptive Attribute - The estimated date of departure.'),
eta_dt DATE OPTIONS(description='Descriptive Attribute - The estimated date of arrival.'),
ata_dt DATE OPTIONS(description='Descriptive Attribute - Actual date of arrival.'),
arrival_dt DATE
OPTIONS(description='Descriptive Attribute - The date on which the goods were received by the recipient.'),
receipt_dt DATE OPTIONS(description='Descriptive Attribute - The date of the receipt.'),
sales_receipt_nr STRING(250) OPTIONS(description='Descriptive Attribute - The number of the internal sales receipt.'),
transport_identification_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The business identification number of the transport within the delivery.'),
shipment_nr_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - The business number of the shipment (can be a list of shipment numbers)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.'),
PRIMARY KEY (delivery_nr, delivery_position_nr, transport_unit_nr) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional Events - This table contains detailed informationen of delivery positions regarding their transportation (e.g. transported either by truck or container).  - Source - LExIS');