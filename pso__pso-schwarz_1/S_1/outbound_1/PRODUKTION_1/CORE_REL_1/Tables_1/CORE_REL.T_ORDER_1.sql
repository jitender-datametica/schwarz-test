--==============================================================
-- Table: T_ORDER_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_ORDER_1
   generated from Powerdesigner on Donnerstag, 9. Februar 2023 14:16:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core_rel.t_order_1 (
order_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Order ID as technical surrogate key from source system'),
production_line_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production line'),
material_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the material (e.g. plasting in production plants)'),
order_start_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
order_end_dt DATE
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
order_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Order number as natural key from source system'),
order_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Descriptive Attribute - Timestamp of order start. Production line start can be later (e.g. up to 2 days) after order start. Dependency: in automated plants if order is starting it starts the production line automatically, so order start = production line start. Otherwise is the process manually done by personal.'),
order_end_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - Timestamp of order end / completion'),
production_line_start_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - Timestamp of production plant start'),
production_line_end_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - Timestamp of production plant end'),
use_for_oee_fg BOOL NOT NULL
OPTIONS(description='Flag serves for calculation of Overall Equipment Efficiency, which is valid for only non overlapping orders beeing produced on one production line in parallel. Not relevant for Plastic Plants but for Ice Cream. TRUE means no overlapping possible  & valid for OEE. FALSE means overlapping possible & more than 1 order on 1 prod-line can be produced. '),
order_amount_plan_qty BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - semi additive - Planned order quantity'),
order_amount_actual_qty BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - semi additive - Actual order quantity'),
nominal_capacity_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - non additive - nominal capacity of the order'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(250)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (order_id, production_line_resource_item_sid, material_resource_item_sid) NOT ENFORCED
)
OPTIONS(description='Transactional Facts - Periodic Snapshot_1  (5 Min) - capturing the orders of the production line. Source - MES via Proleit ODS (views on SQLServer delivered via Azure Data Factory). Order is created & released in SAP, then it is activated/started in MES. Thereafter order will be delivered to plant system control & produced. Order serves as a reference for planing & material parts. Order switching/shifting can happen dependent on planning but only on month ending on 0:00 am.');