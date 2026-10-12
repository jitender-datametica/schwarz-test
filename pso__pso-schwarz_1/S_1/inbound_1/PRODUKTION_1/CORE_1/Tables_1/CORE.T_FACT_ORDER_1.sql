--==============================================================
-- Table: T_FACT_ORDER_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_ORDER_1
   generated from Powerdesigner on Donnerstag, 9. Februar 2023 14:16:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_ORDER_1 DATA_RETENTION_TIME_IN_DAYS = 0(
   ORDER_ID                            NUMBER(38,0)    NOT NULL COMMENT 'Order ID as technical surrogate key from source system',
   PRODUCTION_LINE_RESOURCE_ITEM_SID   NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line',
   MATERIAL_RESOURCE_ITEM_SID          NUMBER(38,0)    NOT NULL COMMENT 'Id of the material (e.g. plasting in production plants)',
   ORDER_START_DT                      DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   ORDER_END_DT                        DATE            COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   ORDER_NR                            NUMBER(38,0)    NOT NULL COMMENT 'Order number as natural key from source system',
   ORDER_START_TMSP                    TIMESTAMP_TZ    NOT NULL COMMENT 'Descriptive Attribute - Timestamp of order start. Production line start can be later (e.g. up to 2 days) after order start. Dependency: in automated plants if order is starting it starts the production line automatically, so order start = production line start. Otherwise is the process manually done by personal.',
   ORDER_END_TMSP                      TIMESTAMP_TZ    COMMENT 'Descriptive Attribute - Timestamp of order end / completion',
   PRODUCTION_LINE_START_TMSP          TIMESTAMP_TZ    COMMENT 'Descriptive Attribute - Timestamp of production plant start. Planned orders without start_time are also delivered',
   PRODUCTION_LINE_END_TMSP            TIMESTAMP_TZ    COMMENT 'Descriptive Attribute - Timestamp of production plant end',
   USE_FOR_OEE_FG                      BOOLEAN         NOT NULL COMMENT 'Flag serves for calculation of Overall Equipment Efficiency, which is valid for only non overlapping orders beeing produced on one production line in parallel. Not relevant for Plastic Plants but for Ice Cream. TRUE means no overlapping possible  & valid for OEE. FALSE means overlapping possible & more than 1 order on 1 prod-line can be produced. ',
   ORDER_AMOUNT_PLAN_QTY               NUMBER(38, 5)   NOT NULL COMMENT 'Fact - semi additive - Planned order quantity',
   ORDER_AMOUNT_ACTUAL_QTY             NUMBER(38, 5)   NOT NULL COMMENT 'Fact - semi additive - Actual order quantity',
   NOMINAL_CAPACITY_QTY                NUMBER(38, 5)   NOT NULL COMMENT 'Fact - non additive - nominal capacity of the order',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(250)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_FACT_ORDER PRIMARY KEY (ORDER_ID, PRODUCTION_LINE_RESOURCE_ITEM_SID, MATERIAL_RESOURCE_ITEM_SID) NOT ENFORCED
 )  COMMENT= 'Transactional Facts - Periodic Snapshot_1  (5 Min) - capturing the orders of the production line. Source - MES via Proleit ODS (views on SQLServer delivered via Azure Data Factory). Order is created & released in SAP, then it is activated/started in MES. Thereafter order will be delivered to plant system control & produced. Order serves as a reference for planing & material parts. Order switching/shifting can happen dependent on planning but only on month ending on 0:00 am.';

