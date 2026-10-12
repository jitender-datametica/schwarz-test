/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_RVM_REJECT_REASON_GROUP
   generated from Powerdesigner on Freitag, 16. Mai 2025 14:08:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_RVM_REJECT_REASON_GROUP (
   REJECT_REASON_GROUP_ID              NUMBER(38, 0)   NOT NULL COMMENT 'The code for the group of rejection reasons.',
   REJECT_REASON_GROUP_DESCR           VARCHAR(250)    NOT NULL COMMENT 'A textual default description for the group of rejection reasons in German.',
   REJECT_REASON_GROUP_DESCR_DE        VARCHAR(250)    NOT NULL COMMENT 'A textual description for the group of rejection reasons in German.',
   REJECT_REASON_GROUP_DESCR_EN        VARCHAR(250)    NOT NULL COMMENT 'A textual description for the group of rejection reasons in English.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_T_DIM_RVM_REJECT_REASON_GROUP PRIMARY KEY (REJECT_REASON_GROUP_ID) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - Describes the groups for rejection reasons for the deposited articles in a Deposit Machine - Source - Manual';
