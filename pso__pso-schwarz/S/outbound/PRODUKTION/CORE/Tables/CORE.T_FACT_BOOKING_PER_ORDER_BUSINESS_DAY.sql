--==============================================================
-- Table: T_FACT_BOOKING_PER_ORDER_BUSINESS_DAY
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_BOOKING_PER_ORDER_BUSINESS_DAY
   generated from Powerdesigner on Mittwoch, 20. September 2023 16:15:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_fact_booking_per_order_business_day (
production_line_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production line'),
material_group_resource_item_group_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the material groups'),
booking_business_dt DATE NOT NULL
OPTIONS(description='Business day of booking. Has separate from-to hour definition as natural day. Booking is assigned to business date as a temporary solution before shifts concept is designed. Regularly the business shifts will be from 06:00:00 am to to0 5:59:59 am of the next business date, in which 2-3 shifts takes place '),
movement_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier for the movement type'),
order_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Order ID as technical surrogate key from source system'),
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
max_booking_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Descriptive Attribute - Timestamp of the last delivered booking in the order. Dependent on the production process it may happen that order is finished earlier as the last booking_tmsp is transmitted.'),
consumed_material_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - consumed material quantity per order / movement type / material group'),
produced_material_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - produced material quantity per order / movement type / material group'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (production_line_resource_item_sid, order_id, material_group_resource_item_group_sid, booking_business_dt,
 movement_type_id, material_resource_item_sid) NOT ENFORCED
)
OPTIONS(description='Fact Table - Analytical - Granularity - 5 Min (updating cycle) per Business Day of Booking & Movement Type & Material Group & Order & Production Line - Aggregate - capturing the bookings with their consumed & produced material amounts & corresponding. Orders & depending production line are started - Source - Facts for booking & order');