/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_NOTIFICATION_POSITION_2
   generated from Powerdesigner on Donnerstag, 15. Mai 2025 14:46:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_DELIVERY_NOTIFICATION_POSITION_2 (
   INTERNAL_HANDLING_UNIT_NR           VARCHAR(250)    NOT NULL COMMENT 'Business/Natural Key - The internal identification number of the handling unit.',
   INTERNAL_HANDLING_UNIT_POS_NR       NUMBER(38, 0)   NOT NULL COMMENT 'Business/Natural Key - The position number within the handling unit.',
   PRODUCT_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   PACKAGED_BASE_QTY                   NUMBER(38, 5)   NOT NULL COMMENT 'The packaged base quantity that is notified to be delivered.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DELIVERY_NOTIFICATION_POSITION PRIMARY KEY (INTERNAL_HANDLING_UNIT_NR, INTERNAL_HANDLING_UNIT_POS_NR) NOT ENFORCED 
)  COMMENT = 'Bridge Table - The delivery notification position referes to a position within the handling unit_2 that will be notified to the receiver. - Source - LExIS';
