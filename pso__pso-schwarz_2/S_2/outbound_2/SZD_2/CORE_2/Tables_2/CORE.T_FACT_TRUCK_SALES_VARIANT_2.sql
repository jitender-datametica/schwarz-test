/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_TRUCK_SALES_VARIANT_2
   generated from Powerdesigner on Mittwoch, 30. Juli 2025 14:18:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_truck_sales_variant_2 (
delivery_nr STRING(250) NOT NULL OPTIONS(description='Business/Natural key - The business identifier of the delivery.'),
distribution_nr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - The business number of the distribution.'),
sales_variant_product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant.'),
hauler_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hauler (carrier )'),
receipt_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the recipient.'),
delivery_note_nr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - External delivery identification note number.'),
actual_delivery_dt DATE OPTIONS(description='Descriptive Attribute - The date when the goods are delivered.'),
planned_goods_movement_dt DATE
OPTIONS(description='Descriptive Attribute - The planned date of the movement of the goods.'),
promotion_dt DATE OPTIONS(description='Descriptive Attribute - The date of promotion.'),
chargeback_min_dt DATE OPTIONS(description='Descriptive Attribute - Minimum date of charge back.'),
min_wave_delivery_dt DATE
OPTIONS(description='Descriptive Attribute - The minimum delivery date of the of the delivery wave.'),
decommissioning_month BIGNUMERIC(38,0)
OPTIONS(description='Descriptive Attribute - The month of decommisioning in the format of YYMM (e.g. 1707 for July 2017).'),
lidl_delivery_week_fixed_fg BOOL
OPTIONS(description='Descriptive Attribute - Flag indicating if the delivery week is fixed.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.'),
PRIMARY KEY (delivery_nr, distribution_nr) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional Events - This table contains detailed informationen of transactions of materials delivered by trucks  - Source - LExIS');