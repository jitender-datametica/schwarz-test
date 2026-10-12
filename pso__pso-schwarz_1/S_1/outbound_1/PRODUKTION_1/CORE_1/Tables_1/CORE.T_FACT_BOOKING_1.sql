--==============================================================
-- Table: T_FACT_BOOKING_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_BOOKING_1
   generated from Powerdesigner on Donnerstag, 9. Februar 2023 14:16:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_fact_booking_1 (
booking_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Booking ID as technical surrogate key from source system'),
plant_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production plant'),
material_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the material (e.g. plasting in production plants)'),
warehouse_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the stock (e.g. production)'),
material_group_resource_item_group_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the material groups'),
booking_dt DATE NOT NULL OPTIONS(description='Date of booking'),
material_movement_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier for the material movement type'),
shift_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Concatenated ID: shift_start_dt + shift_type_id as integer. Each day has 3 shifts.'),
orig_shift_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Concatenated ID: shift_start_dt + shift_type_id as integer. Each day has 3 shifts.'),
booking_tmsp TIMESTAMP NOT NULL OPTIONS(description='Descriptive Attribute - Timestamp of booking'),
business_dt DATE NOT NULL
OPTIONS(description='Descriptive Attribute - Business day has separate from-to hour definition as natural day. Booking is assigned to business date as a temporary solution before shifts concept is designed. Regularly the business shifts will be from 06:00:00 am to to0 5:59:59 am of the next business date, in which 2-3 shifts takes place '),
material_unit STRING(50) NOT NULL OPTIONS(description='Descriptive Attribute - Material unit_1 '),
material_qty BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - additive - material amount used for production'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(250)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (booking_id, plant_resource_item_sid) NOT ENFORCED
)
OPTIONS(description='Transactional Facts - Periodic Snapshot_1  (5 Min) - capturing the bookings. Source - MES via Proleit ODS (views on SQLServer delivered via Azure Data Factory). The booking is a transaction during the production order. Lagger bookings possible if e.g. palletizer finishes palletizing after the order was finished. Booking happens in MES & deliver the info to SAP');