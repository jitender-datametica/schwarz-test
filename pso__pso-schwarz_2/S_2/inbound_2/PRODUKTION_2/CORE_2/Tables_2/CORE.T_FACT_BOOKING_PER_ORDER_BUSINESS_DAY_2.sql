--==============================================================
-- Table: T_FACT_BOOKING_PER_ORDER_BUSINESS_DAY_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_BOOKING_PER_ORDER_BUSINESS_DAY_2
   generated from Powerdesigner on Mittwoch, 20. September 2023 16:15:15
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_BOOKING_PER_ORDER_BUSINESS_DAY_2 (
   PRODUCTION_LINE_RESOURCE_ITEM_SID   NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line',
   MATERIAL_GROUP_RESOURCE_ITEM_GROUP_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the material groups',
   BOOKING_BUSINESS_DT                 DATE            NOT NULL COMMENT 'Business day of booking. Has separate from-to hour definition as natural day. Booking is assigned to business date as a temporary solution before shifts concept is designed. Regularly the business shifts will be from 06:00:00 am to to0 5:59:59 am of the next business date, in which 2-3 shifts takes place ',
   MOVEMENT_TYPE_ID                    NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier for the movement type',
   ORDER_ID                            NUMBER(38,0)    NOT NULL COMMENT 'Order ID as technical surrogate key from source system',
   MATERIAL_RESOURCE_ITEM_SID          NUMBER(38,0)    NOT NULL COMMENT 'Id of the material (e.g. plasting in production plants)',
   ORDER_START_DT                      DATE            NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   ORDER_END_DT                        DATE            COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   ORDER_NR                            NUMBER(38,0)    NOT NULL COMMENT 'Order number as natural key from source system',
   ORDER_START_TMSP                    TIMESTAMP_TZ(9) NOT NULL COMMENT 'Descriptive Attribute - Timestamp of order start',
   ORDER_END_TMSP                      TIMESTAMP_TZ(9) COMMENT 'Descriptive Attribute - Timestamp of order end / completion',
   PRODUCTION_LINE_START_TMSP          TIMESTAMP_TZ(9) NOT NULL COMMENT 'Descriptive Attribute - Timestamp of production plant start. Planned orders without start_time are NOT delivered',
   PRODUCTION_LINE_END_TMSP            TIMESTAMP_TZ(9) COMMENT 'Descriptive Attribute - Timestamp of production plant end',
   MAX_BOOKING_TMSP                    TIMESTAMP_TZ(9) NOT NULL COMMENT 'Descriptive Attribute - Timestamp of the last delivered booking in the order. Dependent on the production process it may happen that order is finished earlier as the last booking_tmsp is transmitted.',
   CONSUMED_MATERIAL_QTY               NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - consumed material quantity per order / movement type / material group',
   PRODUCED_MATERIAL_QTY               NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - produced material quantity per order / movement type / material group',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_FACT_BOOKING_PER_ORDER_BUSINESS_DAY PRIMARY KEY (PRODUCTION_LINE_RESOURCE_ITEM_SID, ORDER_ID, MATERIAL_GROUP_RESOURCE_ITEM_GROUP_SID, BOOKING_BUSINESS_DT, MOVEMENT_TYPE_ID, MATERIAL_RESOURCE_ITEM_SID) NOT ENFORCED
 )  COMMENT= 'Fact Table - Analytical - Granularity - 5 Min (updating cycle) per Business Day of Booking & Movement Type & Material Group & Order & Production Line - Aggregate - capturing the bookings with their consumed & produced material amounts & corresponding. Orders & depending production line are started - Source - Facts for booking & order';
