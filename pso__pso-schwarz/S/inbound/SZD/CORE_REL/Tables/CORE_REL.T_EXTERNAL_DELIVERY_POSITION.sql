/* --------------------------------------------------------------------------------
   DDL for table: T_EXTERNAL_DELIVERY_POSITION
   generated from Powerdesigner on Donnerstag, 28. November 2024 11:30:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_EXTERNAL_DELIVERY_POSITION (
   DELIVERY_NR                         VARCHAR(50)     NOT NULL COMMENT 'The business identifier of the delivery.',
   POSITION_NR                         VARCHAR(50)     NOT NULL COMMENT 'The number of the position within the delivery.',
   EVENT_DT                            DATE            NOT NULL COMMENT 'The date on with the transaction takes place.',
   ORIGINAL_COUNTRY_LOCATION_SID       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location.',
   PRODUCT_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The surrogate key of the product references from this position.',
   SALES_RECEIPT_NR                    VARCHAR(250)    NOT NULL COMMENT 'The business number of the sales receipt this delivery is connected to.',
   SALES_RECEIPT_POSITION_NR           NUMBER(38, 0)   NOT NULL COMMENT 'The position number on the receipt',
   GOODS_MOVEMENT_TYPE_CD              VARCHAR(50)     NOT NULL COMMENT 'The unique code of the movement type for goods.',
   DELIVERED_SALES_UNIT_QTY            NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The quantity that was actually delivered.measured in sales units.',
   DELIVERED_STORE_UNIT_QTY            NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The quantity that was actually delivered measured in store units.',
   ORIGINAL_QTY                        NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The original quantity of this position.',
   BASE_UNIT_ID                        NUMBER(38,0)    NOT NULL COMMENT 'Descriptive attribute - The code identifying the base unit of measure.',
   SALES_UNIT_ID                       NUMBER(38,0)    NOT NULL COMMENT 'Descriptive attribute - The code identifying the unit of measure.',
   CONVERSION_FACTOR_VAL               NUMBER(38, 5)   NOT NULL COMMENT 'Fact - non-additive - A conversion factor for calculating the delivery quantity based on the sales quantity.',
   NET_WEIGHT_MEAS                     NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The net weight of the goods.',
   NET_WEIGHT_UNIT_ID                  NUMBER(38,0)    NOT NULL COMMENT 'The unit of measure for the net weight',
   GROSS_WEIGHT_MEAS                   NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The gross weight of the goods.',
   GROSS_WEIGHT_UNIT_ID                NUMBER(38,0)    NOT NULL COMMENT 'The unit of measure for the gross weight.',
   VOLUME_MEAS                         NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The volume in space the goods take up',
   VOLUME_UNIT_ID                      NUMBER(38,0)    NOT NULL COMMENT 'The unit of measure for the volume',
   ITEM_PROVISION_DT                   DATE            COMMENT 'The date of provisioning of the item(s).',
   GTIN_NR                             NUMBER(38, 0)   NOT NULL COMMENT 'Descriptive attribute - The global GTIN number (EAN11)',
   RETURN_POSITION_FG                  BOOLEAN         NOT NULL COMMENT 'A flag indicating that this position is a return.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_EXTERNAL_DELIVERY_POSITION PRIMARY KEY (DELIVERY_NR, POSITION_NR, EVENT_DT) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - This event describes a position of special product within the delivery of goods from an external supplier.';
