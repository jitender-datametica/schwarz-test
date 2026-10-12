/* --------------------------------------------------------------------------------
   DDL for table: T_EXTERNAL_DELIVERY_POSITION
   generated from Powerdesigner on Donnerstag, 28. November 2024 11:30:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_external_delivery_position (
delivery_nr STRING(50) NOT NULL OPTIONS(description='The business identifier of the delivery.'),
position_nr STRING(50) NOT NULL OPTIONS(description='The number of the position within the delivery.'),
event_dt DATE NOT NULL OPTIONS(description='The date on with the transaction takes place.'),
original_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location.'),
product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The surrogate key of the product references from this position.'),
sales_receipt_nr STRING(250) NOT NULL
OPTIONS(description='The business number of the sales receipt this delivery is connected to.'),
sales_receipt_position_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The position number on the receipt'),
goods_movement_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the movement type for goods.'),
delivered_sales_unit_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The quantity that was actually delivered.measured in sales units.'),
delivered_store_unit_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The quantity that was actually delivered measured in store units.'),
original_qty BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - additive - The original quantity of this position.'),
base_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Descriptive attribute - The code identifying the base unit of measure.'),
sales_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Descriptive attribute - The code identifying the unit of measure.'),
conversion_factor_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - non-additive - A conversion factor for calculating the delivery quantity based on the sales quantity.'),
net_weight_meas BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - additive - The net weight of the goods.'),
net_weight_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unit of measure for the net weight'),
gross_weight_meas BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - additive - The gross weight of the goods.'),
gross_weight_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unit of measure for the gross weight.'),
volume_meas BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - additive - The volume in space the goods take up'),
volume_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unit of measure for the volume'),
item_provision_dt DATE OPTIONS(description='The date of provisioning of the item(s).'),
gtin_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Descriptive attribute - The global GTIN number (EAN11)'),
return_position_fg BOOL NOT NULL OPTIONS(description='A flag indicating that this position is a return.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (delivery_nr, position_nr, event_dt) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - This event describes a position of special product within the delivery of goods from an external supplier.');