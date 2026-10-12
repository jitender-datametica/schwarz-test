--==============================================================
-- Table: T_BOOKING
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_BOOKING
   generated from Powerdesigner on Donnerstag, 9. Februar 2023 14:16:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_BOOKING DATA_RETENTION_TIME_IN_DAYS = 0(
   BOOKING_ID                          NUMBER(38,0)    NOT NULL COMMENT 'Booking ID as technical surrogate key from source system',
   PLANT_RESOURCE_ITEM_SID             NUMBER(38,0)    NOT NULL COMMENT 'Id of the production plant',
   MATERIAL_RESOURCE_ITEM_SID          NUMBER(38,0)    NOT NULL COMMENT 'Id of the material (e.g. plasting in production plants)',
   WAREHOUSE_RESOURCE_ITEM_SID         NUMBER(38,0)    NOT NULL COMMENT 'Id of the stock (e.g. production)',
   MATERIAL_GROUP_RESOURCE_ITEM_SID    NUMBER(38,0)    NOT NULL COMMENT 'Id of the material group',
   BOOKING_DT                          DATE            NOT NULL COMMENT 'Date of booking',
   MATERIAL_MOVEMENT_TYPE_ID           NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier for the material movement type',
   SHIFT_ID                            NUMBER(38,0)    NOT NULL COMMENT 'Concatenated ID: shift_start_dt + shift_type_id as integer. Each day has 3 shifts.',
   ORIG_SHIFT_ID                       NUMBER(38,0)    NOT NULL COMMENT 'Concatenated ID: shift_start_dt + shift_type_id as integer. Each day has 3 shifts.',
   BOOKING_TMSP                        TIMESTAMP_TZ    NOT NULL COMMENT 'Descriptive Attribute - Timestamp of booking',
   BUSINESS_DT                         DATE            NOT NULL COMMENT 'Descriptive Attribute - Business day has separate from-to hour definition as natural day. Booking is assigned to business date as a temporary solution before shifts concept is designed. Regularly the business shifts will be from 06:00:00 am to to0 5:59:59 am of the next business date, in which 2-3 shifts takes place ',
   ORDER_ID                            NUMBER(38,0)    NOT NULL COMMENT 'Order ID as technical surrogate key from source system - only for building aggregate, not for enduser/reporting',
   MATERIAL_UNIT                       VARCHAR(50)     NOT NULL COMMENT 'Descriptive Attribute - Material unit ',
   MATERIAL_QTY                        NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - material amount used for production',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(250)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_BOOKING PRIMARY KEY (BOOKING_ID, PLANT_RESOURCE_ITEM_SID) NOT ENFORCED
 )  COMMENT= 'Transactional Facts - Periodic Snapshot  (5 Min) - capturing the bookings. Source - MES via Proleit ODS (views on SQLServer delivered via Azure Data Factory). The booking is a transaction during the production order. Lagger bookings possible if e.g. palletizer finishes palletizing after the order was finished. Booking happens in MES & deliver the info to SAP';

