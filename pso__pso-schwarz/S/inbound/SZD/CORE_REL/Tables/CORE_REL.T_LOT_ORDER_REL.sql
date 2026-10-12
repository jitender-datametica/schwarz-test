/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_ORDER_REL
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LOT_ORDER_REL (
   LOT_PRODUCT_INSTANCE_GROUP_SID      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the lot.',
   SAP_ORDER_NR                        VARCHAR(50)     NOT NULL COMMENT 'Sap Order Number associated with lot',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_LOT_ORDER_REL PRIMARY KEY (LOT_PRODUCT_INSTANCE_GROUP_SID, SAP_ORDER_NR, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'M:N Relation Entity - VMT is connected to a SAP ERP system, that can send  1..n (but usually 1-2) order numbers per lot for certain types of lots (port RTM, warehouse MOO). Source - VMT';
