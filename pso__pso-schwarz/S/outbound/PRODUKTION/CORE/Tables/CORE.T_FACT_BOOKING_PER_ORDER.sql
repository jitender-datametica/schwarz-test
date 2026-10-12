--==============================================================
-- Table: T_FACT_BOOKING_PER_ORDER
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_BOOKING_PER_ORDER
   generated from Powerdesigner on Monday, November 29, 2021 11:23:56 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_fact_booking_per_order (
order_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Order ID as technical surrogate key from source system'),
production_line_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production line'),
material_group_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the material groups'),
movement_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier for the movement type'),
material_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the material (e.g. plasting in production plants)'),
order_start_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
order_end_dt DATE
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
order_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Order number as natural key from source system'),
order_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Descriptive Attribute - Timestamp of order start'),
order_end_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - Timestamp of order end / completion'),
production_line_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Descriptive Attribute - Timestamp of production plant start. Planned orders without start_time are NOT delivered'),
production_line_end_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - Timestamp of production plant end'),
consumed_material_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - consumed material quantity per order / movement type / material group'),
produced_material_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - produced material quantity per order / movement type / material group'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source')
)
OPTIONS(description='Analytical Facts - Aggregate - Granularity 5 Min (updating cycle) per Order & Movement Type & Material Group - capturing the bookings per order with their consumed & produced material amounts. Orders & depending production line are started.');