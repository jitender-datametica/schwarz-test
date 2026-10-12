/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_LOT_SHIPMENT_MILESTONE_2
   generated from Powerdesigner on Freitag, 2. August 2024 08:21:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_LOT_SHIPMENT_MILESTONE_2 DATA_RETENTION_TIME_IN_DAYS = 7 (
   LOT_PRODUCT_INSTANCE_GROUP_SID      NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The unique identifier (surrogate key) for the lot.',
   LOT_MILESTONE_CD                    VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - A milestone is an event in the lot lifecycle. Table contains the list of the possible events',
   EVENT_TMSP                          TIMESTAMP_TZ(9) NOT NULL COMMENT 'The timestamp when the event took place',
   LOT_MILESTONE_RESULT_CD             VARCHAR(50)     NOT NULL COMMENT 'A milestone is an event in the lot lifecycle. Table contains the list of the possible events',
   EVENT_DT                            DATE            NOT NULL COMMENT 'Natural Key/Business Key - A date when measurement was taken',
   MILESTONE_DT                        DATE            COMMENT 'Business date of a milestone (e.g. date when gas measurement was done)',
   DUE_DT                              DATE            COMMENT 'Due date of a milestone',
   DONE_DT                             DATE            COMMENT 'Done date of milestone (date when system receives the data)',
   LOT_MILESTONE_RESULT_EVALUATION_DT  DATE            COMMENT 'Event Result represented as a date',
   LOT_MILESTONE_RESULT_EVALUATION_TXT VARCHAR(1000)   COMMENT 'Descriptive attribute - Text  Description of Lot Event Result',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_FACT_LOT_SHIPMENT_MILESTONE PRIMARY KEY (LOT_PRODUCT_INSTANCE_GROUP_SID, LOT_MILESTONE_CD, EVENT_TMSP) NOT ENFORCED 
)  COMMENT = 'Fact table - Transactional Events - Transaction - A milestone is an event in the lot lifecycle. There are around 60 milestones in VMT such as "shipment release" or "producer booking". Some milestones are triggered by external events/interfaces, others resolved by manual actions. - Source - VMT';
