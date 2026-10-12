/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_RVM_REJECT_REASON_1
   generated from Powerdesigner on Freitag, 16. Mai 2025 14:07:34
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_RVM_REJECT_REASON_1 (
   REJECT_REASON_SOURCE_ID             NUMBER(38,0)    NOT NULL COMMENT 'The Unique Identifier for the rejection reason for the deposited articles.',
   REJECT_REASON_GROUP_CD              NUMBER(38, 0)   NOT NULL COMMENT 'The Identifier for the group of rejection reasons.',
   DEPOSIT_ITEM_CAT_CD                 VARCHAR(50)     NOT NULL COMMENT 'The category of the deposit item_1 i.e. refillable, non-refillable',
   MANUFACTURER_SID                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a company which produces deposit machines.',
   REJECT_REASON_SOURCE_CD             VARCHAR(100)     NOT NULL COMMENT 'The free text code for the rejection reason from the source for the deposited articles.',
   REJECT_REASON_SOURCE_DESCR          VARCHAR(250)    NOT NULL COMMENT 'The description for the rejection reason from the source for the deposited articles.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_T_DIM_RVM_REJECT_REASON PRIMARY KEY (REJECT_REASON_SOURCE_ID) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - Describes the rejection reasons from the source for the deposited articles in a Deposit Machine - Source - S-File from a Deposit Machine';
