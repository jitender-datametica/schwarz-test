/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_DESTINATION
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LOT_DESTINATION (
   LOT_PRODUCT_INSTANCE_GROUP_SID      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the lot.',
   SHIPPING_DESTINATION_CD             VARCHAR(50)     NOT NULL COMMENT 'The code identifying a political country according to ISO 3166.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   DELIVERY_WEEK_START_DT              DATE            COMMENT 'Descriptive Attribute - Delivery week of country (ODW)',
   SHIFTED_DELIVERY_WEEK_START_DT      DATE            COMMENT 'Descriptive Attribute - ODW (official delivery week) plus x weeks ("shifted" ODW)',
   SHIPPING_MARK_TXT                   VARCHAR(1000)   COMMENT 'Descriptive Attribute - Logistics info code sent from SAP',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_LOT_DESTINATION PRIMARY KEY (LOT_PRODUCT_INSTANCE_GROUP_SID, DWH_VALID_FROM_TMSP, SHIPPING_DESTINATION_CD) NOT ENFORCED 
)  COMMENT = 'Satellite table  - A shipment of particular product to a particular destination  - Source - VMT';
