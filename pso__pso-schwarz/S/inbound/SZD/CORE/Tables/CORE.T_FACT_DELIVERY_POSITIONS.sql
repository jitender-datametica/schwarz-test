/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_DELIVERY_POSITIONS
   generated from Powerdesigner on Freitag, 8. August 2025 13:28:51
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_DELIVERY_POSITIONS (
   DELIVERY_NR                         VARCHAR(250)    NOT NULL COMMENT 'Business/Natural Key - The unique business identifier of the delivery.',
   DELIVERY_POSITION_NR                NUMBER(38, 0)   NOT NULL COMMENT 'Business/Natural Key - The unique business identifier of the position within the delivery.',
   TRANSPORT_UNIT_NR                   VARCHAR(250)    NOT NULL COMMENT 'Business/Natural Key - The unique identification number of the transport unit (either a container or a truck).',
   TRANSPORT_UNIT_TYPE_CD              VARCHAR(50)     NOT NULL COMMENT 'The unique code for the general type of the transport unit (CONTAINER or TRUCK)',
   TRANSPORT_UNIT_TYPE_NAME            VARCHAR(100)    COMMENT 'Descriptive Attribute - A descriptive name for the special type of the transport unit.',
   TRANSPORT_UNIT_PACKAGE_QTY          NUMBER(38, 5)   COMMENT 'Fact - additive - The quantity of packages within the transport unit.',
   SALES_VARIANT_PRODUCT_SID           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   DELIVERY_TARGET_NAME                VARCHAR(100)    COMMENT 'Descriptive Attribute - The name of the warehouse or store that is the target of the delivery.',
   ETD_DT                              DATE            COMMENT 'Descriptive Attribute - The estimated date of departure.',
   ETA_DT                              DATE            COMMENT 'Descriptive Attribute - The estimated date of arrival.',
   ATA_DT                              DATE            COMMENT 'Descriptive Attribute - Actual date of arrival.',
   ARRIVAL_DT                          DATE            COMMENT 'Descriptive Attribute - The date on which the goods were received by the recipient.',
   RECEIPT_DT                          DATE            COMMENT 'Descriptive Attribute - The date of the receipt.',
   SALES_RECEIPT_NR                    VARCHAR(250)    COMMENT 'Descriptive Attribute - The number of the internal sales receipt.',
   TRANSPORT_IDENTIFICATION_NR         VARCHAR(250)    COMMENT 'Descriptive Attribute - The business identification number of the transport within the delivery.',
   SHIPMENT_NR_TXT                     VARCHAR(1000)   COMMENT 'Descriptive Attribute - The business number of the shipment (can be a list of shipment numbers)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.',   
   CONSTRAINT PK_FACT_DELIVERY_POSITIONS PRIMARY KEY (DELIVERY_NR, DELIVERY_POSITION_NR, TRANSPORT_UNIT_NR) NOT ENFORCED 
)  COMMENT = 'Fact table - Transactional Events - This table contains detailed informationen of delivery positions regarding their transportation (e.g. transported either by truck or container).  - Source - LExIS';
