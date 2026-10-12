--==============================================================
-- Table: T_FACT_BOOKING_PER_ORDER_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_BOOKING_PER_ORDER_1
   generated from Powerdesigner on Monday, November 29, 2021 11:23:56 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_BOOKING_PER_ORDER_1 (
   ORDER_ID                            NUMBER(38,0)    NOT NULL COMMENT 'Order ID as technical surrogate key from source system',
   PRODUCTION_LINE_RESOURCE_ITEM_SID   NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line',
   MATERIAL_GROUP_RESOURCE_ITEM_SID    NUMBER(38,0)    NOT NULL COMMENT 'Id of the material groups',
   MOVEMENT_TYPE_ID                    NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier for the movement type',
   MATERIAL_RESOURCE_ITEM_SID          NUMBER(38,0)    NOT NULL COMMENT 'Id of the material (e.g. plasting in production plants)',
   ORDER_START_DT                      DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   ORDER_END_DT                        DATE            COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   ORDER_NR                            NUMBER(38,0)    NOT NULL COMMENT 'Order number as natural key from source system',
   ORDER_START_TMSP                    TIMESTAMP_TZ    NOT NULL COMMENT 'Descriptive Attribute - Timestamp of order start',
   ORDER_END_TMSP                      TIMESTAMP_TZ    COMMENT 'Descriptive Attribute - Timestamp of order end / completion',
   PRODUCTION_LINE_START_TMSP          TIMESTAMP_TZ    NOT NULL COMMENT 'Descriptive Attribute - Timestamp of production plant start. Planned orders without start_time are NOT delivered',
   PRODUCTION_LINE_END_TMSP            TIMESTAMP_TZ    COMMENT 'Descriptive Attribute - Timestamp of production plant end',
   CONSUMED_MATERIAL_QTY               NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - consumed material quantity per order / movement type / material group',
   PRODUCED_MATERIAL_QTY               NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - produced material quantity per order / movement type / material group',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ   NOT NULL COMMENT 'The extraction timestamp of the record from the source'
)COMMENT = 'Analytical Facts - Aggregate - Granularity 5 Min (updating cycle) per Order & Movement Type & Material Group - capturing the bookings per order with their consumed & produced material amounts. Orders & depending production line are started.';

